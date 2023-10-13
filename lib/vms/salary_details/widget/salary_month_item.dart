import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class SalaryMonthItem extends StatelessWidget {
  final String month;
  final double salary;
  const SalaryMonthItem({
    Key? key,
    required this.color,
    required this.month,
    required this.salary,
  }) : super(key: key);

  final int color;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Container(
        decoration: BoxDecoration(
          color: noticeBackgroundColor.elementAt(color).withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Text(
                    month,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0))),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹$salary",
                    style: Theme.of(context).textTheme.titleMedium!.merge(
                        TextStyle(
                            color: noticeColor.elementAt(color),
                            fontSize: 20.0)),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Net Salary",
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                        TextStyle(
                            letterSpacing: 0.2,
                            color: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .color)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
