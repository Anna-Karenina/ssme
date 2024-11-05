import 'package:grpc/grpc.dart' as GRPCLIB;

import 'package:desktop/di/di.dart';
import 'package:desktop/presentations/components/sidebar.dart';
import 'package:desktop/presentations/pages/dashboard/dashboard.dart';
import 'package:desktop/presentations/pages/disconnected/disconnected.dart';
import 'package:desktop/presentations/pages/apps/apps.dart';
import 'package:desktop/presentations/pages/npm/npm.dart';
import 'package:desktop/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DiManager.initDi();

  runApp(const Rs25App());
}

class Rs25App extends StatefulWidget {
  const Rs25App({super.key});

  @override
  State<Rs25App> createState() => _Rs25AppState();
}

class _Rs25AppState extends State<Rs25App> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  final grpc = DiManager.getgRpc();

  bool _engineIsRunning = false;

  @override
  void initState() {
    _asyncInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: null,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          snackBarTheme:
              const SnackBarThemeData(backgroundColor: Colors.redAccent),
          useMaterial3: true,
          chipTheme: ChipThemeData(
            showCheckmark: false,
            color: const ChipBackgroundColor(),
            labelStyle: const TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: CustomColors.accentBlue),
            ),
          ),
          textTheme: Typography.whiteCupertino,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
                color: CustomColors.accentColor.withOpacity(.4), fontSize: 13),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.accentColor)),
          )),
      home: Scaffold(
        backgroundColor: CustomColors.drawerColor,
        key: _key,
        drawer: Sidebar(controller: _controller),
        body: Visibility(
          replacement: const Disconnected(),
          visible: _engineIsRunning,
          child: Row(
            children: [
              Sidebar(controller: _controller),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _getMainComponent(_controller))),
            ],
          ),
        ),
      ),
    );
  }

  _getMainComponent(SidebarXController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            // return Dashboard();
            return const Dashboard();
          case 1:
            return const Nodes();
          case 2:
            return const Npm();
          default:
            return Text("1");
        }
      },
    );
  }

  Future<void> _asyncInit() async {
    try {
      await grpc.connectgRpc();

      grpc.stream.listen((event) {
        if (event == GRPCLIB.ConnectionState.ready) {
          setState(() => _engineIsRunning = true);
        } else if ([
          GRPCLIB.ConnectionState.transientFailure,
          GRPCLIB.ConnectionState.idle,
          GRPCLIB.ConnectionState.shutdown
        ].contains(event)) {
          // setState(() => _engineIsRunning = false);
        }
      });
      setState(() => _engineIsRunning = true);
    } catch (e) {
      print(e);
    }
  }
}

class ChipBackgroundColor extends Color implements MaterialStateColor {
  const ChipBackgroundColor() : super(_default);

  static const int _default = 0xFF000000;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return CustomColors.scaffoldBackgroundColor;
    }
    return CustomColors.drawerColor;
  }
}
