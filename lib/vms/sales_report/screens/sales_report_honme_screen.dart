import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_widget.dart';
import 'package:m_skool_flutter/vms/sales_report/api/department_api.dart';
import 'package:m_skool_flutter/vms/sales_report/api/designation_api.dart';
import 'package:m_skool_flutter/vms/sales_report/api/employee_api.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import '../../../staffs/gallery_upload/widget/gallery_checkbox.container.dart';

class SalesReportHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const SalesReportHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<SalesReportHomeScreen> createState() => _SalesReportHomeScreenState();
}

class _SalesReportHomeScreenState extends State<SalesReportHomeScreen> {
  SalesController salesController = Get.put(SalesController());
  final _controller = ScrollController();
  final _controller1 = ScrollController();
  final _controller2 = ScrollController();
  final RxBool selectAllDepartment = RxBool(false);
  final RxBool selectAllDesignation = RxBool(false);
  final RxBool selectAllEmployee = RxBool(false);
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  List<int> idList = [];
  addId(int value) {
    idList.add(value);
  }

  void removeId(int value) {
    idList.remove(value);
  }

  _getDepartment() async {
    salesController.departmentLoading(true);
    salesController.designationListValues.clear();
    await DepartmentAPI.instance.departmentAPI(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        hrmdId: widget.loginSuccessModel.empId!,
        salesController: salesController);
    _getDegnisation(idList);
    salesController.departmentLoading(false);
  }

  _getDegnisation(List<int> hrndId) async {
    salesController.designationLoading(true);
    await DesignationAPI.instance.designationAPI(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        hrndIdList: hrndId,
        salesController: salesController);
    salesController.designationLoading(false);
  }

  _getEmployee() async {
    salesController.employeeLoading(true);
    await EmployeeListAPI.instance.employeeListAPI(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        hrndIdList: idList,
        hrmdesIdList: salesController.designationId,
        salesController: salesController);
    salesController.employeeLoading(false);
  }

