import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/controller/dashboard_controller.dart';
import 'package:m_skool_flutter/staffs/widget/punch_lop.dart';
import 'package:m_skool_flutter/staffs/widget/staff_carasouel.dart';

class StaffDashboardContainer extends StatelessWidget {
  final StaffDashboardController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffDashboardContainer(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          controller.dashboardCoe.isEmpty
              ? const SizedBox()
              : StaffCarasouel(
                  loginSuccessModel: loginSuccessModel,
                  mList: controller.dashboardCoe,
                  mskoolController: mskoolController,
                ),
          controller.dashboardLop.isEmpty
              ? const SizedBox()
              : StaffPunchCardAndLop(
                  controller: controller,
                ),
          const SizedBox(
            height: 16.0,
          ),
          // // controller.dashboardLeaves.isEmpty
          // //     ? const SizedBox()
          // //     : StaffHomeLeave(
          // //         controller: controller,
          // //         loginSuccessModel: loginSuccessModel,
          // //         mskoolController: mskoolController,
          // //       ),
          // const SizedBox(
          //   height: 16.0,
          // ),
          // controller.dashboardTT.isEmpty
          //     ? const SizedBox()
          //     : StaffHomeTT(
          //         controller: controller,
          //         loginSuccessModel: loginSuccessModel,
          //         mskoolController: mskoolController,
          //       ),
          // const SizedBox(
          //   height: 16.0,
          // ),
        ],
      );
    });
  }
}
