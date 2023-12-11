import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrnotApproveScreen extends StatelessWidget {
  const DrnotApproveScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .merge(TextStyle(color: Theme.of(context).primaryColor)),
            ),
            const SizedBox(height: 16),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "OK",
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ))
          ],
        ),
      ),
    );
  }
}
