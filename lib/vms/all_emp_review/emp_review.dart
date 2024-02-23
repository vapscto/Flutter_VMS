import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/api/all_emp_rating_api.dart';
import 'package:m_skool_flutter/vms/all_emp_review/controller/all_emp_rating_controller.dart';
import 'package:m_skool_flutter/vms/utils/check_box_container.dart';
import 'package:m_skool_flutter/vms/widgets/level_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class AllEmpReviewHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const AllEmpReviewHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<AllEmpReviewHome> createState() => _AllEmpReviewHomeState();
}

class _AllEmpReviewHomeState extends State<AllEmpReviewHome> {
  EmpRatingController controller = Get.put(EmpRatingController());
  List<int> employeesID = [];
  _loadData() async {
    controller.empLoad(true);
    await AllEmpRatingAPI.i.yearAPI(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "Userid": widget.loginSuccessModel.userId,
          "Role_flag": "S",
          "IVRMRT_Id": widget.loginSuccessModel.roleId
        },
        controller: controller);
    controller.empLoad(false);
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  final ScrollController _controller = ScrollController();
  final ScrollController _controller1 = ScrollController();
  final ScrollController _controller2 = ScrollController();
  final RxBool selectAllEmployee = RxBool(false);
  final RxBool selectAllMonth = RxBool(false);
  final RxBool selectAllYear = RxBool(false);
  final serchEmployee = TextEditingController();
  bool selectAll = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Employee Ratings', action: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  "Search",
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        )
      ]).getAppBar(),
      body: Obx(() {
        return (controller.isEmpLoading.value)
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading",
                desc: "We are under process to get your details from server.")
            : (controller.employeeList.isEmpty)
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "",
                    animatorHeight: 250,
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    children: [
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.vertical,
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: MediaQuery.of(context).size.height * 0.4,
                      //     decoration: const BoxDecoration(
                      //       border: Border(
                      //           right:
                      //               BorderSide(width: 1, color: Colors.black54),
                      //           bottom: BorderSide(
                      //               width: 1, color: Colors.black54)),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 5, horizontal: 5),
                      //       child: Column(
                      //         children: [
                      //           TextField(
                      //             maxLines: 1,
                      //             controller: serchEmployee,
                      //             onChanged: (value) {
                      //               filterEmployees(value);
                      //             },
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .titleSmall!
                      //                 .merge(const TextStyle(
                      //                   fontWeight: FontWeight.w100,
                      //                   fontSize: 12.0,
                      //                   letterSpacing: 0.3,
                      //                   overflow: TextOverflow.clip,
                      //                 )),
                      //             decoration: InputDecoration(
                      //                 hintText: "Search",
                      //                 helperStyle: Theme.of(context)
                      //                     .textTheme
                      //                     .titleSmall!
                      //                     .merge(const TextStyle(
                      //                       fontWeight: FontWeight.w100,
                      //                       fontSize: 12.0,
                      //                       letterSpacing: 0.3,
                      //                       overflow: TextOverflow.clip,
                      //                     )),
                      //                 border: OutlineInputBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(5))),
                      //           ),
                      //           const SizedBox(
                      //             height: 5,
                      //           ),
                      //           SizedBox(
                      //             width: MediaQuery.of(context).size.width,
                      //             height:
                      //                 MediaQuery.of(context).size.height * 0.3,
                      //             child: ListView.builder(
                      //               itemCount:
                      //                   controller.selectedEmployeeList.length +
                      //                       1,
                      //               itemBuilder: (context, index) {
                      //                 if (index == 0) {
                      //                   return Padding(
                      //                     padding: const EdgeInsets.symmetric(
                      //                         vertical: 2),
                      //                     child: Row(
                      //                       children: [
                      //                         Checkbox(
                      //                           shape:
                      //                               ContinuousRectangleBorder(
                      //                             borderRadius:
                      //                                 BorderRadius.circular(10),
                      //                           ),
                      //                           activeColor:
                      //                               const Color.fromRGBO(
                      //                                   26, 48, 241, 1),
                      //                           value: selectAll,
                      //                           onChanged: (value) {
                      //                             setState(() {
                      //                               selectAll = value!;
                      //                               if (selectAll) {
                      //                                 employeesID.clear();
                      //                                 employeesID = List.from(
                      //                                     controller
                      //                                         .selectedEmployeeList
                      //                                         .map((employee) =>
                      //                                             employee
                      //                                                 .hRMEId!));
                      //                                 logger.i(employeesID);
                      //                               } else {
                      //                                 employeesID.clear();
                      //                                 logger.i(employeesID);
                      //                               }
                      //                               controller.checkBox
                      //                                   .assignAll(List.filled(
                      //                                       controller
                      //                                           .selectedEmployeeList
                      //                                           .length,
                      //                                       selectAll));
                      //                             });
                      //                           },
                      //                         ),
                      //                         const SizedBox(),
                      //                         const Text(
                      //                           "All Employees",
                      //                           style: TextStyle(
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   );
                      //                 } else {
                      //                   return Padding(
                      //                     padding: const EdgeInsets.symmetric(
                      //                         vertical: 2),
                      //                     child: SizedBox(
                      //                       width: 180,
                      //                       height: 30,
                      //                       child: Row(
                      //                         children: [
                      //                           Checkbox(
                      //                             shape:
                      //                                 ContinuousRectangleBorder(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                       10),
                      //                             ),
                      //                             activeColor:
                      //                                 const Color.fromRGBO(
                      //                                     26, 48, 241, 1),
                      //                             value: controller
                      //                                 .checkBox[index - 1],
                      //                             onChanged: (value) {
                      //                               setState(() {
                      //                                 controller.checkBox[
                      //                                     index - 1] = value!;

                      //                                 if (value) {
                      //                                   employeesID.add(controller
                      //                                       .selectedEmployeeList[
                      //                                           index - 1]
                      //                                       .hRMEId!);
                      //                                   logger.i(employeesID);
                      //                                 } else {
                      //                                   employeesID.remove(
                      //                                       controller
                      //                                           .selectedEmployeeList[
                      //                                               index - 1]
                      //                                           .hRMEId);
                      //                                   logger.i(employeesID);
                      //                                 }

                      //                                 selectAll = controller
                      //                                     .checkBox
                      //                                     .every(
                      //                                         (value) => value);
                      //                               });
                      //                             },
                      //                           ),
                      //                           const SizedBox(),
                      //                           SizedBox(
                      //                             width: 180,
                      //                             child: RichText(
                      //                               text: TextSpan(
                      //                                 children: [
                      //                                   TextSpan(
                      //                                     text: controller
                      //                                         .selectedEmployeeList[
                      //                                             index - 1]
                      //                                         .userEmpName,
                      //                                     style:
                      //                                         Theme.of(context)
                      //                                             .textTheme
                      //                                             .titleSmall!
                      //                                             .merge(
                      //                                               const TextStyle(
                      //                                                 fontWeight:
                      //                                                     FontWeight
                      //                                                         .bold,
                      //                                                 fontSize:
                      //                                                     12.0,
                      //                                                 letterSpacing:
                      //                                                     0.3,
                      //                                                 overflow:
                      //                                                     TextOverflow
                      //                                                         .clip,
                      //                                               ),
                      //                                             ),
                      //                                   ),
                      //                                   TextSpan(
                      //                                     text:
                      //                                         " : ${controller.selectedEmployeeList[index - 1].hRMDDepartmentName} ",
                      //                                     style:
                      //                                         Theme.of(context)
                      //                                             .textTheme
                      //                                             .titleSmall!
                      //                                             .merge(
                      //                                               const TextStyle(
                      //                                                 fontWeight:
                      //                                                     FontWeight
                      //                                                         .w100,
                      //                                                 fontSize:
                      //                                                     12.0,
                      //                                                 letterSpacing:
                      //                                                     0.3,
                      //                                                 overflow:
                      //                                                     TextOverflow
                      //                                                         .clip,
                      //                                               ),
                      //                                             ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }
                      //               },
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 160,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                                        bool allSelected = controller
                                                .selectedEmployeeList.length ==
                                            controller.employeeList.length;

                                        return CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          checkboxShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          dense: true,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          visualDensity: const VisualDensity(
                                              horizontal: -4.0),
                                          title: Text(
                                            "Select All",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3,
                                                )),
                                          ),
                                          value: allSelected,
                                          onChanged: (bool? value) {
                                            controller.selectedEmployeeList
                                                .clear();
                                            if (value!) {
                                              controller.selectedEmployeeList
                                                  .addAll(
                                                      controller.employeeList);
                                            }
                                          },
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    ListView.builder(
                                      itemCount: controller.employeeList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                            height: 35,
                                            child: Obx(() {
                                              return CheckBoxContainer(
                                                sectionName:
                                                    "${controller.employeeList.elementAt(index).userEmpName}",
                                                func: (b) {
                                                  if (b) {
                                                    controller
                                                        .addToSelectedEmployee(
                                                            controller
                                                                .employeeList
                                                                .elementAt(
                                                                    index));
                                                  } else {
                                                    selectAllEmployee.value =
                                                        false;
                                                    controller
                                                        .removeFromSelectedEmployee(
                                                            controller
                                                                .employeeList
                                                                .elementAt(
                                                                    index));
                                                  }
                                                },
                                                isChecked: RxBool(
                                                  controller
                                                      .selectedEmployeeList
                                                      .contains(
                                                    controller.employeeList
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
                            title: 'Select Employee',
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 160,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                              controller: _controller1,
                              child: SingleChildScrollView(
                                controller: _controller1,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: Obx(() {
                                        bool allSelected = controller
                                                .selectedMonthList.length ==
                                            controller.monthList.length;

                                        return CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          checkboxShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          dense: true,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          visualDensity: const VisualDensity(
                                              horizontal: -4.0),
                                          title: Text(
                                            "Select All",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3,
                                                )),
                                          ),
                                          value: allSelected,
                                          onChanged: (bool? value) {
                                            controller.selectedMonthList
                                                .clear();
                                            if (value!) {
                                              controller.selectedMonthList
                                                  .addAll(controller.monthList);
                                            }
                                          },
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    ListView.builder(
                                      itemCount: controller.monthList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                            height: 35,
                                            child: Obx(() {
                                              return CheckBoxContainer(
                                                sectionName:
                                                    "${controller.monthList.elementAt(index).ivrMMonthName}",
                                                func: (b) {
                                                  if (b) {
                                                    controller
                                                        .addToSelectedMonth(
                                                            controller.monthList
                                                                .elementAt(
                                                                    index));
                                                  } else {
                                                    selectAllMonth.value =
                                                        false;
                                                    controller
                                                        .removeFromSelectedMonth(
                                                            controller.monthList
                                                                .elementAt(
                                                                    index));
                                                  }
                                                },
                                                isChecked: RxBool(
                                                  controller.selectedMonthList
                                                      .contains(
                                                    controller.monthList
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
                            title: 'Select Month',
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 160,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                              controller: _controller2,
                              child: SingleChildScrollView(
                                controller: _controller2,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: Obx(() {
                                        bool allSelected = controller
                                                .selectedYearList.length ==
                                            controller.yearList.length;

                                        return CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          checkboxShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          dense: true,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          visualDensity: const VisualDensity(
                                              horizontal: -4.0),
                                          title: Text(
                                            "Select All",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3,
                                                )),
                                          ),
                                          value: allSelected,
                                          onChanged: (bool? value) {
                                            controller.selectedYearList.clear();
                                            if (value!) {
                                              controller.selectedYearList
                                                  .addAll(controller.yearList);
                                            }
                                          },
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    ListView.builder(
                                      itemCount: controller.yearList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                            height: 35,
                                            child: Obx(() {
                                              return CheckBoxContainer(
                                                sectionName:
                                                    "${controller.yearList.elementAt(index).asmaYYear}",
                                                func: (b) {
                                                  if (b) {
                                                    controller
                                                        .addToSelectedYear(
                                                            controller.yearList
                                                                .elementAt(
                                                                    index));
                                                  } else {
                                                    selectAllYear.value = false;
                                                    controller
                                                        .removeFromSelectedYear(
                                                            controller.yearList
                                                                .elementAt(
                                                                    index));
                                                  }
                                                },
                                                isChecked: RxBool(
                                                  controller.selectedYearList
                                                      .contains(
                                                    controller.yearList
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
                            title: 'Select Year',
                          ),
                        ],
                      ),
                    ],
                  );
      }),
    );
  }

  // void filterEmployees(String query) {
  //   logger.e(query);
  //   controller.selectedEmployeeList.value = controller.employeeList
  //       .where((employee) =>
  //           employee.userEmpName!.toLowerCase().contains(query.toLowerCase()) ||
  //           employee.hRMDDepartmentName!.toLowerCase().trim() ==
  //               query.toLowerCase().trim())
  //       .toList();
  // }
}
