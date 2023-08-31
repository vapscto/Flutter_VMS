import 'package:flutter/material.dart';
import 'package:m_skool_flutter/staffs/controller/dashboard_controller.dart';
import 'package:m_skool_flutter/staffs/widget/staff_home_lop.dart';
import 'package:m_skool_flutter/staffs/widget/staff_punch_report.dart';

class StaffPunchCardAndLop extends StatelessWidget {
  final StaffDashboardController controller;
  const StaffPunchCardAndLop({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: controller.dashboardLop.isEmpty
              ? const SizedBox()
              : StaffHomeLop(
                  value: controller.dashboardLop.first,
                ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
            child: controller.dashboardPunch.isEmpty
                ? const SizedBox()
                : StaffPunchReport(
                    values: controller.dashboardPunch.first,
                  ))
      ],
    );
  }
}
