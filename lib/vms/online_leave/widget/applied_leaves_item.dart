import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/applied_leave_model.dart';
import 'package:m_skool_flutter/vms/online_leave/widget/approval_widget.dart';
import 'package:m_skool_flutter/vms/online_leave/widget/proxy_list.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class AppliedLeaveItem extends StatelessWidget {
  final int color;
  final AppliedLeaveModelValues value;
  final MskoolController mskoolController;
  const AppliedLeaveItem(
      {super.key,
      required this.color,
      required this.value,
      required this.mskoolController});

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
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (value.leaveCode == 'PL')
                    ? InkWell(
                        onTap: () {
                          if (value.proxy != null) {
                            Get.dialog(ProxyListPopUp(value: value));
                          } else {
                            Fluttertoast.showToast(msg: "No Proxy Added");
                          }
                        },
                        child: Chip(
                          label: Text(
                            "Proxy",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      )
                    : const SizedBox(),
                value.hrelaPApplicationStatus!.toLowerCase() == "applied"
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: noticeColor.elementAt(color)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return ApprovalWidget(
                                          hrmeId: value.hrelaPId!,
                                          mskoolController: mskoolController,
                                        );
                                      });
                                  // Get.dialog(ApprovalWidget(
                                  //   hrmeId: value.hrelaPId!,
                                  //   mskoolController: mskoolController,
                                  // ));
                                },
                                child: const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
