import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/api/task_list_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_plan_table.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/create_planner_table_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

import '../../../../controller/global_utilities.dart';

class PlannerCreateWidget extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const PlannerCreateWidget({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PlannerCreateWidget> createState() => _PlannerCreateWidgetState();
}

class _PlannerCreateWidgetState extends State<PlannerCreateWidget> {
  PlannerCreationController plannerCreationController =
      Get.put(PlannerCreationController());

  final _plannerName = TextEditingController();
  final _plannerGoal = TextEditingController();
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool selectAll = false;
  bool checked = false;
  List<int> checkList = [];
  RxString remark = ''.obs;
  DateTime? fromDate;
  DateTime? toDate;
  List<CreatePlannerTable> newTable = [];
  List<CategoryPlanTable> categoryList = [];
  String startDate = '';
  String endDate = '';
  String assignedDate = '';

  getListData() async {
    plannerCreationController.taskLoading(true);
    await TaskListAPI.instance.getList(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        plannerCreationController: plannerCreationController,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        flag: '',
        startDate: _startDate.text,
        endDate: _endDate.text);
    if (plannerCreationController.categoryWisePlan.isNotEmpty) {
      for (int index = 0;
          index < plannerCreationController.categoryWisePlan.length;
          index++) {
        setState(() {
          categoryList.add(CategoryPlanTable(
              '${plannerCreationController.categoryWisePlan.elementAt(index).ismmtcaTTaskCategoryName}',
              '${plannerCreationController.categoryWisePlan.elementAt(index).ismmtcaTTaskPercentage} %',
              "${plannerCreationController.categoryWisePlan.elementAt(index).ismtcrastOEffortInHrs}",
              "${plannerCreationController.categoryWisePlan.elementAt(index).ismtpltAEffortInHrs}",
              "${plannerCreationController.categoryWisePlan.elementAt(index).ismtpLTotalHrs}"));
        });
      }
    }
    if (plannerCreationController.assignedTaskList.isNotEmpty) {
      for (int index = 0;
          index < plannerCreationController.assignedTaskList.length;
          index++) {
        setState(() {
          DateTime dt = DateTime.parse(plannerCreationController
              .assignedTaskList
              .elementAt(index)
              .iSMTCRASTOAssignedDate
              .toString());
          assignedDate =
              '${numberList[dt.day]}:${numberList[dt.month]}:${dt.year}';
          //
          DateTime startDt = DateTime.parse(plannerCreationController
              .assignedTaskList
              .elementAt(index)
              .iSMTCRASTOStartDate!);
          startDate =
              '${numberList[startDt.day]}:${numberList[startDt.month]}:${startDt.year}';
          logger.i('===$startDate');
          //
          DateTime endDt = DateTime.parse(plannerCreationController
              .assignedTaskList
              .elementAt(index)
              .iSMTCRASTOEndDate!);
          endDate =
              '${numberList[endDt.day]}:${numberList[endDt.month]}:${endDt.year}';
          //
          newTable.add(CreatePlannerTable(
              false,
              '${plannerCreationController.assignedTaskList.elementAt(index).iSMTCRTaskNo}',
              '${plannerCreationController.assignedTaskList.elementAt(index).iSMTCRTitle}',
              '${plannerCreationController.assignedTaskList.elementAt(index).hRMPName}',
              '${plannerCreationController.assignedTaskList.elementAt(index).iSMMCLTClientName}',
              '${plannerCreationController.assignedTaskList.elementAt(index).hRMDDepartmentName}',
              '${plannerCreationController.assignedTaskList.elementAt(index).periodicity}',
              assignedDate,
              '${plannerCreationController.assignedTaskList.elementAt(index).assignedby}',
              '$startDate To $endDate ',
              '${plannerCreationController.assignedTaskList.elementAt(index).iSMTCRASTOEffortInHrs} Hr',
              plannerCreationController.assignedTaskList
                      .elementAt(index)
                      .iSMTCRASTORemarks ??
                  ' '));
        });
      }
    }
    plannerCreationController.taskLoading(false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (plannerCreationController.categoryWisePlan.isNotEmpty) {
      plannerCreationController.categoryWisePlan.isEmpty;
    }
    if (plannerCreationController.assignedTaskList.isNotEmpty) {
      plannerCreationController.assignedTaskList.isEmpty;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: _plannerName,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFFFEBEA)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/subjectfielicon.png",
                              height: 24.0,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              " Planner Name ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFFFF6F67)),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Enter here.',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                CustomContainer(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: _plannerGoal,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFFFEBEA)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/subjectfielicon.png",
                              height: 24.0,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              " Planner Goal ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFFFF6F67)),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Enter here.',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomContainer(
                        child: TextField(
                          style: Theme.of(context).textTheme.titleSmall,
                          readOnly: true,
                          controller: _startDate,
                          onTap: () async {
                            fromDate = await showDatePicker(
                              context: context,
                              helpText: "Select From Data",
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(3050),
                              // selectableDayPredicate: (day) =>
                              //     day.weekday == 1 ? false : true,
                            );
                            if (fromDate != null) {
                              setState(() {
                                _startDate.text =
                                    "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                              });
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () async {
                                fromDate = await showDatePicker(
                                  helpText: "Select From Data",
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(3050),
                                  // selectableDayPredicate: (day) =>
                                  //     day.weekday == 1 ? false : true,
                                );
                                if (fromDate != null) {
                                  setState(() {
                                    _startDate.text =
                                        "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                  });
                                }
                              },
                              icon: SvgPicture.asset(
                                "assets/svg/calendar_icon.svg",
                                color: const Color(0xFF3E78AA),
                                height: 18,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.only(top: 40.0, left: 12),
                            border: const OutlineInputBorder(),
                            label: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: const Color(0xFFE5F3FF)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/calendar_icon.svg",
                                    color: const Color(0xFF3E78AA),
                                    height: 18,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    " Start Date ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xFF3E78AA),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Select Date',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: CustomContainer(
                        child: TextField(
                          readOnly: true,
                          style: Theme.of(context).textTheme.titleSmall,
                          controller: _endDate,
                          onTap: () async {
                            if (fromDate != null) {
                              toDate = await showDatePicker(
                                context: context,
                                helpText: "Select To Date",
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3050),
                                // selectableDayPredicate: (day) =>
                                //     day.weekday == 7 || day.weekday == 7
                                //         ? false
                                //         : true,
                              );
                              if (toDate != null) {
                                setState(() {
                                  _endDate.text =
                                      "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                  getListData();
                                });
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please Select Start Date");
                            }
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.only(top: 40.0, left: 12),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (fromDate != null) {
                                  toDate = await showDatePicker(
                                    context: context,
                                    helpText: "Select To Date",
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(3050),
                                    fieldHintText: 'Date:Month:Year',
                                    // selectableDayPredicate: (day) =>
                                    //     day.weekday == 7 || day.weekday == 7
                                    //         ? false
                                    //         : true,
                                  );
                                  if (toDate != null) {
                                    setState(() {
                                      _endDate.text =
                                          "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                      getListData();
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Start Date");
                                }
                              },
                              icon: SvgPicture.asset(
                                "assets/svg/calendar_icon.svg",
                                color: const Color(0xFF3E78AA),
                                height: 18,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                            label: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: const Color(0xFFE5F3FF)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/calendar_icon.svg",
                                    color: const Color(0xFF3E78AA),
                                    height: 18,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    " End Date ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                              fontSize: 18.0,
                                              color: Color(0xFF3E78AA)),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Select Date',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          (plannerCreationController.isAssignedTask.value)
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading data',
                  desc: "Please wait we are loading data",
                )
              : (plannerCreationController.assignedTaskList.isEmpty)
                  ? const AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'No data Available',
                      desc: " ",
                      animatorHeight: 250,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Planner Details",
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomContainer(
                            child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Total Task: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '25 ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Total Working Days: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '7 ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Minimum Effort Required: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '25 ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'planned Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '25 Hrs ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Total Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '25 ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                            ],
                          ),
                        )),
                        (plannerCreationController.categoryWisePlan.isNotEmpty)
                            ? _createCategortTable()
                            : const SizedBox(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MSkollBtn(
                            title: "Save",
                            onPress: () {
                              if (_plannerName.text.isEmpty ||
                                  _startDate.text.isEmpty ||
                                  _endDate.text.isEmpty) {}
                            },
                          ),
                        ),
                        _createPlannerTable(),
                      ],
                    ),
        ],
      ),
    );
  }

//
  _createPlannerTable() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DataTable(
          showCheckboxColumn: true,
          headingRowColor:
              MaterialStatePropertyAll(Theme.of(context).primaryColor),
          dataTextStyle: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(0, 0, 0, 0.95),
              fontWeight: FontWeight.w400),
          dataRowHeight: MediaQuery.of(context).size.height * 0.21,
          headingRowHeight: MediaQuery.of(context).size.height * 0.08,
          horizontalMargin: 10,
          columnSpacing: MediaQuery.of(context).size.width * 0.08,
          dividerThickness: 1,
          headingTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(10), width: 0.5),
          columns: [
            const DataColumn(
              numeric: true,
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'S.No',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            DataColumn(
              numeric: true,
              label: Align(
                alignment: Alignment.center,
                child: Checkbox(
                  checkColor: Colors.indigo,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  value: selectAll,
                  onChanged: (newValue) {
                    setState(() {
                      selectAll = newValue!;
                      if (selectAll) {
                        for (var i = 0; i < newTable.length; i++) {
                          checkList.add(i);
                          setState(() {
                            newTable.elementAt(i).flag = true;
                          });
                        }
                      } else {
                        for (var i = 0; i < newTable.length; i++) {
                          checked = newTable[i].flag = false;
                        }
                        checkList.clear();
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Issue/Task',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Assigned By',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Date',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Effort(Hrs)',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Remarks',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
          rows: [
            ...List.generate(newTable.length, (index) {
              var i = index + 1;
              return DataRow(cells: [
                DataCell(Text(i.toString())),
                DataCell(
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Checkbox(
                        checkColor: Colors.indigo,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: newTable.elementAt(index).flag,
                        onChanged: (val) {
                          setState(() {
                            checked = newTable[index].flag = val!;
                            if (checkList.contains(index)) {
                              checkList.remove(index);
                              checked = newTable[index].flag = false;
                              if (newTable.length != checkList.length) {
                                selectAll = false;
                              }
                              setState(() {});
                            } else {
                              checkList.add(index);
                              if (newTable.length == checkList.length) {
                                selectAll = true;
                              }
                            }
                            setState(() {});
                          });
                        },
                      )),
                ),
                DataCell(SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newTable[index].taskNo,
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          newTable[index].taskName,
                          maxLines: 2,
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Type Task: ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(
                              text: newTable[index].taskType,
                              style: Get.textTheme.titleSmall!.copyWith()),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Clint: ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(
                              text: newTable[index].clint,
                              style: Get.textTheme.titleSmall!.copyWith()),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Category: ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(
                              text: newTable[index].category,
                              style: Get.textTheme.titleSmall!.copyWith()),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Periodicity: ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(
                              text: newTable[index].Periodicity,
                              style: Get.textTheme.titleSmall!.copyWith()),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Assigned Date: ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(
                              text: newTable[index].assignedDate,
                              style: Get.textTheme.titleSmall!.copyWith()),
                        ])),
                      ],
                    ),
                  ),
                )),
                DataCell(Text(newTable[index].assignedBy)),
                DataCell(Text(newTable[index].date)),
                DataCell(Text(newTable[index].effort)),
                DataCell(TextFormField(
                  initialValue: newTable[index].remarks,
                  onChanged: (value) {
                    remark.value = value;
                  },
                  onTap: () {
                    var checkTxt = checkList.contains(
                            newTable.indexOf(newTable.elementAt(index)))
                        ? false
                        : true;
                    if (checkTxt) {
                      Fluttertoast.showToast(msg: "Please select checkbox");
                    }
                  },
                  readOnly: checkList
                          .contains(newTable.indexOf(newTable.elementAt(index)))
                      ? false
                      : true,
                  style: Get.textTheme.titleSmall,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 4, right: 4),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                )),
              ]);
            })
          ],
        ),
      ),
    );
  }

  _createCategortTable() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DataTable(
          headingRowColor:
              MaterialStatePropertyAll(Theme.of(context).primaryColor),
          dataTextStyle: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(0, 0, 0, 0.95),
              fontWeight: FontWeight.w400),
          horizontalMargin: 2,
          columnSpacing: MediaQuery.of(context).size.width * 0.04,
          dividerThickness: 1,
          headingTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(10), width: 0.5),
          columns: const [
            DataColumn(
              label: Text("Category Name"),
            ),
            DataColumn(
              label: Text('Required Percentage'),
            ),
            DataColumn(
              label: Text('Minimun Effort Required'),
            ),
            DataColumn(
              label: Text('Current Effort'),
            ),
            DataColumn(
              label: Text('Required Effort'),
            ),
          ],
          rows: [
            ...List.generate(categoryList.length, (index) {
              return DataRow(cells: [
                DataCell(Text(categoryList.elementAt(index).categoryName)),
                DataCell(Text(categoryList.elementAt(index).percentage)),
                DataCell(Text('${categoryList.elementAt(index).effort} Hr')),
                DataCell(
                    Text('${categoryList.elementAt(index).currentEffort} Hr')),
                DataCell(
                  Text(
                    '${categoryList.elementAt(index).requiredEffort} Hr',
                    style:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.red),
                  ),
                ),
              ]);
            }),
          ],
        ),
      ),
    );
  }
}
