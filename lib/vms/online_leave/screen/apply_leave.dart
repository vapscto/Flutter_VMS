import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_name_model.dart';
import 'package:m_skool_flutter/vms/online_leave/widget/apply_leave_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ApplyForLeave extends StatefulWidget {
  final LeaveNamesModelValues values;
  final Color color;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final OpetionLeaveController controller;
  const ApplyForLeave(
      {super.key,
      required this.values,
      required this.color,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<ApplyForLeave> createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForLeave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Apply Leave").getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ApplyLeaveWidget(
                values: widget.values,
                controller: widget.controller,
                color: widget.color,
                loginSuccessModel: widget.loginSuccessModel,
                mskoolController: widget.mskoolController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
