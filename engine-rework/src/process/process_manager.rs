use std::collections::HashMap;
use std::process::Stdio;
use sysinfo::{ProcessExt, System, SystemExt};
use tokio::io::{AsyncBufReadExt, BufReader};
use tokio::process::{Child, Command};
use tokio::sync::{Mutex, mpsc};

use crate::api::{ProcessLogsByLine, ProcessesListInfo, ResourceUsage};

#[derive(Debug)]
struct ProcessInfo {
    child: Child,
    stdout: Option<tokio::process::ChildStdout>, // что бы не забирать stdout и stderr из child методом take()
    stderr: Option<tokio::process::ChildStderr>,
}

#[derive(Debug, Default)]
pub struct ProcessManager {
    processes: Mutex<HashMap<i32, ProcessInfo>>, // i32 — это ID процесса из БД
}

impl ProcessManager {
    pub fn new() -> Self {
        Self {
            processes: Mutex::new(HashMap::new()),
        }
    }
    pub async fn prepare_process() {}
    /// Запуск нового процесса и добавление его в HashMap
    pub async fn start_process(&self, id: i32, command: &str, args: &[&str]) -> Result<(), String> {
        let mut child = Command::new(command)
            .args(args)
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .map_err(|e| format!("Failed to start process: {}", e))?;

        let stdout = child.stdout.take();
        let stderr = child.stderr.take();

        self.processes.lock().await.insert(
            id,
            ProcessInfo {
                child,
                stdout,
                stderr,
            },
        );

        Ok(())
    }

    pub async fn stop_process(&self, id: i32) -> Result<(), Box<dyn std::error::Error>> {
        let mut processes = self.processes.lock().await;

        if let Some(mut process) = processes.remove(&id) {
            let child = &mut process.child;
            child.kill().await?; // Завершаем процесс
            let _ = child.wait().await; // Дожидаемся завершения
        } else {
            return Err("Process not found".into());
        }

        Ok(())
    }

    /// Получение списка всех запущенных процессов
    pub async fn list_processes(&self) -> Vec<ProcessesListInfo> {
        let processes = self.processes.lock().await;
        processes
            .iter()
            .map(|(&id, process_info)| ProcessesListInfo {
                id,
                pid: process_info.child.id().unwrap_or(0) as i32,
            })
            .collect()
    }

    pub async fn stream_output(
        &self,
        id: i32,
        tx: mpsc::Sender<Result<ProcessLogsByLine, tonic::Status>>,
    ) -> Result<(), String> {
        let mut processes = self.processes.lock().await;

        let process = match processes.get_mut(&id) {
            Some(proc) => proc,
            None => {
                let _ = tx
                    .send(Err(tonic::Status::not_found("Process not found")))
                    .await;
                return Err("Process not found".to_string());
            }
        };
        let child = &mut process.child;
        // Используем ссылки, чтобы не "забирать" stdout и stderr из ProcessInfo
        let stdout = process.stdout.as_mut().ok_or("No stdout")?;
        let stderr = process.stderr.as_mut().ok_or("No stderr")?;

        let mut stdout_reader = BufReader::new(stdout).lines();
        let mut stderr_reader = BufReader::new(stderr).lines();

        loop {
            tokio::select! {
                line = stdout_reader.next_line() => {
                    if let Ok(Some(line)) = line {
                        if tx.send(Ok(ProcessLogsByLine { line: format!("stdout: {}", line) })).await.is_err() {
                            break; // Клиент отключился
                        }
                    }
                }
                line = stderr_reader.next_line() => {
                    if let Ok(Some(line)) = line {
                        if tx.send(Ok(ProcessLogsByLine { line: format!("stderr: {}", line) })).await.is_err() {
                            break; // Клиент отключился
                        }
                    }
                }
                _ = child.wait() => {
                    break; // Процесс завершился
                }
                else => {
                    // Проверяем, жив ли процесс
                    if let Ok(Some(_status)) = child.try_wait() {
                        break; // Если процесс завершился
                    }
                }
            }
        }

        Ok(())
    }

    pub async fn stream_resource_usage(
        &self,
        id: i32,
        tx: mpsc::Sender<Result<ResourceUsage, tonic::Status>>,
    ) -> Result<(), String> {
        let mut processes = self.processes.lock().await;

        let process = match processes.get_mut(&id) {
            Some(proc) => proc,
            None => {
                let _ = tx
                    .send(Err(tonic::Status::not_found("Process not found")))
                    .await;
                return Err("Process not found".to_string());
            }
        };

        let child = &mut process.child; // Работаем с ссылкой на процесс

        // Создаем объект System для отслеживания ресурсов
        let mut system = System::new_all();

        let mut last_checked = tokio::time::Instant::now();

        // Подготовим поток для мониторинга ресурсов
        loop {
            dbg!("in loop");
            tokio::select! {
                _ = tokio::time::sleep(std::time::Duration::from_secs(10)) => {
                    system.refresh_process(child.id().unwrap_or(0) as i32);

                    if let Some(proc_info) = system.process(child.id().unwrap_or(0) as i32) {
                        let cpu_usage = proc_info.cpu_usage(); // Получаем использование CPU
                        let ram_usage = proc_info.memory(); // Получаем использование RAM

                        let resource_usage = ResourceUsage {
                            time_stamp:  Some(prost_types::Timestamp {
                                    seconds: last_checked.elapsed().as_secs() as i64,
                                    nanos: last_checked.elapsed().subsec_nanos() as i32,
                                }),
                            cpu: cpu_usage as f32,
                            mem: ram_usage as f32,
                        };

                        if tx.send(Ok(resource_usage)).await.is_err() {
                            break; // Клиент отключился
                        }
                    }

                    last_checked = tokio::time::Instant::now();
                }
                _ = child.wait() => {
                    break; // Если процесс завершился
                }
            }
        }

        Ok(())
    }
}
