import 'package:desktop/dal/models/node_ui.dart';
import 'package:desktop/di/di.dart';
import 'package:desktop/pb/nodes.pb.dart';
import 'package:desktop/presentations/components/new_node_form.dart';
import 'package:flutter/material.dart';

class Nodes extends StatefulWidget {
  const Nodes({super.key});

  @override
  State<Nodes> createState() => _NodesState();
}

class _NodesState extends State<Nodes> {
  final grpc = DiManager.getgRpc();
  List<NodeUi> nodes = [];

  @override
  void initState() {
    asyncInit();
    super.initState();
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
            "Nodes",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Wrap(spacing: 8, children: [
                          const ChoiceChip(
                            selected: true,
                            label: Text("New Node"),
                          ),
                          ...nodes
                              .map((item) => ChoiceChip(
                                    selected: false,
                                    label: Text(item.name),
                                  ))
                              .toList(),
                        ]),
                      )),
                ],
              ),
            ),
            SizedBox(
                width: 300,
                child: EditNodeForm(
                  onSubmit: _createNode,
                )),
          ],
        )
      ],
    );
  }

  Future<void> _createNode(String name, String path) async {
    await grpc.nodeClient!.createNode(CreateRequest(path: path, name: name));
    asyncInit();
  }

  Future<void> asyncInit() async {
    try {
      final apiNodes = await grpc.nodeClient!.readAllNodes(EmptyParams());

      setState(() => nodes = nodesUifromRequest(apiNodes));
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }
}
