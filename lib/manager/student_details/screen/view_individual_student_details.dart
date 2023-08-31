import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_academic_history.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_student_details.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/tabs/view_details_tabs/academic.dart';
import 'package:m_skool_flutter/manager/student_details/tabs/view_details_tabs/attendance.dart';
import 'package:m_skool_flutter/manager/student_details/tabs/view_details_tabs/exam.dart';
import 'package:m_skool_flutter/manager/student_details/tabs/view_details_tabs/fee.dart';
import 'package:m_skool_flutter/manager/student_details/tabs/view_details_tabs/personal.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_tab_bar_2.dart';

class ViewStudentIndividualDetails extends StatefulWidget {
  final int miId;
  final String baseUrl;
  final int asmayId;
  final int amstId;
  const ViewStudentIndividualDetails(
      {super.key,
      required this.asmayId,
      required this.amstId,
      required this.miId,
      required this.baseUrl});

  @override
  State<ViewStudentIndividualDetails> createState() =>
      _ViewStudentIndividualDetailsState();
}

class _ViewStudentIndividualDetailsState
    extends State<ViewStudentIndividualDetails>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final ViewStudentDetailsController studentDetailsController =
      Get.put(ViewStudentDetailsController());
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);

    GetStudentDetailsApi.instance.getDetails(
      miId: widget.miId,
      amstId: widget.amstId,
      asmayId: widget.asmayId,
      base: widget.baseUrl,
      controller: studentDetailsController,
    );
    GetAcademicHistoryApi.instance.getHistory(
        miId: widget.miId,
        amstId: widget.amstId,
        asmayId: widget.asmayId,
        base: widget.baseUrl,
        controller: studentDetailsController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "View Details").getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar2(
              tabController: tabController!,
              tabs: const [
                CustomTab(name: "Academic"),
                CustomTab(name: "Personal"),
                CustomTab(name: "Attendance"),
                CustomTab(name: "Fee"),
                CustomTab(name: "Exam"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController!,
              children: [
                AcademicTab(
                  controller: studentDetailsController,
                ),
                PersonalTab(
                  controller: studentDetailsController,
                ),
                AttendanceTab(
                  controller: studentDetailsController,
                ),
                FeeTab(
                  controller: studentDetailsController,
                ),
                ExamTab(
                  controller: studentDetailsController,
                  amstId: widget.amstId,
                  asmayId: widget.asmayId,
                  miId: widget.miId,
                  base: widget.baseUrl,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
