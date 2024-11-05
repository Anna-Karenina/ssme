import 'package:flutter/material.dart';

void showToast(BuildContext ctx, String title, String description) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: SnakBarContent(title: title, description: description),
  ));
}

class SnakBarContent extends StatelessWidget {
  final String title;
  final String? description;

  const SnakBarContent({super.key, required this.title, this.description = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(description ?? ""),
      ],
    );
  }
}
