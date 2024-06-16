import 'dart:async';

import 'package:flutter/material.dart';

class Disconnected extends StatefulWidget {
  const Disconnected({super.key});

  @override
  State<Disconnected> createState() => _DisconnectedState();
}

class _DisconnectedState extends State<Disconnected> {
  double _width = 30.0;
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() => _width = _width == 30.0 ? 600.0 : 30.0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Prepare rocket to launch",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: _width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(90 / 360),
                    child: Icon(
                      Icons.rocket,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
