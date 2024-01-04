import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
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

  // addExtraTaskToDR() {
  //   for (int i = 0; i < controller.checkboxExtraTask.length; i++) {
  //     if (controller.checkboxExtraTask[i]) {
  //       logger.d(
  //           " Prathap ${controller.addExtraTaskDR.elementAt(i).iSMTCRTitle}");

  //       // Log the values before adding to controller.getTaskDrList
  //       logger.d("Adding ${controller.getTaskDrList.elementAt(i).iSMTCRTitle}");

  //       controller.getTaskDrList.add(GetTaskDrListModelValues(
  //         iSMTCRTitle: controller.addExtraTaskDR.elementAt(i).iSMTCRTitle,
  //         iSMTCRTaskNo: controller.addExtraTaskDR.elementAt(i).iSMTCRTaskNo,
  //         iSMTCRBugOREnhancementFlg:
  //             controller.addExtraTaskDR.elementAt(i).iSMTCRBugOREnhancementFlg,
  //         iSMMCLTClientName:
  //             controller.addExtraTaskDR.elementAt(i).iSMMCLTClientName,
  //         createdemp: controller.addExtraTaskDR.elementAt(i).createdby,
  //         iSMTCRCreationDate:
  //             controller.addExtraTaskDR.elementAt(i).iSMTCRCreationDate,
  //         taskcategoryname:
  //             controller.addExtraTaskDR.elementAt(i).taskcategoryname,
  //         assignedby: controller.addExtraTaskDR.elementAt(i).assignedby,
  //         iSMTPLStartDate: controller.addExtraTaskDR.elementAt(i).startDate,
  //         iSMTPLEndDate: controller.addExtraTaskDR.elementAt(i).endDate,
  //         iSMDRPTRemarks: controller.reasonController.elementAt(i).text,
  //       ));
  //     }
  //   }
  // }

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
                  setState(() {
                    widget.controller.getTaskDrList.addAll(
                        fliteresList.map((e) => GetTaskDrListModelValues()));
                  });
                  Get.back();
                },
                title: "ADD",
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(() => widget.controller.isExtraTaskloading.value
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
                        child: Padding(
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
                                  dataRowHeight: 150,
                                  headingRowHeight: 55,
                                  horizontalMargin: 10,
                                  columnSpacing: 40,
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
                                    // if (v.addtoplannerflag == 0) {
                                    //   addPlanner = false;
                                    // } else {
                                    //   addPlanner = true;
                                    // }
                                    return DataRow(cells: [
                                      DataCell(
                                        Text(v1.toString()),
                                      ),
                                      DataCell(
                                        Checkbox(
                                            value: addPlanner,
                                            onChanged: (value) {
                                              setState(() {
                                                if (value!) {
                                                  fliteresList.clear();
                                                  fliteresList.add(widget
                                                      .controller
                                                      .addExtraTaskList
                                                      .elementAt(index));
                                                  v.addtoplannerflag = 1;
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
                                                (await getDate(v.startDate!))!;
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
                                                (await getDate(v.endDate!))!;
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
                            )))))));
  }

  DateTime? dt;
  Future<String?> getDate(String fromDate) async {
    dt = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(fromDate),
        firstDate: DateTime.parse(fromDate),
        lastDate: DateTime(2050));
    if (dt != null) {
      return '${dt!.day}-${dt!.month}-${dt!.year}';
    }
    return 'Date is not Selected';
  }
}
