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
import 'package:m_skool_flutter/vms/task%20creation/controller/task_client_module.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_projects_cntroller.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_Tsk_Client.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';
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
  @override
  void initState() {
    loadCmpny();
     logger.d({
      "userId": widget.loginSuccessModel.userId!,
         "ivrmrtId": widget.loginSuccessModel.roleTypeId!,
       "miId": widget.loginSuccessModel.mIID!,
     "HRME_Id": widget.loginSuccessModel.empId!,
    "roleflag":widget.loginSuccessModel.roleforlogin! ,
  });
    super.initState();
  }

  loadCmpny() async {
    await getTskCompaniesList(
            base: baseUrlFromInsCode(
              'issuemanager',
              widget.mskoolController,
            ),
            controller: _taskDepartController,
            userId: widget.loginSuccessModel.userId!,
            ivrmrtId: widget.loginSuccessModel.roleTypeId!,
            miId: widget.loginSuccessModel.mIID!,
            HRME_Id: widget.loginSuccessModel.empId!)
        .then(
      (value) {
        if (value) {
          getTskPrjtCatgryList(
              base: baseUrlFromInsCode(
                'issuemanager',
                widget.mskoolController,
              ),
              controller: _taskProjectsController,
              userId: widget.loginSuccessModel.userId!,
              ivrmrtId: widget.loginSuccessModel.roleTypeId!,
              miId: widget.loginSuccessModel.mIID!,
              HRME_Id: widget.loginSuccessModel.empId!,
              HRMD_Id: widget.loginSuccessModel.empId!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            await getTskPrjtCatgryList(
                                base: baseUrlFromInsCode(
                                  'issuemanager',
                                  widget.mskoolController,
                                ),
                                controller: _taskProjectsController,
                                userId: widget.loginSuccessModel.userId!,
                                ivrmrtId: widget.loginSuccessModel.roleTypeId!,
                                miId: widget.loginSuccessModel.mIID!,
                                HRME_Id: widget.loginSuccessModel.empId!,
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
                          value:
                              _taskProjectsController.getTaskProjectsList.first,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(223, 251, 254, 1),
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
                           //  _taskClientModuleCntroller.taskClientList.clear();
                             logger.d({
                                 "userId": widget.loginSuccessModel.userId!,
                                "ivrmrtId": widget.loginSuccessModel.roleTypeId!,
                                "miId": widget.loginSuccessModel.mIID!,
                                "HRME_Id": widget.loginSuccessModel.empId!,
                                "HRMD_Id": s!.hrmDId!,
                                "roleflag":widget.loginSuccessModel.roleforlogin! ,
                                "ISMMPR_Id": s.ismmpRId!
                             });
                            await  geTskClientApi(
                              base: baseUrlFromInsCode("issuemanager", widget.mskoolController,)
                                ,
                                controller: _taskClientModuleCntroller,
                                userId: widget.loginSuccessModel.userId!,
                                ivrmrtId: widget.loginSuccessModel.roleTypeId!,
                                miId: widget.loginSuccessModel.mIID!,
                                 HRME_Id: widget.loginSuccessModel.empId!,
                                HRMD_Id: s.hrmDId!,
                                roleflag:widget.loginSuccessModel.roleforlogin! ,
                                ISMMPR_Id: s.ismmpRId!
                            );
                          },
                        ),
                      )),
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
                    ?  const AnimatedProgressWidget(
                          title: "No Data found",
                          desc:
                              "There is no corresponding topic available for the selected subject",
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                        ):  _taskClientModuleCntroller.clientLoading.value? const AnimatedProgressWidget(
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
                          value:
                              _taskClientModuleCntroller.taskClientList.first,
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
                                ? 'Select Project'
                                : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(223, 251, 254, 1),
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
                              _taskClientModuleCntroller.taskClientList.length,
                              (index) {
                            return DropdownMenuItem(
                              value: _taskClientModuleCntroller
                                  .taskClientList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
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
                            );
                          }),
                          onChanged: (s) async {

                          },
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
