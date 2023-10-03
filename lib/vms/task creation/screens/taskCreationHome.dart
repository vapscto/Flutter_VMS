import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/get_depart_api.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/get_prjects_catgory_api.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/get_task_client.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/onchange_client_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_client_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_projects_cntroller.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_Tsk_Client.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_tsk_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class TaskCreationHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const TaskCreationHome(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<TaskCreationHome> createState() => _TaskCreationHomeState();
}

class _TaskCreationHomeState extends State<TaskCreationHome> {
  TaskDepartController _taskDepartController = Get.put(TaskDepartController());

  TaskProjectsController _taskProjectsController =
      Get.put(TaskProjectsController());

  TaskClientModuleCntroller _taskClientModuleCntroller =
      Get.put(TaskClientModuleCntroller());

  TextEditingController _titleETController = TextEditingController();
  TextEditingController _descritpionETController = TextEditingController();
  TextEditingController _etListControllerStatus = TextEditingController();
  RxList<AtachmentFile> _addListBrowser = <AtachmentFile>[].obs ;
  @override
  void initState() {
    loadCmpny();
    addItemListBrowse(0,"");
    _etListControllerStatus.text = "Open";
    super.initState();
  }
 addItemListBrowse(int val,String name){
  _addListBrowser.add( AtachmentFile(id: val, FileName: name));
  setState(() {
    
  });
 }
 removeItemListBrowse(int val ){
    
_addListBrowser.removeAt(val);
 setState(() {
    
  });
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
            HRME_Id: logInBox!.get("EmpId")!)
        .then(
      (value) {
        if (value) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        leading: const CustomGoBackButton(),
        title: const Text(
          "Task Creation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                        child: DropdownButtonFormField<GetDeptsValues>(
                          value: _taskDepartController.getDeptsList.first,
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
                                          fontSize: 12.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            _taskProjectsController.getTaskProjectsList.clear();
                            _taskProjectsController.getTaskCategoryList.clear();

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
                                HRMD_Id: s!.hrmDId!);
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
                    ? const AnimatedProgressWidget(
                        animationPath: 'assets/json/nodata.json',
                        title: 'Loading data',
                        desc: "Please wait we are loading data",
                      )
                    : _taskProjectsController.categoryLoading.value
                        ? AnimatedProgressWidget(
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
                              value: _taskProjectsController
                                  .getTaskProjectsList.first,
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
                                   _taskClientModuleCntroller.getModuleValuesList.clear(); 
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
                                    ISMMPR_Id: s!.ismmpRId!);
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
                : _taskClientModuleCntroller.taskClientList.isEmpty
                    ? const AnimatedProgressWidget(
                        title: "No Data found",
                        desc:
                            "There is no corresponding topic available for the selected subject",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      )
                    : _taskClientModuleCntroller.clientLoading.value
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
                            child: DropdownButtonFormField<GeTskClientValues>(
                              value: _taskClientModuleCntroller
                                  .taskClientList.first,
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
                                        .taskClientList.isNotEmpty
                                    ? 'Select Client'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/hat.png',
                                  containerColor:
                                      Color.fromRGBO(223, 251, 254, 1),
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
                                  _taskClientModuleCntroller
                                      .taskClientList.length, (index) {
                                return DropdownMenuItem(
                                  value: _taskClientModuleCntroller
                                      .taskClientList[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5),
                                    child: SizedBox(
                                      width: 300,
                                      child: Text(
                                        overflow: TextOverflow.clip,
                                        _taskClientModuleCntroller
                                            .taskClientList[index]
                                            .ismmclTClientName!,
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
                               
                             await  onChangeModuleListApi(
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
                                    roleType:
                                        widget.loginSuccessModel.roleforlogin!,
                                    ismmprId: s!.ismmpRId!,
                                    ismmcltId: s.ismmclTId!
                                    
                               );
                              },
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
                      value: _taskProjectsController.getTaskCategoryList.first,
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
                              width: 300,
                              child: Text(
                                overflow: TextOverflow.clip,
                                _taskProjectsController.getTaskCategoryList[index]
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

                      },
                    ),
                  )
                : SizedBox()),
            
            // Task Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                maxLines: 6,
                style:Theme.of(context)
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
                    hintStyle:Theme.of(context)
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
                maxLines: 6,
                style:Theme.of(context)
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
                    hintStyle:Theme.of(context)
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
             SizedBox(height: 10,),
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
                : _taskClientModuleCntroller.getModuleValuesList.isEmpty
                    ? const AnimatedProgressWidget(
                        title: "No Data found",
                        desc:
                            "There is no corresponding topic available for the selected subject",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      )
                    : _taskClientModuleCntroller.clientLoading.value
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
                            child: DropdownButtonFormField<GetmoduleValues>(
                              value: _taskClientModuleCntroller
                                  .getModuleValuesList.first,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/hat.png',
                                  containerColor:
                                      Color.fromRGBO(223, 251, 254, 1),
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
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5),
                                    child: SizedBox(
                                      width: 300,
                                      child: Text(
                                        overflow: TextOverflow.clip,
                                       _taskClientModuleCntroller
                                  .getModuleValuesList[index].ivrmMModuleName!,
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
                              onChanged: (s) async { },
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
                          value: _taskDepartController.getPriorityModelList.first,
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
                            hintText:
                             _taskDepartController.getPriorityModelList.isNotEmpty
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
                              value:_taskDepartController.getPriorityModelList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                 _taskDepartController.getPriorityModelList[index].hrmPName!,
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
                            
                         
                          },
                        ),
                      )),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Assign The Task :",
                          style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),),
                          Obx(()=> Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 100,
                              child: RadioListTile(
                                dense: true,
                              activeColor: Theme.of(context).primaryColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: const VisualDensity(horizontal: -4.0),
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
                                value:"Y",
                               groupValue:  _taskDepartController.taskAssingn.value, onChanged:  (v) {
                                 _taskDepartController.updateTaskAssign(v!);
                               },),
                            ),
                            SizedBox(width: 100,
                              child: RadioListTile(
                                dense: true,
                              activeColor: Theme.of(context).primaryColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: const VisualDensity(horizontal: -4.0),
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
                                value:"N",
                               groupValue:  _taskDepartController.taskAssingn.value, onChanged:  (v) {
                                 _taskDepartController.updateTaskAssign(v!);
                               },),
                            ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: TextField(
                      readOnly: true,
                      
                       controller: _etListControllerStatus,
                      decoration: InputDecoration(border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      
                      labelText: "Status",
                      labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3,
                                          color: Colors.black))),
                      style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                        
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3,
                                          color: Colors.black)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Obx(()=> Wrap(
                             
                            children: [
                              SizedBox(width: 160,
                              child: RadioListTile(
                                dense: true,
                              activeColor: Theme.of(context).primaryColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: const VisualDensity(horizontal: -4.0),
                              title: Text(
                                "Bugs/Complaint",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),
                              ),
                                value:"B",
                               groupValue:  _taskDepartController.typesTask.value, onChanged:  (v) {
                                 _taskDepartController.updateTypeOfTask(v!);
                               },),
                            ),
                            SizedBox(width: 160,
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
                                value:"T",
                               groupValue:  _taskDepartController.typesTask.value, onChanged:  (v) {
                                 _taskDepartController.updateTypeOfTask(v!);
                               },),
                            ),
                                SizedBox(width: 165,
                              child: RadioListTile(
                                dense: true,
                              activeColor: Theme.of(context).primaryColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: const VisualDensity(horizontal: -4.0),
                              title: Text(
                                "Enhancement",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),
                              ),
                                value:"E",
                               groupValue:  _taskDepartController.typesTask.value, onChanged:  (v) {
                                 _taskDepartController.updateTypeOfTask(v!);
                               },),
                            ),
                                SizedBox(width: 150,
                              child: RadioListTile(
                                dense: true,
                              activeColor: Theme.of(context).primaryColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: const VisualDensity(horizontal: -4.0),
                              title: Text(
                                "Other's",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),
                              ),
                                value:"O",
                               groupValue:  _taskDepartController.typesTask.value, onChanged:  (v) {
                                 _taskDepartController.updateTypeOfTask(v!);
                               },),
                            ),
                            ],
                          )),
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
                              columns:   [
                                // 1
                                DataColumn(
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
                                    child: Text(
                                      'UploadFile',
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
                                    child: Text(
                                      'File Name',
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
                                    child: Text(
                                      'View',
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
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ), 
                              ]
                              ,
                              rows:  List.generate(_addListBrowser.length, (index)  {
                                int i = index+1;
                                return DataRow(
                                  cells: [
                                    DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text('$i'))),
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child:   ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255, 27, 59, 238),
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                          onPressed: () {
                                          
                                        }, child: Text("Browse",
                                         style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                      color: Colors.white,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),)))),
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text('$i'))),
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text('$i'))),
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: index == 0? InkWell(
                                          onTap: () {
                                           addItemListBrowse(index +1,""); 
                                          },
                                          child: Icon(Icons.add)) :  index == _addListBrowser.length - 1 ?  Icon(Icons.add) :  InkWell(
                                          onTap: () {
                                           removeItemListBrowse(index ); 
                                          },
                                          child: Icon(Icons.remove)))),
                                              // 0==0 ? icon : index < 3 ? icon:2== 3-1
                                  ]
                                );
                              }),
                            )
                          )
                        )
                          )
                       )
          ]   
          
        ),
      ),
    );
  }
}
