import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/online_leave/model/applied_leave_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class AppliedLeaveItem extends StatelessWidget {
  final int color;
  final AppliedLeaveModelValues value;
  const AppliedLeaveItem({super.key, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${value.hrelaPLeaveReason}",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "${value.hrmLLeaveName} | ${value.hrelaPTotalDays} Days",
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              TextStyle(
                                  letterSpacing: 0.2,
                                  fontSize: 14.0,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color),
                            ),
                      ),
                      // const SizedBox(
                      //   height: 2.0,
                      // ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(
                    "${value.hrelaPApplicationStatus}",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  ),
                  backgroundColor:
                      value.hrelaPApplicationStatus!.toLowerCase() == "rejected"
                          ? Colors.red
                          : value.hrelaPApplicationStatus!.toLowerCase() ==
                                  "applied"
                              ? Colors.grey.shade400
                              : Colors.green,
                )
              ],
            ),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: noticeBackgroundColor
                            .elementAt(color)
                            .withOpacity(0.3)),
                    child: Image.asset(
                      value.hrmLLeaveName!.toLowerCase() == "sick leave"
                          ? "assets/images/sl.png"
                          : value.hrmLLeaveName!.toLowerCase() == "casual leave"
                              ? "assets/images/cl.png"
                              : value.hrmLLeaveName!.toLowerCase() ==
                                      "emergency leave"
                                  ? "assets/images/el.png"
                                  : "assets/images/el.png",
                      color: noticeColor.elementAt(color),
                      width: 24.0,
                    )),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leave From : ",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color,
                              ),
                            ),
                      ),
                      Expanded(
                        child: Text(
                          "${getFormatedDate(DateTime.parse(value.hrelaPFromDate!))} - ${getFormatedDate(DateTime.parse(value.hrelaPToDate!))}",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
