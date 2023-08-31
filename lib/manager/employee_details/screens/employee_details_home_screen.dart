import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_details/controller/employee_details_related_controller.dart';
import 'package:m_skool_flutter/manager/employee_details/screens/employee_details_screen.dart';
import 'package:m_skool_flutter/manager/employee_details/widget/data_card_widget.dart';
import 'package:m_skool_flutter/manager/employee_details/widget/header_data_widget.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class EmployeeDetailsHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const EmployeeDetailsHomeScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<EmployeeDetailsHomeScreen> createState() =>
      _EmployeeDetailsHomeScreenState();
}

class _EmployeeDetailsHomeScreenState extends State<EmployeeDetailsHomeScreen> {
  final EmployeeDetailsController employeeDetailsController =
      Get.put(EmployeeDetailsController());

  final controller = ScrollController();
  final controller1 = ScrollController();
  final controller2 = ScrollController();
  final controller3 = ScrollController();

  RxList<Map> selectedHeaderList = <Map>[].obs;
  List<int> multipletype = [];
  List<int> multipledep = [];
  List<int> multipledes = [];

  RxBool selectAllHeader = RxBool(false);
  RxBool selectAllType = RxBool(false);
  RxBool selectAllDep = RxBool(false);
  RxBool selectAllDes = RxBool(false);

  void getTypesData() async {
    employeeDetailsController.istypeloading(true);
    await employeeDetailsController
        .getTypes(
            base: baseUrlFromInsCode('frontoffice', widget.mskoolController),
            miId: widget.loginSuccessModel.mIID!,
            asmayId: widget.loginSuccessModel.asmaYId!)
        .then((value) {
      logger.d(value);
    });
    employeeDetailsController.istypeloading(false);
  }

  void getDepartmentData() async {
    employeeDetailsController.isdepartmentloading(true);
    multipledep.clear();
    selectAllDep.value = false;
    await employeeDetailsController.getDepartment(
      base: baseUrlFromInsCode('frontoffice', widget.mskoolController),
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      multipletype: multipletype.join(','),
    );
    employeeDetailsController.isdepartmentloading(false);
  }

  void getDesignationData() async {
    employeeDetailsController.isdesignationloading(true);
    multipledes.clear();
    selectAllDes.value = false;
    await employeeDetailsController.getDesignation(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.mIID!,
      multipletype: multipletype.join(','),
      multipledep: multipledep.join(','),
      base: baseUrlFromInsCode(
        'frontoffice',
        widget.mskoolController,
      ),
    );
    employeeDetailsController.isdesignationloading(false);
  }

  void addToMultipleType(int id) {
    multipletype.add(id);
    getDepartmentData();
  }

  void removeFromMultipleType(int id) {
    multipletype.removeWhere((val) => val == id);
    selectAllType.value = false;
    getDepartmentData();
  }

  void addToMultipleDepartment(int id) {
    multipledep.add(id);
    getDesignationData();
  }

  void removeFromMultipleDepartment(int id) {
    multipledep.removeWhere((element) => element == id);
    selectAllDep.value = false;
    getDesignationData();
  }

  void addToMultipleDesignation(int id) {
    multipledes.add(id);
  }

  void removeFromMultipleDesignation(int id) {
    multipledes.removeWhere((element) => element == id);
    selectAllDes.value = false;
  }

  void addToHeaderList(Map<String, dynamic> data) {
    selectedHeaderList.add(data);
    logger.d(selectedHeaderList);
  }

  void removeFromHeaderList(String id) {
    selectedHeaderList.removeWhere((element) => element['columnID'] == id);
    selectAllHeader.value = false;
    logger.d(selectedHeaderList);
  }

