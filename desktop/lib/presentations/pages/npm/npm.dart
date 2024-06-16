import 'package:flutter/material.dart';

class Npm extends StatefulWidget {
  const Npm({super.key});

  @override
  State<Npm> createState() => _NpmState();
}

class _NpmState extends State<Npm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("NPM"),
      ),
    );
  }
}
