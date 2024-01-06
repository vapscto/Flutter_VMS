import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/add_extra_task_api.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/add_extra_task_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class AddExtraTaskScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PlannerDetails controller;
  const AddExtraTaskScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<AddExtraTaskScreen> createState() => _AddExtraTaskScreenState();
}

class _AddExtraTaskScreenState extends State<AddExtraTaskScreen> {
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  List<AddExtraTaskModelValues> fliteresList = [];
  AddExtraTaskModelValues? addExtraTaskModelValues;

  getExtraTask() async {
    widget.controller.updateErrorLoadingaddExtraTaskDR(true);
    await AddExtraTaskAPI.instance.addExtraTaskDR(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        mIId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        roleId: widget.loginSuccessModel.roleId!,
        ismDate: DateTime.now().toIso8601String(),
        controller: widget.controller);
    widget.controller.updateErrorLoadingaddExtraTaskDR(false);
  }

  List<int>? selectCheckBx = <int>[].obs;
  bool addPlanner = false;
  @override
  void initState() {
    getExtraTask();
    super.initState();
  }

  @override
  void dispose() {
    fliteresList.clear();
    super.dispose();
  }

  String startDate = '';
  String endDate = '';
  addExtraTaskToDR() {
    for (int i = 0; i < fliteresList.length; i++) {
      var v = fliteresList.elementAt(i);
      widget.controller.getTaskDrList.add(GetTaskDrListModelValues(
        iSMTCRId: v.iSMTCRId,
        hRMPRId: v.hRMPRId,
        hRMPName: v.hRMPName,
        iSMTCRBugOREnhancementFlg: v.iSMTCRBugOREnhancementFlg,
        iSMTCRCreationDate: v.iSMTCRCreationDate,
        iSMTCRTitle: v.iSMTCRTitle,
        iSMTCRDesc: v.iSMTCRDesc,
        iSMTCRStatus: v.iSMTCRStatus,
        iSMTCRReOpenFlg: v.iSMTCRReOpenFlg,
        iSMTCRTaskNo: v.iSMTCRTaskNo,
        iSMMCLTId: v.iSMMCLTId,
        iSMMCLTClientName: v.iSMMCLTClientName,
        iSMTPLStartDate: v.startdatenew,
        iSMTPLEndDate: v.enddatenew,
        iSMTPLTAStartDate: v.startdatenew,
        iSMTPLTAEndDate: v.startdatenew,
        assignedby: v.assignedby,
        createdemp: v.createdby,
        taskcategoryname: v.taskcategoryname,
        iSMMTCATId: v.iSMMTCATId,
        periodicitydailyflag: v.addtoplannerflag,
        iSMTAPLToDate: v.startdatenew,
        periodicityweeklyflag: v.addtoplannerflag,
        iSMMTCATCompulsoryFlg: v.iSMMTCATCompulsoryFlg,
        iSMDRPTTimeTakenInHrsmins: v.iSMDRPTTimeTakenInHrsmin,
        effortss: v.efforts,
        iSMTPLTAEffortInHrs: v.iSMTPLTAEffortInHrs,
        iSMDRPTRemarks: widget.controller.remarksController.elementAt(i).text,
        iSMDRPTStatus: v.iSMTCRStatus,
        iSMDRPTTimeTakenInHrs: v.iSMTPLTAEffortInHrs,
        drFlag: 0,
        hRMEId: v.hRMEId,
        createdFlag: v.createdFlag,
        // iSMMCLTId: widget.controller.addExtraTaskList.elementAt(i).iSMMCLTId,
        // iSMMTCATId: widget.controller.addExtraTaskList.elementAt(i).iSMMTCATId,
        // hRMPRId: widget.controller.addExtraTaskList.elementAt(i).hRMPRId,
        // hRMEId: widget.controller.addExtraTaskList.elementAt(i).hRMEId,
        // hRMPName: widget.controller.addExtraTaskList.elementAt(i).hRMPName,
        // iSMTCRReOpenFlg:
        //     widget.controller.addExtraTaskList.elementAt(i).iSMTCRReOpenFlg,
        // iSMTCRDesc: widget.controller.addExtraTaskList.elementAt(i).iSMTCRDesc,
        // iSMDRPTStatus:
        //     widget.controller.addExtraTaskList.elementAt(i).iSMTCRStatus,
        // createdFlag:
        //     widget.controller.addExtraTaskList.elementAt(i).createdFlag,
        // iSMTPLTAEffortInHrs:
        //     widget.controller.addExtraTaskList.elementAt(i).iSMTPLTAEffortInHrs,
        // iSMMTCATCompulsoryFlg: widget.controller.addExtraTaskList
        //     .elementAt(i)
        //     .iSMMTCATCompulsoryFlg,
        // iSMTCRId: widget.controller.addExtraTaskList.elementAt(i).iSMTCRId,
        // iSMTCRTitle:
        //     widget.controller.addExtraTaskList.elementAt(i).iSMTCRTitle,
        // iSMTCRTaskNo:
        //     widget.controller.addExtraTaskList.elementAt(i).iSMTCRTaskNo,
        // iSMTCRBugOREnhancementFlg: widget.controller.addExtraTaskList
        //     .elementAt(i)
        //     .iSMTCRBugOREnhancementFlg,
        // iSMMCLTClientName:
        //     widget.controller.addExtraTaskList.elementAt(i).iSMMCLTClientName,
        // createdemp: widget.controller.addExtraTaskList.elementAt(i).createdby,
        // iSMTCRCreationDate:
        //     widget.controller.addExtraTaskList.elementAt(i).iSMTCRCreationDate,
        // taskcategoryname:
        //     widget.controller.addExtraTaskList.elementAt(i).taskcategoryname,
        // assignedby: widget.controller.addExtraTaskList.elementAt(i).assignedby,
        // iSMTPLStartDate:
        //     widget.controller.addExtraTaskList.elementAt(i).startdatenew,
        // iSMTPLEndDate:
        //     widget.controller.addExtraTaskList.elementAt(i).enddatenew,
        // iSMDRPTRemarks: widget.controller.remarksController.elementAt(i).text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ADD EXTRA TASK"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BtnSave(
                onPress: () async {
                  if (fliteresList.isNotEmpty) {
                    fliteresList.map((v) {
                      return GetTaskDrListModelValues(
                        type: v.type,
                        iSMTCRId: v.iSMTCRId,
                        hRMPRId: v.hRMPRId,
                        hRMPName: v.hRMPName,
                        iSMTCRBugOREnhancementFlg: v.iSMTCRBugOREnhancementFlg,
                        iSMTCRCreationDate: v.iSMTCRCreationDate,
                        iSMTCRTitle: v.iSMTCRTitle,
                        iSMTCRDesc: v.iSMTCRDesc,
                        iSMTCRStatus: v.iSMTCRStatus,
                        iSMTCRReOpenFlg: v.iSMTCRReOpenFlg,
                        iSMTCRTaskNo: v.iSMTCRTaskNo,
                        iSMMCLTId: v.iSMMCLTId,
                        iSMMCLTClientName: v.iSMMCLTClientName,
                        iSMTPLStartDate: v.startdatenew,
                        iSMTPLEndDate: v.enddatenew,
                        iSMTPLTAStartDate: v.startdatenew,
                        iSMTPLTAEndDate: v.startdatenew,
                        assignedby: v.assignedby,
                        createdemp: v.createdby,
                        taskcategoryname: v.taskcategoryname,
                        iSMMTCATId: v.iSMMTCATId,
                        iSMTAPLToDate: v.startdatenew,
                        iSMMTCATCompulsoryFlg: v.iSMMTCATCompulsoryFlg,
                        iSMDRPTTimeTakenInHrsmins: v.iSMDRPTTimeTakenInHrsmin,
                        effortss: v.efforts,
                        iSMTPLTAEffortInHrs: v.iSMTPLTAEffortInHrs,
                        iSMDRPTRemarks:
                            widget.controller.remarksController.first.text,
                        iSMDRPTStatus: v.iSMTCRStatus,
                        iSMDRPTTimeTakenInHrs: v.iSMTPLTAEffortInHrs,
                        drFlag: 0,
                        hRMEId: v.hRMEId,
                        createdFlag: v.createdFlag,
                      );
                    });
                    // await addExtraTaskToDR();
                    Get.back();
                  } else {
                    Fluttertoast.showToast(msg: "Select task");
                    return;
                  }
                },
                title: "ADD",
              ),
            ),
          ],
        ),
        body: Obx(() {
          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: widget.controller.isExtraTaskloading.value
                  ? const AnimatedProgressWidget(
                      animationPath: "assets/json/default.json",
                      title: "Loading...",
                      desc:
                          "Please wait while we are loading Add Extra Task Details",
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                              top: 3, left: 15, right: 15, bottom: 30),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                                dataTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(5, 5, 5, 0.945),
                                  fontWeight: FontWeight.w500,
                                ),
                                dataRowHeight: 120,
                                headingRowHeight: 55,
                                horizontalMargin: 10,
                                columnSpacing: 20,
                                dividerThickness: 1,
                                border: TableBorder.all(
                                  color: Colors.black26,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                headingRowColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                headingTextStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      "Sl No",
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "",
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Issue Details",
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Category",
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Assigned By",
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Start Date",
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "End Date",
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Reason",
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                    widget.controller.addExtraTaskList.length,
                                    (index) {
                                  var v1 = index + 1;
                                  var v = widget.controller.addExtraTaskList
                                      .elementAt(index);
                                  DateTime dt =
                                      DateTime.parse(v.iSMTCRCreationDate!);
                                  if (v.addtoplannerflag == 0) {
                                    addPlanner = false;
                                  } else {
                                    addPlanner = true;
                                  }
                                  return DataRow(cells: [
                                    DataCell(
                                      Text(v1.toString()),
                                    ),
                                    DataCell(
                                      Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          checkColor: Colors.indigo,
                                          value: addPlanner,
                                          onChanged: (value) {
                                            setState(() {
                                              addPlanner = !addPlanner;
                                              if (value!) {
                                                fliteresList.clear();
                                                fliteresList.add(widget
                                                    .controller.addExtraTaskList
                                                    .elementAt(index));
                                                v.addtoplannerflag = 1;
                                                logger.i(fliteresList.toList());
                                                logger.e(fliteresList
                                                    .first.assignedby);
                                              } else {
                                                fliteresList.removeAt(index);
                                                v.addtoplannerflag = 0;
                                              }
                                            });
                                          }),
                                    ),
                                    DataCell(Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          v.iSMTCRTitle.toString(),
                                          style: Get.textTheme.titleSmall,
                                        ),
                                        Text(
                                            '${v.iSMTCRTaskNo}-${v.iSMTCRBugOREnhancementFlg}'),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Clint: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                          TextSpan(
                                              text: v.iSMMCLTClientName,
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ])),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Created By: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                          TextSpan(
                                              text: v.createdby,
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ])),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Created Date: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                          TextSpan(
                                              text:
                                                  '${dt.day}-${dt.month}-${dt.year}',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ])),
                                      ],
                                    )),
                                    DataCell(Text(v.taskcategoryname!)),
                                    DataCell(Text(v.assignedby!)),
                                    DataCell(SizedBox(
                                      width: 120,
                                      child: TextFormField(
                                        style: Get.textTheme.titleSmall,
                                        readOnly: true,
                                        controller: widget
                                            .controller.startDateController
                                            .elementAt(index),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey))),
                                        onTap: () async {
                                          widget.controller.startDateController
                                                  .elementAt(index)
                                                  .text =
                                              (await getDate(v.startdatenew!))
                                                  .toString();
                                          DateTime dt = DateTime.parse(widget
                                              .controller.startDateController
                                              .elementAt(index)
                                              .text);
                                          startDate =
                                              '${dt.year}-${dt.month}-${dt.day}T00:00:00';
                                          widget.controller.endDateController
                                                  .elementAt(index)
                                                  .text =
                                              widget.controller
                                                  .startDateController
                                                  .elementAt(index)
                                                  .text;
                                        },
                                      ),
                                    )),
                                    DataCell(SizedBox(
                                      width: 120,
                                      child: TextFormField(
                                        style: Get.textTheme.titleSmall,
                                        readOnly: true,
                                        controller: widget
                                            .controller.endDateController
                                            .elementAt(index),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey))),
                                        onTap: () async {
                                          widget.controller.endDateController
                                                  .elementAt(index)
                                                  .text =
                                              (await getDate(v.startdatenew!))
                                                  .toString();
                                          DateTime dt = DateTime.parse(widget
                                              .controller.endDateController
                                              .elementAt(index)
                                              .text);
                                          endDate =
                                              '${dt.year}-${dt.month}-${dt.day}T00:00:00';
                                        },
                                      ),
                                    )),
                                    DataCell(SizedBox(
                                      width: 140,
                                      child: TextFormField(
                                        style: Get.textTheme.titleSmall,
                                        controller: widget
                                            .controller.remarksController
                                            .elementAt(index),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey))),
                                      ),
                                    )),
                                  ]);
                                })),
                          ))));
        }));
  }

  DateTime? dt;
  Future<String?> getDate(String fromDate) async {
    dt = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(fromDate),
        firstDate: DateTime.parse(fromDate),
        lastDate: DateTime(2050));
    if (dt != null) {
      return '${dt!.day}:${dt!.month}:${dt!.year}';
    }
    return 'Date is not Selected';
  }
}
