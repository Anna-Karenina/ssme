import 'package:desktop/dal/models/enviroment_ui.dart';
import 'package:desktop/dal/models/app_ui.dart';
import 'package:desktop/di/di.dart';
import 'package:desktop/pb/api.pb.dart';
import 'package:desktop/presentations/components/apps_table.dart';
import 'package:desktop/presentations/components/snackbar.dart';
import 'package:desktop/utils/colors.dart';
import 'package:desktop/utils/inc_key.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:grpc/grpc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final grpc = DiManager.getgRpc();
  final searchController = TextEditingController();

  bool _onlyActive = false;
  List<AppTableColumn> columns = [
    AppTableColumn(isActive: true, label: "name"),
    AppTableColumn(isActive: true, label: "hidden"),
    AppTableColumn(isActive: true, label: "path"),
    AppTableColumn(isActive: true, label: "status"),
    AppTableColumn(isActive: true, label: "pid"),
    AppTableColumn(isActive: true, label: "sid"),
    AppTableColumn(isActive: true, label: "cpu"),
    AppTableColumn(isActive: true, label: "mem"),
    AppTableColumn(isActive: true, label: "port"),
    AppTableColumn(isActive: true, label: "branch"),
  ];

  List<AppUi> nodes = [];
  bool _isTableLoading = true;
  String _tableKey = "0";

  EnviromentUi _enviroment = EnviromentUi(cpu: "0%", mem: "0%", quantity: "0");
  NodejsVersionsInfo _nodejsVersionsInfo =
      NodejsVersionsInfo(installed: [], remoteLts: []);

  @override
  void initState() {
    asyncInit();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 14.0, bottom: 20),
          child: Text(
            "Dashboard",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: double.infinity,
          color: CustomColors.white.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "Nodes\n",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                            fontWeight: FontWeight.w300,
                          )),
                      TextSpan(
                          text: "${_enviroment.quantity} / ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w500,
                              height: 1.6)),
                      TextSpan(
                          text: nodes.length.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.cyan.shade500,
                              fontWeight: FontWeight.w500,
                              height: 1.2))
                    ])),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: "CPU usage\n",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        )),
                    TextSpan(
                        text: _enviroment.cpu,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.w500,
                            height: 1.6))
                  ])),
                ],
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Memory usage\n",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                    )),
                TextSpan(
                    text: "${_enviroment.mem} /",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w500,
                        height: 1.6)),
                TextSpan(
                    text: " 100%",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.cyan.shade500,
                        fontWeight: FontWeight.w500,
                        height: 1.2))
              ]))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 200,
                      height: 35,
                      child: TextField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: CustomColors.accentBlue)),
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          prefixIcon: Icon(
                            Icons.search,
                            color: CustomColors.accentColor,
                            size: 20,
                          ),
                          labelText: 'Search',
                        ),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        controller: searchController,
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 6.0),
                    child: Text("Show only running",
                        style: TextStyle(color: CustomColors.accentColor)),
                  ),
                  SizedBox(
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                        value: _onlyActive,
                        activeColor: CustomColors.accentBlue,
                        inactiveTrackColor: Colors.transparent,
                        inactiveThumbColor: CustomColors.accentColor,
                        onChanged: _toggleOnlyActive,
                      ),
                    ),
                  )
                ],
              ),
              PopupMenuButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  color: CustomColors.accentColor,
                  child: const SizedBox(
                    child: Icon(
                      Icons.more_horiz,
                      color: CustomColors.accentColor,
                    ),
                  ),
                  itemBuilder: (context) => columns
                      .where((e) =>
                          !['hidden', 'actions', 'name'].contains(e.label))
                      .map((e) => PopupMenuItem(
                            height: 20,
                            padding: const EdgeInsets.only(
                                left: 15, top: 0, bottom: 0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.label,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                    height: 15,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Switch(
                                            value: e.isActive,
                                            onChanged: (_) =>
                                                _tableMenuAction(e))))
                              ],
                            ),
                          ))
                      .toList()),
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: Column(
            children: [
              Expanded(
                  child: Visibility(
                replacement: const Center(child: CircularProgressIndicator()),
                visible: !_isTableLoading,
                child: Container(
                  color: Colors.transparent,
                  child: AppTable(
                      key: Key(_tableKey),
                      runApp: _runApp,
                      stopApp: _stopApp,
                      columns: columns,
                      nodes: nodes,
                      syncAppData: _syncAppData,
                      nodejsVersionsInfo: _nodejsVersionsInfo,
                      saveNewNodeJsVersion: _saveNewNodeJsVersion,
                      updateDefaultScript: _updateDefaultScript),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> asyncInit() async {
    setState(() {
      _isTableLoading = true;
    });
    try {
      // _observeEnv();
      await _getNodeJsInfo();

      final apiNodes = await grpc.appsClient!.readAllApps(EmptyParams());
      setState(() => nodes = nodesUifromRequest(apiNodes));
    } catch (e) {
      print(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isTableLoading = false);
      }
    }
  }

  _tableMenuAction(AppTableColumn col) {
    var newCols = columns
        .map((e) => e.label == col.label
            ? AppTableColumn(isActive: !col.isActive, label: col.label)
            : e)
        .toList();
    if (mounted) {
      setState(() => columns = newCols);
    }
  }

  Future<void> _runApp(AppUi curerntNode) async {
    try {
      final apiNode = await grpc.appsClient!.runApp(RunAppRequest(
          command: curerntNode.defaultScript, id: curerntNode.id));
      final node = nodeUiFromRequest(apiNode, curerntNode);
      final newNodes = nodes.map((n) => n.id == node.id ? node : n).toList();
      setState(() {
        nodes = newNodes;
        _tableKey = incKey(_tableKey);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _stopApp(AppUi curerntNode) async {
    try {
      final apiNode =
          await grpc.appsClient!.stopApp(StopAppRequest(id: curerntNode.id));
      final node = nodeUiFromRequest(apiNode, curerntNode);
      final newNodes = nodes.map((n) => n.id == node.id ? node : n).toList();
      setState(() {
        nodes = newNodes;
        _tableKey = incKey(_tableKey);
      });
    } on GrpcError catch (e) {
      showToast(context, e.codeName, e?.message ?? "");
    }
  }

  _observeEnv() async {
    try {
      final res = grpc.envClient!.processStream(DataRequest(id: "1"));
      await for (var message in res) {
        final newNodes = nodes.map((node) {
          final curNode =
              message.apps.firstWhereOrNull((element) => element.id == node.id);
          if (curNode != null) {
            return nodeUiFromRequest(curNode, node);
          } else {
            return node;
          }
        }).toList();
        if (mounted) {
          setState(() {
            _tableKey = incKey(_tableKey);
            nodes = newNodes;
            _enviroment = EnviromentUi(
                cpu: message.environment.cpu,
                mem: message.environment.mem,
                quantity: message.environment.quantity.toString());
          });
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _getNodeJsInfo() async {
    try {
      final nodeJsVerions = await grpc.envClient!.getNodejsInfo(EmptyParams());
      setState(() => _nodejsVersionsInfo = nodeJsVerions);
    } catch (e) {
      print(e.toString());
    }
  }

  _updateDefaultNodejsVersion(int id, bool updateNvmrc, String version) async {
    try {
      await grpc.envClient!.updateDefaultNodejsVersion(
          UpdateDefaultNodejsVersionParams(
              id: id, updateNvmrc: updateNvmrc, version: version));
    } catch (e) {
      print(e);
    }
  }

  Future<AppUi?> _syncAppData(int id) async {
    try {
      await _getNodeJsInfo();
      await grpc.appsClient!.syncAppScripts(AppIdPayload(id: id));
      final apiNode = await grpc.appsClient!.readApp(AppIdPayload(id: id));
      var updatedNode = null;

      final newNodes = nodes.map<AppUi>((n) {
        if (n.id == id) {
          updatedNode = AppUi(
            id: id,
            name: apiNode.name,
            isAppValid: apiNode.isAppValid,
            path: apiNode.path,
            scripts: apiNode.scripts,
            nodeVersion: apiNode.nodeVersion,
            defaultScript: apiNode.defaultScript,
            status: n.status,
            pid: n.pid,
            cpu: n.cpu,
            mem: n.mem,
            sid: n.sid,
            ports: n.ports,
            branch: n.branch,
          );
          return updatedNode;
        } else {
          return n;
        }
      }).toList();
      setState(() => nodes = newNodes);
      return updatedNode;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveNewNodeJsVersion(String version, AppUi node) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: CustomColors.drawerColor,
        title: const Text('Update?'),
        content: const Text(
            'Update nodejs project version file (.nvmrc, .node_version)'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _updateDefaultNodejsVersion(node.id, false, version);
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              _updateDefaultNodejsVersion(node.id, true, version);
              Navigator.pop(context, 'Update');
            },
            child: const Text('Update now'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateDefaultScript(
      int id, String script, bool saveAsDefault) async {
    try {
      if (saveAsDefault) {
        await grpc.appsClient!.updateDefaultRunScript(
            UpdateDefaultRunScriptParams(id: id, script: script));
      }

      final newNodes = nodes.map((n) {
        return n.id == id
            ? AppUi(
                id: n.id,
                name: n.name,
                path: n.path,
                status: n.status,
                isAppValid: n.isAppValid,
                pid: n.pid,
                cpu: n.cpu,
                mem: n.mem,
                sid: n.sid,
                ports: n.ports,
                branch: n.branch,
                scripts: n.scripts,
                nodeVersion: n.nodeVersion,
                defaultScript: script)
            : n;
      }).toList();

      if (mounted) {
        setState(() {
          _tableKey = incKey(_tableKey);
          nodes = newNodes;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _toggleOnlyActive(bool value) {
    setState(() {
      _onlyActive = value;
      // nodes = nodes.where((node) => node.status == 'runnnig').toList();
      _tableKey = incKey(_tableKey);
    });
  }
}
