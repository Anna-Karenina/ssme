import 'package:desktop/pb/api.pb.dart';

class AppUi {
  final int id;
  final String name;
  final String path;
  final String status;
  final String pid;
  final String cpu;
  final String mem;
  final String sid;
  final String ports;
  final String branch;
  final String nodeVersion;
  final String defaultScript;
  final bool isAppValid;
  final List<String> scripts;

  AppUi(
      {required this.id,
      required this.name,
      required this.path,
      required this.status,
      required this.pid,
      required this.cpu,
      required this.mem,
      required this.sid,
      required this.ports,
      required this.branch,
      required this.scripts,
      required this.defaultScript,
      required this.nodeVersion,
      required this.isAppValid});
}

List<AppUi> nodesUifromRequest(AppList list) {
  List<AppUi> temp = [];
  for (var e in list.apps) {
    temp.add(AppUi(
      id: e.id,
      name: e.name,
      path: e.path,
      nodeVersion: e.nodeVersion.trim(),
      scripts: e.scripts,
      defaultScript: e.defaultScript,
      isAppValid: e.isAppValid,
      //runtime
      status: "",
      pid: "",
      cpu: "",
      mem: "",
      sid: "",
      ports: "",
      branch: "",
    ));
  }
  return temp;
}

AppUi nodeUiFromRequest(AppRunTime nodeRt, AppUi currentNode) => AppUi(
    id: nodeRt.id,
    status: nodeRt.status,
    pid: nodeRt.pid.toString(),
    cpu: nodeRt.cpu.toString(),
    mem: nodeRt.mem.toString(),
    sid: nodeRt.sid.toString(),
    ports: nodeRt.ports.join(","),
    branch: nodeRt.branch,
    name: currentNode.name,
    isAppValid: currentNode.isAppValid,
    path: currentNode.path,
    scripts: currentNode.scripts,
    nodeVersion: currentNode.nodeVersion,
    defaultScript: currentNode.defaultScript);
