import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/online_leave/api/get_applied_leave.dart';
import 'package:m_skool_flutter/vms/online_leave/api/leave_name.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/applied_leave_model.dart';
import 'package:m_skool_flutter/vms/online_leave/widget/all_applied_leave.dart';
import 'package:m_skool_flutter/vms/online_leave/widget/leaves.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class ApplyLeaveHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const ApplyLeaveHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<ApplyLeaveHomeScreen> createState() => _ApplyLeaveHomeScreenState();
}

class _ApplyLeaveHomeScreenState extends State<ApplyLeaveHomeScreen> {
  OpetionLeaveController opetionLeaveController =
      Get.put(OpetionLeaveController());
  _getLeave() async {
    opetionLeaveController.leaveloading(true);
    await LeaveNameApi.instance.getLeaves(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode(
          "leave",
          widget.mskoolController,
        ),
        opetionLeaveController: opetionLeaveController);
    opetionLeaveController.leaveloading(false);
  }

  @override
  void initState() {
    _getLeave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              opetionLeaveController.isLeaveloading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading leaves",
                      desc: "Please wait we are loading the leaves for you",
                      animationPath: "assets/json/default.json")
                  : opetionLeaveController.leaveNameList.isEmpty
                      ? const AnimatedProgressWidget(
                          title: "",
                          desc: "Leave types not available",
                          animationPath: "assets/json/nodata.json")
                      : Leaves(
                          leaves: opetionLeaveController.leaveNameList,
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                        ),
              FutureBuilder<List<AppliedLeaveModelValues>>(
                  future: GetAppliedLeave.instance.getAppliedLeave(
                      miId: widget.loginSuccessModel.mIID!,
                      userId: widget.loginSuccessModel.userId!,
                      base:
                          baseUrlFromInsCode("leave", widget.mskoolController)),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return const AnimatedProgressWidget(
                          title: "No Leave Applied",
                          desc: "There are no leave applied by you...",
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AppliedLeaveWidget(
                          leaves: snapshot.data!,
                          mskoolController: widget.mskoolController,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return ErrWidget(
                          err: snapshot.error as Map<String, dynamic>);
                    }

                    return const AnimatedProgressWidget(
                        title: "Loading applied leaves",
                        desc:
                            "Please wait we are loading the leaves you applied for",
                        animationPath: "assets/json/default.json");
                  }),
            ],
          ),
        );
      }),
    );
  }
}
