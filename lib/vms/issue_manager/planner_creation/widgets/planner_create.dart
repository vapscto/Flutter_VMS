import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/api/planner_save_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/api/planner_status_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/api/task_list_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/category_plan_table.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/create_planner_table_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../controller/global_utilities.dart';
import '../../../../main.dart';

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
  bool selectAll = true;
  bool checked = false;
  List<int> checkList = [];
  RxString remark = ''.obs;
  DateTime? fromDate;
  DateTime? toDate;
  DateTime dt = DateTime.now();
  double totalday = 0.0;
  List<CreatePlannerTable> newTable = [];
  List<CategoryPlanTable> categoryList = [];
  // String startDate = '';
  // String endDate = '';
  String assignedDate = '';
  double plannedEffort = 0.0;
  List<Map<String, dynamic>> plannerrArray = [];
  List<Map<String, dynamic>> categoryArray = [];
  List<Map<String, dynamic>> newCategoryArray = [];
  double totalHour = 0;
  DateTime todayDate = DateTime.now();
  void addPlannedEffort(var plan) {
    plannedEffort -= plan;
    setState(() {});
  }

  void removePlannedEffort(var plan) {
    plannedEffort += plan;
    setState(() {});
  }

  var id = 0;
  int calculateWeekdaysDifference(DateTime startDate, DateTime endDate) {
    var weekdayCount = 0;

    if (startDate.isAfter(endDate)) {
      final temp = startDate;
      startDate = endDate;
      endDate = temp;
    }

    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      if (startDate.weekday != DateTime.sunday) {
        weekdayCount++;
      }
      startDate = startDate.add(const Duration(days: 1));
    }
    totalday = plannerCreationController.totalDay;
    ;

    return weekdayCount;
  }

  getListData() async {
    plannedEffort = 0.0;
    totalHour = 0;
    plannerCreationController.taskLoading(true);
    await TaskListAPI.instance.getList(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        plannerCreationController: plannerCreationController,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        flag: 'S',
        startDate: (fromDate != null)
            ? fromDate!.toIso8601String()
            : dt.toIso8601String(),
        endDate: (toDate != null)
            ? toDate!.toIso8601String()
            : dt.toIso8601String());
    if (plannerCreationController.categoryWisePlan.isNotEmpty) {
      categoryList.clear();
      for (int index = 0;
          index < plannerCreationController.categoryWisePlan.length;
          index++) {
        setState(() {
          categoryList.add(CategoryPlanTable(
              '${plannerCreationController.categoryWisePlan.elementAt(index).ismmtcaTTaskCategoryName}',
              '${plannerCreationController.categoryWisePlan.elementAt(index).ismmtcaTTaskPercentage} %',
              double.parse(
                  "${plannerCreationController.categoryWisePlan.elementAt(index).ismmtcaTTaskPercentage! / 100 * 8 * totalday}"),
              double.parse(
                  "${plannerCreationController.categoryWisePlan.elementAt(index).ismtcrastOEffortInHrs}"),
              double.parse(
                  "${plannerCreationController.categoryWisePlan.elementAt(index).ismmtcaTTaskPercentage! / 100 * 8 * totalday}")));
        });

        categoryArray.add({
          "ISMMTCAT_Id": plannerCreationController.categoryWisePlan
              .elementAt(index)
              .ismmtcaTId,
        });
        newCategoryArray.addAll(categoryArray.toSet());
      }
    }
    if (plannerCreationController.createdTaskList.isNotEmpty) {
      for (int index = 0;
          index < plannerCreationController.createdTaskList.length;
          index++) {
        setState(() {
          if (plannerCreationController.createdTaskList
                  .elementAt(index)
                  .iSMTPLTAId !=
              null) {
            if (plannerCreationController.createdTaskList
                    .elementAt(index)
                    .iSMTPLTAId! ==
                0) {
              plannedEffort += plannerCreationController.createdTaskList
                  .elementAt(index)
                  .iSMTCRASTOEffortInHrs!;
              setState(() {});
            }
          }
          if (plannerCreationController.createdTaskList
                  .elementAt(index)
                  .iSMTCRASTOEffortInHrs !=
              null) {
            totalHour += plannerCreationController.createdTaskList
                .elementAt(index)
                .iSMTCRASTOEffortInHrs!;
          }
          //
        });
        plannerrArray.add({
          "ISMTCR_Id": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTCRId,
          "ISMTPLTA_StartDate": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTPLTAStartDate,
          "ISMTPLTA_EndDate": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTPLTAEndDate,
          "ISMTPLTA_EffortInHrs": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTCRASTOEffortInHrs,
          "ISMTPLTA_Remarks": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTCRASTORemarks,
          "ISMTPLTA_Id": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTPLTAId,
          "ISMTPLTA_Status": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTPLTAStatus,
          "ISMTPLTA_PreviousTask": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTPLTAPreviousTask,
          "ISMTPLTA_ApprovalFlg": plannerCreationController.createdTaskList
              .elementAt(index)
              .iSMTPLTAApprovalFlg,
        });
      }
    }
    plannerCreationController.totalDay = 0;
    plannerCreationController.totalHour = 0;
    plannerCreationController.effortDataValues.forEach((element) {
      plannerCreationController.totalDay++;
      plannerCreationController.totalHour += element.wORKINGHOURS!;
    });
    plannerCreationController.taskLoading(false);
  }

  getPlannerStatus() async {
    plannerCreationController.plannerLoading(true);
    await PlannerStatusList.instance.plannerStatusAPI(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        plannerCreationController: plannerCreationController);
    plannerCreationController.plannerLoading(false);
  }

  savePlanner() async {
    await PlannerSaveAPI.instance.saveDataAPI(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        plannerName: _plannerName.text,
        startDate: fromDate!.toIso8601String(),
        endDate: toDate!.toIso8601String(),
        totalHour: totalHour.toInt(),
        remarks: _plannerGoal.text,
        catListId: categoryArray,
        taskplannerArray: plannerrArray);
    getListData();
  }

  bool isDeta = false;
  @override
  void initState() {
    getPlannerStatus();
    getListData();
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

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return plannerCreationController.isPlannerLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading...",
                    desc: "We are loading Planner creation  Please wait ",
                    animationPath: "assets/json/default.json"),
              )
            : ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                children: [
                  (plannerCreationController.isPlannerCreate.value != true)
                      ? const Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 30),
                          child: TextScroll(
                            "YOU CAN'T GENERATE PLANNER TODAY!!",
                            delayBefore: Duration(milliseconds: 500),
                            mode: TextScrollMode.endless,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                            selectable: true,
                          ),
                        )
                      : const SizedBox(),
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                                      firstDate: DateTime.parse(
                                          plannerCreationController.maxDate),
                                      initialDate: DateTime.parse(
                                          plannerCreationController.maxDate),
                                      lastDate: DateTime(3050),
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
                                          firstDate: DateTime.parse(
                                              plannerCreationController
                                                  .maxDate),
                                          initialDate: DateTime.parse(
                                              plannerCreationController
                                                  .maxDate),
                                          lastDate: DateTime(3050),
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
                                    contentPadding: const EdgeInsets.only(
                                        top: 40.0, left: 12),
                                    border: const OutlineInputBorder(),
                                    label: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
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
                                        firstDate: fromDate!,
                                        initialDate: fromDate!,
                                        lastDate: DateTime(3050),
                                      );
                                      if (toDate != null) {
                                        setState(() {
                                          _endDate.text =
                                              "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                          calculateWeekdaysDifference(
                                              fromDate!, toDate!);
                                          getListData();
                                          isDeta = true;
                                        });
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Start Date");
                                    }
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        top: 40.0, left: 12),
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        if (fromDate != null) {
                                          toDate = await showDatePicker(
                                            context: context,
                                            helpText: "Select To Date",
                                            firstDate: fromDate!,
                                            initialDate: fromDate!,
                                            lastDate: DateTime(3050),
                                            fieldHintText: 'Date:Month:Year',
                                          );
                                          if (toDate != null) {
                                            setState(() {
                                              _endDate.text =
                                                  "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                              calculateWeekdaysDifference(
                                                  fromDate!, toDate!);
                                              getListData();
                                              isDeta = true;
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
                                          borderRadius:
                                              BorderRadius.circular(24.0),
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
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
                  (plannerCreationController.createdTaskList.isEmpty ||
                          isDeta == false)
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
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text:
                                            '${plannerCreationController.createdTaskList.length} ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  const SizedBox(height: 6),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Total Working Days: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text: '$totalday',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  const SizedBox(height: 6),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Minimum Effort Required: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text:
                                            '${plannerCreationController.totalHour} Hr',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  const SizedBox(height: 6),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'planned Effort: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text: '$plannedEffort Hr',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  const SizedBox(height: 6),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Total Effort: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text: '$totalHour Hr ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                ],
                              ),
                            )),
                            (plannerCreationController
                                    .categoryWisePlan.isNotEmpty)
                                ? _createCategortTable()
                                : const SizedBox(),
                            (plannerCreationController.categoryWisePlan.isEmpty)
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: MSkollBtn(
                                        title: "Save",
                                        onPress: () {
                                          if (_plannerName.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Please enter plan name");
                                          } else if (plannedEffort <
                                              plannerCreationController
                                                  .totalHour) {
                                            Get.dialog(showPopup());
                                          } else if (plannerCreationController
                                                  .isPlannerCreate.value ==
                                              false) {
                                            Get.dialog(plannerNotCreate());
                                          } else {
                                            savePlanner();
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            _createPlannerTable(),
                          ],
                        ),
                ],
              );
      }),
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
                        for (var i = 0;
                            i <
                                plannerCreationController
                                    .createdTaskList.length;
                            i++) {
                          checkList.add(i);
                          plannerCreationController.createdTaskList[i].flag =
                              true;
                        }
                      } else {
                        for (var i = 0;
                            i <
                                plannerCreationController
                                    .createdTaskList.length;
                            i++) {
                          plannerCreationController.createdTaskList[i].flag =
                              false;
                        }
                        checkList.clear();
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
            ...List.generate(plannerCreationController.createdTaskList.length,
                (index) {
              var i = index + 1;
              var data =
                  plannerCreationController.createdTaskList.elementAt(index);
              DateTime startDt = DateTime.parse(
                  data.iSMTPLTAStartDate!.contains('1900-01-01T00:00:00')
                      ? data.iSMTCRASTOStartDate.toString()
                      : data.iSMTPLTAStartDate.toString());
              var startDate =
                  '${numberList[startDt.day]}:${numberList[startDt.month]}:${startDt.year}';
              DateTime endDt = DateTime.parse(
                  data.iSMTPLTAEndDate!.contains('1900-01-01T00:00:00')
                      ? data.iSMTCRASTOEndDate.toString()
                      : data.iSMTPLTAEndDate!);
              var endDate =
                  '${numberList[endDt.day]}:${numberList[endDt.month]}:${endDt.year}';
              id = data.iSMTPLTAId!;
              DateTime dt =
                  DateTime.parse(data.iSMTCRASTOAssignedDate.toString());
              assignedDate =
                  '${numberList[dt.day]}:${numberList[dt.month]}:${dt.year}';
              return DataRow(
                  color: (plannerCreationController
                              .createdTaskList[index].iSMTPLTAId !=
                          0)
                      ? MaterialStatePropertyAll(Colors.indigo.withOpacity(0.3))
                      : const MaterialStatePropertyAll(Colors.white),
                  cells: [
                    DataCell(Text(i.toString())),
                    DataCell(
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Checkbox(
                            checkColor: Colors.indigo,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            value: (plannerCreationController
                                        .createdTaskList[index].iSMTPLTAId ==
                                    0)
                                ? plannerCreationController.createdTaskList
                                    .elementAt(index)
                                    .flag
                                : true,
                            onChanged: (plannerCreationController
                                        .createdTaskList[index].iSMTPLTAId ==
                                    0)
                                ? (val) {
                                    setState(() {
                                      plannerCreationController
                                          .createdTaskList[index].flag = val!;
                                      if (checkList.contains(index)) {
                                        checkList.remove(index);
                                        plannerCreationController
                                            .createdTaskList[index]
                                            .flag = false;
                                        if (plannerCreationController
                                                .createdTaskList.length !=
                                            checkList.length) {
                                          selectAll = false;
                                        }
                                      } else {
                                        checkList.add(index);
                                        if (plannerCreationController
                                                .createdTaskList.length ==
                                            checkList.length) {
                                          selectAll = true;
                                        }
                                      }
                                    });
                                  }
                                : null,
                          )),
                    ),
                    DataCell(SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.iSMTCRTaskNo!,
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              '${data.iSMTCRTitle}',
                              maxLines: 2,
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Type Task: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: (data.iSMTPLTAId == 0)
                                          ? Theme.of(context).primaryColor
                                          : Colors.red)),
                              TextSpan(
                                  text: data.hRMPName,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Clint: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: data.iSMMCLTClientName,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Category: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: data.iSMMTCATTaskCategoryName,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Periodicity: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: data.periodicity,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Assigned Date: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: assignedDate,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                          ],
                        ),
                      ),
                    )),
                    DataCell(Text(data.assignedby!)),
                    DataCell(Text('$startDate TO $endDate')),
                    DataCell(Text('${data.iSMTCRASTOEffortInHrs} Hr')),
                    DataCell(TextFormField(
                      initialValue: data.iSMTCRASTORemarks ?? '',
                      onChanged: (value) {
                        remark.value = value;
                      },
                      onTap: () {
                        var checkTxt = checkList.contains(
                                plannerCreationController.createdTaskList
                                    .indexOf(plannerCreationController
                                        .createdTaskList
                                        .elementAt(index)))
                            ? false
                            : true;
                        if (checkTxt) {
                          Fluttertoast.showToast(msg: "Please select checkbox");
                        }
                      },
                      readOnly: checkList.contains(plannerCreationController
                              .createdTaskList
                              .indexOf(plannerCreationController.createdTaskList
                                  .elementAt(index)))
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
                DataCell(Text(
                    '${categoryList.elementAt(index).effort.toStringAsFixed(2)} Hr')),
                DataCell(Text(
                    '${categoryList.elementAt(index).currentEffort.toStringAsFixed(2)} Hr')),
                DataCell(
                  Text(
                    '${categoryList.elementAt(index).requiredEffort.toStringAsFixed(2)} Hr',
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

  showPopup() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
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
                "Planned Effort must be greater than or equal to ${totalday * 8} Hours ... !!",
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
                      getListData();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }

  plannerNotCreate() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
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
                "YOU CAN'T GENERATE PLANNER TODAY!!",
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
                      getListData();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
