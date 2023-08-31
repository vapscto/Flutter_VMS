import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryStatusDate extends StatelessWidget {
  final Color color;
  final String title;
  final String date;
  const LibraryStatusDate({
    Key? key,
    required this.color,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Get.size.width * 0.5) - 48,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: color,
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
            maxLines: 1,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            date,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          )
        ],
      ),
    );
  }
}
