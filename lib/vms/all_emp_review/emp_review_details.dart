import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
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
  final String year;
  const EmpRatingDetails(
      {super.key,
      required this.controller,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.data,
      required this.year});

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
    widget.controller.rating(true);
    await AllEmpRatingAPI.i.ratingList(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "UserId": widget.loginSuccessModel.userId,
          "year": widget.year,
          "arrayuserEmp": empList,
          "flag": "A",
          // "arrayuserdes": [
          //   {"HRMDES_Id": 408},
          //   {"HRMDES_Id": 373},
          //   {"HRMDES_Id": 406},
          //   {"HRMDES_Id": 596},
          //   {"HRMDES_Id": 444},
          //   {"HRMDES_Id": 512},
          //   {"HRMDES_Id": 438},
          //   {"HRMDES_Id": 342},
          //   {"HRMDES_Id": 474},
          //   {"HRMDES_Id": 475},
          //   {"HRMDES_Id": 479},
          //   {"HRMDES_Id": 481},
          //   {"HRMDES_Id": 483},
          //   {"HRMDES_Id": 429},
          //   {"HRMDES_Id": 473},
          //   {"HRMDES_Id": 299},
          //   {"HRMDES_Id": 298},
          //   {"HRMDES_Id": 426},
          //   {"HRMDES_Id": 296},
          //   {"HRMDES_Id": 314},
          //   {"HRMDES_Id": 388},
          //   {"HRMDES_Id": 478},
          //   {"HRMDES_Id": 485},
          //   {"HRMDES_Id": 476},
          //   {"HRMDES_Id": 477},
          //   {"HRMDES_Id": 482},
          //   {"HRMDES_Id": 484},
          //   {"HRMDES_Id": 529},
          //   {"HRMDES_Id": 545},
          //   {"HRMDES_Id": 409},
          //   {"HRMDES_Id": 3},
          //   {"HRMDES_Id": 318},
          //   {"HRMDES_Id": 319}
          // ],
          // "departmentlist": [
          //   {"HRMDC_ID": 1, "HRMD_ID": 0},
          //   {"HRMDC_ID": 2, "HRMD_ID": 0},
          //   {"HRMDC_ID": 3, "HRMD_ID": 0},
          //   {"HRMDC_ID": 4, "HRMD_ID": 0},
          //   {"HRMDC_ID": 5, "HRMD_ID": 0},
          //   {"HRMDC_ID": 6, "HRMD_ID": 0},
          //   {"HRMDC_ID": 7, "HRMD_ID": 0},
          //   {"HRMDC_ID": 8, "HRMD_ID": 0},
          //   {"HRMDC_ID": 9, "HRMD_ID": 0},
          //   {"HRMDC_ID": 16, "HRMD_ID": 0},
          //   {"HRMDC_ID": 17, "HRMD_ID": 0},
          //   {"HRMDC_ID": 18, "HRMD_ID": 0},
          //   {"HRMDC_ID": 19, "HRMD_ID": 0},
          //   {"HRMDC_ID": 20, "HRMD_ID": 0},
          //   {"HRMDC_ID": 21, "HRMD_ID": 0},
          //   {"HRMDC_ID": 22, "HRMD_ID": 0},
          //   {"HRMDC_ID": 23, "HRMD_ID": 0}
          // ],
          // "monthList": monthList,
          // "ratingtypelist": [
          //   {"RATMT_Id": 76},
          //   {"RATMT_Id": 77},
          //   {"RATMT_Id": 78},
          //   {"RATMT_Id": 79},
          //   {"RATMT_Id": 80},
          //   {"RATMT_Id": 81},
          //   {"RATMT_Id": 82},
          //   {"RATMT_Id": 83},
          //   {"RATMT_Id": 84},
          //   {"RATMT_Id": 85},
          //   {"RATMT_Id": 86},
          //   {"RATMT_Id": 87},
          //   {"RATMT_Id": 88},
          //   {"RATMT_Id": 89},
          //   {"RATMT_Id": 90},
          //   {"RATMT_Id": 91},
          //   {"RATMT_Id": 92},
          //   {"RATMT_Id": 93},
          //   {"RATMT_Id": 94},
          //   {"RATMT_Id": 95},
          //   {"RATMT_Id": 96},
          //   {"RATMT_Id": 97},
          //   {"RATMT_Id": 98},
          //   {"RATMT_Id": 99},
          //   {"RATMT_Id": 100},
          //   {"RATMT_Id": 101},
          //   {"RATMT_Id": 102},
          //   {"RATMT_Id": 103},
          //   {"RATMT_Id": 104},
          //   {"RATMT_Id": 105},
          //   {"RATMT_Id": 106},
          //   {"RATMT_Id": 107},
          //   {"RATMT_Id": 108},
          //   {"RATMT_Id": 109},
          //   {"RATMT_Id": 110}
          // ],
        },
        controller: widget.controller);
    widget.controller.rating(false);
  }

  int bgColor = -1;

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
            : (widget.controller.ratingDataList.isEmpty)
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "",
                    animatorHeight: 250,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      bgColor += 1;
                      if (bgColor % 6 == 0) {
                        bgColor = 0;
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: lighterColor.elementAt(bgColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name:-${widget.controller.ratingDataList.elementAt(index).employeeName}",
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                    "Average Rating:-${widget.controller.ratingDataList.elementAt(index).rating} "),
                              ]),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    itemCount: widget.controller.ratingDataList.length);
      }),
    );
  }
}
