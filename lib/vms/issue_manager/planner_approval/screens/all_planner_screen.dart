import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/api/planner_approval_save_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/api/planner_details_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/api/planner_list_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/widgets/planner_table_widget.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class AllPlanners extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PlannerApprovalController plannerApprovalController;
  final int ismtplId;
  final String createdBy;
  final String toDate;
  final String fromDate;
  final double plannedEffort;
  const AllPlanners(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.plannerApprovalController,
      required this.ismtplId,
      required this.createdBy,
      required this.toDate,
      required this.fromDate,
      required this.plannedEffort});

  @override
  State<AllPlanners> createState() => _AllPlannersState();
}

class _AllPlannersState extends State<AllPlanners> {
  bool selectAll = false;
  List<int> checkList = [];
  bool checked = false;
  //
  List<dynamic> headerDropDownList = ['Approve All', 'Reject All'];
  String headerGroupValue = 'Approve All';
  //
  String dataRowGroupValue = 'Approve';
  //
  RxList<String> rowStatus = <String>[].obs;
  void getStatus(List<String> status) {
    rowStatus.addAll(status);
  }

  //remarks
  RxList<TextEditingController> remarksController =
      <TextEditingController>[].obs;
  void addRemarks(TextEditingController remarks) {
    remarksController.add(TextEditingController(text: remarks.toString()));
  }

  //effort
  RxList<TextEditingController> effortController =
      <TextEditingController>[].obs;
  void addEffort(TextEditingController effort) {
    effortController.add(TextEditingController(text: effort.toString()));
  }

  //
  List<AllPlannerTable> allPlannerList = <AllPlannerTable>[];
//
  late List<DropdownMenuItem<dynamic>> dropdownMenuItems;
  final _remarkController = TextEditingController();
  double currentWeekEffort = 0.0;
  double deviatedEffort = 0.0;
  //
  double approveEffort = 0.0;
  void addApproveEffort(double effort) {
    approveEffort += effort;
  }

  void removeApproveEffort(double effort) {
    approveEffort -= effort;
  }

  double rejectEffort = 0.0;
  void addRejectEffort(double effort) {
    rejectEffort += effort;
  }

  void removeRejectEffort(double effort) {
    rejectEffort -= effort;
  }

  //
  _getData() async {
    widget.plannerApprovalController.approvalLoading(true);
    await PlannerDetailsAPI.instance.plannerDetails(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        plannerApprovalController: widget.plannerApprovalController,
        roleFlag: 'S',
        flag: widget.plannerApprovalController.flag,
        userId: widget.loginSuccessModel.userId!,
        ismmacId: widget.plannerApprovalController.ismmcId,
        miId: widget.loginSuccessModel.mIID!,
        completedCount: widget.plannerApprovalController.completedCount,
        ivrmrtId: widget.plannerApprovalController.ivrmrtId,
        asmayId: widget.loginSuccessModel.asmaYId!,
        effort: widget.plannerApprovalController.effort,
        ismtplId: widget.ismtplId,
        view: 1);
    for (int i = 0;
        i < widget.plannerApprovalController.plannerApprovalList.length;
        i++) {
      effortController.add(TextEditingController(
          text: widget.plannerApprovalController.plannerApprovalList
              .elementAt(i)
              .iSMTPLTAEffortInHrs
              .toString()));
      if (widget.plannerApprovalController.plannerApprovalList
              .elementAt(i)
              .iSMTPLTAPreviousTask ==
          false) {
        currentWeekEffort += widget
            .plannerApprovalController.plannerApprovalList
            .elementAt(i)
            .iSMTPLTAEffortInHrs!;
      }
      if (widget.plannerApprovalController.plannerApprovalList
              .elementAt(i)
              .iSMTPLTAPreviousTask ==
          true) {
        deviatedEffort += (widget.plannerApprovalController.plannerApprovalList
            .elementAt(i)
            .iSMTPLTAEffortInHrs!);
      }
      var value =
          widget.plannerApprovalController.plannerApprovalList.elementAt(i);
      DateTime dt = DateTime.parse(value.iSMTCRASTOStartDate!);
      DateTime dt2 = DateTime.parse(value.iSMTCRASTOEndDate!);

      allPlannerList.add(AllPlannerTable(
          value.iSMTPLApprovalFlg!,
          value.iSMTCRTaskNo!,
          value.iSMTCRTitle!,
          value.hRMPName!,
          value.iSMMCLTClientName!,
          value.iSMMTCATTaskCategoryName!,
          value.periodicity ?? '',
          '${dt.day}-${dt.month}-${dt.year} To ${dt2.day}-${dt2.month}-${dt2.year}',
          value.plannerDate!,
          value.iSMTPLTAEffortInHrs.toString(),
          '',
          value.iSMTPLTAId!,
          value.plannedby!,
          value.iSMMTCATDurationFlg ?? '',
          value.iSMTCRId!,
          value.iSMTCRStatus!,
          value.pTSCount!,
          value.iSMTCRASTOStartDate!,
          value.iSMTCRASTOEndDate!));
    }
    widget.plannerApprovalController.approvalLoading(false);
  }

