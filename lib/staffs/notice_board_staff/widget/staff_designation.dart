import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/check_box_container.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_get_designation.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_get_employee.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_employee.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class StaffDesignation extends StatefulWidget {
  final NoticeBoardController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffDesignation(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<StaffDesignation> createState() => _StaffDesignationState();
}

class _StaffDesignationState extends State<StaffDesignation> {
  final RxBool selectAllDesignation = RxBool(false);
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    List<Map<String, dynamic>> mList = [];
    for (var element in widget.controller.selectedDepartment) {
      mList.add({"HRMDC_ID": element.hRMDCID});
    }

    NoticeBoardGetDesignation.instance.getDesignation(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      userId: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      departmentList: mList,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      noticeBoardController: widget.controller,
    );
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
          return widget.controller.isErrorOccuredWhileLoadingDesignation.value
              ? const ErrWidget(
                  err: {
                    "errorTite": "An Error Occured",
                    "errorMsg":
                        "An error occured while trying to get designation list",
                  },
                )
              : widget.controller.isDesignationLoading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading Designation's",
                      desc: "Please wait while we load designation's for you.",
                      animationPath: "assets/json/default.json")
                  : Obx(() {
                      return widget.controller.designation.isEmpty
                          ? const AnimatedProgressWidget(
                              title: "No Designation Found",
                              desc:
                                  "There are no designation's available ask them to add",
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
                                                              horizontal: -4.0),
                                                      title: Text(
                                                        "Select All",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .merge(const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.3)),
                                                      ),
                                                      value:
                                                          selectAllDesignation
                                                              .value,
                                                      onChanged: (bool? value) {
                                                        selectAllDesignation
                                                            .value = value!;

                                                        if (!value) {
                                                          widget.controller
                                                              .selectedDesignation
                                                              .clear();

                                                          widget.controller
                                                              .employee
                                                              .clear();
                                                          return;
                                                        }
                                                        widget.controller
                                                            .selectAllDesignation(
                                                                widget
                                                                    .controller
                                                                    .designation);
                                                        loadEmployee();
                                                      },
                                                    );
                                                  })),
                                              const SizedBox(
                                                height: 6.0,
                                              ),
                                              ListView.builder(
                                                itemCount: widget.controller
                                                    .designation.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return SizedBox(
                                                      height: 35,
                                                      child: Obx(() {
                                                        return CheckBoxContainer(
                                                            sectionName:
                                                                "${widget.controller.designation.elementAt(index).hRMDESDesignationName}",
                                                            func: (b) {
                                                              if (b) {
                                                                widget
                                                                    .controller
                                                                    .addToSelectedDesignation(
                                                                  widget
                                                                      .controller
                                                                      .designation
                                                                      .elementAt(
                                                                    index,
                                                                  ),
                                                                );
                                                              } else {
                                                                widget
                                                                    .controller
                                                                    .removeFromSelectedDesignation(
                                                                  widget
                                                                      .controller
                                                                      .designation
                                                                      .elementAt(
                                                                    index,
                                                                  ),
                                                                );
                                                              }

                                                              if (widget
                                                                  .controller
                                                                  .selectedDesignation
                                                                  .isEmpty) {
                                                                widget
                                                                    .controller
                                                                    .employee
                                                                    .clear();

                                                                return;
                                                              }
                                                              loadEmployee();
                                                            },
                                                            isChecked:
                                                                selectAllDesignation
                                                                            .value ==
                                                                        true
                                                                    ? RxBool(
                                                                        true)
                                                                    : RxBool(
                                                                        widget
                                                                            .controller
                                                                            .selectedDesignation
                                                                            .contains(
                                                                          widget
                                                                              .controller
                                                                              .designation
                                                                              .elementAt(index),
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
                                      iT: Color(0xFF47BA9E),
                                      bg: Color(0xFFDBFDF5),
                                      image: 'assets/images/abouticon.png',
                                      title: 'Select Designation',
                                    ),
                                  ],
                                ),
                                StaffEmployee(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                    controller: widget.controller)
                              ],
                            );
                    });
        })
      ],
    );
  }

  void loadEmployee() {
    List<Map<String, dynamic>> department = [];
    List<Map<String, dynamic>> designation = [];

    for (var element in widget.controller.selectedDepartment) {
      department.add({"HRMDC_ID": element.hRMDCID});
    }

    for (var element in widget.controller.selectedDesignation) {
      designation.add({"HRMDES_Id": element.hRMDESId});
    }

    logger.d(designation);

    NoticeGetEmployee.instance.getEmployee(
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        department: department,
        designation: designation,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        controller: widget.controller);
  }
}
