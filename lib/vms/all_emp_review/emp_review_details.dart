import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/api/all_emp_rating_api.dart';
import 'package:m_skool_flutter/vms/all_emp_review/controller/all_emp_rating_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class EmpRatingDetails extends StatefulWidget {
  final EmpRatingController controller;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final String data;
  const EmpRatingDetails(
      {super.key,
      required this.controller,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.data});

  @override
  State<EmpRatingDetails> createState() => _EmpRatingDetailsState();
}

class _EmpRatingDetailsState extends State<EmpRatingDetails> {
  List<Map<String, dynamic>> empList = [];
  List<Map<String, dynamic>> monthList = [];
  _getData() async {
    empList.clear();
    for (int i = 0; i < widget.controller.selectedEmployeeList.length; i++) {
      empList
          .add({"HRME_Id": widget.controller.selectedEmployeeList[i].hRMEId});
    }
    monthList.clear();
    for (int j = 0; j < widget.controller.selectedMonthList.length; j++) {
      monthList.add({
        "IVRM_Month_Id": widget.controller.selectedMonthList[j].ivrMMonthId,
        "IVRM_Month_Name":
            "${widget.controller.selectedMonthList[j].ivrMMonthName}"
      });
    }
    logger.i(monthList);
    logger.v(empList);
    widget.controller.rating(true);
    await AllEmpRatingAPI.i.ratingList(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "UserId": widget.loginSuccessModel.userId,
          "Role_flag": "A",
          "IVRMRT_Id": widget.loginSuccessModel.roleId,
          "arrayuserEmp": empList,
          "arrayuserdes": [],
          "departmentlist": [],
          "monthList": monthList,
          "ratingtypelist": [],
          "flag": widget.data
        },
        controller: widget.controller);
    widget.controller.rating(false);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Rating Details").getAppBar(),
      body: Obx(() {
        return widget.controller.isRatingLoading.value
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading",
                desc: "We are under process to get your details from server.")
            // : (controller.employeeList.isEmpty)
            //     ? const AnimatedProgressWidget(
            //         animationPath: 'assets/json/nodata.json',
            //         title: 'Data is not available',
            //         desc: "",
            //         animatorHeight: 250,
            //       )
            : ListView.separated(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemBuilder: (context, index) {
                  return Container();
                },
                separatorBuilder: (_, index) {
                  return const SizedBox(height: 8);
                },
                itemCount: 0);
      }),
    );
  }
}
