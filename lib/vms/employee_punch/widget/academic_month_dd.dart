import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/month_list_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/model/yearlist_dropdown_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/widget/staff_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

import '../../../controller/mskoll_controller.dart';

class AcademicMonthDD extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final EmployeePunchController salaryController;
  const AcademicMonthDD(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.salaryController});

  @override
  State<AcademicMonthDD> createState() => _AcademicMonthDDState();
}

class _AcademicMonthDDState extends State<AcademicMonthDD> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.salaryController.yearlist.isEmpty &&
              widget.salaryController.monthList.isEmpty
          ? const Center(
              // child: AnimatedProgressWidget(
              //   animationPath: 'assets/json/nodata.json',
              //   title: 'No Academic Year & Month Present',
              //   desc:
              //       'While loading the academic year or month we are unable to found any data',
              // ),
              )
          : Column(
              children: [
                CustomContainer(
                  child: DropdownButtonFormField<YearListDorpdownValues>(
                    value: widget.salaryController.selectedYear,
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
                            color: const Color(0xFFDFFBFE),
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/cap.png",
                              height: 28.0,
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "Academic Year",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(const TextStyle(
                                      fontSize: 20, color: Color(0xFF28B6C8))),
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
                      widget.salaryController.yearlist.length,
                      (index) => DropdownMenuItem<YearListDorpdownValues>(
                        value:
                            widget.salaryController.yearlist.elementAt(index),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 8, right: 8),
                          child: Text(
                            widget.salaryController.yearlist
                                .elementAt(index)
                                .hrmlYLeaveYear!,
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

                      widget.salaryController.selectedYear = s!;
                      // await loadOnChange();
                    },
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                CustomContainer(
                  child: DropdownButtonFormField<MonthDorpdownValues>(
                    value: widget.salaryController.selectedMonth,
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
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEA),
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/calendar.png",
                              color: const Color(0xFFFF6F67),
                              height: 22.0,
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "Select Month",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(const TextStyle(
                                      fontSize: 20, color: Color(0xFFFF6F67))),
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
                      widget.salaryController.monthList.length,
                      (index) => DropdownMenuItem<MonthDorpdownValues>(
                        value:
                            widget.salaryController.monthList.elementAt(index),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 8, right: 8),
                          child: Text(
                            widget.salaryController.monthList
                                    .elementAt(index)
                                    .ivrMMonthName ??
                                "N/a",
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
                      widget.salaryController.selectedMonth = s;
                    },
                  ),
                ),
                const SizedBox(
                  height: 36.0,
                ),
                StaffDropDown(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  salaryController: widget.salaryController,
                ),
                // ListView.separated(itemBuilder: (_,index){return CoeItem(values: values, color: color)}, separatorBuilder: (_,index){
                //   return SizedBox(height: 16.0,);
                // }, itemCount: 5)
              ],
            );
    });
  }
}
