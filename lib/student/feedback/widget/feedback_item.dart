import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/student/feedback/model/get_feed_model.dart';

class FeedBackItem extends StatelessWidget {
  final Color color;
  final FeedBacksModelValues feedBacks;
  const FeedBackItem({
    Key? key,
    required this.feedBacks,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
            child: Text(
              getFormatedDate(DateTime.parse(feedBacks.asgfEFeedbackDate!)),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .merge(const TextStyle(color: Colors.white)),
            ),
          ),
          // const Divider(
          //   thickness: 1,
          //   height: 1,
          // ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Text(
              feedBacks.asgfEFeedBack!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