  var totalHour;
  _getTotalHour() {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateTime startDate = dateFormat.parse(widget.fromDate);
    DateTime endDate = dateFormat.parse(widget.toDate);
    Duration difference = endDate.difference(startDate);
    int totalDays = difference.inDays;
    totalHour = totalDays * 8;
  }

  @override
  void initState() {
    _getData();
    _getTotalHour();
    dropdownMenuItems = headerDropDownList.map((dynamic item) {
      return DropdownMenuItem<dynamic>(
        value: item,
        child: Text(item),
      );
    }).toList();
    super.initState();
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = ['Approve', 'Reject'];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: Get.textTheme.titleSmall,
              ),
            ))
        .toList();
  }

  List<String> selectedItemValue = <String>[];
  bool isLoading = false;
  //save planner
  List<Map<String, dynamic>> plannerList = [];
  _getPlannerSave() async {
    setState(() {
      isLoading = true;
    });
    for (int i = 0; i < checkList.length; i++) {
      var value = allPlannerList.elementAt(checkList[i]);
      plannerList.add({
        "ISMTCR_Id": value.ismtcrId,
        "ISMTPLAPTA_StartDate": value.startDate,
        "ISMTPLAPTA_EndDate": value.endDate,
        "ISMTPLAPTA_EffortInHrs": value.effort,
        "ISMTPLAPTA_Status": selectedItemValue[i], //value.status,
        "plannerStatus": (dataRowGroupValue == 'Approve') ? 1 : 0,
        "ISMTPLTA_Id": value.ismtpltaId,
        "ISMTPL_Id": widget.ismtplId,
        "extraflag": 0,
        "PTSCount": value.ptsCount
      });
    }
    await PlannerApprovalSaveAPI.instance.plannerapproval(
      base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
      plannerList: plannerList,
      userId: widget.loginSuccessModel.userId!,
      miId: widget.loginSuccessModel.mIID!,
      roleFlag: "S",
      ivrmrtId: widget.plannerApprovalController.ivrmrtId,
      asmayId: widget.loginSuccessModel.asmaYId!,
      view: 1,
      ismtplId: widget.ismtplId,
      remarks: _remarkController.text,
      totalEffort: approveEffort,
    );
    _getData();
    // Get.back();
    // Get.back();
    setState(() {
      isLoading = false;
    });
  }

  int visibleRowCount = 10;
  _getPlannerData() async {
    widget.plannerApprovalController.plannerLoading(true);
    await PlannerListAPI.instance.plannerListAPI(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        plannerApprovalController: widget.plannerApprovalController,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        roleId: widget.loginSuccessModel.roleId!);
    widget.plannerApprovalController.plannerLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Planner Approval', action: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: isLoading == true
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Colors.white,
                    ),
                  )
                : BtnSave(
                    title: 'Save',
                    onPress: () {
                      setState(() {
                        if (_remarkController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please Enter Planner Remarks");
                        } else if (checkList.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please Select check box");
                        } else {
                          _getPlannerSave();
                        }
                      });
                    },
                  ),
          ),
        )
      ]).getAppBar(),
      body: Obx(() {
        return (widget.plannerApprovalController.isPlanner.value)
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Getting Planner List",
                    desc: "We are loading Planner List... Please wait ",
                    animationPath: "assets/json/default.json"),
              )
            : (widget.plannerApprovalController.plannerApprovalList.isEmpty)
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Planners not Found",
                        desc: " ",
                        animationPath: "assets/json/nodata.json"))
                : ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, top: 30, bottom: 16),
                        child: CustomContainer(
                          child: TextFormField(
                            controller: _remarkController,
                            maxLines: 1,
                            keyboardType: TextInputType.multiline,
                            style: Get.textTheme.titleSmall!
                                .copyWith(fontSize: 15),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Enter Planner Remark",
                              label: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFFBFE),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 6.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/cap.png",
                                      height: 28.0,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      "Planner Remark",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                                backgroundColor:
                                                    Color(0xFFDFFBFE),
                                                fontSize: 20.0,
                                                color: Color(0xFF28B6C8)),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomContainer(
                            child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'By: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '${widget.createdBy} ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Planner Date: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text:
                                        '${widget.fromDate} TO ${widget.toDate}',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Min.Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '$totalHour Hr ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Total Task: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text:
                                        '${widget.plannerApprovalController.plannerApprovalList.length} ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Planned Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '${widget.plannedEffort} Hr',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Current Week Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '$currentWeekEffort Hr',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Deviated Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text:
                                        '${deviatedEffort.toStringAsFixed(1)} Hr',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Approving Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text:
                                        '${approveEffort.toStringAsFixed(1)} Hr ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                              const SizedBox(height: 6),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Rejecting Effort: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text:
                                        '${rejectEffort.toStringAsFixed(1)} Hr ',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ])),
                            ],
                          ),
                        )),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                              showCheckboxColumn: true,
                              headingRowColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColor),
                              headingTextStyle: Get.textTheme.titleSmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                              dataTextStyle: Get.textTheme.titleSmall!,
                              dataRowHeight:
                                  MediaQuery.of(context).size.height * 0.26,
                              headingRowHeight:
                                  MediaQuery.of(context).size.height * 0.08,
                              horizontalMargin: 10,
                              columnSpacing:
                                  MediaQuery.of(context).size.width * 0.08,
                              dividerThickness: 1,
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              columns: [
                                const DataColumn(
                                    label: Text(
                                  "Sl No.",
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    numeric: true,
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Checkbox(
                                          checkColor: Colors.indigo,
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          value: selectAll,
                                          onChanged: (value) {
                                            setState(() {
                                              selectAll = value!;
                                              if (selectAll) {
                                                for (var i = 0;
                                                    i < allPlannerList.length;
                                                    i++) {
                                                  checkList.add(i);
                                                  setState(() {
                                                    allPlannerList
                                                        .elementAt(i)
                                                        .flag = true;
                                                    if (headerGroupValue ==
                                                        'Approve All') {
                                                      addApproveEffort(
                                                          double.parse(
                                                              allPlannerList[i]
                                                                  .effort));
                                                    } else if (headerGroupValue ==
                                                        'Reject All') {
                                                      addRejectEffort(
                                                          double.parse(
                                                              allPlannerList[i]
                                                                  .effort));
                                                    }
                                                  });
                                                }
                                              } else {
                                                for (var i = 0;
                                                    i < allPlannerList.length;
                                                    i++) {
                                                  checked = allPlannerList[i]
                                                      .flag = false;
                                                  for (int i = 0;
                                                      i < checkList.length;
                                                      i++) {}
                                                  rejectEffort = 0.0;
                                                  approveEffort = 0.0;
                                                }

                                                checkList.clear();
                                                setState(() {});
                                              }
                                            });
                                          }),
                                    )),
                                const DataColumn(
                                    numeric: true,
                                    label: Text(
                                      "Issue/Task Details",
                                      textAlign: TextAlign.center,
                                    )),
                                DataColumn(
                                    numeric: true,
                                    label: Container(
                                      width: 140,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Center(
                                        child: DropdownButton<dynamic>(
                                          underline: Container(),
                                          elevation: 0,
                                          iconSize: 0,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 30,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          dropdownColor: Colors.white,
                                          value: headerGroupValue,
                                          items: dropdownMenuItems,
                                          style: Get.textTheme.titleSmall,
                                          onChanged: (dynamic newValue) {
                                            setState(() {
                                              headerGroupValue = newValue;
                                              if (headerGroupValue ==
                                                  'Approve All') {
                                                dataRowGroupValue = 'Approve';
                                              } else if (headerGroupValue ==
                                                  'Reject All') {
                                                dataRowGroupValue = 'Reject';
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    )),
                                const DataColumn(
                                    numeric: true,
                                    label: Text(
                                      "Effort",
                                      textAlign: TextAlign.center,
                                    )),
                                const DataColumn(
                                    numeric: true,
                                    label: Text(
                                      "Remarks",
                                    )),
                              ],
                              rows:
                                  List.generate(allPlannerList.length, (index) {
                                var v = index + 1;
                                for (int i = 0;
                                    i < allPlannerList.length;
                                    i++) {
                                  selectedItemValue.add(dataRowGroupValue);
                                }
                                addRemarks(TextEditingController(
                                    text: allPlannerList[index].remarks));
                                return DataRow(
                                    color: (widget.plannerApprovalController
                                                .plannerApprovalList
                                                .elementAt(index)
                                                .iSMTPLTAPreviousTask ==
                                            false)
                                        ? const MaterialStatePropertyAll(
                                            Colors.white)
                                        : MaterialStatePropertyAll(
                                            Colors.indigo.withOpacity(0.3)),
                                    cells: [
                                      DataCell(
                                        Text(v.toString()),
                                      ),
                                      DataCell(Checkbox(
                                          checkColor:
                                              Theme.of(context).primaryColor,
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          value: allPlannerList
                                              .elementAt(index)
                                              .flag,
                                          onChanged: (value) {
                                            setState(() {
                                              checked = allPlannerList
                                                  .elementAt(index)
                                                  .flag = value!;
                                              if (checkList.contains(index)) {
                                                checkList.remove(index);
                                                checked = allPlannerList[index]
                                                    .flag = false;
                                                if (allPlannerList.length !=
                                                    checkList.length) {
                                                  selectAll = false;
                                                }
                                              } else {
                                                checkList.add(index);
                                                if (allPlannerList.length ==
                                                    checkList.length) {
                                                  selectAll = true;
                                                }
                                              }
                                              if (value == false) {
                                                rejectEffort = 0.0;
                                                approveEffort = 0.0;
                                              }
                                            });
                                          })),
                                      DataCell(SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              allPlannerList[index].taskNo,
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                            Text(
                                              allPlannerList[index].taskName,
                                              maxLines: 2,
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Type Task: ',
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                              TextSpan(
                                                  text: allPlannerList[index]
                                                      .taskType,
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith()),
                                            ])),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Clint: ',
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                              TextSpan(
                                                  text: allPlannerList[index]
                                                      .clint,
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith()),
                                            ])),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Category: ',
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                              TextSpan(
                                                  text: allPlannerList[index]
                                                      .category,
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith()),
                                            ])),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Periodicity: ',
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                              TextSpan(
                                                  text: allPlannerList[index]
                                                      .periodicity,
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith()),
                                            ])),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Created Date: ',
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                              TextSpan(
                                                  text: getDateSelect(
                                                      DateTime.parse(
                                                          allPlannerList[index]
                                                              .date)),
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith()),
                                            ])),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Planned Date: ',
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                              TextSpan(
                                                  text: allPlannerList[index]
                                                      .plannedDate,
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith()),
                                            ])),
                                          ],
                                        ),
                                      )),
                                      DataCell((allPlannerList
                                                  .elementAt(index)
                                                  .flag ==
                                              true)
                                          ? Container(
                                              width: 120,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Center(
                                                  child: DropdownButton(
                                                value: selectedItemValue[index]
                                                    .toString(),
                                                items: _dropDownItem(),
                                                onChanged: (value) {
                                                  selectedItemValue[index] =
                                                      value!;
                                                  if (selectedItemValue[
                                                          index] ==
                                                      'Approve') {
                                                    addApproveEffort(double
                                                        .parse(allPlannerList
                                                            .elementAt(index)
                                                            .effort));
                                                    if (rejectEffort > 0) {
                                                      removeRejectEffort(double
                                                          .parse(allPlannerList
                                                              .elementAt(index)
                                                              .effort));
                                                    }
                                                  } else if (selectedItemValue[
                                                          index] ==
                                                      'Reject') {
                                                    addRejectEffort(double
                                                        .parse(allPlannerList
                                                            .elementAt(index)
                                                            .effort));
                                                    if (approveEffort > 0) {
                                                      removeApproveEffort(double
                                                          .parse(allPlannerList
                                                              .elementAt(index)
                                                              .effort));
                                                    }
                                                  }
                                                  setState(() {});
                                                },
                                              )),
                                            )
                                          : Container(
                                              width: 120,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Center(
                                                  child: Text(
                                                dataRowGroupValue,
                                                style: Get.textTheme.titleSmall,
                                              )),
                                            )),
                                      DataCell((allPlannerList
                                                  .elementAt(index)
                                                  .flag ==
                                              true)
                                          ? SizedBox(
                                              height: 40,
                                              width: 100,
                                              child: TextFormField(
                                                style: Get.textTheme.titleSmall,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: effortController
                                                    .elementAt(index),
                                                decoration: InputDecoration(
                                                    hintText: 'Effort',
                                                    hintStyle: Get
                                                        .textTheme.titleSmall,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black))),
                                              ),
                                            )
                                          : Text(
                                              '${allPlannerList[index].effort} ${(allPlannerList[index].duration == 'HOURS') ? 'Hr' : "Min"}')),
                                      DataCell(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: TextFormField(
                                          readOnly: (allPlannerList
                                                      .elementAt(index)
                                                      .flag ==
                                                  true)
                                              ? false
                                              : true,
                                          style: Get.textTheme.titleSmall,
                                          keyboardType: TextInputType.text,
                                          maxLines: 2,
                                          initialValue:
                                              allPlannerList[index].remarks,
                                          onChanged: (value) {
                                            setState(() {
                                              allPlannerList[index].remarks =
                                                  value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Task Remarks',
                                              hintStyle:
                                                  Get.textTheme.titleSmall,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black))),
                                        ),
                                      )),
                                    ]);
                              })
                              // .sublist(0, visibleRowCount),
                              ),
                        ),
                      ),
                      // (allPlannerList.isEmpty)
                      //     ? const SizedBox()
                      //     : Padding(
                      //         padding:
                      //             const EdgeInsets.only(bottom: 8.0, left: 16),
                      //         child: Align(
                      //           alignment: Alignment.bottomLeft,
                      //           child: InkWell(
                      //             onTap: () {
                      //               setState(() {
                      //                 visibleRowCount = (visibleRowCount + 10 <=
                      //                         allPlannerList.length)
                      //                     ? visibleRowCount + 10
                      //                     : allPlannerList.length;
                      //               });
                      //             },
                      //             child: Container(
                      //               height: 35,
                      //               width: 75,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 color: Theme.of(context).primaryColor,
                      //               ),
                      //               child: Center(
                      //                   child: Text(
                      //                 "Next",
                      //                 style: Get.textTheme.titleSmall!
                      //                     .copyWith(color: Colors.white),
                      //               )),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                    ],
                  );
      }),
    );
  }

  String getDateSelect(DateTime dt) {
    return "${dt.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
  }
}
