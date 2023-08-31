import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class DashboardLeaveWidget extends StatelessWidget {
  final DynamicAnalyticsController dashboardController;
  const DashboardLeaveWidget({super.key, required this.dashboardController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.55,
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  visualDensity: const VisualDensity(
                      vertical: VisualDensity.minimumDensity),
                  title: Text(
                    "Staff Leave",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                        ),
                  ),
                  trailing: Chip(
                    backgroundColor: const Color(0xFFF8FFD6),
                    label: Text(
                        getFormatedDate(DateTime.now().toLocal()).substring(
                          0,
                          getFormatedDate(DateTime.now().toLocal()).length - 4,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(const TextStyle(color: Color(0xFF97AE1F)))),
                  ),
                ),
                Image.asset(
                  "assets/images/leave.png",
                  width: 50,
                ),
                Text(
                  "${dashboardController.dashboardLeave.first.totalLeave ?? 0} Members",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0xFFFFEBEA)),
              child: Text(
                "${dashboardController.dashboardLeave.first.appliedLeave ?? "N/a"} Members Applied for Leave Approval ",
                style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(color: Color(0xFFFF6F67), fontSize: 13.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
