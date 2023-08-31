import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';

class ViewNoticeItem extends StatelessWidget {
  final String title;
  final String date;
  const ViewNoticeItem({
    Key? key,
    required this.color,
    required this.title,
    required this.date,
  }) : super(key: key);

  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      width: double.infinity,
      //height: 150,
      decoration: BoxDecoration(
        color: lighterColor.elementAt(color),
        // boxShadow: CustomThemeData.getShadow(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  backgroundColor: noticeColor.elementAt(color),
                  label: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  ),
                ),
                // const SizedBox(
                //   height: 12.0,
                // ),
                Text(
                  "Date : $date",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 12.0,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
