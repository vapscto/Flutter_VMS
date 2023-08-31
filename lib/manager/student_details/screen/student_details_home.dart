import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/student_details/controller/custom_search_handler.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/tabs/all_student.dart';
import 'package:m_skool_flutter/manager/student_details/tabs/individual.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ManagerStudentDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const ManagerStudentDetails(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<ManagerStudentDetails> createState() => _ManagerStudentDetailsState();
}

class _ManagerStudentDetailsState extends State<ManagerStudentDetails>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final StudentDetailsController studentDetails =
      Get.put(StudentDetailsController());
  final CustomSearchHandler handler = Get.put(CustomSearchHandler());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StudentDetailsController>();
    Get.delete<CustomSearchHandler>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Student Details",
      ).getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            // height: 55,
            child: CustomTabBar(tabs: const [
              CustomTab(name: "Individual", asset: "assets/svg/user.svg"),
              CustomTab(name: "All Student", asset: "assets/svg/users.svg"),
            ], tabController: tabController!),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController!,
              children: [
                IndividualTab(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  studentDetails: studentDetails,
                ),
                AllStudent(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  handler: handler,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
