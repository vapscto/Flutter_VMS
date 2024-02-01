import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_get_staff_api.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/staff_list_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/screen/employee_punch_view.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

import '../../../widget/mskoll_btn.dart';

class StaffDropDown extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final EmployeePunchController salaryController;
  const StaffDropDown(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.salaryController});

  @override
  State<StaffDropDown> createState() => _StaffDropDownState();
}

class _StaffDropDownState extends State<StaffDropDown> {
  DateTime? selectedfromdate;
  DateTime? selectedtodate;
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  String department = "";
  String designation = "";

  @override
  void initState() {
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
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                            iconSize: 0,
                            // isDense: true,
                            items: List.generate(
                              widget.salaryController.staffs.length,
                              (index) => DropdownMenuItem<StaffListValues>(
                                value: widget.salaryController.staffs
                                    .elementAt(index),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 8, right: 8),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        1.65,
                                    child: Text(
                                      "${widget.salaryController.staffs.elementAt(index).ename}",
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
                            ),
                            onChanged: (s) async {
                              widget.salaryController.selectedStaff = s!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomContainer(
                                child: TextField(
                                  controller: startDate,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  readOnly: true,
                                  //maxLines: 4,
                                  onTap: () async {
                                    selectedfromdate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2005),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedfromdate != null) {
                                      setState(() {
                                        startDate.text =
                                            "${numberList[selectedfromdate!.day]}-${numberList[selectedfromdate!.month]}-${selectedfromdate!.year}";
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () async {},
                                      icon: SvgPicture.asset(
                                        'assets/svg/calendar_icon.svg',
                                        color: const Color(0xFF787878),
                                        height: 22.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 48.0, left: 12),
                                    border: const OutlineInputBorder(),
                                    label: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          color: const Color(0xFFE5F3FF)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/calendar_icon.svg",
                                            color: const Color(0xFF3E78AA),
                                            height: 24.0,
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " Start Date ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color(0xFF3E78AA),
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: 'Select Date',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: CustomContainer(
                                child: TextField(
                                  controller: endDate,
                                  readOnly: true,
                                  style: Theme.of(context).textTheme.titleSmall,

                                  //maxLines: 4,
                                  onTap: () async {
                                    selectedtodate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2005),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedtodate != null) {
                                      setState(() {
                                        endDate.text =
                                            "${numberList[selectedtodate!.day]}-${numberList[selectedtodate!.month]}-${selectedtodate!.year}";
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        top: 48.0, left: 12),
                                    suffixIcon: IconButton(
                                      onPressed: () async {},
                                      icon: SvgPicture.asset(
                                        'assets/svg/calendar_icon.svg',
                                        color: const Color(0xFF787878),
                                        height: 22.0,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(),
                                    label: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          color: const Color(0xFFE5F3FF)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/calendar_icon.svg",
                                            color: const Color(0xFF3E78AA),
                                            height: 24.0,
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " End Date ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color(0xFF3E78AA)),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: 'Select Date',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        MSkollBtn(
                          onPress: () {
                            if (selectedfromdate == null ||
                                selectedtodate == null) {
                              Fluttertoast.showToast(
                                  msg: "please select dates");
                              return;
                            }
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return EmployeePunchView(
                                loginSuccessModel: widget.loginSuccessModel,
                                mskoolController: widget.mskoolController,
                                salaryController: widget.salaryController,
                                fromdate: selectedfromdate!,
                                todate: selectedtodate!,
                              );
                            }));
                          },
                          title: 'View Details',
                        ),
                      ],
                    );
    });
  }

  @override
  void dispose() {
    widget.salaryController.selectedStaff == null;
    super.dispose();
  }
}
