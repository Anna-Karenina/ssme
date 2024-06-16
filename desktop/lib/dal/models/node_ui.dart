import 'package:desktop/pb/nodes.pb.dart';

class NodeUi {
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
  final List<String> scripts;

  NodeUi(
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
      required this.nodeVersion});
}

List<NodeUi> nodesUifromRequest(NodeList list) {
  List<NodeUi> temp = [];
  for (var e in list.nodes) {
    temp.add(NodeUi(
      id: e.id,
      name: e.name,
      path: e.path,
      nodeVersion: e.nodeVersion,
      scripts: e.scripts,
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

NodeUi nodeUiFromRequest(NodeRunTime nodeRt, NodeUi currentNode) => NodeUi(
    id: nodeRt.id,
    status: nodeRt.status,
    pid: nodeRt.pid.toString(),
    cpu: nodeRt.cpu.toString(),
    mem: nodeRt.mem.toString(),
    sid: nodeRt.sid.toString(),
    ports: nodeRt.ports.join(","),
    branch: nodeRt.branch,
    name: currentNode.name,
    path: currentNode.path,
    scripts: currentNode.scripts,
    nodeVersion: currentNode.nodeVersion);
