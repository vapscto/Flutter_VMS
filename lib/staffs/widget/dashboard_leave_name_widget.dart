import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_leave_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class DashboardLeaveNames extends StatelessWidget {
  final int backgroundColor;
  final DashboardLeaveModelValues values;

  const DashboardLeaveNames({
    super.key,
    required this.backgroundColor,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.4,
      child: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (_) {
          //   return OnlineLeaveApply(
          //     loginSuccessModel: loginSuccessModel,
          //     mskoolController: mskoolController,
          //     title: 'Online Leave Apply',
          //   );
          // }));
        },
        child: CustomContainer(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: values.hRELSTotalLeaves == null ||
                            values.hRELSCBLeaves == null ||
                            values.hRELSTotalLeaves == null
                        ? 0
                        : (values.hRELSTotalLeaves! - values.hRELSCBLeaves!) /
                            values.hRELSTotalLeaves!.toDouble().toDouble(),
                    backgroundColor: noticeBackgroundColor
                        .elementAt(backgroundColor)
                        .withOpacity(0.8),
                    color: noticeColor.elementAt(backgroundColor),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: values.hRMLLeaveCode == null
                          ? Image.asset("assets/images/el.png")
                          : Image.asset(
                              values.hRMLLeaveCode!.toLowerCase() == "sl"
                                  ? "assets/images/sl.png"
                                  : values.hRMLLeaveCode!.toLowerCase() == "cl"
                                      ? "assets/images/cl.png"
                                      : values.hRMLLeaveCode!.toLowerCase() ==
                                              "el"
                                          ? "assets/images/el.png"
                                          : "assets/images/el.png",
                              color: noticeColor.elementAt(backgroundColor),
                              width: 24.0,
                            )),
                ],
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      values.hRELSCBLeaves == null
                          ? "N/A"
                          : "${values.hRELSCBLeaves!.toInt()}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      values.hRMLLeaveName ?? "N/A",
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
