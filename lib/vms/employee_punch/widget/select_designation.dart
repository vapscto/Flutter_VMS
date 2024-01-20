import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';

import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/widget/gallery_checkbox.container.dart';
// import 'package:m_skool_flutter/student/gallery_view/widget/gallery_checkbox.container.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_designation_api.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_get_staff_api.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/widget/staff_dd.dart';
import 'package:m_skool_flutter/vms/widgets/level_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class EmpSelectDesignation extends StatefulWidget {
  final EmployeePunchController salaryController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const EmpSelectDesignation(
      {super.key,
      required this.salaryController,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<EmpSelectDesignation> createState() => _EmpSelectDesignationState();
}

class _EmpSelectDesignationState extends State<EmpSelectDesignation> {
  final ScrollController _controller = ScrollController();
  final RxBool selectAllDesignation = RxBool(false);

  final EmployeePunchController salaryController =
      Get.put(EmployeePunchController());

  @override
  void initState() {
    String department = "";
    for (var element in widget.salaryController.selectedDepartment) {
      department += "${element.hrmDId},";
    }
    EmployeeDesignationApi.instance.getDesignation(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      base: baseUrlFromInsCode("frontoffice", widget.mskoolController),
      salaryController: widget.salaryController,
      departments: department,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.salaryController.isErrorOccuredWhileLoadingDesignation.value
          ? const Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": "While loading department we encountered an error"
                },
              ),
            )
          : widget.salaryController.isLoadingDesignation.value
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading Designation',
                    desc: "Please wait we are loading designation",
                  ),
                )
              : widget.salaryController.designation.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        animationPath: 'assets/json/nodata.json',
                        title: 'No Designation Found',
                        desc: "There are no designation available",
                        animatorHeight: 250,
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 160,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                            bool allSelected = salaryController
                                                    .selectedDesignation
                                                    .length ==
                                                salaryController
                                                    .designation.length;

                                            return CheckboxListTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              checkboxShape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
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
                                                        letterSpacing: 0.3)),
                                              ),
                                              value: allSelected,
                                              onChanged: (bool? value) {
                                                widget.salaryController
                                                    .selectedDesignation
                                                    .clear();
                                                selectAllDesignation.value =
                                                    value!;
                                                if (value) {
                                                  widget.salaryController
                                                      .selectedDesignation
                                                      .addAll(widget
                                                          .salaryController
                                                          .designation);
                                                }
                                                loadStaff();
                                              },
                                            );
                                          })),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      ListView.builder(
                                        itemCount: widget.salaryController
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
                                                        "${widget.salaryController.designation.elementAt(index).hrmdeSDesignationName}",
                                                    func: (b) {
                                                      if (b) {
                                                        widget.salaryController
                                                            .addToSelectedDesignation(
                                                                widget
                                                                    .salaryController
                                                                    .designation
                                                                    .elementAt(
                                                                        index));
                                                      } else {
                                                        selectAllDesignation
                                                            .value = false;
                                                        widget.salaryController
                                                            .removeFromSelectedDesignation(
                                                                widget
                                                                    .salaryController
                                                                    .designation
                                                                    .elementAt(
                                                                        index));
                                                      }

                                                      loadStaff();
                                                    },
                                                    isChecked: RxBool(
                                                      widget.salaryController
                                                          .selectedDesignation
                                                          .contains(
                                                        widget.salaryController
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
                        const SizedBox(
                          height: 24.0,
                        ),
                        StaffDropDown(
                          mskoolController: widget.mskoolController,
                          loginSuccessModel: widget.loginSuccessModel,
                          salaryController: widget.salaryController,
                        ),
                      ],
                    );
    });
  }

  @override
  void dispose() {
    widget.salaryController.designation.clear();
    widget.salaryController.designation.clear();
    super.dispose();
  }

  void loadStaff() {
    String department = "";
    String designation = "";
    for (var element in widget.salaryController.selectedDepartment) {
      department += "${element.hrmDId},";
    }
    for (var element in widget.salaryController.selectedDesignation) {
      designation += "${element.hrmdeSId},";
    }
    EmployeeStaffApi.instance.getStaff(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("frontoffice", widget.mskoolController),
        departments: department,
        selectedDesignation: designation,
        salaryController: widget.salaryController);
  }
}
