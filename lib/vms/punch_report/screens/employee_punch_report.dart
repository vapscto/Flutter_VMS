import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/punch_report/api/punch_api.dart';
import 'package:m_skool_flutter/vms/punch_report/controller/punch_filter_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

import '../../../controller/mskoll_controller.dart';

class EmployeePunchReport extends StatefulWidget {
  final String title;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String? previousScreen;
  final PunchFilterController punchFilterController;
  const EmployeePunchReport(
      {super.key,
      required this.title,
      required this.loginSuccessModel,
      required this.mskoolController,
      this.previousScreen,
      required this.punchFilterController});

  @override
  State<EmployeePunchReport> createState() => _EmployeePunchReportState();
}

class _EmployeePunchReportState extends State<EmployeePunchReport> {
  // PunchFilterController punchFilterController =
  //     Get.put(PunchFilterController());
  // _getPunch() async {
  //   punchFilterController.punchLoading(true);
  //   await PunchApi.instance.pcReports(
  //       body: {
  //         "UserId": widget.loginSuccessModel.userId,
  //         "MI_Id": widget.loginSuccessModel.mIID,
  //         "IVRMRT_Id": widget.loginSuccessModel.roleId!,
  //         "ASMAY_Id": widget.loginSuccessModel.asmaYId
  //       },
  //       base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
  //       controller: punchFilterController);
  //   punchFilterController.punchLoading(false);
  // }

  @override
  void initState() {
    // _getPunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          centerTitle: (widget.previousScreen == '0') ? false : true,
          // titleSpacing: 0,
          leading: (widget.previousScreen == '0')
              ? const CustomGoBackButton()
              : const SizedBox(),
        ),
        body: widget.punchFilterController.isPunchLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Punch Report",
                    desc: "Please wait, While we load Punch Report for you.",
                    animationPath: "assets/json/default.json"),
              )
            : widget.punchFilterController.currentPunchList.isEmpty
                ? Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg": widget.punchFilterController.message.value,
                      },
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                              dataRowHeight: 35,
                              headingRowHeight: 40,
                              columnSpacing: 20,
                              headingTextStyle:
                                  const TextStyle(color: Colors.white),
                              border: TableBorder.all(
                                color: Colors.black,
                                width: 0.6,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(label: Text("SL.NO.")),
                                DataColumn(label: Text("Punch Date")),
                                DataColumn(label: Text("In Time	")),
                                DataColumn(label: Text("Out Time")),
                                DataColumn(label: Text("Working Hours")),
                              ],
                              rows: List.generate(
                                  widget.punchFilterController.currentPunchList
                                      .length, (index) {
                                var i = index + 1;
                                var v = widget
                                    .punchFilterController.currentPunchList
                                    .elementAt(index);
                                return DataRow(cells: [
                                  DataCell(Text(i.toString())),
                                  DataCell(Text(v.punchdate!)),
                                  DataCell(Text(v.intime!)),
                                  DataCell(
                                    Text(
                                      v.outtime.toString(),
                                      style: TextStyle(
                                          color: (double.parse(v.workingtime
                                                          .toString()
                                                          .replaceAll(
                                                              ":", ".")) <
                                                      double.parse('8.00') &&
                                                  v.workingtime != '00:00')
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                  ),
                                  DataCell(
                                    Text(v.workingtime.toString()),
                                  ),
                                ]);
                              })),
                        ),
                      )
                    ],
                  ),
      );
    });
  }
}
