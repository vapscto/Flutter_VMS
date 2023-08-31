import 'package:flutter/material.dart';

class ReferenceItem extends StatelessWidget {
  final TextEditingController controller;

  const ReferenceItem({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .merge(const TextStyle(color: Colors.blueAccent)),
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Provide reference here. e.g: Url",
        ),
      ),
    );
  }
}
