import 'package:desktop/dal/models/app_ui.dart';
import 'package:desktop/pb/api.pb.dart';
import 'package:desktop/presentations/components/app_settings_dialog.dart';
import 'package:desktop/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';

class AppTableColumn {
  final String label;
  final bool isActive;

  AppTableColumn({required this.isActive, required this.label});
}

class AppTable extends StatefulWidget {
  final List<AppTableColumn> columns;
  final List<AppUi> nodes;
  final NodejsVersionsInfo nodejsVersionsInfo;

  final Future<void> Function(AppUi) runApp;
  final Future<void> Function(AppUi) stopApp;
  final Future<void> Function(String, AppUi) saveNewNodeJsVersion;
  final Future<void> Function(int, String, bool) updateDefaultScript;
  final Future<AppUi?> Function(int) syncAppData;

  const AppTable(
      {super.key,
      required this.runApp,
      required this.stopApp,
      required this.columns,
      required this.nodes,
      required this.syncAppData,
      required this.nodejsVersionsInfo,
      required this.saveNewNodeJsVersion,
      required this.updateDefaultScript});

  @override
  State<AppTable> createState() => _AppTableState();
}

class _AppTableState extends State<AppTable> {
  List<ExpandableTableHeader> headers = [];

  @override
  void initState() {
    headers = widget.columns
        .map((col) => ExpandableTableHeader(
              cell: buildCell(col.label),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableTable(
      firstHeaderCell: headers[0].cell,
      firstColumnWidth: 180,
      rows: generateRows(),
      headers: headers.sublist(2),
      defaultsRowHeight: 50,
      headerHeight: 50,
      defaultsColumnWidth: 150,
      scrollShadowColor: CustomColors.accentColor.withOpacity(0.1),
      scrollShadowSize: 3,
      visibleScrollbar: true,
    );
  }

  List<ExpandableTableRow> generateRows() {
    return widget.nodes
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

  ExpandableTableCell buildFirstRowCell(AppUi node) {
    return ExpandableTableCell(
        child: DefaultCellCard(
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
    ));
  }

  List<ExpandableTableCell> _buildCells(AppUi row) {
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

  Widget _addActions(AppUi node) {
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
          children: [_buildActionWidget(node), _showAppSettingsDialog(node)],
        ),
      ),
    );
  }

  _showAppSettingsDialog(AppUi node) {
    return IconButton(
        onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                  key: Key(DateTime.now().toString()),
                  insetPadding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  backgroundColor: Colors.transparent,
                  child: AppSettingsDialog(
                      key: Key(DateTime.now().toString()),
                      node: node,
                      nodejsVersionsInfo: widget.nodejsVersionsInfo,
                      saveNewNodeJsVersion: widget.saveNewNodeJsVersion,
                      syncAppData: widget.syncAppData,
                      updateDefaultScript: widget.updateDefaultScript)),
            ),
        icon: const Icon(Icons.more_vert, color: CustomColors.accentColor));
  }

  _buildActionWidget(AppUi node) {
    switch (node.status) {
      case "running":
        return IconButton(
            onPressed: () => widget.stopApp(node),
            icon: const Icon(Icons.stop, color: CustomColors.accentColor));

      default:
        if (!widget.nodejsVersionsInfo.installed.contains(node.nodeVersion)) {
          return Tooltip(
            message:
                "required node  ${node.nodeVersion == '' ? 'unknown version' : node.nodeVersion}, but it's not installed",
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.sync_problem,
                  color: CustomColors.accentColor,
                )),
          );
        } else {
          return Tooltip(
            message:
                "run with \nnode: ${node.nodeVersion}\nscript: ${node.defaultScript}",
            child: IconButton(
                onPressed: () => widget.runApp(node),
                icon: const Icon(
                  Icons.play_arrow,
                  color: CustomColors.accentColor,
                )),
          );
        }
    }
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
            bottom:
                BorderSide(color: Colors.white.withOpacity(.5), width: 0.5)),
        color: CustomColors.drawerColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      margin: const EdgeInsets.only(bottom: .4, right: 0),
      child: child,
    );
  }
}
