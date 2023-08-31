import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/employee_salary/api/employee_get_staff_api.dart';
import 'package:m_skool_flutter/manager/employee_salary/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/manager/employee_salary/model/staff_list_model.dart';
import 'package:m_skool_flutter/manager/employee_salary/screen/employee_sal_view_details.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/screen/salary_overall_det.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

import '../../../widget/mskoll_btn.dart';

class StaffDropDown extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final EmployeeSalaryController salaryController;
  const StaffDropDown(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.salaryController});

  @override
  State<StaffDropDown> createState() => _StaffDropDownState();
}

class _StaffDropDownState extends State<StaffDropDown> {
  @override
  void initState() {
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
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        departments: department,
        selectedDesignation: designation,
        salaryController: widget.salaryController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.salaryController.isErrorOccuredWhileLoadingStaff.value
          ? const Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": "While loading Staff we encountered an error"
                },
              ),
            )
          : widget.salaryController.isLoadingStaff.value
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading Staff',
                    desc: "Please wait we are loading staff",
                  ),
                )
              : widget.salaryController.staffs.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        animationPath: 'assets/json/nodata.json',
                        title: 'No Staff Found',
                        desc: "There are no staff available",
                        animatorHeight: 250,
                      ),
                    )
                  : Column(
                      children: [
                        CustomContainer(
                          child: DropdownButtonFormField<StaffListValues>(
                            value: widget.salaryController.selectedStaff,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16.0),
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
                              label: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 5),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFE5F3FF),
                                    borderRadius: BorderRadius.circular(24.0)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/selectteachericon.png",
                                      height: 28.0,
                                    ),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(
                                      "Select Employee",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xFF3E78AA))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            icon: const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              ),
                            ),
                            iconSize: 30,
                            items: List.generate(
                              widget.salaryController.staffs.length,
                              (index) => DropdownMenuItem<StaffListValues>(
                                value: widget.salaryController.staffs
                                    .elementAt(index),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    
                                      top: 12.0, left: 8, right: 8),
                                  child: Text(
                                    "${widget.salaryController.staffs.elementAt(index).hrmEEmployeeFirstName} ${widget.salaryController.staffs.elementAt(index).hrmEEmployeeMiddleName} ${widget.salaryController.staffs.elementAt(index).hrmEEmployeeLastName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            letterSpacing: 0.3)),
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (s) async {
                              // selectedValue = s;
                              // asmayId.value = s!.asmaYId!;
                              // setState(() {});
                              // handler.updateSelectedInDropDown(s!);
                              // handler.asmayId.value = s.asmaYId!;
                              // logger.d(s.asmaYId);
                              // reloadEvent();

                              widget.salaryController.selectedStaff = s!;
                              // await loadOnChange();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        MSkollBtn(
                          onPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                                  //EmployeeSalDetails
                                  //SalaryOverallDetails
                              return EmployeeSalDetails(
                                loginSuccessModel: widget.loginSuccessModel,
                                mskoolController: widget.mskoolController,
                               salaryController: widget.salaryController,
                               //SalaryOverallDetails:widget.salaryController
                              );
                            }));
                          },
                          title: 'View Details',
                        ),
                      ],
                    );
    });
  }
}
