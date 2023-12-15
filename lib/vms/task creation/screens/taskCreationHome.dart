import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/api/vms_transation_api.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/get_depart_api.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/get_prjects_catgory_api.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/get_task_client.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/onchange_client_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/sava_task.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_client_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_projects_cntroller.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_Tsk_Client.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/task_employee_list.dart';
import 'package:m_skool_flutter/vms/task%20creation/screens/task_details_screen.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:open_filex/open_filex.dart';

class TaskCreationHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String previousScreen;
  // final bool showAppBar;
  const TaskCreationHome({
    required this.loginSuccessModel,
    required this.mskoolController,
    super.key,
    required this.previousScreen,
    // required this.showAppBar
  });

  @override
  State<TaskCreationHome> createState() => _TaskCreationHomeState();
}

class _TaskCreationHomeState extends State<TaskCreationHome> {
  final TaskDepartController _taskDepartController =
      Get.put(TaskDepartController());
  final ImagePicker _imagePicker = ImagePicker();
  DrDetailsCtrlr controller = Get.put(DrDetailsCtrlr());

  final TaskProjectsController _taskProjectsController =
      Get.put(TaskProjectsController());

  final TaskClientModuleCntroller _taskClientModuleCntroller =
      Get.put(TaskClientModuleCntroller());
  final VmsTransationController _vmsTransationController =
      Get.put(VmsTransationController());
  final TextEditingController _titleETController = TextEditingController();
  final TextEditingController _descritpionETController =
      TextEditingController();
  final TextEditingController _etListControllerStatus = TextEditingController();
  TextEditingController selectFromDate = TextEditingController();
  TextEditingController selectToDate = TextEditingController();
  TextEditingController hoursEt = TextEditingController();
  TextEditingController minutesEt = TextEditingController();
  TextEditingController remarksEt = TextEditingController();
  TextEditingController serchEmployee = TextEditingController();
  TextEditingController etDayControllers = TextEditingController();
  TextEditingController etRemarkControllers = TextEditingController();
  Map<String, dynamic> transnumbconfiguration = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var moduleId;
  List<int> employeesID = [];
  RxList<TaskEmployeeListModelValues> taskEmployeeList =
      <TaskEmployeeListModelValues>[].obs;
  RxList<String> periodicityList = <String>[
    "Daily",
    "Weekly",
    "Once in Fortnight",
    "Yearly Once",
    "Specific Day"
  ].obs;
  RxString dropdownValue = "Daily".obs;
  int hrmdIds = 0;
  String priorityId = "";
  int clinetId = 0;
  int projectId = 0;
  int categoryId = 0;

  List<Map<String, dynamic>> taskEmpArray = [];
  @override
  void initState() {
    hoursEt.text = "0";
    minutesEt.text = "0";
    logger.d("userId${widget.loginSuccessModel.userId}");
    if (_taskDepartController.addListBrowser.isNotEmpty) {
      _taskDepartController.addListBrowser.clear();
    }
    loadCmpny();
    VmsTransationAPI.init().getTransation(
        base: baseUrlFromInsCode("login", widget.mskoolController),
        vmsTransationController: _vmsTransationController,
        userName: widget.loginSuccessModel.userName!,
        password: logInBox!.get("password"),
        miId: widget.loginSuccessModel.mIID!,
        roleId: widget.loginSuccessModel.roleId!);
    addItemListBrowse(0, "");
    taskEmployeeList.assignAll(_taskDepartController.getTaskEmployeeList);

    _etListControllerStatus.text = "Open";
    super.initState();
  }

  addItemListBrowse(int val, String name) {
    _taskDepartController.addListBrowser.add(AtachmentFile(
      id: val,
      FileName: name,
    ));

    setState(() {});
  }

  removeItemListBrowse(int val) {
    _taskDepartController.addListBrowser.removeAt(val);
    setState(() {});
  }

