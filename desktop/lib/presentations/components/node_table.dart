import 'package:desktop/dal/models/node_ui.dart';
import 'package:desktop/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';

class NodeTableColumn {
  final String label;
  final bool isActive;

  NodeTableColumn({required this.isActive, required this.label});
}

class NodeTable extends StatefulWidget {
  final List<NodeTableColumn> columns;
  final List<NodeUi> nodes;

  final Function(NodeUi) runApp;
  final Function(NodeUi) stopApp;

  const NodeTable(
      {super.key,
      required this.runApp,
      required this.stopApp,
      required this.columns,
      required this.nodes});

  @override
  State<NodeTable> createState() => _NodeTableState();
}

class _NodeTableState extends State<NodeTable> {
  List<ExpandableTableHeader> headers = [];
  List<NodeUi> rows = [];

  @override
  void initState() {
    headers = widget.columns
        .map((col) => ExpandableTableHeader(
              cell: buildCell(col.label),
            ))
        .toList();
    setState(() => rows = widget.nodes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableTable(
      firstHeaderCell: headers[0].cell,
      firstColumnWidth: 180,
      rows: generateRows(rows.length),
      headers: headers.sublist(2),
      defaultsRowHeight: 50,
      headerHeight: 50,
      defaultsColumnWidth: 150,
      scrollShadowColor: CustomColors.accentColor.withOpacity(0.4),
      scrollShadowSize: 3,
      visibleScrollbar: true,
    );
  }

  List<ExpandableTableRow> generateRows(int quantity) {
    return rows
        .map((row) => ExpandableTableRow(
            firstCell: buildFirstRowCell(row), cells: _buildCells(row)))
        .toList();
  }

  buildCell(String content, {CellBuilder? builder}) {
    return ExpandableTableCell(
      child: builder != null
          ? null
          : DefaultCellCard(
              child: Center(
                child: Text(
                  content,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
      builder: builder,
    );
  }

  ExpandableTableCell buildFirstRowCell(NodeUi node) {
    return ExpandableTableCell(
      builder: (context, details) => DefaultCellCard(
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Row(
            children: [
              _addActions(node),
              Text(
                node.name,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ExpandableTableCell> _buildCells(NodeUi row) {
    List<dynamic> list = [
      row.path,
      row.status,
      row.pid,
      row.sid,
      row.cpu,
      row.mem,
      row.ports,
      row.branch,
    ];

    var cells = List<ExpandableTableCell>.generate(list.length, (columnIndex) {
      if (columnIndex == 0) {
        //path
        return buildCell(
          list[columnIndex],
          builder: (context, details) => DefaultCellCard(
            child: Center(
              child: Tooltip(
                message: list[columnIndex],
                child: RichText(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: list[columnIndex],
                      style: const TextStyle(color: CustomColors.accentBlue)),
                ),
              ),
            ),
          ),
        );
      } else {
        return buildCell(list[columnIndex]);
      }
    });

    return cells;
  }

  Widget _addActions(NodeUi node) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
          width: 1,
          color: Colors.white.withOpacity(0.1),
        ))),
        child: Row(
          children: [
            Visibility(
              visible: node.status != 'running',
              replacement: IconButton(
                  onPressed: () => widget.stopApp(node),
                  icon:
                      const Icon(Icons.stop, color: CustomColors.accentColor)),
              child: IconButton(
                  onPressed: () => widget.runApp(node),
                  icon: const Icon(
                    Icons.play_arrow,
                    color: CustomColors.accentColor,
                  )),
            ),
            SizedBox(
                child: IconButton(
              onPressed: () => _showAppSettingsDialog(node),
              icon:
                  const Icon(Icons.more_vert, color: CustomColors.accentColor),
            )),
          ],
        ),
      ),
    );
  }

  _showAppSettingsDialog(NodeUi node) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.zero,
        alignment: Alignment.centerRight,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: CustomColors.drawerColor,
          ),
          width: 500,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Node settings',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              DropdownMenu(
                label: const Text(
                  "Run script",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                initialSelection: node.scripts.first,
                onSelected: (String? value) {
                  setState(() {
                    // dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    node.scripts.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultCellCard extends StatelessWidget {
  final Widget child;

  const DefaultCellCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(.5), width: 1)),
        color: CustomColors.drawerColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      margin: const EdgeInsets.only(bottom: .4, right: 0),
      child: child,
    );
  }
}
