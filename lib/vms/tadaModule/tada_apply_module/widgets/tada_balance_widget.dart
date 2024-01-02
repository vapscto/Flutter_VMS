import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/applied_deta_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/check_apply_planner_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

import '../../../../widget/animated_progress_widget.dart';

class TadaBalanceWidget extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final TabController tabController;
  const TadaBalanceWidget(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.tabController});

  @override
  State<TadaBalanceWidget> createState() => _TadaBalanceWidgetState();
}

class _TadaBalanceWidgetState extends State<TadaBalanceWidget> {
  TadaApplyDataController tadaApplyDataController =
      Get.put(TadaApplyDataController());

  savedDataListAPI() async {
    tadaApplyDataController.appliedData(true);
    await AppliedDataAPI.instance.tadaAppliedListAPI(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        tadaApplyController: tadaApplyDataController);
    for (int i = 0;
        i < tadaApplyDataController.tadaSavedDataValues.length;
        i++) {
      checkPlanner(
          tadaApplyDataController.tadaSavedDataValues[i].vtadaaAFromDate!,
          tadaApplyDataController.tadaSavedDataValues[i].vtadaaAToDate!);
    }
    tadaApplyDataController.appliedData(false);
  }

  checkPlanner(String date, String todate1) async {
    tadaApplyDataController.plannerCreate(true);
    await CheckPlannerAPI.instance.applyCheckPlannerAPI(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        fromDate: date,
        toDate: todate1,
        tadaApplyController: tadaApplyDataController);
    tadaApplyDataController.plannerCreate(false);
  }

  @override
  void initState() {
    savedDataListAPI();
    super.initState();
  }

  @override
  void dispose() {
    currentTab.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (tadaApplyDataController.isAppliedDataLoading.value)
          ? const Center(
              child: AnimatedProgressWidget(
                  title: "Loading TA-DA Entry",
                  desc:
                      "Please wait while we load TA-DA entry and create a view for you.",
                  animationPath: "assets/json/default.json"),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note:",
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "* TA-DA Should Applied Only Below 30 Days",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.red, fontSize: 10),
                      ),
                      Text(
                        "*  When Daily Report Not Generate Ta Da Not Avalible For apply",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.red, fontSize: 10),
                      ),
                      Text(
                        "* Old Balance Not Clear Ta Da Not Avalible For apply",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.red, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                (tadaApplyDataController.tadaSavedDataValues.isEmpty)
                    ? const Center(
                        child: AnimatedProgressWidget(
                          title: "No Record Found",
                          desc: "",
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: DataTable(
                              dataRowHeight: 35,
                              headingRowHeight: 45,
                              columnSpacing: 20,
                              headingTextStyle:
                                  const TextStyle(color: Colors.white),
                              border: TableBorder.all(
                                color: Colors.black,
                                width: 0.6,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(label: Text("SL.NO.")),
                                DataColumn(label: Text("City")),
                                DataColumn(label: Text("Total Applied Amount")),
                                DataColumn(
                                    label: Text("Total Sactioned Amount")),
                                DataColumn(label: Text("Total Paid Amount")),
                                DataColumn(label: Text("From Date")),
                                DataColumn(label: Text("To Date")),
                                DataColumn(label: Text("Action")),
                                // DataColumn(label: Text("View")),
                              ],
                              rows: List.generate(
                                  tadaApplyDataController
                                      .tadaSavedDataValues.length, (index) {
                                var value = index + 1;

                                if (tadaApplyDataController
                                        .tadaSavedDataValues[index]
                                        .vtadaaAFromDate !=
                                    null) {
                                  DateTime dt = DateTime.parse(
                                      tadaApplyDataController
                                          .tadaSavedDataValues[index]
                                          .vtadaaAFromDate!);
                                  date = '${dt.day}-${dt.month}-${dt.year}';
                                }
                                if (tadaApplyDataController
                                        .tadaSavedDataValues[index]
                                        .vtadaaAToDate !=
                                    null) {
                                  DateTime dt = DateTime.parse(
                                      tadaApplyDataController
                                          .tadaSavedDataValues[index]
                                          .vtadaaAToDate!);
                                  toDate = '${dt.day}-${dt.month}-${dt.year}';
                                }

                                return DataRow(cells: [
                                  DataCell(Text(value.toString())),
                                  DataCell(Text(tadaApplyDataController
                                      .tadaSavedDataValues[index]
                                      .ivrmmcTName!)),
                                  DataCell(Text(tadaApplyDataController
                                      .tadaSavedDataValues[index]
                                      .vtadaaATotalAppliedAmount
                                      .toString())),
                                  DataCell(Text(tadaApplyDataController
                                      .tadaSavedDataValues[index]
                                      .vtadaaATotalSactionedAmount
                                      .toString())),
                                  DataCell(Text(tadaApplyDataController
                                      .tadaSavedDataValues[index]
                                      .vtadaaATotalPaidAmount
                                      .toString())),
                                  DataCell(Text(date)),
                                  DataCell(Text(toDate)),
                                  DataCell(IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (tadaApplyDataController
                                              .checkPlanner.isNotEmpty) {
                                            tadaApplyDataController
                                                .tadaSavedData
                                                .add(tadaApplyDataController
                                                        .tadaSavedDataValues[
                                                    index]);
                                            widget.tabController.index = 0;
                                          } else {
                                            Get.dialog(showPopup());
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_upward,
                                        color: Theme.of(context).primaryColor,
                                      ))),
                                  // DataCell(IconButton(
                                  //     onPressed: () {
                                  //       Get.dialog(const AppliedListWidget());
                                  //     },
                                  //     icon: const Icon(Icons.visibility))),
                                ]);
                              })),
                        ),
                      ),
              ],
            );
    });
  }

  var date = '';
  var toDate = '';

  showPopup() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(10),
      content: WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Daily report is not generated between dates !",
                textAlign: TextAlign.center,
                style: Get.textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 40),
              MSkollBtn(
                  title: "OK",
                  onPress: () {
                    setState(() {
                      Get.back();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
