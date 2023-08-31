import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "Please Wait",
            style: Theme.of(context).textTheme.titleMedium!.merge(
                  const TextStyle(fontSize: 20.0),
                ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