  Future<void> loadImages() async {
    controller.updateTabLoading(true);
    String? periodicityType;
    var taskDay;
    if (_taskDepartController.typesTask.value == "T") {
      periodicityType = dropdownValue.value;
      if (dropdownValue.value == "Daily") {
        //  taskDay = 0;
      } else if (dropdownValue.value == "Weekly" ||
          dropdownValue.value == "Once in Fortnight") {
        taskDay = etDayControllers.text;
      } else if (dropdownValue.value == "Yearly Once" ||
          dropdownValue.value == "Specific Day") {
        int dayNum = 0;
        taskDay = dayNum.toInt();
      }
    } else if (_taskDepartController.typesTask.value == "B" ||
        _taskDepartController.typesTask.value == "E" ||
        _taskDepartController.typesTask.value == "O") {
      periodicityType = "";
    }
    for (int i = 0; i < employeesID.length; i++) {
      taskEmpArray.add({"HRME_Id": employeesID[i]});
    }
    for (int i = 0;
        i < _vmsTransationController.transationConfigmodel.length;
        i++) {
      transnumbconfiguration.addAll({
        "IMN_Id": _vmsTransationController.transationConfigmodel[i].imNId,
        "MI_Id": _vmsTransationController.transationConfigmodel[i].mIId,
        "IMN_AutoManualFlag":
            _vmsTransationController.transationConfigmodel[i].imNAutoManualFlag,
        "IMN_StartingNo":
            _vmsTransationController.transationConfigmodel[i].imNStartingNo,
        "IMN_WidthNumeric":
            _vmsTransationController.transationConfigmodel[i].imNWidthNumeric,
        "IMN_ZeroPrefixFlag":
            _vmsTransationController.transationConfigmodel[i].imNZeroPrefixFlag,
        "IMN_PrefixAcadYearCode": _vmsTransationController
            .transationConfigmodel[i].imNPrefixAcadYearCode,
        "IMN_PrefixParticular": _vmsTransationController
            .transationConfigmodel[i].imNPrefixParticular,
        "IMN_SuffixAcadYearCode": _vmsTransationController
            .transationConfigmodel[i].imNSuffixAcadYearCode,
        "IMN_SuffixParticular": "",
        "IMN_RestartNumFlag":
            _vmsTransationController.transationConfigmodel[i].imNRestartNumFlag,
        "IMN_Flag": _vmsTransationController.transationConfigmodel[i].imNFlag,
        "ASMAY_Id": 0
      });
    }
    await saveTask(
      typeAssign: _taskDepartController.taskAssingn.value,
      base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
      controller: _taskDepartController,
      controllerLoading: controller,
      trnsNumConfig: transnumbconfiguration,
      miId: widget.loginSuccessModel.mIID!,
      userID: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      academicYear: widget.loginSuccessModel.asmaYId!,
      hrme: logInBox!.get("EmpId"),
      HRMD_Id: hrmdIds,
      HRMPR_Id: priorityId, // priority id
      ISMCIM_IEList: "0",
      ISMMCLT_Id: clinetId, //clientsID
      ISMMPR_Id: projectId, // projectId
      ISMMTCAT_Id: categoryId, // categoryId
      ISMTCR_BugOREnhancementFlg: _taskDepartController.typesTask.value,
      ISMTCR_CreationDate: DateTime.now().toString(),
      ISMTCR_Desc: _descritpionETController.text,
      ISMTCR_Id: "0",
      ISMTCR_Status: "Open",
      ISMTCR_Title: _titleETController.text,
      IVRMM_Id: moduleId, //module id
      TaskDay: taskDay,
      TimeRequiredFlg: "HOURS",
      Yearlydate: "Thu Jan 01 1970",
      assignto: _taskDepartController.taskAssingn.value,
      uploadDocs: _taskDepartController.addListBrowser,
      effortinhrs: double.parse("${hoursEt.text}.${minutesEt.text}"),
      enddate: selectToDate.text,
      periodicity: periodicityType,
      remarks: etRemarkControllers.text,
      roletype: widget.loginSuccessModel.roleforlogin,
      startdate: selectFromDate.text,
      taskEmpArray: taskEmpArray,
    ).then(
      (value) {
        if (value) {
          //  Get.back();
          employeesID.clear();
          taskEmployeeList.clear();
          _taskDepartController.getDeptsList.clear();
          _taskDepartController.getTaskEmployeeList.clear();
          selectFromDate.clear();
          selectToDate.clear();
          hoursEt.text = "0";
          minutesEt.text = "0";
          remarksEt.clear();
          etDayControllers.clear();
          etRemarkControllers.clear();
          _taskProjectsController.getTaskProjectsList.clear();
          _taskProjectsController.getTaskCategoryList.clear();
          _taskClientModuleCntroller.getModuleValuesList.clear();
          _taskDepartController.getPriorityModelList.clear();
          _taskDepartController.addListBrowser.clear();
          _taskClientModuleCntroller.taskClientList.clear();
          _titleETController.clear();
          _descritpionETController.clear();
          _taskDepartController.updateTaskAssign("N");
          _taskDepartController.updateTypeOfTask("B");
          employeesID.clear();
          _taskDepartController.checkBox.clear();
          addItemListBrowse(0, "");
          loadCmpny();
          _taskDepartController.updateDisbleSubmitButton(true);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Task Created successfully',
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  loadCmpny() async {
    await getTskCompaniesList(
      base: baseUrlFromInsCode(
        'issuemanager',
        widget.mskoolController,
      ),
      controller: _taskDepartController,
      userId: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      miId: widget.loginSuccessModel.mIID!,
    ).then(
      (value) {
        if (value) {}
      },
    );
  }

  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: (widget.previousScreen == '1') ? true : false,
          // titleSpacing: (widget.previousScreen == '1') ? 40 : 0,
          leading: (widget.previousScreen == '0')
              ? const CustomGoBackButton()
              : const SizedBox(),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
              child: Obx(
                () => controller.drIsLoading.value
                    ? const SizedBox()
                    : Visibility(
                        visible:
                            _taskDepartController.disableSubmitButton.isTrue,
                        child: BtnSave(
                          title: 'Submit',
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_taskDepartController.taskAssingn.value ==
                                  'Y') {
                                if (selectFromDate.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Select From Date");
                                  return;
                                } else if (selectToDate.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "Select To Date");
                                  return;
                                } else if (hoursEt.text == "0" &&
                                    minutesEt.text == "0") {
                                  Fluttertoast.showToast(msg: "Enter Time");
                                  return;
                                } else if (employeesID.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Select Employee");
                                  return;
                                } else {
                                  _taskDepartController
                                      .updateDisbleSubmitButton(false);
                                  await loadImages();
                                }
                              } else if (_taskDepartController
                                      .taskAssingn.value ==
                                  'N') {
                                _taskDepartController
                                    .updateDisbleSubmitButton(false);
                                await loadImages();
                              }
                            } else {
                              Fluttertoast.showToast(msg: "Select mandatory");
                            }
                          },
                        ),
                      ),
              ),
            )
          ],
          title: const Text(
            "Task Creation",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Obx(() => _taskDepartController.tskDeptErrorLoading.value
                ? const Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg":
                            "While loading company we encountered an error"
                      },
                    ),
                  )
                : _taskDepartController.getDeptsList.isEmpty
                    ? const AnimatedProgressWidget(
                        animationPath: 'assets/json/default.json',
                        title: 'Loading data',
                        desc: "Please wait we are loading data",
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                            top: 30, left: 16, right: 16, bottom: 16),
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
                        child: DropdownButtonFormField<GetDeptsValues>(
                          // value: _taskDepartController.getDeptsList.first,
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
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
                            hintText:
                                _taskDepartController.getDeptsList.isNotEmpty
                                    ? 'Select Department'
                                    : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(223, 251, 254, 1),
                              text: 'Department',
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
                          items: List.generate(
                              _taskDepartController.getDeptsList.length,
                              (index) {
                            return DropdownMenuItem(
                              value: _taskDepartController.getDeptsList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  _taskDepartController
                                      .getDeptsList[index].hrmDDepartmentName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            _taskProjectsController.getTaskProjectsList.clear();
                            _taskProjectsController.getTaskCategoryList.clear();
                            hrmdIds = s!.hrmDId!;
                            filterEmployees(s.hrmDDepartmentName!);
                            await getTskPrjtCatgryList(
                                base: baseUrlFromInsCode(
                                  'issuemanager',
                                  widget.mskoolController,
                                ),
                                controller: _taskProjectsController,
                                userId: widget.loginSuccessModel.userId!,
                                ivrmrtId: widget.loginSuccessModel.roleId!,
                                miId: widget.loginSuccessModel.mIID!,
                                HRME_Id: logInBox!.get("EmpId"),
                                HRMD_Id: s.hrmDId!);
                          },
                        ),
                      )),
            Obx(() => _taskProjectsController.tskPrjErrorLoading.value
                ? const Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg":
                            "While loading company we encountered an error"
                      },
                    ),
                  )
                : _taskProjectsController.getTaskProjectsList.isEmpty
                    ? SizedBox()
                    : _taskProjectsController.tskPrjtloading.value
                        ? const AnimatedProgressWidget(
                            animationPath: 'assets/json/default.json',
                            title: 'Loading data',
                            desc: "Please wait we are loading data",
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 16, right: 16, bottom: 16),
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
                            child: DropdownButtonFormField<GeTskProjectsValues>(
                              // value: _taskProjectsController
                              //     .getTaskProjectsList.first,
                              validator: (value) {
                                if (value == null) {
                                  return "";
                                }
                                return null;
                              },
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
                                hintText: _taskProjectsController
                                        .getTaskProjectsList.isNotEmpty
                                    ? 'Select Project'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/hat.png',
                                  containerColor:
                                      Color.fromRGBO(223, 251, 254, 1),
                                  text: 'Project',
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
                              items: List.generate(
                                  _taskProjectsController
                                      .getTaskProjectsList.length, (index) {
                                return DropdownMenuItem(
                                  value: _taskProjectsController
                                      .getTaskProjectsList[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5),
                                    child: Text(
                                      overflow: TextOverflow.clip,
                                      _taskProjectsController
                                          .getTaskProjectsList[index]
                                          .ismmpRProjectName!,
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
                                _taskClientModuleCntroller.taskClientList
                                    .clear();
                                _taskClientModuleCntroller.getModuleValuesList
                                    .clear();
                                projectId = s!.ismmpRId!;
                                await geTskClientApi(
                                    base: baseUrlFromInsCode(
                                      "issuemanager",
                                      widget.mskoolController,
                                    ),
                                    controller: _taskClientModuleCntroller,
                                    userId: widget.loginSuccessModel.userId!,
                                    ivrmrtId: widget.loginSuccessModel.roleId!,
                                    miId: widget.loginSuccessModel.mIID!,
                                    HRME_Id: logInBox!.get("EmpId"),
                                    HRMD_Id: logInBox!.get("HRMDID"),
                                    roleflag:
                                        widget.loginSuccessModel.roleforlogin!,
                                    ISMMPR_Id: s.ismmpRId!);
                              },
                            ),
                          )),
            // Clients Dropdown
            Obx(() => _taskClientModuleCntroller.clientErrorloading.value
                ? const Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg":
                            "While loading company we encountered an error"
                      },
                    ),
                  )
                : Visibility(
                    visible:
                        _taskClientModuleCntroller.taskClientList.isNotEmpty,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 20, left: 16, right: 16, bottom: 16),
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
                      child: DropdownButtonFormField<GeTskClientValues>(
                        // value:
                        //     _taskClientModuleCntroller.taskClientList.first,
                        validator: (value) {
                          if (value == null) {
                            return "";
                          }
                          return null;
                        },
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
                          hintText: _taskClientModuleCntroller
                                  .taskClientList.isNotEmpty
                              ? 'Select Client'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Client',
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
                        items: List.generate(
                            _taskClientModuleCntroller.taskClientList.length,
                            (index) {
                          return DropdownMenuItem(
                            value: _taskClientModuleCntroller
                                .taskClientList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  _taskClientModuleCntroller
                                      .taskClientList[index].ismmclTClientName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) async {
                          clinetId = s!.ismmclTId!;
                          await onChangeModuleListApi(
                              base: baseUrlFromInsCode(
                                "issuemanager",
                                widget.mskoolController,
                              ),
                              controller: _taskDepartController,
                              userId: widget.loginSuccessModel.userId!,
                              ivrmrtId: widget.loginSuccessModel.roleId!,
                              miId: widget.loginSuccessModel.mIID!,
                              HRME_Id: logInBox!.get("EmpId"),
                              hrmdId: logInBox!.get("HRMDID"),
                              roleType: widget.loginSuccessModel.roleforlogin!,
                              ismmprId: s.ismmpRId!,
                              ismmcltId: s.ismmclTId!);
                        },
                      ),
                    ),
                  )),

            // Category Dropdown

            Obx(() => _taskProjectsController.getTaskCategoryList.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(
                        top: 20, left: 16, right: 16, bottom: 16),
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
                    child: DropdownButtonFormField<GeTskCategoryValues>(
                      // value: _taskProjectsController.getTaskCategoryList.first,
                      validator: (value) {
                        if (value == null) {
                          return "";
                        }
                        return null;
                      },
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
                        hintText: _taskProjectsController
                                .getTaskCategoryList.isNotEmpty
                            ? 'Select Category'
                            : 'No data available',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        isDense: true,
                        label: const CustomDropDownLabel(
                          icon: 'assets/images/hat.png',
                          containerColor: Color.fromRGBO(223, 251, 254, 1),
                          text: 'Category',
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
                      items: List.generate(
                          _taskProjectsController.getTaskCategoryList.length,
                          (index) {
                        return DropdownMenuItem(
                          value: _taskProjectsController
                              .getTaskCategoryList[index],
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                overflow: TextOverflow.clip,
                                _taskProjectsController
                                    .getTaskCategoryList[index]
                                    .ismmtcaTTaskCategoryName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          ),
                        );
                      }),
                      onChanged: (s) async {
                        categoryId = s!.ismmtcaTId!;
                      },
                    ),
                  )
                : SizedBox()),

            // Task Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Task Title';
                  }
                  return null;
                },
                maxLines: 6,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .merge(const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      letterSpacing: 0.3,
                      overflow: TextOverflow.clip,
                    )),
                decoration: InputDecoration(
                    hintText: 'Enter Task Title',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .merge(const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          letterSpacing: 0.3,
                          overflow: TextOverflow.clip,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _titleETController,
              ),
            ),
            // Description Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Task Description';
                  }
                  return null;
                },
                maxLines: 6,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .merge(const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      letterSpacing: 0.3,
                      overflow: TextOverflow.clip,
                    )),
                decoration: InputDecoration(
                    hintText: 'Enter Task Description',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .merge(const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          letterSpacing: 0.3,
                          overflow: TextOverflow.clip,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _descritpionETController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Module Dropdown
            Obx(() => _taskClientModuleCntroller.clientErrorloading.value
                ? const Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg":
                            "While loading company we encountered an error"
                      },
                    ),
                  )
                : Visibility(
                    visible: _taskClientModuleCntroller
                        .getModuleValuesList.isNotEmpty,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 20, left: 16, right: 16, bottom: 16),
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
                      child: DropdownButtonFormField<GetmoduleValues>(
                        validator: (value) {
                          if (value == null) {
                            return "";
                          }
                          return null;
                        },
                        // value: _taskClientModuleCntroller
                        //     .getModuleValuesList.first,
                        decoration: InputDecoration(
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
                          hintText: _taskClientModuleCntroller
                                  .getModuleValuesList.isNotEmpty
                              ? 'Select Module'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Module',
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
                        items: List.generate(
                            _taskClientModuleCntroller
                                .getModuleValuesList.length, (index) {
                          return DropdownMenuItem(
                            value: _taskClientModuleCntroller
                                .getModuleValuesList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  _taskClientModuleCntroller
                                      .getModuleValuesList[index]
                                      .ivrmMModuleName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) async {
                          moduleId = s!.ivrmMId;
                        },
                      ),
                    ),
                  )),

            // Prority List Dropdown
            Obx(() => _taskDepartController.tskDeptErrorLoading.value
                ? const Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg":
                            "While loading company we encountered an error"
                      },
                    ),
                  )
                : _taskDepartController.getDeptsList.isEmpty
                    ? const AnimatedProgressWidget(
                        animationPath: 'assets/json/default.json',
                        title: 'Loading data',
                        desc: "Please wait we are loading data",
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                            top: 40, left: 16, right: 16, bottom: 16),
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
                            hintText: _taskDepartController
                                    .getPriorityModelList.isNotEmpty
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
                          items: List.generate(
                              _taskDepartController.getPriorityModelList.length,
                              (index) {
                            return DropdownMenuItem(
                              value: _taskDepartController
                                  .getPriorityModelList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  _taskDepartController
                                      .getPriorityModelList[index].hrmPName!,
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
                            priorityId = s!.hrmpRId.toString();
                          },
                        ),
                      )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Assign The Task :",
                  style: Theme.of(context).textTheme.labelSmall!.merge(
                      const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          letterSpacing: 0.3)),
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: RadioListTile(
                            dense: true,
                            activeColor: Theme.of(context).primaryColor,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            visualDensity:
                                const VisualDensity(horizontal: -4.0),
                            title: Text(
                              "Yes",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .merge(const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      letterSpacing: 0.3)),
                            ),
                            value: "Y",
                            groupValue: _taskDepartController.taskAssingn.value,
                            onChanged: (v) {
                              _taskDepartController.updateTaskAssign(v!);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: RadioListTile(
                            dense: true,
                            activeColor: Theme.of(context).primaryColor,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            visualDensity:
                                const VisualDensity(horizontal: -4.0),
                            title: Text(
                              "No",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .merge(const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      letterSpacing: 0.3)),
                            ),
                            value: "N",
                            groupValue: _taskDepartController.taskAssingn.value,
                            onChanged: (v) {
                              _taskDepartController.updateTaskAssign(v!);
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                readOnly: true,
                controller: _etListControllerStatus,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Status",
                    labelStyle: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            letterSpacing: 0.3,
                            color: Colors.black))),
                style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        letterSpacing: 0.3,
                        color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => Wrap(
                  children: [
                    SizedBox(
                      width: 160,
                      child: RadioListTile(
                        dense: true,
                        activeColor: Theme.of(context).primaryColor,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        visualDensity: const VisualDensity(horizontal: -4.0),
                        title: Text(
                          "Bugs/Complaint",
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                        value: "B",
                        groupValue: _taskDepartController.typesTask.value,
                        onChanged: (v) {
                          _taskDepartController.updateTypeOfTask(v!);
                        },
                      ),
                    ),
                    Visibility(
                      visible: _taskDepartController.taskAssingn.value == "Y",
                      child: SizedBox(
                        width: 160,
                        child: RadioListTile(
                          dense: true,
                          activeColor: Theme.of(context).primaryColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          title: Text(
                            "Task(Periodicity)",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    letterSpacing: 0.3)),
                          ),
                          value: "T",
                          groupValue: _taskDepartController.typesTask.value,
                          onChanged: (v) {
                            _taskDepartController.updateTypeOfTask(v!);
                            dropdownValue.value == "Daily";
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 165,
                      child: RadioListTile(
                        dense: true,
                        activeColor: Theme.of(context).primaryColor,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        visualDensity: const VisualDensity(horizontal: -4.0),
                        title: Text(
                          "Enhancement",
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                        value: "E",
                        groupValue: _taskDepartController.typesTask.value,
                        onChanged: (v) {
                          _taskDepartController.updateTypeOfTask(v!);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        dense: true,
                        activeColor: Theme.of(context).primaryColor,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        visualDensity: const VisualDensity(horizontal: -4.0),
                        title: Text(
                          "Other's",
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                        value: "O",
                        groupValue: _taskDepartController.typesTask.value,
                        onChanged: (v) {
                          _taskDepartController.updateTypeOfTask(v!);
                        },
                      ),
                    ),
                  ],
                )),
            //Browse images
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 50,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 30,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                // 1
                                DataColumn(
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
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'UploadFile',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'File Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  _taskDepartController.addListBrowser.length,
                                  (index) {
                                int i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 27, 59, 238),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 2.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            pickImage(index);
                                          },
                                          child: Text(
                                            "Browse",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .merge(const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.3)),
                                          )))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(_taskDepartController
                                          .addListBrowser[index].FileName!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {
                                          OpenFilex.open(_taskDepartController
                                              .addListBrowser[index]
                                              .file!
                                              .path);
                                        },
                                        child: Icon(Icons.visibility),
                                      ))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: index ==
                                              _taskDepartController
                                                      .addListBrowser.length -
                                                  1
                                          ? Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      addItemListBrowse(
                                                        index + 1,
                                                        "",
                                                      );
                                                    },
                                                    child:
                                                        const Icon(Icons.add)),
                                                // InkWell(
                                                //     onTap: () {
                                                //       removeItemListBrowse(
                                                //           index);
                                                //     },
                                                //     child: Icon(Icons.remove))
                                              ],
                                            )
                                          : index <
                                                  _taskDepartController
                                                      .addListBrowser.length
                                              ? InkWell(
                                                  onTap: () {
                                                    removeItemListBrowse(index);
                                                  },
                                                  child:
                                                      const Icon(Icons.remove))
                                              : null)),
                                ]);
                              }),
                            ))))),
            // select time date employee
            Obx(
              () => Visibility(
                visible: _taskDepartController.taskAssingn.value == "Y",
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ASSIGN ISSUE/TASK/ENHANCEMENT",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

            Obx(
              () => Visibility(
                visible: _taskDepartController.taskAssingn.value == "Y",
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => Visibility(
                                        visible: _taskDepartController
                                                .typesTask.value ==
                                            "T",
                                        child: Container(
                                          width: 250,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Color.fromRGBO(
                                                  12, 54, 238, 1),
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10))),
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Periodicity',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(() => Visibility(
                                          visible:
                                              dropdownValue.value == "Daily"
                                                  ? false
                                                  : _taskDepartController
                                                              .typesTask
                                                              .value ==
                                                          "T"
                                                      ? true
                                                      : false,
                                          child: Container(
                                            width: 250,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Color.fromRGBO(
                                                  12, 54, 238, 1),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                dropdownValue.value ==
                                                            "Weekly" ||
                                                        dropdownValue.value ==
                                                            "Once in Fortnight"
                                                    ? 'Task Day'
                                                    : "Date",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )),
                                    Obx(
                                      () => Container(
                                        width: 250,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: _taskDepartController
                                                      .typesTask.value ==
                                                  "T"
                                              ? BorderRadius.zero
                                              : const BorderRadius.only(
                                                  topLeft: Radius.circular(10)),
                                          color: Color.fromRGBO(12, 54, 238, 1),
                                        ),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Start and End Date',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 210,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color.fromRGBO(12, 54, 238, 1),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Effort for each task',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color.fromRGBO(12, 54, 238, 1),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Assign To',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Color.fromRGBO(12, 54, 238, 1),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10))),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Remarks',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => Visibility(
                                        visible: _taskDepartController
                                                .typesTask.value ==
                                            "T",
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.black54),
                                                right: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54)),
                                          ),
                                          width: 250,
                                          height: 210,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: DropdownButtonFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 201, 201, 199),
                                                        width: 1),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 201, 200, 199),
                                                        width: 1),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                                dropdownColor: Colors.white,
                                                value: periodicityList.first,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    dropdownValue.value =
                                                        value!;
                                                  });
                                                },
                                                items: periodicityList.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Visibility(
                                        visible: dropdownValue.value == "Daily"
                                            ? false
                                            : _taskDepartController
                                                        .typesTask.value ==
                                                    "T"
                                                ? true
                                                : false,
                                        child: Container(
                                            width: 250,
                                            height: 210,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        color: Colors.black54,
                                                        width: 1),
                                                    bottom: BorderSide(
                                                      color: Colors.black54,
                                                    ))),
                                            child: dropdownValue.value ==
                                                        "Once in Fortnight" ||
                                                    dropdownValue.value ==
                                                        "Weekly"
                                                ? Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        maxLines: 1,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5))),
                                                        controller:
                                                            etDayControllers,
                                                      ),
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        onTap: () async {
                                                          await showDatePicker(
                                                            context: context,
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate:
                                                                DateTime(2035),
                                                            initialDate:
                                                                DateTime.now(),
                                                          ).then((value) {
                                                            setState(() {
                                                              etDayControllers
                                                                      .text =
                                                                  getDateFrom(
                                                                      value);
                                                            });
                                                          });
                                                        },
                                                        readOnly: true,
                                                        controller:
                                                            etDayControllers,
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          suffixIcon: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  firstDate:
                                                                      DateTime
                                                                          .now(),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2035),
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                ).then((value) {
                                                                  setState(() {
                                                                    etDayControllers
                                                                            .text =
                                                                        getDateFrom(
                                                                            value);
                                                                  });
                                                                });
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/svg/calendar_icon.svg",
                                                                color: const Color(
                                                                    0xFF3E78AA),
                                                              ),
                                                            ),
                                                          ),
                                                          hintText:
                                                              "Select From Date",
                                                          hintStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .merge(
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                              )),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            )),
                                                      ),
                                                    ),
                                                  )),
                                      ),
                                    ),
                                    Obx(
                                      () => Container(
                                        width: 250,
                                        height: 210,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              left: _taskDepartController
                                                          .typesTask.value ==
                                                      "T"
                                                  ? BorderSide.none
                                                  : const BorderSide(
                                                      width: 1,
                                                      color: Colors.black54),
                                              right: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black54),
                                              bottom: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black54)),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: TextField(
                                                  onTap: () {
                                                    fromDate();
                                                  },
                                                  readOnly: true,
                                                  controller: selectFromDate,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          fromDate();
                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/svg/calendar_icon.svg",
                                                          color: const Color(
                                                              0xFF3E78AA),
                                                        ),
                                                      ),
                                                    ),
                                                    hintText:
                                                        "Select From Date",
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      )),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: TextField(
                                                  onTap: () {
                                                    toDate();
                                                  },
                                                  readOnly: true,
                                                  controller: selectToDate,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          toDate();
                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/svg/calendar_icon.svg",
                                                          color: const Color(
                                                              0xFF3E78AA),
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: "Select To Date",
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 210,
                                      height: 210,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1,
                                                color: Colors.black54),
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black54)),
                                      ),
                                      child: Align(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                  child: TextField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                      LengthLimitingTextInputFormatter(
                                                          2),
                                                    ],
                                                    keyboardType:
                                                        const TextInputType
                                                                .numberWithOptions(
                                                            decimal: false),
                                                    maxLines: 1,
                                                    controller: hoursEt,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text("HH")
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                  child: TextField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                      LengthLimitingTextInputFormatter(
                                                          2),
                                                    ],
                                                    keyboardType:
                                                        const TextInputType
                                                                .numberWithOptions(
                                                            decimal: false),
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                    controller: minutesEt,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text('MM')
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        width: 250,
                                        height: 210,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1,
                                                  color: Colors.black54),
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Colors.black54)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height: 40,
                                                  width: 200,
                                                  child: TextField(
                                                    maxLines: 1,
                                                    controller: serchEmployee,
                                                    onChanged: (value) {
                                                      filterEmployees(value);
                                                    },
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                    decoration: InputDecoration(
                                                        hintText: "Search",
                                                        helperStyle: Theme.of(
                                                                context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            )),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                  )),
                                              const SizedBox(
                                                height: 0,
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: SizedBox(
                                                  width: 240,
                                                  height: 150,
                                                  child: Obx(
                                                    () => ListView.builder(
                                                      itemCount:
                                                          taskEmployeeList
                                                                  .length +
                                                              1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (index == 0) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        2),
                                                            child: Row(
                                                              children: [
                                                                Checkbox(
                                                                  shape:
                                                                      ContinuousRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  activeColor:
                                                                      const Color
                                                                              .fromRGBO(
                                                                          26,
                                                                          48,
                                                                          241,
                                                                          1),
                                                                  value:
                                                                      selectAll,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      selectAll =
                                                                          value!;
                                                                      if (selectAll) {
                                                                        employeesID =
                                                                            List.from(taskEmployeeList.map((employee) =>
                                                                                employee.hRMEId!));
                                                                      } else {
                                                                        employeesID
                                                                            .clear();
                                                                      }
                                                                      _taskDepartController
                                                                          .checkBox
                                                                          .assignAll(List.filled(
                                                                              taskEmployeeList.length,
                                                                              selectAll));
                                                                    });
                                                                  },
                                                                ),
                                                                const SizedBox(),
                                                                const Text(
                                                                  "All Employees",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        } else {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        2),
                                                            child: Container(
                                                              width: 180,
                                                              height: 30,
                                                              child: Row(
                                                                children: [
                                                                  Checkbox(
                                                                    shape:
                                                                        ContinuousRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    activeColor:
                                                                        const Color.fromRGBO(
                                                                            26,
                                                                            48,
                                                                            241,
                                                                            1),
                                                                    value: _taskDepartController
                                                                            .checkBox[
                                                                        index -
                                                                            1],
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _taskDepartController.checkBox[index -
                                                                                1] =
                                                                            value!;

                                                                        if (value) {
                                                                          employeesID
                                                                              .add(taskEmployeeList[index - 1].hRMEId!);
                                                                        } else {
                                                                          employeesID
                                                                              .remove(taskEmployeeList[index - 1].hRMEId);
                                                                        }

                                                                        selectAll = _taskDepartController
                                                                            .checkBox
                                                                            .every((value) =>
                                                                                value);
                                                                      });
                                                                    },
                                                                  ),
                                                                  const SizedBox(),
                                                                  SizedBox(
                                                                    width: 180,
                                                                    child:
                                                                        RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                taskEmployeeList[index - 1].employeeName,
                                                                            style: Theme.of(context).textTheme.titleSmall!.merge(
                                                                                  const TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.3,
                                                                                    overflow: TextOverflow.clip,
                                                                                  ),
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                " : ${taskEmployeeList[index - 1].hRMDESDesignationName} ",
                                                                            style: Theme.of(context).textTheme.titleSmall!.merge(
                                                                                  const TextStyle(
                                                                                    fontWeight: FontWeight.w100,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.3,
                                                                                    overflow: TextOverflow.clip,
                                                                                  ),
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      height: 210,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1,
                                                color: Colors.black54),
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black54)),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.3,
                                                  overflow: TextOverflow.clip,
                                                )),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            controller: etRemarkControllers,
                                            maxLines: 6,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )))),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MSkollBtn(
                    title: "Task Details",
                    onPress: () {
                      Get.to(() => TaskDetailsScreen(
                            loginSuccessModel: widget.loginSuccessModel,
                            mskoolController: widget.mskoolController,
                            taskDepartController: _taskDepartController,
                          ));
                    }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> fromDate() async {
    await showDatePicker(
      context: context,
      firstDate: DateTime.parse(_taskDepartController.maxPlannerDate),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    ).then((value) {
      setState(() {
        selectFromDate.text = getDateFrom(value);
        selectToDate.text = getDateFrom(value!.add(Duration(days: 5)));
      });
    });
  }

  Future<void> toDate() async {
    await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    ).then((value) {
      setState(() {
        selectToDate.text = getDateFrom(value);
      });
    });
  }

  String getDateFrom(DateTime? dt) {
    return "${dt!.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }

  Future<void> pickImage(int index) async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _taskDepartController.addListBrowser[index].file = pickedImage;
      _taskDepartController.addListBrowser[index].FileName = pickedImage.name;
      setState(() {});
    }
  }

  void filterEmployees(String query) {
    logger.e(query);
    taskEmployeeList.value = _taskDepartController.getTaskEmployeeList
        .where((employee) =>
            employee.employeeName!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            employee.hRMDDepartmentName!.toLowerCase().trim() ==
                query.toLowerCase().trim())
        .toList();
  }

  @override
  void dispose() {
    employeesID.clear();
    taskEmployeeList.clear();
    _taskDepartController.getTaskEmployeeList.clear();
    transnumbconfiguration.clear();
    _taskDepartController.addListBrowser.clear();
    super.dispose();
  }
}
