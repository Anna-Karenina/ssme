import 'package:desktop/dal/models/app_ui.dart';
import 'package:desktop/di/di.dart';
import 'package:desktop/pb/api.pb.dart';
import 'package:desktop/presentations/components/edit_node_form.dart';
import 'package:desktop/utils/colors.dart';
import 'package:desktop/utils/inc_key.dart';
import 'package:flutter/material.dart';

class Nodes extends StatefulWidget {
  const Nodes({super.key});

  @override
  State<Nodes> createState() => _NodesState();
}

class _NodesState extends State<Nodes> {
  final grpc = DiManager.getgRpc();
  List<AppUi> nodes = [];
  AppUi? _selectedNode;
  String _editNodeFormKey = "0";

  final searchController = TextEditingController();

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
            "Nodes",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SizedBox(
              width: 200,
              height: 35,
              child: TextField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColors.accentBlue)),
                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.accentColor,
                    size: 20,
                  ),
                  labelText: 'Search',
                ),
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                controller: searchController,
              )),
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
                      height: 480,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Wrap(spacing: 8, children: [
                          ChoiceChip(
                            selected: _selectedNode == null,
                            onSelected: (_) => _selectNode(null),
                            label: const Text("New Node"),
                          ),
                          ...nodes
                              .map((item) => ChoiceChip(
                                    onSelected: (_) => _selectNode(item),
                                    selected:
                                        item.id == _selectedNode?.id ?? false,
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
                  key: Key(_editNodeFormKey),
                  selectedNode: _selectedNode,
                  onSubmit: _createNode,
                )),
          ],
        )
      ],
    );
  }

  Future<void> _createNode(String name, String path) async {
    await grpc.appsClient!.createApp(CreateAppPayload(path: path, name: name));
    asyncInit();
  }

  Future<void> asyncInit() async {
    try {
      final apiNodes = await grpc.appsClient!.readAllApps(EmptyParams());
      setState(() => nodes = nodesUifromRequest(apiNodes).toList());
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }

  void _selectNode(AppUi? node) {
    setState(() {
      _selectedNode = node;
      incKey(_editNodeFormKey);
    });
  }
}
