import 'package:flutter/material.dart';

class PunchReportItem extends StatelessWidget {
  final String title;
  final String time;
  const PunchReportItem({
    Key? key,
    required this.title,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  TextStyle(
                      fontWeight: FontWeight.w500,
                      //color: Theme.of(context).textTheme.titleMedium!.color,
                      fontSize:
                          Theme.of(context).textTheme.labelMedium!.fontSize,
                      letterSpacing: 0.2),
                ),
          ),
        ),
        const SizedBox(width: 12.0),
        const Text(" : "),
        const SizedBox(width: 12.0),
        Expanded(
            flex: 6,
            child: Text(
              time,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .merge(const TextStyle(fontWeight: FontWeight.w600)),
            ))
      ],
    );
  }
}
