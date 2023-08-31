import 'package:flutter/material.dart';

class LibrarySubItem extends StatelessWidget {
  final String title;
  final String value;
  const LibrarySubItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        const Text(":"),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
