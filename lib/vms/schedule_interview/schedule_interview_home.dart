import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/schedule_interview/controller/schedule_interview_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ScheduleInterviewHome extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const ScheduleInterviewHome(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<ScheduleInterviewHome> createState() => _ScheduleInterviewHomeState();
}

class _ScheduleInterviewHomeState extends State<ScheduleInterviewHome> {
  final candidateName = TextEditingController();
  final interviewDate = TextEditingController();
  final interviewRound = TextEditingController();
  final intviewerName = TextEditingController();
  final address = TextEditingController();
  final status = TextEditingController();
  ScheduleInterviewController controller =
      Get.put(ScheduleInterviewController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Schedule Interview').getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [],
      ),
    );
  }
}