  void searchEmployeeDetails() async {
    employeeDetailsController.issearchloadig(true);
    await employeeDetailsController
        .getEmployeeDetail(
      miId: widget.loginSuccessModel.mIID!,
      left: employeeDetailsController.left.value,
      working: employeeDetailsController.working.value,
      selectedDepartment: multipledep,
      selectedDesignation: multipledes,
      selectedType: multipletype,
      selectedHeader: selectedHeaderList,
      base: baseUrlFromInsCode('hrms', widget.mskoolController),
    )
        .then(
      (value) {
        if (value) {
          if (employeeDetailsController.employeeDetailsList.isEmpty) {
            Fluttertoast.showToast(msg: 'No data available.');
            return;
          }
          Get.to(() => EmployeeDetailsScreen(
                headerList: selectedHeaderList,
                loginSuccessModel: widget.loginSuccessModel,
                mskoolController: widget.mskoolController,
              ));
        }
      },
    );
    employeeDetailsController.issearchloadig(false);
  }

  @override
  void initState() {
    getTypesData();
    super.initState();
  }

  // RxBool selectAllType = RxBool(false);
  // RxBool selectAllDept = RxBool(false);
  // RxBool selectAllDesig = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Employee details').getAppBar(),
      floatingActionButton: const HomeFab(),
      body: Obx(
        () => employeeDetailsController.isType.value
            ? const Align(
                alignment: Alignment.center,
                child: AnimatedProgressWidget(
                    title: "Loading Employee Details",
                    desc:
                        "Please wait while we load employee details and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: employeeDetailsController.typeList.isEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 36.0,
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 36.0,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Something went wrong',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(fontSize: 20.0),
                                    ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Unable to load data try after some time.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(letterSpacing: 0.2)),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 180,
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
                                  thumbColor: Theme.of(context).primaryColor,
                                  trackColor:
                                      const Color.fromRGBO(223, 239, 253, 1),
                                  trackRadius: const Radius.circular(10),
                                  trackVisibility: true,
                                  radius: const Radius.circular(10),
                                  thickness: 14,
                                  thumbVisibility: true,
                                  controller: controller,
                                  child: SingleChildScrollView(
                                    controller: controller,
                                    child: Obx(() {
                                      return Column(
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
                                              value: selectAllHeader.value,
                                              onChanged: (value) {
                                                selectAllHeader.value = value!;
                                                selectedHeaderList.clear();
                                                employeeDetailsController
                                                    .selectedHeaderList
                                                    .clear();
                                                if (value) {
                                                  selectedHeaderList.addAll(
                                                      employeeDetailsController
                                                          .headerList);

                                                  for (var i = 0;
                                                      i <
                                                          employeeDetailsController
                                                              .headerList
                                                              .length;
                                                      i++) {
                                                    employeeDetailsController
                                                        .selectedHeaderList
                                                        .add(i);
                                                  }
                                                  logger.d(
                                                      employeeDetailsController
                                                          .selectedHeaderList);
                                                  logger.d(selectedHeaderList);
                                                }
                                              },
                                            ),
                                          ),
                                          Obx(
                                            () => Column(
                                              children: List.generate(
                                                employeeDetailsController
                                                    .headerList.length,
                                                (index) {
                                                  return Obx(
                                                    () => HeaderDataWidget(
                                                      name:
                                                          employeeDetailsController
                                                                  .headerList
                                                                  .elementAt(
                                                                      index)[
                                                              'columnName'],
                                                      id: employeeDetailsController
                                                              .headerList
                                                              .elementAt(index)[
                                                          'columnID'],
                                                      addfunction:
                                                          addToHeaderList,
                                                      removefunction:
                                                          removeFromHeaderList,
                                                      index: index,
                                                      selectAll: RxBool(
                                                          employeeDetailsController
                                                              .selectedHeaderList
                                                              .contains(index)),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -20,
                                left: 14,
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 7),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(235, 253, 255, 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/headericon.png',
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        ' Header',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    50, 185, 202, 1),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 180,
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
                                  thumbColor: Theme.of(context).primaryColor,
                                  trackColor:
                                      const Color.fromRGBO(223, 239, 253, 1),
                                  trackRadius: const Radius.circular(10),
                                  trackVisibility: true,
                                  radius: const Radius.circular(10),
                                  thickness: 14,
                                  thumbVisibility: true,
                                  controller: controller1,
                                  child: employeeDetailsController
                                          .typeList.isNotEmpty
                                      ? SingleChildScrollView(
                                          controller: controller1,
                                          child: Obx(() {
                                            return Column(
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
                                                      'Select all',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .merge(
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.3)),
                                                    ),
                                                    value: selectAllType.value,
                                                    onChanged: (value) {
                                                      selectAllType.value =
                                                          value!;

                                                      multipletype.clear();
                                                      if (value) {
                                                        for (var i = 0;
                                                            i <
                                                                employeeDetailsController
                                                                    .typeList
                                                                    .length;
                                                            i++) {
                                                          multipletype.add(
                                                              employeeDetailsController
                                                                  .typeList
                                                                  .elementAt(i)
                                                                  .hrmgTId!);
                                                        }
                                                        getDepartmentData();
                                                      }
                                                      logger.d(multipletype);
                                                    },
                                                  ),
                                                ),
                                                ...List.generate(
                                                    employeeDetailsController
                                                        .typeList
                                                        .length, (index) {
                                                  return Obx(
                                                    () => DataCardWidget(
                                                      name: employeeDetailsController
                                                          .typeList
                                                          .elementAt(index)
                                                          .hrmgTEmployeeGroupType!,
                                                      id: employeeDetailsController
                                                          .typeList
                                                          .elementAt(index)
                                                          .hrmgTId!,
                                                      addfunction:
                                                          addToMultipleType,
                                                      removefunction:
                                                          removeFromMultipleType,
                                                      selectAll: RxBool(
                                                          multipletype.contains(
                                                              employeeDetailsController
                                                                  .typeList
                                                                  .elementAt(
                                                                      index)
                                                                  .hrmgTId)),
                                                    ),
                                                  );
                                                })
                                              ],
                                            );
                                          }),
                                        )
                                      : const Center(
                                          child: Text(
                                              'No department available for selected types'),
                                        ),
                                ),
                              ),
                              Positioned(
                                top: -20,
                                left: 14,
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 7),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(219, 253, 245, 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/typeicon.png',
                                        color: const Color.fromRGBO(
                                            71, 186, 158, 1),
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        ' Type',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    71, 186, 158, 1),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 180,
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
                                  thumbColor: Theme.of(context).primaryColor,
                                  trackColor:
                                      const Color.fromRGBO(223, 239, 253, 1),
                                  trackRadius: const Radius.circular(10),
                                  trackVisibility: true,
                                  radius: const Radius.circular(10),
                                  thickness: 14,
                                  thumbVisibility: true,
                                  controller: controller2,
                                  child: employeeDetailsController
                                          .isDepartment.value
                                      ? const Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        )
                                      : employeeDetailsController
                                              .departmentList.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: controller2,
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
                                                        'Select all',
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
                                                      value: selectAllDep.value,
                                                      onChanged: (value) {
                                                        selectAllDep.value =
                                                            value!;
                                                        multipledep.clear();
                                                        if (value) {
                                                          for (var i = 0;
                                                              i <
                                                                  employeeDetailsController
                                                                      .departmentList
                                                                      .length;
                                                              i++) {
                                                            multipledep.add(
                                                                employeeDetailsController
                                                                    .departmentList
                                                                    .elementAt(
                                                                        i)
                                                                    .hrmDId!);
                                                          }
                                                          getDesignationData();
                                                        }
                                                        logger.d(multipledep);
                                                      },
                                                    ),
                                                  ),
                                                  ...List.generate(
                                                      employeeDetailsController
                                                          .departmentList
                                                          .length,
                                                      (index) => Obx(
                                                            () => DataCardWidget(
                                                                name: employeeDetailsController
                                                                    .departmentList
                                                                    .elementAt(
                                                                        index)
                                                                    .hrmDDepartmentName!,
                                                                id: employeeDetailsController
                                                                    .departmentList
                                                                    .elementAt(
                                                                        index)
                                                                    .hrmDId,
                                                                addfunction:
                                                                    addToMultipleDepartment,
                                                                removefunction:
                                                                    removeFromMultipleDepartment,
                                                                selectAll: RxBool(multipledep.contains(employeeDetailsController
                                                                    .departmentList
                                                                    .elementAt(
                                                                        index)
                                                                    .hrmDId))),
                                                          ))
                                                ],
                                              ),
                                            )
                                          : const Center(
                                              child: Text(
                                                  'No department available for selected types'),
                                            ),
                                ),
                              ),
                              Positioned(
                                top: -20,
                                left: 14,
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 7),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 235, 234, 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/subjectfielicon.png',
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        ' Department',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    255, 111, 103, 1),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 180,
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
                                  thumbColor: Theme.of(context).primaryColor,
                                  trackColor:
                                      const Color.fromRGBO(223, 239, 253, 1),
                                  trackRadius: const Radius.circular(10),
                                  trackVisibility: true,
                                  radius: const Radius.circular(10),
                                  thickness: 14,
                                  thumbVisibility: true,
                                  controller: controller3,
                                  child: employeeDetailsController
                                          .isDesignation.value
                                      ? const Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        )
                                      : employeeDetailsController
                                              .designationList.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: controller3,
                                              child: Obx(() {
                                                return Column(
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
                                                          'Select all',
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
                                                        value:
                                                            selectAllDes.value,
                                                        onChanged: (value) {
                                                          selectAllDes.value =
                                                              value!;
                                                          multipledes.clear();
                                                          if (value) {
                                                            for (var i = 0;
                                                                i <
                                                                    employeeDetailsController
                                                                        .designationList
                                                                        .length;
                                                                i++) {
                                                              multipledes.add(
                                                                  employeeDetailsController
                                                                      .designationList
                                                                      .elementAt(
                                                                          i)
                                                                      .hrmdeSId!);
                                                            }
                                                          }
                                                          logger.d(multipledes);
                                                        },
                                                      ),
                                                    ),
                                                    ...List.generate(
                                                      employeeDetailsController
                                                          .designationList
                                                          .length,
                                                      (index) => Obx(
                                                        () => DataCardWidget(
                                                            name: employeeDetailsController
                                                                .designationList
                                                                .elementAt(
                                                                    index)
                                                                .hrmdeSDesignationName!,
                                                            id: employeeDetailsController
                                                                .designationList
                                                                .elementAt(
                                                                    index)
                                                                .hrmdeSId,
                                                            addfunction:
                                                                addToMultipleDesignation,
                                                            removefunction:
                                                                removeFromMultipleDesignation,
                                                            selectAll: RxBool(multipledes.contains(
                                                                employeeDetailsController
                                                                    .designationList
                                                                    .elementAt(
                                                                        index)
                                                                    .hrmdeSId))),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                            )
                                          : const Center(
                                              child: Text(
                                                  'No designation available for selected types and department',
                                                  textAlign: TextAlign.center),
                                            ),
                                ),
                              ),
                              Positioned(
                                top: -20,
                                left: 14,
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 7),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(229, 243, 255, 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/selectteachericon.png',
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        ' Designation',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    62, 120, 170, 1),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: CheckboxListTile(
                                  activeColor: Theme.of(context).primaryColor,
                                  dense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    'Left',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                  ),
                                  value: employeeDetailsController.left.value,
                                  onChanged: (value) {
                                    employeeDetailsController
                                        .leftCheckbox(value!);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: CheckboxListTile(
                                  activeColor: Theme.of(context).primaryColor,
                                  dense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    'Working',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                  ),
                                  value:
                                      employeeDetailsController.working.value,
                                  onChanged: (value) {
                                    employeeDetailsController
                                        .workingCheckbox(value!);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromWidth(150),
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 14.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              if (selectedHeaderList.isEmpty) {
                                Fluttertoast.showToast(msg: 'Select header');
                              } else if (multipletype.isEmpty) {
                                Fluttertoast.showToast(msg: 'Select type');
                              } else if (multipledep.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'Select department');
                              } else if (multipledes.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'Select designation');
                              } else {
                                searchEmployeeDetails();
                              }
                            },
                            child: employeeDetailsController.isSearch.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Search',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 0.3,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                  ),
                          )
                        ],
                      ),
              ),
      ),
    );
  }
}
