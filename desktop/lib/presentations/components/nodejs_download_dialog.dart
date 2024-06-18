import 'package:desktop/di/di.dart';
import 'package:desktop/pb/nodes.pb.dart';
import 'package:flutter/material.dart';

enum Stage { PRE, IN_PROGRESS, DONE }

class NodeJsDownloadDialog extends StatefulWidget {
  final String version;
  const NodeJsDownloadDialog({required this.version, super.key});

  @override
  State<NodeJsDownloadDialog> createState() => _NodeJsDownloadDialogState();
}

class _NodeJsDownloadDialogState extends State<NodeJsDownloadDialog> {
  final grpc = DiManager.getgRpc();
  String text = "";
  Stage _stage = Stage.PRE;

  @override
  void initState() {
    setState(() => text = "Download nodejs ${widget.version}?");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: [Stage.PRE, Stage.DONE].contains(_stage),
              replacement: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: CircularProgressIndicator(),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(_stage == Stage.DONE ? "Close" : 'Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Visibility(
                    visible: _stage == Stage.PRE,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Download'),
                        onPressed: () => _download()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _download() async {
    try {
      var responseStream = grpc.envClient!
          .downloadNodeJsVersion(RequestVersion(version: widget.version));
      setState(() => _stage = Stage.IN_PROGRESS);
      await for (var m in responseStream) {
        setState(() {
          if (m.status == "done") {
            _stage = Stage.DONE;
            text = "${widget.version} successfully installed";
          } else {
            text = m.status;
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {}
  }
}
