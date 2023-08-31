import 'package:flutter/material.dart';
import 'package:m_skool_flutter/staffs/online_leave/model/applied_leave_model.dart';
import 'package:m_skool_flutter/staffs/online_leave/widget/applied_leaves_item.dart';

class AppliedLeaveWidget extends StatelessWidget {
  final List<AppliedLeaveModelValues> leaves;
  const AppliedLeaveWidget({
    Key? key,
    required this.leaves,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int color = -1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Leave Status",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .merge(const TextStyle(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(
          height: 16.0,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            color += 1;

            if (index % 6 == 0) {
              color = 0;
            }
            if (color > 6) {
              color = 0;
            }

            return AppliedLeaveItem(
              color: color,
              value: leaves.elementAt(index),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 16.0,
            );
          },
          itemCount: leaves.length,
        )
      ],
    );
  }
}
