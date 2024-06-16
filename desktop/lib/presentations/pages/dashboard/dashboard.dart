import 'package:desktop/dal/models/enviroment_ui.dart';
import 'package:desktop/dal/models/node_ui.dart';
import 'package:desktop/di/di.dart';
import 'package:desktop/pb/nodes.pbgrpc.dart';
import 'package:desktop/presentations/components/node_table.dart';
import 'package:desktop/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final grpc = DiManager.getgRpc();
  final searchController = TextEditingController();

  bool _onlyActive = false;
  List<NodeTableColumn> columns = [
    NodeTableColumn(isActive: true, label: "name"),
    NodeTableColumn(isActive: true, label: "hidden"),
    NodeTableColumn(isActive: true, label: "path"),
    NodeTableColumn(isActive: true, label: "status"),
    NodeTableColumn(isActive: true, label: "pid"),
    NodeTableColumn(isActive: true, label: "sid"),
    NodeTableColumn(isActive: true, label: "cpu"),
    NodeTableColumn(isActive: true, label: "mem"),
    NodeTableColumn(isActive: true, label: "port"),
    NodeTableColumn(isActive: true, label: "branch"),
  ];

  List<NodeUi> nodes = [];
  bool _isTableLoading = true;
  Key _tableKey = Key("1");

  EnviromentUi _enviroment = EnviromentUi(cpu: "", mem: "", quantity: "");

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
                        onChanged: (bool value) =>
                            setState(() => _onlyActive = value),
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
                  child: NodeTable(
                    key: _tableKey,
                    runApp: _runApp,
                    stopApp: _stopApp,
                    columns: columns,
                    nodes: nodes,
                  ),
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
      final apiNodes = await grpc.nodeClient!.readAllNodes(EmptyParams());
      setState(() => nodes = nodesUifromRequest(apiNodes));
      print(nodes);
    } catch (e) {
      print(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isTableLoading = false);
      }
    }
  }

  _tableMenuAction(NodeTableColumn col) {
    var newCols = columns
        .map((e) => e.label == col.label
            ? NodeTableColumn(isActive: !col.isActive, label: col.label)
            : e)
        .toList();
    if (mounted) {
      setState(() => columns = newCols);
    }
  }

  _runApp(NodeUi curerntNode) async {
    try {
      final apiNode = await grpc.nodeClient!
          .runNode(RunNodeRequest(command: "dev", id: curerntNode.id));
      final node = nodeUiFromRequest(apiNode, curerntNode);
      final newNodes = nodes.map((n) => n.id == node.id ? node : n).toList();
      setState(() {
        nodes = newNodes;
        _tableKey = Key("${_tableKey}1");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _stopApp(NodeUi curerntNode) async {
    try {
      final apiNode =
          await grpc.nodeClient!.stopNode(StopNodeRequest(id: curerntNode.id));
      final node = nodeUiFromRequest(apiNode, curerntNode);
      final newNodes = nodes.map((n) => n.id == node.id ? node : n).toList();
      setState(() {
        nodes = newNodes;
        _tableKey = Key("${_tableKey}1");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _observeEnv() async {
    try {
      final res = grpc.envClient!.processStream(DataRequest(id: "1"));
      await for (var message in res) {
        final newNodes = nodes.map((node) {
          final curNode = message.nodes
              .firstWhereOrNull((element) => element.id == node.id);
          if (curNode != null) {
            return nodeUiFromRequest(curNode, node);
          } else {
            return node;
          }
        }).toList();
        if (mounted) {
          setState(() {
            _tableKey = Key("${_tableKey}1");
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
}
