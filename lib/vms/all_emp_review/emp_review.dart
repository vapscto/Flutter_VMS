import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/api/all_emp_rating_api.dart';
import 'package:m_skool_flutter/vms/all_emp_review/controller/all_emp_rating_controller.dart';
import 'package:m_skool_flutter/vms/all_emp_review/emp_review_details.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/all_rating_emp_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/rating_year_model.dart';
import 'package:m_skool_flutter/vms/utils/check_box_container.dart';
import 'package:m_skool_flutter/vms/widgets/level_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

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

  final searchController = TextEditingController();
  @override
  void initState() {
    _loadData();
    filterEmpList.value = controller.employeeList;
    super.initState();
  }

  List year = [];
  String selectedYearData = '';

  final ScrollController _controller = ScrollController();
  final ScrollController _controller1 = ScrollController();
  // final ScrollController _controller2 = ScrollController();
  final RxBool selectAllEmployee = RxBool(false);
  final RxBool selectAllMonth = RxBool(false);
  final RxBool selectAllYear = RxBool(false);
  final serchEmployee = TextEditingController();
  bool selectAll = false;
  RxList<RatingEmpModelValues> filterEmpList = <RatingEmpModelValues>[].obs;

  Future<void> _refresh() async {
    _loadData();
    filterEmpList.value = controller.employeeList;
  }

  RatingYearModelValues? selectedYear;
  List<String> radioList = ["All", "Month Wise"];
  String selectedData = 'All';
  String selectedvalue = '';
  @override
  void dispose() {
    controller.selectedEmployeeList.clear();
    controller.selectedMonthList.clear();
    selectedYear = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Employee Ratings', action: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
          child: InkWell(
            onTap: () {
              if (selectedYear != null) {
                if (selectedData == 'All') {
                  if (controller.selectedEmployeeList.isEmpty) {
                    Fluttertoast.showToast(msg: "Select Employee");
                    return;
                  } else {
                    Get.to(() => EmpRatingDetails(
                          controller: controller,
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          data: selectedvalue,
                          year: selectedYear!.hrmlYLeaveYear!,
                        ));
                  }
                } else if (selectedData == 'Month Wise') {
                  if (controller.selectedEmployeeList.isEmpty) {
                    Fluttertoast.showToast(msg: "Select Employee");
                    return;
                  } else if (controller.selectedMonthList.isEmpty) {
                    Fluttertoast.showToast(msg: "Select Month");
                    return;
                  } else {
                    Get.to(() => EmpRatingDetails(
                          controller: controller,
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          data: selectedvalue,
                          year: selectedYear!.hrmlYLeaveYear.toString(),
                        ));
                  }
                }
              } else {
                Fluttertoast.showToast(msg: "Select Year");
                return;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    List.generate(radioList.length, (index) {
                                  return Row(
                                    children: [
                                      Radio(
                                        fillColor: MaterialStatePropertyAll(
                                            Theme.of(context).primaryColor),
                                        value: radioList[index],
                                        groupValue: selectedData,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedData = value!;
                                            if (selectedData == 'All') {
                                              selectedvalue = 'all';
                                            } else {
                                              selectedvalue = 'monthyearwise';
                                            }
                                            logger.w(selectedvalue);
                                          });
                                        },
                                        visualDensity: const VisualDensity(
                                            vertical: 0, horizontal: 0),
                                      ),
                                      Text(
                                        radioList[index],
                                        style: Get.textTheme.titleSmall,
                                      )
                                    ],
                                  );
                                }),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: CustomContainer(
                            child:
                                DropdownButtonFormField<RatingYearModelValues>(
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                hintText: 'Select Academic Year',
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFDFFBFE),
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
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
                                                fontSize: 20,
                                                color: Color(0xFF28B6C8))),
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
                                controller.yearList.length,
                                (index) =>
                                    DropdownMenuItem<RatingYearModelValues>(
                                  value: controller.yearList.elementAt(index),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 8, right: 8),
                                    child: Text(
                                      controller.yearList
                                              .elementAt(index)
                                              .hrmlYLeaveYear ??
                                          '',
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
                                setState(() {
                                  selectedYear = s;
                                  year.clear();
                                  year.add(
                                      selectedYear!.hrmlYLeaveYear!.split("-"));
                                  logger.v(year);
                                });
                              },
                            ),
                          ),
                        ),
                        year.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: CustomContainer(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.all(16.0),
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
                                      hintText: 'Select  Year',
                                      hintStyle: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFDFFBFE),
                                            borderRadius:
                                                BorderRadius.circular(24.0)),
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
                                              "Year",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .merge(const TextStyle(
                                                      fontSize: 20,
                                                      color:
                                                          Color(0xFF28B6C8))),
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
                                      year.length,
                                      (index) => DropdownMenuItem(
                                        value: year.elementAt(index),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12.0, left: 8, right: 8),
                                          child: Text(
                                            year.elementAt(index),
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
                                      setState(() {
                                        selectedYearData = s.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                        const SizedBox(height: 20),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(8.0),
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 8, 20, 0),
                                        child: SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: searchController,
                                            onChanged: (value) {
                                              setState(() {
                                                filterEmployees(value);
                                              });
                                            },
                                            style: Get.textTheme.titleSmall,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                hintText: 'Search Employee',
                                                hintStyle: Get
                                                    .textTheme.titleSmall!
                                                    .copyWith(
                                                        color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: Obx(() {
                                          bool allSelected = controller
                                                  .selectedEmployeeList
                                                  .length ==
                                              filterEmpList.length;

                                          return CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            checkboxShape:
                                                RoundedRectangleBorder(
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
                                                    .addAll(filterEmpList);
                                              }
                                            },
                                          );
                                        }),
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      ListView.builder(
                                        itemCount: filterEmpList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                              height: 35,
                                              child: Obx(() {
                                                return CheckBoxContainer(
                                                  sectionName:
                                                      "${filterEmpList.elementAt(index).userEmpName}",
                                                  func: (b) {
                                                    if (b) {
                                                      controller
                                                          .addToSelectedEmployee(
                                                              filterEmpList
                                                                  .elementAt(
                                                                      index));
                                                    } else {
                                                      selectAllEmployee.value =
                                                          false;
                                                      controller
                                                          .removeFromSelectedEmployee(
                                                              filterEmpList
                                                                  .elementAt(
                                                                      index));
                                                    }
                                                  },
                                                  isChecked: RxBool(
                                                    controller
                                                        .selectedEmployeeList
                                                        .contains(
                                                      filterEmpList
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
                        (selectedData != 'Month Wise')
                            ? const SizedBox()
                            : Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 160,
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(8.0),
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
                                      controller: _controller1,
                                      child: SingleChildScrollView(
                                        controller: _controller1,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: Obx(() {
                                                bool allSelected = controller
                                                        .selectedMonthList
                                                        .length ==
                                                    controller.monthList.length;

                                                return CheckboxListTile(
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  dense: true,
                                                  activeColor: Theme.of(context)
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
                                                              FontWeight.w400,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                        )),
                                                  ),
                                                  value: allSelected,
                                                  onChanged: (bool? value) {
                                                    controller.selectedMonthList
                                                        .clear();
                                                    if (value!) {
                                                      controller
                                                          .selectedMonthList
                                                          .addAll(controller
                                                              .monthList);
                                                    }
                                                  },
                                                );
                                              }),
                                            ),
                                            const SizedBox(
                                              height: 6.0,
                                            ),
                                            ListView.builder(
                                              itemCount:
                                                  controller.monthList.length,
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
                                                            controller.addToSelectedMonth(
                                                                controller
                                                                    .monthList
                                                                    .elementAt(
                                                                        index));
                                                          } else {
                                                            selectAllMonth
                                                                .value = false;
                                                            controller.removeFromSelectedMonth(
                                                                controller
                                                                    .monthList
                                                                    .elementAt(
                                                                        index));
                                                          }
                                                        },
                                                        isChecked: RxBool(
                                                          controller
                                                              .selectedMonthList
                                                              .contains(
                                                            controller.monthList
                                                                .elementAt(
                                                                    index),
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
                      ],
                    ),
                  );
      }),
    );
  }

  void filterEmployees(String query) {
    if (query.isEmpty) {
      filterEmpList.value = controller.employeeList;
    } else {
      filterEmpList.value = controller.employeeList
          .where((employee) =>
              employee.userEmpName!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              employee.hRMDDepartmentName!.toLowerCase().trim() ==
                  query.toLowerCase().trim())
          .toList();
    }

    setState(() {});
  }
}
