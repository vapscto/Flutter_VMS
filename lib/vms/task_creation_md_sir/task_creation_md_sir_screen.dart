import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/api/vms_transation_api.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/task_employee_list.dart';
import 'package:m_skool_flutter/vms/task_creation_md_sir/api/task_create_new_api.dart';
import 'package:m_skool_flutter/vms/task_creation_md_sir/controller/task_controller.dart';
import 'package:m_skool_flutter/vms/utils/save_btn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';

class TaskCreationNewScreen extends StatefulWidget {
  final String title;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const TaskCreationNewScreen(
      {super.key,
      required this.title,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<TaskCreationNewScreen> createState() => _TaskCreationNewScreenState();
}

class _TaskCreationNewScreenState extends State<TaskCreationNewScreen> {
  TaskCreationController controller = Get.put(TaskCreationController());
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final depController = TextEditingController();
  final _suggestionsBoxController = SuggestionsBoxController();
  final _suggestionsBoxController1 = SuggestionsBoxController();
  final employeeNameController = TextEditingController();
  int empId = 0;
  final VmsTransationController _vmsTransationController =
      Get.put(VmsTransationController());
  int depId = 0;
  DateTime? fdt;
  DateTime? toDt;
  _onload() async {
    controller.department(true);
    await TaskCreateNewAPI.instance.getDepartment(
        controller: controller,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: {
          "IVRMRT_Id": widget.loginSuccessModel.roleId,
          "UserId": widget.loginSuccessModel.userId,
          "MI_Id": widget.loginSuccessModel.mIID,
          "PageFlag": "app.ISM_TaskCreation"
        });
    taskEmployeeList.assignAll(controller.employeeListData);
    controller.department(false);
  }

  GetPriorityModelValues? selectPriority;
  @override
  void initState() {
    hrController.text = '0';
    minController.text = '0';
    isLoading = false;
    _onload();
    VmsTransationAPI.init().getTransation(
        base: baseUrlFromInsCode("login", widget.mskoolController),
        vmsTransationController: _vmsTransationController,
        userName: widget.loginSuccessModel.userName!,
        password: logInBox!.get("password"),
        miId: widget.loginSuccessModel.mIID!,
        roleId: widget.loginSuccessModel.roleId!);
    super.initState();
  }

  final hrController = TextEditingController();
  final minController = TextEditingController();
  int priorityId = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title, action: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: (isLoading)
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : BtnSave(
                  title: "Save",
                  onPress: () async {
                    if (depController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Select Department",
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                      return;
                    } else if (priorityId == 0) {
                      Fluttertoast.showToast(
                          msg: "Select Priority",
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                      return;
                    } else if (employeeNameController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Select Employee",
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                      return;
                    } else if (fromDateController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter Date",
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                      return;
                    } else if (titleController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter Title",
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                      return;
                    } else if (descriptionController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter Description",
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                      return;
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      String countHr =
                          (double.parse(minController.text) * 0.0166667)
                              .toStringAsFixed(2);
                      double count = double.parse(hrController.text) +
                          double.parse(countHr);
                      transnumbconfiguration.clear();
                      for (int i = 0;
                          i <
                              _vmsTransationController
                                  .transationConfigmodel.length;
                          i++) {
                        transnumbconfiguration.addAll({
                          "IMN_Id": _vmsTransationController
                              .transationConfigmodel[i].imNId,
                          "MI_Id": _vmsTransationController
                              .transationConfigmodel[i].mIId,
                          "IMN_AutoManualFlag": _vmsTransationController
                              .transationConfigmodel[i].imNAutoManualFlag,
                          "IMN_StartingNo": _vmsTransationController
                              .transationConfigmodel[i].imNStartingNo,
                          "IMN_WidthNumeric": _vmsTransationController
                              .transationConfigmodel[i].imNWidthNumeric,
                          "IMN_ZeroPrefixFlag": _vmsTransationController
                              .transationConfigmodel[i].imNZeroPrefixFlag,
                          "IMN_PrefixAcadYearCode": _vmsTransationController
                              .transationConfigmodel[i].imNPrefixAcadYearCode,
                          "IMN_PrefixParticular": _vmsTransationController
                              .transationConfigmodel[i].imNPrefixParticular,
                          "IMN_SuffixAcadYearCode": _vmsTransationController
                              .transationConfigmodel[i].imNSuffixAcadYearCode,
                          "IMN_SuffixParticular": "",
                          "IMN_RestartNumFlag": _vmsTransationController
                              .transationConfigmodel[i].imNRestartNumFlag,
                          "IMN_Flag": _vmsTransationController
                              .transationConfigmodel[i].imNFlag,
                          "ASMAY_Id": 0
                        });
                      }
                      await TaskCreateNewAPI.instance.taskSave(
                          base: baseUrlFromInsCode(
                              "issuemanager", widget.mskoolController),
                          body: {
                            "transnumbconfigurationsettingsss":
                                transnumbconfiguration,
                            "UserId": widget.loginSuccessModel.userId,
                            "Role_flag": "S",
                            "roletype": widget.loginSuccessModel.roleforlogin,
                            "IVRMRT_Id": widget.loginSuccessModel.roleId,
                            "plannerextapproval": false,
                            "plannerMaxdate": "0001-01-01T00:00:00",
                            "MI_Id": widget.loginSuccessModel.mIID,
                            "HRME_Id": logInBox!.get("EmpId"),
                            "ASMAY_Id": widget.loginSuccessModel.asmaYId,
                            "HRMD_Id": depId,
                            "ISMMPR_Id": controller.projectId,
                            "IVRMM_Id": controller.moduleId,
                            "ISMTCR_BugOREnhancementFlg": "O",
                            "assignto": "Y",
                            "ISMTCR_CreationDate":
                                DateTime.now().toIso8601String(),
                            "ISMTCR_Title": titleController.text,
                            "HRMPR_Id": priorityId,
                            "ISMMTCAT_Id": controller.categoryId,
                            "ISMTCR_Desc": descriptionController.text,
                            "ISMTCR_Status": "Open",
                            // "ISMTCRCL_Id": 0,
                            "ISMMCLT_Id": controller.clientId, //iSMMCLTId
                            "TimeRequiredFlg": "HOURS",
                            "attachmentArray": [],
                            "effortinhrs": count,
                            "enddate": toDt!.toIso8601String(),
                            "periodicity": "",
                            "remarks": "",
                            "startdate": fdt!.toIso8601String(),
                            "taskEmpArray": [
                              {"HRME_Id": empId}
                            ],
                            // "ISMTCR_Hours": 0,
                            // "ISMTCR_Days": 0,
                            // "ISMTCR_MainGroupTaskFlg": ismtcrMainGroupTask
                          }).then((value) {
                        if (value == true) {}
                      });
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
        )
      ]).getAppBar(),
      body: Obx(() {
        return controller.isDepartmentLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading data',
                desc: "Please wait we are loading data",
              ))
            : controller.departmentList.isEmpty
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'No data',
                    desc: "",
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
                        height: 60,
                        margin: const EdgeInsets.only(top: 10, bottom: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: TypeAheadFormField<GetDeptsValues>(
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          suggestionsBoxController: _suggestionsBoxController,
                          getImmediateSuggestions: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            style: Get.textTheme.titleSmall,
                            controller: depController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey, fontSize: 14),
                                hintText: controller.departmentList.isNotEmpty
                                    ? 'Search Department'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/prof1.png',
                                  containerColor:
                                      Color.fromRGBO(235, 214, 201, 1),
                                  text: 'Department',
                                  textColor: Color.fromRGBO(182, 72, 29, 1),
                                ),
                                suffixIcon: (depController.text.isEmpty)
                                    ? const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          depController.clear();
                                          depId = 0;
                                          taskEmployeeList.clear();
                                          setState(() {});
                                        },
                                        icon:
                                            const Icon(Icons.clear_outlined))),
                          ),
                          suggestionsCallback: (v) {
                            return controller.departmentList.where((d) => d
                                .hrmDDepartmentName!
                                .toLowerCase()
                                .contains(v.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              onTap: () async {
                                setState(() {
                                  depController.text =
                                      suggestion.hrmDDepartmentName!;
                                  depId = suggestion.hrmDId!;
                                  depController.text =
                                      suggestion.hrmDDepartmentName!;
                                  _suggestionsBoxController.close();

                                  // filterEmployees(
                                  //     suggestion.hrmDDepartmentName!);
                                });
                                await TaskCreateNewAPI.instance
                                    .getTskPrjtCatgryList(
                                        base: baseUrlFromInsCode(
                                          'issuemanager',
                                          widget.mskoolController,
                                        ),
                                        controller: controller,
                                        userId:
                                            widget.loginSuccessModel.userId!,
                                        ivrmrtId:
                                            widget.loginSuccessModel.roleId!,
                                        miId: widget.loginSuccessModel.mIID!,
                                        hRMEId: logInBox!.get("EmpId"),
                                        hRMDId: suggestion.hrmDId!)
                                    .then((value) async {
                                  if (value == 200) {
                                    await TaskCreateNewAPI.instance
                                        .geTskClientApi(
                                            base: baseUrlFromInsCode(
                                              "issuemanager",
                                              widget.mskoolController,
                                            ),
                                            controller: controller,
                                            userId: widget
                                                .loginSuccessModel.userId!,
                                            ivrmrtId: widget
                                                .loginSuccessModel.roleId!,
                                            miId:
                                                widget.loginSuccessModel.mIID!,
                                            hRMEId: logInBox!.get("EmpId"),
                                            hRMDId: logInBox!.get("HRMDID"),
                                            roleflag: widget.loginSuccessModel
                                                .roleforlogin!,
                                            iSMMPRId: controller.projectId);
                                  }
                                });
                              },
                              title: Text(
                                suggestion.hrmDDepartmentName!,
                                style: Get.textTheme.titleSmall,
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {},
                          noItemsFoundBuilder: (context) {
                            return const SizedBox();
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<GetPriorityModelValues>(
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          // value: _taskDepartController.getPriorityModelList.first,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText: controller.priorityList.isNotEmpty
                                ? 'Select priority: '
                                : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(223, 251, 254, 1),
                              text: 'Priority',
                              textColor: Color.fromRGBO(40, 182, 200, 1),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 30,
                          items: List.generate(controller.priorityList.length,
                              (index) {
                            return DropdownMenuItem(
                              value: controller.priorityList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  controller.priorityList[index].hrmPName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            priorityId = s!.hrmpRId!;
                          },
                        ),
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                              showCheckboxColumn: true,
                              headingRowColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColor),
                              dataTextStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w400),
                              dataRowHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                              headingRowHeight: 50,
                              horizontalMargin: 10,
                              columnSpacing: 10,
                              dividerThickness: 1,
                              headingTextStyle: Get.textTheme.titleSmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    ' Effort for each task',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // DataColumn(
                                //   label: Align(
                                //     alignment: Alignment.center,
                                //     child: Text(
                                //       'Employee List',
                                //     ),
                                //   ),
                                // ),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                  readOnly: true,
                                                  controller:
                                                      fromDateController,
                                                  onTap: () async {
                                                    fdt = await showDatePicker(
                                                      context: context,
                                                      helpText:
                                                          "Select From Data",
                                                      firstDate: DateTime.parse(
                                                          controller
                                                              .maxPlannerDate),
                                                      initialDate:
                                                          DateTime.now(),
                                                      lastDate: DateTime(3050),
                                                    );
                                                    if (fdt != null) {
                                                      setState(() {
                                                        fromDateController
                                                                .text =
                                                            "${numberList[fdt!.day]}:${numberList[fdt!.month]}:${fdt!.year}";
                                                        DateTime dt = fdt!.add(
                                                            const Duration(
                                                                days: 5));
                                                        toDateController.text =
                                                            "${numberList[dt.day]}:${numberList[dt.month]}:${dt.year}";
                                                      });
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.calendar_month,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(4),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    hintText: 'Start Date',
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  readOnly: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                  controller: toDateController,
                                                  onTap: () async {
                                                    if (fdt != null) {
                                                      toDt =
                                                          await showDatePicker(
                                                        context: context,
                                                        helpText:
                                                            "Select To Date",
                                                        firstDate: fdt!,
                                                        initialDate: fdt!,
                                                        lastDate:
                                                            DateTime(3050),
                                                      );
                                                      if (toDt != null) {
                                                        toDateController.text =
                                                            "${numberList[toDt!.day]}:${numberList[toDt!.month]}:${toDt!.year}";
                                                      }
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Select Start Date");
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.calendar_month,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(4),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    hintText: 'End Date',
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    controller: hrController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                        // contentPadding:
                                                        //     const EdgeInsets
                                                        //         .all(3),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6))),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    "HH",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    controller: minController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                        // contentPadding:
                                                        //     const EdgeInsets
                                                        //         .all(3),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6))),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    "MM",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                  // DataCell(SizedBox(
                                  //   width:
                                  //       MediaQuery.of(context).size.width * 0.7,
                                  //   child: SingleChildScrollView(
                                  //     scrollDirection: Axis.vertical,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //           vertical: 5, horizontal: 5),
                                  //       child: Column(
                                  //         children: [
                                  //           // SizedBox(
                                  //           //     height: 40,
                                  //           //     width: 200,
                                  //           //     child: TextField(
                                  //           //       maxLines: 1,
                                  //           //       controller: serchEmployee,
                                  //           //       onChanged: (value) {
                                  //           //         filterEmployees(value);
                                  //           //       },
                                  //           //       style: Theme.of(context)
                                  //           //           .textTheme
                                  //           //           .titleSmall!
                                  //           //           .merge(const TextStyle(
                                  //           //             fontWeight:
                                  //           //                 FontWeight.w100,
                                  //           //             fontSize: 12.0,
                                  //           //             letterSpacing: 0.3,
                                  //           //             overflow:
                                  //           //                 TextOverflow.clip,
                                  //           //           )),
                                  //           //       decoration: InputDecoration(
                                  //           //           hintText: "Search",
                                  //           //           helperStyle: Theme.of(
                                  //           //                   context)
                                  //           //               .textTheme
                                  //           //               .titleSmall!
                                  //           //               .merge(
                                  //           //                   const TextStyle(
                                  //           //                 fontWeight:
                                  //           //                     FontWeight.w100,
                                  //           //                 fontSize: 12.0,
                                  //           //                 letterSpacing: 0.3,
                                  //           //                 overflow:
                                  //           //                     TextOverflow
                                  //           //                         .clip,
                                  //           //               )),
                                  //           //           border:
                                  //           //               OutlineInputBorder(
                                  //           //                   borderRadius:
                                  //           //                       BorderRadius
                                  //           //                           .circular(
                                  //           //                               5))),
                                  //           //     )),

                                  //           (taskEmployeeList.isEmpty)
                                  //               ? const Center(
                                  //                   child: Text(
                                  //                       "Select Department"),
                                  //                 )
                                  //               : SingleChildScrollView(
                                  //                   scrollDirection:
                                  //                       Axis.vertical,
                                  //                   child: SizedBox(
                                  //                     width:
                                  //                         MediaQuery.of(context)
                                  //                                 .size
                                  //                                 .width *
                                  //                             0.7,
                                  //                     height:
                                  //                         MediaQuery.of(context)
                                  //                                 .size
                                  //                                 .height *
                                  //                             0.3,
                                  //                     child: Obx(
                                  //                       () => ListView.builder(
                                  //                         itemCount:
                                  //                             taskEmployeeList
                                  //                                     .length +
                                  //                                 1,
                                  //                         itemBuilder:
                                  //                             (context, index) {
                                  //                           if (index == 0) {
                                  //                             return Padding(
                                  //                               padding: const EdgeInsets
                                  //                                       .symmetric(
                                  //                                   vertical:
                                  //                                       2),
                                  //                               child: Row(
                                  //                                 children: [
                                  //                                   Checkbox(
                                  //                                     shape:
                                  //                                         ContinuousRectangleBorder(
                                  //                                       borderRadius:
                                  //                                           BorderRadius.circular(10),
                                  //                                     ),
                                  //                                     activeColor:
                                  //                                         const Color(
                                  //                                             0xFF1A30F1),
                                  //                                     value:
                                  //                                         selectAll,
                                  //                                     onChanged:
                                  //                                         (value) {
                                  //                                       setState(
                                  //                                           () {
                                  //                                         selectAll =
                                  //                                             value!;
                                  //                                         if (selectAll) {
                                  //                                           employeesID.clear();
                                  //                                           employeesID =
                                  //                                               List.from(taskEmployeeList.map((employee) => employee.hRMEId!));
                                  //                                           logger.i(employeesID);
                                  //                                         } else {
                                  //                                           employeesID.clear();
                                  //                                           logger.i(employeesID);
                                  //                                         }
                                  //                                         controller.checkBox.assignAll(List.filled(
                                  //                                             taskEmployeeList.length,
                                  //                                             selectAll));
                                  //                                       });
                                  //                                     },
                                  //                                   ),
                                  //                                   const SizedBox(),
                                  //                                   const Text(
                                  //                                     "All Employees",
                                  //                                     style: TextStyle(
                                  //                                         fontWeight:
                                  //                                             FontWeight.bold),
                                  //                                   ),
                                  //                                 ],
                                  //                               ),
                                  //                             );
                                  //                           } else {
                                  //                             return Padding(
                                  //                               padding: const EdgeInsets
                                  //                                       .symmetric(
                                  //                                   vertical:
                                  //                                       2),
                                  //                               child: SizedBox(
                                  //                                 width: MediaQuery.of(
                                  //                                             context)
                                  //                                         .size
                                  //                                         .width *
                                  //                                     0.7,
                                  //                                 height: 30,
                                  //                                 child: Row(
                                  //                                   children: [
                                  //                                     Checkbox(
                                  //                                       shape:
                                  //                                           ContinuousRectangleBorder(
                                  //                                         borderRadius:
                                  //                                             BorderRadius.circular(10),
                                  //                                       ),
                                  //                                       activeColor:
                                  //                                           const Color(0xFF1A30F1),
                                  //                                       value: controller.checkBox[
                                  //                                           index -
                                  //                                               1],
                                  //                                       onChanged:
                                  //                                           (value) {
                                  //                                         setState(
                                  //                                             () {
                                  //                                           controller.checkBox[index - 1] =
                                  //                                               value!;

                                  //                                           if (value) {
                                  //                                             employeesID.add(taskEmployeeList[index - 1].hRMEId!);
                                  //                                             logger.i(employeesID);
                                  //                                           } else {
                                  //                                             employeesID.remove(taskEmployeeList[index - 1].hRMEId);
                                  //                                             logger.i(employeesID);
                                  //                                           }

                                  //                                           selectAll =
                                  //                                               controller.checkBox.every((value) => value);
                                  //                                         });
                                  //                                       },
                                  //                                     ),
                                  //                                     const SizedBox(),
                                  //                                     SizedBox(
                                  //                                       width: MediaQuery.of(context).size.width *
                                  //                                           0.5,
                                  //                                       child:
                                  //                                           RichText(
                                  //                                         text:
                                  //                                             TextSpan(
                                  //                                           children: [
                                  //                                             TextSpan(
                                  //                                               text: taskEmployeeList[index - 1].employeeName,
                                  //                                               style: Theme.of(context).textTheme.titleSmall!.merge(
                                  //                                                     const TextStyle(
                                  //                                                       fontWeight: FontWeight.bold,
                                  //                                                       fontSize: 14.0,
                                  //                                                       overflow: TextOverflow.clip,
                                  //                                                     ),
                                  //                                                   ),
                                  //                                             ),
                                  //                                             TextSpan(
                                  //                                               text: " : ${taskEmployeeList[index - 1].hRMDESDesignationName} ",
                                  //                                               style: Theme.of(context).textTheme.titleSmall!.merge(
                                  //                                                     const TextStyle(
                                  //                                                       fontWeight: FontWeight.w100,
                                  //                                                       fontSize: 13.0,
                                  //                                                       overflow: TextOverflow.clip,
                                  //                                                     ),
                                  //                                                   ),
                                  //                                             ),
                                  //                                           ],
                                  //                                         ),
                                  //                                       ),
                                  //                                     )
                                  //                                   ],
                                  //                                 ),
                                  //                               ),
                                  //                             );
                                  //                           }
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )),
                                ]),
                              ],
                            ),
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 25.0),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Expanded(
                      //         child: CustomContainer(
                      //           child: TextField(
                      //             style: Theme.of(context).textTheme.titleSmall,
                      //             readOnly: true,
                      //             controller: fromDateController,
                      //             onTap: () async {
                      //               fdt = await showDatePicker(
                      //                 context: context,
                      //                 helpText: "Select From Data",
                      //                 firstDate: DateTime.now(),
                      //                 initialDate: DateTime.now(),
                      //                 lastDate: DateTime(3050),
                      //               );
                      //               if (fdt != null) {
                      //                 setState(() {
                      //                   fromDateController.text =
                      //                       "${numberList[fdt!.day]}:${numberList[fdt!.month]}:${fdt!.year}";
                      //                   DateTime dt =
                      //                       fdt!.add(const Duration(days: 5));
                      //                   toDateController.text =
                      //                       "${numberList[dt.day]}:${numberList[dt.month]}:${dt.year}";
                      //                 });
                      //               }
                      //             },
                      //             decoration: InputDecoration(
                      //               suffixIcon: Icon(
                      //                 Icons.calendar_month,
                      //                 color: Theme.of(context).primaryColor,
                      //                 size: 35,
                      //               ),
                      //               contentPadding: const EdgeInsets.only(
                      //                   top: 40.0, left: 12),
                      //               border: const OutlineInputBorder(),
                      //               label: Container(
                      //                 margin: const EdgeInsets.only(bottom: 5),
                      //                 padding: const EdgeInsets.symmetric(
                      //                     horizontal: 12.0, vertical: 8.0),
                      //                 decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(24.0),
                      //                     color: const Color(0xFFE5F3FF)),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                       "assets/svg/calendar_icon.svg",
                      //                       color: const Color(0xFF3E78AA),
                      //                       height: 18,
                      //                     ),
                      //                     const SizedBox(
                      //                       width: 6.0,
                      //                     ),
                      //                     Text(
                      //                       " Start Date ",
                      //                       style: Theme.of(context)
                      //                           .textTheme
                      //                           .labelMedium!
                      //                           .merge(
                      //                             const TextStyle(
                      //                               fontSize: 18.0,
                      //                               color: Color(0xFF3E78AA),
                      //                             ),
                      //                           ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               hintText: 'Select Date',
                      //               floatingLabelBehavior:
                      //                   FloatingLabelBehavior.always,
                      //               enabledBorder: const OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                   color: Colors.transparent,
                      //                 ),
                      //               ),
                      //               focusedBorder: const OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                   color: Colors.transparent,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 12.0,
                      //       ),
                      //       Expanded(
                      //         child: CustomContainer(
                      //           child: TextField(
                      //             readOnly: true,
                      //             style: Theme.of(context).textTheme.titleSmall,
                      //             controller: toDateController,
                      //             onTap: () async {
                      //               if (fdt != null) {
                      //                 toDt = await showDatePicker(
                      //                   context: context,
                      //                   helpText: "Select To Date",
                      //                   firstDate: fdt!,
                      //                   initialDate: fdt!,
                      //                   lastDate: DateTime(3050),
                      //                 );
                      //                 if (toDt != null) {
                      //                   toDateController.text =
                      //                       "${numberList[toDt!.day]}:${numberList[toDt!.month]}:${toDt!.year}";
                      //                 }
                      //               } else {
                      //                 Fluttertoast.showToast(
                      //                     msg: "Please Select Start Date");
                      //               }
                      //             },
                      //             decoration: InputDecoration(
                      //               isDense: true,
                      //               contentPadding: const EdgeInsets.only(
                      //                   top: 40.0, left: 12),
                      //               suffixIcon: Icon(
                      //                 Icons.calendar_month,
                      //                 color: Theme.of(context).primaryColor,
                      //                 size: 35,
                      //               ),
                      //               border: const OutlineInputBorder(),
                      //               label: Container(
                      //                 margin: const EdgeInsets.only(bottom: 5),
                      //                 padding: const EdgeInsets.symmetric(
                      //                     horizontal: 12.0, vertical: 8.0),
                      //                 decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(24.0),
                      //                     color: const Color(0xFFE5F3FF)),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                       "assets/svg/calendar_icon.svg",
                      //                       color: const Color(0xFF3E78AA),
                      //                       height: 18,
                      //                     ),
                      //                     const SizedBox(
                      //                       width: 6.0,
                      //                     ),
                      //                     Text(
                      //                       " End Date ",
                      //                       style: Theme.of(context)
                      //                           .textTheme
                      //                           .labelMedium!
                      //                           .merge(
                      //                             const TextStyle(
                      //                                 fontSize: 18.0,
                      //                                 color: Color(0xFF3E78AA)),
                      //                           ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               hintText: 'Select Date',
                      //               floatingLabelBehavior:
                      //                   FloatingLabelBehavior.always,
                      //               enabledBorder: const OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                   color: Colors.transparent,
                      //                 ),
                      //               ),
                      //               focusedBorder: const OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                   color: Colors.transparent,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      (taskEmployeeList.isEmpty)
                          ? const SizedBox()
                          : Container(
                              height: 60,
                              margin: const EdgeInsets.only(top: 25),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 8,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: TypeAheadFormField<
                                  TaskEmployeeListModelValues>(
                                validator: (value) {
                                  if (value == null) {
                                    return "";
                                  }
                                  return null;
                                },
                                suggestionsBoxController:
                                    _suggestionsBoxController1,
                                getImmediateSuggestions: true,
                                direction: AxisDirection.up,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: employeeNameController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: Colors.grey, fontSize: 14),
                                      hintText: taskEmployeeList.isNotEmpty
                                          ? 'Search Employee'
                                          : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      label: const CustomDropDownLabel(
                                        icon: 'assets/images/prof1.png',
                                        containerColor:
                                            Color.fromRGBO(235, 214, 201, 1),
                                        text: 'Employee',
                                        textColor:
                                            Color.fromRGBO(182, 72, 29, 1),
                                      ),
                                      suffixIcon: (employeeNameController
                                              .text.isEmpty)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                employeeNameController.clear();
                                                empId = 0;
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                  Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return taskEmployeeList.where((d) => d
                                      .employeeName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        employeeNameController.text =
                                            suggestion.employeeName!;
                                        empId = suggestion.hRMEId!;
                                        _suggestionsBoxController1.close();
                                      });
                                    },
                                    title: Text(
                                      suggestion.employeeName!,
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {},
                                noItemsFoundBuilder: (context) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                      const SizedBox(height: 15),
                      TextField(
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Issue/Task Title',
                          labelStyle: Get.textTheme.titleMedium,
                          hintText: 'Enter Issue/Task Title.',
                          hintStyle: Get.textTheme.titleSmall!
                              .copyWith(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Description',
                          labelStyle: Get.textTheme.titleMedium,
                          hintText: 'Enter Description.',
                          hintStyle: Get.textTheme.titleSmall!
                              .copyWith(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
      }),
    );
  }

  void filterEmployees(String query) {
    taskEmployeeList.value = controller.employeeListData
        .where((employee) =>
            // employee.employeeName!
            //     .toLowerCase()
            //     .contains(query.toLowerCase()) ||
            employee.hRMDDepartmentName!.toLowerCase().trim() ==
            query.toLowerCase().trim())
        .toList();

    setState(() {});
  }

  RxList<TaskEmployeeListModelValues> taskEmployeeList =
      <TaskEmployeeListModelValues>[].obs;
  List<int> employeesID = [];
  bool selectAll = false;
  TextEditingController serchEmployee = TextEditingController();
  Map<String, dynamic> transnumbconfiguration = {};
}
