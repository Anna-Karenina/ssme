import 'package:collection/collection.dart';
import 'package:desktop/dal/models/app_ui.dart';
import 'package:desktop/pb/api.pb.dart';
import 'package:desktop/presentations/components/nodejs_download_dialog.dart';
import 'package:desktop/utils/colors.dart';
import 'package:flutter/material.dart';

class AppSettingsDialog extends StatefulWidget {
  final AppUi node;
  final NodejsVersionsInfo nodejsVersionsInfo;

  final Future<void> Function(String, AppUi) saveNewNodeJsVersion;
  final Future<void> Function(int, String, bool) updateDefaultScript;
  final Future<AppUi?> Function(int) syncAppData;

  const AppSettingsDialog(
      {super.key,
      required this.node,
      required this.syncAppData,
      required this.nodejsVersionsInfo,
      required this.updateDefaultScript,
      required this.saveNewNodeJsVersion});

  @override
  // ignore: no_logic_in_create_state
  State<AppSettingsDialog> createState() => _AppSettingsDialogState(node: node);
}

class _AppSettingsDialogState extends State<AppSettingsDialog> {
  bool _saveAsDefault = false;
  String _script = "";
  String _version = "";
  bool _loading = true;
  AppUi node;

  bool _nodeJsDowloading = false;

  _AppSettingsDialogState({required this.node});

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        color: CustomColors.drawerColor,
      ),
      width: 500,
      height: double.infinity,
      child: Visibility(
        replacement: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 120, height: 120, child: CircularProgressIndicator())
          ],
        ),
        visible: !_loading,
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 15),
              child: DropdownMenu(
                menuHeight: 300,
                label: const Text(
                  "Select nodejs version",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                initialSelection: _version,
                onSelected: (String? version) =>
                    _saveNewNodeJsVersion(version ?? ""),
                dropdownMenuEntries:
                    widget.nodejsVersionsInfo.remoteLts.map((String value) {
                  return DropdownMenuEntry<String>(
                      leadingIcon: value == node.nodeVersion
                          ? const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                          : null,
                      trailingIcon: widget.nodejsVersionsInfo.installed
                              .contains(value)
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () => _onDownloadNodeVersion(value),
                            ),
                      value: value,
                      label: value);
                }).toList(),
              ),
            ),
            Row(
              children: [
                DropdownMenu(
                  menuHeight: 300,
                  label: const Text(
                    "Run script",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  initialSelection: _script,
                  onSelected: (String? value) async {
                    setState(() => _script = value!);
                    await _updateDefaultScript(value!);
                  },
                  dropdownMenuEntries: node.scripts
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      const Text(
                        "Save as default script",
                        style: TextStyle(fontSize: 10),
                      ),
                      Checkbox(
                        tristate: true,
                        value: _saveAsDefault,
                        onChanged: (bool? value) {
                          setState(() => _saveAsDefault = value ?? false);
                          _updateDefaultScript(_script);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateDefaultScript(String script) async {
    setState(() => _nodeJsDowloading = true);

    try {
      await widget.updateDefaultScript(widget.node.id, _script, _saveAsDefault);
    } catch (e) {
      print(e);
    } finally {
      setState(() => _nodeJsDowloading = false);
    }
  }

  Future<void> asyncInit() async {
    final n = await widget.syncAppData(widget.node.id);
    setState(() {
      node = n!;
      _version = widget.nodejsVersionsInfo.remoteLts
              .firstWhereOrNull((no) => no == n.nodeVersion) ??
          "";
      _script = n.scripts.firstWhereOrNull((ns) => ns == n.defaultScript) ?? "";
      _loading = false;
    });
  }

  _onDownloadNodeVersion(String version) async {
    setState(() => _nodeJsDowloading = true);
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          backgroundColor: CustomColors.drawerColor,
          child: NodeJsDownloadDialog(
            version: version,
          )),
    );
  }

  Future<void> _saveNewNodeJsVersion(String version) async {
    try {
      setState(() => _nodeJsDowloading = true);
      await widget.saveNewNodeJsVersion(version, node);
    } catch (e) {
      print(e);
    } finally {
      setState(() => _nodeJsDowloading = false);
    }
  }
}