  @override
  void initState() {
    setState(() {
      _getDepartment();
      _getDegnisation(idList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sales Reports', action: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 10, bottom: 10),
          child: SizedBox(
              height: 10,
              width: 100,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: Center(
                      child: Text(
                    "Search",
                    style: Get.textTheme.titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  )))),
        )
      ]).getAppBar(),
      body: Obx(() {
        return salesController.isDepartmentLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Sales report",
                    desc:
                        "Please wait while we load Sales report entry and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                children: [
                  salesController.departmentlistValues.isEmpty
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Stack(
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
                                          child: CheckboxListTile(
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
                                                'Select all',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3)),
                                              ),
                                              value: selectAllDepartment.value,
                                              onChanged: (value) {
                                                selectAllDepartment.value =
                                                    value!;

                                                salesController
                                                    .departmentSelectedValues
                                                    .clear();
                                                if (value) {
                                                  salesController
                                                      .departmentSelectedValues
                                                      .addAll(salesController
                                                          .departmentlistValues);
                                                  for (int i = 0;
                                                      i <
                                                          salesController
                                                              .departmentlistValues
                                                              .length;
                                                      i++) {
                                                    addId(salesController
                                                        .departmentlistValues
                                                        .elementAt(i)
                                                        .hrmDId!);
                                                    _getDegnisation(idList);
                                                    setState(() {});
                                                  }
                                                } else {
                                                  salesController
                                                      .departmentSelectedValues
                                                      .clear();
                                                  idList.clear();
                                                  _getDegnisation(idList);
                                                  setState(() {});
                                                }
                                              }),
                                        ),
                                        ListView.builder(
                                          itemCount: salesController
                                              .departmentlistValues.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              height: 35,
                                              child: CheckBoxContainer(
                                                  sectionName:
                                                      "${salesController.departmentlistValues.elementAt(index).hrmDDepartmentName}",
                                                  func: (b) {
                                                    setState(() {
                                                      if (b) {
                                                        salesController
                                                            .addSelectedValues(
                                                                salesController
                                                                    .departmentlistValues
                                                                    .elementAt(
                                                                        index));

                                                        addId(salesController
                                                            .departmentlistValues
                                                            .elementAt(index)
                                                            .hrmDId!);
                                                        logger.i(idList);
                                                        _getDegnisation(idList);
                                                        setState(() {});
                                                      } else {
                                                        selectAllDepartment
                                                            .value = false;
                                                        salesController
                                                            .removeSelectedValues(
                                                                salesController
                                                                    .departmentlistValues
                                                                    .elementAt(
                                                                        index));
                                                        for (int i = 0;
                                                            i < idList.length;
                                                            i++) {
                                                          removeId(
                                                              idList[index]);
                                                        }
                                                        _getDegnisation(idList);
                                                        setState(() {});
                                                      }
                                                    });
                                                  },
                                                  isChecked: RxBool(
                                                    salesController
                                                        .departmentSelectedValues
                                                        .contains(
                                                      salesController
                                                          .departmentlistValues
                                                          .elementAt(index),
                                                    ),
                                                  )),
                                              // })
                                            );
                                          },
                                        ),
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
                        ),
                  const SizedBox(height: 20),
                  salesController.isDesignationLoading.value
                      ? const Center(
                          child: AnimatedProgressWidget(
                              title: "Loading Sales report",
                              desc:
                                  "Please wait while we load Sales report entry and create a view for you.",
                              animationPath: "assets/json/default.json"),
                        )
                      : salesController.designationListValues.isEmpty
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Stack(
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
                                      trackColor: const Color.fromRGBO(
                                          223, 239, 253, 1),
                                      trackRadius: const Radius.circular(10),
                                      trackVisibility: true,
                                      radius: const Radius.circular(10),
                                      thickness: 14,
                                      thumbVisibility: true,
                                      controller: _controller1,
                                      child: SingleChildScrollView(
                                        controller: _controller,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: CheckboxListTile(
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
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
                                                    'Select all',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .merge(const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.0,
                                                            letterSpacing:
                                                                0.3)),
                                                  ),
                                                  value: selectAllDesignation
                                                      .value,
                                                  onChanged: (value) {
                                                    selectAllDesignation.value =
                                                        value!;

                                                    salesController
                                                        .selectedDesignationListValues
                                                        .clear();
                                                    if (value) {
                                                      salesController
                                                          .selectedDesignationListValues
                                                          .addAll(salesController
                                                              .designationListValues);
                                                      for (int i = 0;
                                                          i <
                                                              salesController
                                                                  .designationListValues
                                                                  .length;
                                                          i++) {
                                                        salesController.addDegId(
                                                            salesController
                                                                .designationListValues
                                                                .elementAt(i)
                                                                .hrmdeSId!);
                                                        _getEmployee();
                                                        setState(() {});
                                                      }
                                                    } else {
                                                      salesController
                                                          .selectedDesignationListValues
                                                          .clear();
                                                      salesController
                                                          .designationId
                                                          .clear();
                                                      _getEmployee();
                                                      setState(() {});
                                                    }
                                                  }),
                                            ),
                                            ListView.builder(
                                              itemCount: salesController
                                                  .designationListValues.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return SizedBox(
                                                  height: 35,
                                                  child: CheckBoxContainer(
                                                      sectionName:
                                                          "${salesController.designationListValues.elementAt(index).hrmdeSDesignationName}",
                                                      func: (b) {
                                                        setState(() {
                                                          if (b) {
                                                            salesController.addSelectedDesignationValues(
                                                                salesController
                                                                    .designationListValues
                                                                    .elementAt(
                                                                        index));

                                                            salesController.addDegId(
                                                                salesController
                                                                    .designationListValues
                                                                    .elementAt(
                                                                        index)
                                                                    .hrmdeSId!);
                                                            _getEmployee();
                                                            setState(() {});
                                                          } else {
                                                            selectAllDepartment
                                                                .value = false;
                                                            salesController.removeSelectedDesignationValues(
                                                                salesController
                                                                    .designationListValues
                                                                    .elementAt(
                                                                        index));
                                                            for (int i = 0;
                                                                i <
                                                                    salesController
                                                                        .designationId
                                                                        .length;
                                                                i++) {
                                                              removeId(
                                                                  salesController
                                                                          .designationId[
                                                                      index]);
                                                            }
                                                            _getEmployee();
                                                            setState(() {});
                                                          }
                                                        });
                                                      },
                                                      isChecked: RxBool(
                                                        salesController
                                                            .selectedDesignationListValues
                                                            .contains(
                                                          salesController
                                                              .designationListValues
                                                              .elementAt(index),
                                                        ),
                                                      )),
                                                  // })
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const ContainerTitle(
                                    iT: Color(0xFFFF6F67),
                                    bg: Color.fromARGB(255, 255, 236, 235),
                                    image: 'assets/images/subjectfielicon.png',
                                    title: 'Select Designation',
                                  ),
                                ],
                              ),
                            ),
                  salesController.isEmployeeLoading.value
                      ? const Center(
                          child: AnimatedProgressWidget(
                              title: "Loading Sales report",
                              desc:
                                  "Please wait while we load Sales report entry and create a view for you.",
                              animationPath: "assets/json/default.json"),
                        )
                      : salesController.employeeListValues.isEmpty
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Stack(
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
                                      trackColor: const Color.fromRGBO(
                                          223, 239, 253, 1),
                                      trackRadius: const Radius.circular(10),
                                      trackVisibility: true,
                                      radius: const Radius.circular(10),
                                      thickness: 14,
                                      thumbVisibility: true,
                                      controller: _controller1,
                                      child: SingleChildScrollView(
                                        controller: _controller2,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: CheckboxListTile(
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
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
                                                    'Select all',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .merge(const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.0,
                                                            letterSpacing:
                                                                0.3)),
                                                  ),
                                                  value:
                                                      selectAllEmployee.value,
                                                  onChanged: (value) {
                                                    selectAllEmployee.value =
                                                        value!;

                                                    salesController
                                                        .selectedEmployeeListValues
                                                        .clear();
                                                    if (value) {
                                                      salesController
                                                          .selectedEmployeeListValues
                                                          .addAll(salesController
                                                              .employeeListValues);
                                                      logger.i(salesController
                                                          .employeeListValues
                                                          .length);
                                                      for (int i = 0;
                                                          i <
                                                              salesController
                                                                  .employeeListValues
                                                                  .length;
                                                          i++) {
                                                        addId(salesController
                                                            .employeeListValues
                                                            .elementAt(i)
                                                            .hrmDId!);

                                                        setState(() {});
                                                      }
                                                    } else {
                                                      salesController
                                                          .selectedEmployeeListValues
                                                          .clear();
                                                      salesController.empId
                                                          .clear();

                                                      setState(() {});
                                                    }
                                                  }),
                                            ),
                                            ListView.builder(
                                              itemCount: salesController
                                                  .employeeListValues.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                logger.i(
                                                    " =========${salesController.employeeListValues.elementAt(index).hrmEEmployeeFirstName}");
                                                return SizedBox(
                                                  height: 35,
                                                  child: CheckBoxContainer(
                                                      sectionName:
                                                          "${salesController.employeeListValues.elementAt(index).hrmEEmployeeFirstName} ${salesController.employeeListValues.elementAt(index).hrmEEmployeeMiddleName ?? ''} ${salesController.employeeListValues.elementAt(index).hrmEEmployeeLastName ?? ''}",
                                                      func: (b) {
                                                        setState(() {
                                                          if (b) {
                                                            salesController.addSelectedEmpValues(
                                                                salesController
                                                                    .employeeListValues
                                                                    .elementAt(
                                                                        index));

                                                            salesController.addEmpId(
                                                                salesController
                                                                    .employeeListValues
                                                                    .elementAt(
                                                                        index)
                                                                    .hrmDId!);

                                                            setState(() {});
                                                          } else {
                                                            selectAllDepartment
                                                                .value = false;
                                                            salesController.removeSelectedEmpValues(
                                                                salesController
                                                                    .employeeListValues
                                                                    .elementAt(
                                                                        index));
                                                            for (int i = 0;
                                                                i <
                                                                    salesController
                                                                        .empId
                                                                        .length;
                                                                i++) {
                                                              removeId(
                                                                  salesController
                                                                          .empId[
                                                                      index]);
                                                            }

                                                            setState(() {});
                                                          }
                                                        });
                                                      },
                                                      isChecked: RxBool(
                                                        salesController
                                                            .selectedEmployeeListValues
                                                            .contains(
                                                          salesController
                                                              .employeeListValues
                                                              .elementAt(index),
                                                        ),
                                                      )),
                                                  // })
                                                );
                                              },
                                            ),
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
                            ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomContainer(
                            child: TextField(
                              style: Theme.of(context).textTheme.titleSmall,
                              readOnly: true,
                              controller: _startDate,
                              onTap: () async {
                                fromDate = await showDatePicker(
                                  context: context,
                                  helpText: "Select Data",
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3050),
                                  selectableDayPredicate: (day) =>
                                      day.weekday == 7 || day.weekday == 7
                                          ? false
                                          : true,
                                );
                                if (fromDate != null) {
                                  setState(() {
                                    _startDate.text =
                                        "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    fromDate = await showDatePicker(
                                      helpText: "Select Data",
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(3050),
                                      selectableDayPredicate: (day) =>
                                          day.weekday == 7 || day.weekday == 7
                                              ? false
                                              : true,
                                    );

                                    if (fromDate != null) {
                                      setState(() {
                                        _startDate.text =
                                            "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                      });
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/svg/calendar_icon.svg",
                                    color: const Color(0xFF3E78AA),
                                    height: 18,
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(top: 40.0, left: 12),
                                border: const OutlineInputBorder(),
                                label: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color(0xFFE5F3FF)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/calendar_icon.svg",
                                        color: const Color(0xFF3E78AA),
                                        height: 18,
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
                                                fontSize: 18.0,
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
                              readOnly: true,
                              style: Theme.of(context).textTheme.titleSmall,
                              controller: _endDate,
                              onTap: () async {
                                if (_startDate.text.isNotEmpty) {
                                  toDate = await showDatePicker(
                                    context: context,
                                    helpText: "Select Date",
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3050),
                                  );
                                  if (toDate != null) {
                                    setState(() {
                                      _endDate.text =
                                          "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Start Date");
                                }
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.only(top: 40.0, left: 12),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (_startDate.text.isNotEmpty) {
                                      toDate = await showDatePicker(
                                        context: context,
                                        helpText: "Select Date",
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(3050),
                                      );
                                      if (toDate != null) {
                                        setState(() {
                                          _endDate.text =
                                              "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                        });
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Start Date");
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/svg/calendar_icon.svg",
                                    color: const Color(0xFF3E78AA),
                                    height: 18,
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                                label: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color(0xFFE5F3FF)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/calendar_icon.svg",
                                        color: const Color(0xFF3E78AA),
                                        height: 18,
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
                                                  fontSize: 18.0,
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
                  ),
                ],
              );
      }),
    );
  }
}
