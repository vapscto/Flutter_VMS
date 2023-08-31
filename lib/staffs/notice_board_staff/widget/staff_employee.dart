import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/check_box_container.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_get_employee.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class StaffEmployee extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final NoticeBoardController controller;
  const StaffEmployee(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<StaffEmployee> createState() => _StaffEmployeeState();
}

class _StaffEmployeeState extends State<StaffEmployee> {
  final RxBool selectAllEmployee = RxBool(false);

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    List<Map<String, dynamic>> department = [];
    List<Map<String, dynamic>> designation = [];

    for (var element in widget.controller.selectedDepartment) {
      department.add({"HRMDC_ID": element.hRMDCID});
    }

    for (var element in widget.controller.selectedDesignation) {
      designation.add({"HRMDES_Id": element.hRMDESId});
    }

    NoticeGetEmployee.instance.getEmployee(
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        department: department,
        designation: designation,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        controller: widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 36.0,
        ),
        Obx(() {
          return widget.controller.isErrorOccuredWhileLoadingEmployee.value
              ? const ErrWidget(
                  err: {
                    "errorTitle": "An Error Occured",
                    "errorMsg":
                        "An error occured while trying to get employee list",
                  },
                )
              : widget.controller.isEmpLoading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading Employee's",
                      desc: "Please wait while we load employee's for you.",
                      animationPath: "assets/json/default.json")
                  : Obx(
                      () {
                        return widget.controller.employee.isEmpty
                            ? const AnimatedProgressWidget(
                                title: "No Employee Found",
                                desc:
                                    "There are no Employee's available ask them to add",
                                animationPath: "assets/json/nodata.json",
                                animatorHeight: 250,
                              )
                            : Column(
                                children: [
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
                                          borderRadius:
                                              BorderRadius.circular(16.0),
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
                                          trackColor: const Color.fromRGBO(
                                              223, 239, 253, 1),
                                          trackRadius:
                                              const Radius.circular(10),
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
                                                      return CheckboxListTile(
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .leading,
                                                        checkboxShape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                        dense: true,
                                                        activeColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8),
                                                        visualDensity:
                                                            const VisualDensity(
                                                                horizontal:
                                                                    -4.0),
                                                        title: Text(
                                                          "Select All",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .merge(const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.3)),
                                                        ),
                                                        value: selectAllEmployee
                                                            .value,
                                                        onChanged:
                                                            (bool? value) {
                                                          selectAllEmployee
                                                              .value = value!;

                                                          if (!value) {
                                                            widget.controller
                                                                .selectedEmployee
                                                                .clear();
                                                          } else {
                                                            widget.controller
                                                                .selectAllEmployee(widget
                                                                    .controller
                                                                    .employee);
                                                          }
                                                        },
                                                      );
                                                    })),
                                                const SizedBox(
                                                  height: 6.0,
                                                ),
                                                ListView.builder(
                                                  itemCount: widget.controller
                                                      .employee.length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                        height: 35,
                                                        child: Obx(() {
                                                          return CheckBoxContainer(
                                                              sectionName:
                                                                  "${widget.controller.employee.elementAt(index).userEmpName}",
                                                              func: (b) {
                                                                if (b) {
                                                                  widget
                                                                      .controller
                                                                      .addToSelectedEmployee(
                                                                    widget
                                                                        .controller
                                                                        .employee
                                                                        .elementAt(
                                                                      index,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  widget
                                                                      .controller
                                                                      .removeFromSelectedEmployee(
                                                                    widget
                                                                        .controller
                                                                        .employee
                                                                        .elementAt(
                                                                      index,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              isChecked:
                                                                  selectAllEmployee
                                                                              .value ==
                                                                          true
                                                                      ? RxBool(
                                                                          true)
                                                                      : RxBool(
                                                                          widget
                                                                              .controller
                                                                              .selectedEmployee
                                                                              .contains(
                                                                            widget.controller.employee.elementAt(index),
                                                                          ),
                                                                        ));
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
                                        iT: Color(0xFF3E78AA),
                                        bg: Color(0xFFE5F3FF),
                                        image:
                                            'assets/images/selectteachericon.png',
                                        title: 'Select Employee',
                                      ),
                                    ],
                                  ),
                                ],
                              );
                      },
                    );
        }),
      ],
    );
  }
}
