import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_widget.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_department_api.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_designation_api.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/widget/select_designation.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

import '../../../staffs/homework_classwork/widget/check_box_container.dart';

class EmployeepunchHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const EmployeepunchHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<EmployeepunchHome> createState() => _EmployeepunchHomeState();
}

class _EmployeepunchHomeState extends State<EmployeepunchHome> {
  final EmployeePunchController salaryController =
      Get.put(EmployeePunchController());

  final ScrollController _controller = ScrollController();
  final RxBool selectAllDepartment = RxBool(false);

  @override
  void initState() {
    EmployeeDepartmentApi.instance.getDepartment(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("frontoffice", widget.mskoolController),
        salaryController: salaryController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Employee Punch Details").getAppBar(),
      body: Obx(() {
        return salaryController.isErrorOccuredWhileLoadingDepartment.value
            ? const Center(
                child: ErrWidget(
                  err: {
                    "errorTitle": "Unexpected Error Occured",
                    "errorMsg":
                        "While loading department we encountered an error"
                  },
                ),
              )
            : salaryController.isLoadingDepartment.value
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading Department',
                      desc: "Please wait we are loading department",
                    ),
                  )
                : salaryController.department.isEmpty
                    ? const Center(
                        child: AnimatedProgressWidget(
                          animationPath: 'assets/json/nodata.json',
                          title: 'No Department Found',
                          desc: "There are no department available",
                          animatorHeight: 250,
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24.0,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 160,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 4,
                                        color: Colors.black12,
                                      ),
                                    ],
                                  ),
                                  child: RawScrollbar(
                                    thumbColor: const Color(0xFF1E38FC),
                                    trackColor:
                                        const Color.fromRGBO(223, 239, 253, 1),
                                    trackRadius: const Radius.circular(10),
                                    trackVisibility: true,
                                    radius: const Radius.circular(10),
                                    thickness: 14,
                                    thumbVisibility: true,
                                    controller: _controller,
                                    child: SingleChildScrollView(
                                      controller: _controller,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: Obx(() {
                                              bool allSelected =
                                                  salaryController
                                                          .selectedDepartment
                                                          .length ==
                                                      salaryController
                                                          .department.length;

                                              return CheckboxListTile(
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                checkboxShape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                dense: true,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: -4.0),
                                                title: Text(
                                                  "Select All",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3,
                                                      )),
                                                ),
                                                value: allSelected,
                                                onChanged: (bool? value) {
                                                  salaryController
                                                      .selectedDepartment
                                                      .clear();
                                                  if (value!) {
                                                    salaryController
                                                        .selectedDepartment
                                                        .addAll(salaryController
                                                            .department);
                                                  }
                                                  loadDesignation();
                                                },
                                              );
                                            }),
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          ListView.builder(
                                            itemCount: salaryController
                                                .department.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                  height: 35,
                                                  child: Obx(() {
                                                    return CheckBoxContainer(
                                                      sectionName:
                                                          "${salaryController.department.elementAt(index).hrmDDepartmentName}",
                                                      func: (b) {
                                                        if (b) {
                                                          salaryController
                                                              .addToSelectedDepartment(
                                                                  salaryController
                                                                      .department
                                                                      .elementAt(
                                                                          index));
                                                        } else {
                                                          selectAllDepartment
                                                              .value = false;
                                                          salaryController
                                                              .removeFromSelectedDepartment(
                                                                  salaryController
                                                                      .department
                                                                      .elementAt(
                                                                          index));
                                                        }
                                                        loadDesignation();
                                                      },
                                                      isChecked: RxBool(
                                                        salaryController
                                                            .selectedDepartment
                                                            .contains(
                                                          salaryController
                                                              .department
                                                              .elementAt(index),
                                                        ),
                                                      ),
                                                    );
                                                  }));
                                            },
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const ContainerTitle(
                                  iT: Color(0xFFFF6F67),
                                  bg: Color.fromARGB(255, 255, 236, 235),
                                  image: 'assets/images/subjectfielicon.png',
                                  title: 'Select Department',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            EmpSelectDesignation(
                              salaryController: salaryController,
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                            ),
                          ],
                        ),
                      );
      }),
    );
  }

  @override
  void dispose() {
  salaryController.department.clear();
  salaryController.selectedDepartment.clear();
    super.dispose();
  }
  void loadDesignation() {
    String department = "";
    for (var element in salaryController.selectedDepartment) {
      department += "${element.hrmDId},";
    }
    EmployeeDesignationApi.instance.getDesignation(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      base: baseUrlFromInsCode("frontoffice", widget.mskoolController),
      salaryController: salaryController,
      departments: department,
    );
  }
}
