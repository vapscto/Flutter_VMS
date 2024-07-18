// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/api/department_api.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/api/dr_aprove_api.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/api/fecth_employe_list.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/department_list.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/designation.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/screen/dr_approval.dart';

import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

import '../api/fetach_user_details.dart';
import '../controller/mc_home_screen.dart';
import '../model/employee_model_list.dart';

class MakerCheckerHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const MakerCheckerHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<MakerCheckerHome> createState() => _MakerCheckerHomeState();
}

class _MakerCheckerHomeState extends State<MakerCheckerHome> {
  MakerCheckerController controller = Get.put(MakerCheckerController());
  List<Map<String, dynamic>> departList = [];
  List<Map<String, dynamic>> emplist = [];
  var todayDate = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  DateTime selecteddate = DateTime.now();
  DateTime? selectedstartdate;
  DateTime? selectedenddate;
  DrDetailsCtrlr drController = Get.put(DrDetailsCtrlr());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int hrmdcId = 0;
  int hrmdesId = 0;
  int hrmeId = 0;
  String? getDate;
  @override
  void initState() {
    load();
    todayDate.text =
        "${selecteddate.year}-${numberList[selecteddate.month]}-${numberList[selecteddate.day]}";

    super.initState();
  }

  load() async {
    int statuscode = await feacthUserApi(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        ivrmrtId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        controller: controller);
    if (statuscode == 200) {
      // hrmdcId = controller.departmentList.first.hRMDCID!;
      departList.clear();
      departList.add({
        "HRMDC_ID": controller.departmentList.first.hRMDCID,
        "HRMDC_Name": controller.departmentList.first.hRMDCName,
        "selected": true
      });
      int statusCode = await feachDesignation(
          base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
          miId: widget.loginSuccessModel.mIID!,
          userId: widget.loginSuccessModel.userId!,
          ivrmrt: widget.loginSuccessModel.roleId!,
          controller: controller,
          list: departList);
      if (statusCode == 200) {
        controller.employeeList.clear();
        emplist.clear();
        emplist.add({
          "HRMDES_DesignationName":
              controller.designationList.first.hRMDESDesignationName!,
          "HRMDES_Id": controller.designationList.first.hRMDESId,
          "MI_Id": controller.designationList.first.mIId,
          "MI_Name": controller.designationList.first.mIName,
          "selected": true
        });
      }
    }
    controller.adavanceListModel.isNotEmpty ||
            controller.applyListModel.isNotEmpty
        ? Get.dialog(
            barrierDismissible: false,
            WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Update Task",
                      // ignore: use_build_context_synchronously
                      style: Theme.of(context).textTheme.titleLarge!.merge(
                          // ignore: use_build_context_synchronously
                          TextStyle(color: Theme.of(context).primaryColor)),
                    )),
                content: SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Kindly Approved TA-DA List, Then only can Approved DR",
                          // ignore: use_build_context_synchronously
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              // ignore: use_build_context_synchronously
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MSkollBtn(
                        title: "Close",
                        onPress: () {
                          Get.back();
                          Get.back();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ))
        : null;
    controller.leaveApproveList.isNotEmpty
        ? Get.dialog(
            barrierDismissible: false,
            WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Update Task",
                      // ignore: use_build_context_synchronously
                      style: Theme.of(context).textTheme.titleLarge!.merge(
                          // ignore: use_build_context_synchronously
                          TextStyle(color: Theme.of(context).primaryColor)),
                    )),
                content: SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Kindly Approved Leaves",
                          // ignore: use_build_context_synchronously
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              // ignore: use_build_context_synchronously
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MSkollBtn(
                        title: "Close",
                        onPress: () {
                          Get.back();
                          Get.back();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ))
        : null;
  }

  DepartmentModelListValues? selecteditem;
  DsgnModelValues? selectDesignation;
  EmployeeModelListValues? selectEmployee;
  final departmentController = TextEditingController();
  final designationController = TextEditingController();
  final employeeController = TextEditingController();
  final SuggestionsBoxController _suggestionsBoxController =
      SuggestionsBoxController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: const CustomGoBackButton(),
          title: const Text(
            "Maker and Checker",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => controller.errorLoading.value
                    ? const Center(
                        child: ErrWidget(
                          err: {
                            "errorTitle": "Unexpected Error Occured",
                            "errorMsg":
                                "While loading company we encountered an error"
                          },
                        ),
                      )
                    : controller.loading.value
                        ? const AnimatedProgressWidget(
                            animationPath: 'assets/json/default.json',
                            title: 'Loading data',
                            desc: "Please wait we are loading data",
                          )
                        : Container(
                            height: 60,
                            margin: const EdgeInsets.only(
                                top: 40, left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child:
                                TypeAheadFormField<DepartmentModelListValues>(
                              validator: (value) {
                                if (value == null) {
                                  return "";
                                }
                                return null;
                              },
                              suggestionsBoxController:
                                  _suggestionsBoxController,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: departmentController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText:
                                        controller.departmentList.isNotEmpty
                                            ? 'Search Department'
                                            : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: const CustomDropDownLabel(
                                      icon: 'assets/images/prof1.png',
                                      containerColor:
                                          Color.fromRGBO(235, 214, 201, 1),
                                      text: 'Department',
                                      textColor: Color.fromRGBO(182, 72, 29, 1),
                                    ),
                                    suffixIcon: (departmentController
                                            .text.isEmpty)
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              departmentController.clear();
                                              employeeController.clear();
                                              designationController.clear();
                                              controller.designationList
                                                  .clear();
                                              hrmdcId = 0;
                                              hrmdesId = 0;
                                              hrmeId = 0;
                                              controller.employeeList.clear();
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return controller.departmentList.where((d) => d
                                    .hRMDCName!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    departmentController.text =
                                        '${suggestion.hRMDCName!} Department';
                                    controller.designationList.clear();
                                    // departList.clear();
                                    hrmdcId = suggestion.hRMDCID!;
                                    departmentController.text =
                                        suggestion.hRMDCName!;

                                    departList.add({
                                      "HRMDC_ID": suggestion.hRMDCID,
                                      "HRMDC_Name": suggestion.hRMDCName,
                                      "selected": true
                                    });
                                    logger.e(departList);
                                    await feachDesignation(
                                        base: baseUrlFromInsCode("issuemanager",
                                            widget.mskoolController),
                                        miId: widget.loginSuccessModel.mIID!,
                                        userId:
                                            widget.loginSuccessModel.userId!,
                                        controller: controller,
                                        ivrmrt:
                                            widget.loginSuccessModel.roleId!,
                                        list: departList);
                                    _suggestionsBoxController.close();
                                    setState(() {});
                                  },
                                  title: Text(
                                    '${suggestion.hRMDCName!} Department',
                                    style: Get.textTheme.titleSmall,
                                  ),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  selecteditem = suggestion;
                                });
                              },
                              noItemsFoundBuilder: (context) {
                                return const SizedBox();
                              },
                            ),
                          ),
              ),
              Obx(
                () => controller.dsgloading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.designationList.isNotEmpty
                        ? Container(
                            height: 60,
                            margin: const EdgeInsets.only(
                                top: 20, left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: TypeAheadFormField<DsgnModelValues>(
                              validator: (value) {
                                if (value == null) {
                                  return "";
                                }
                                return null;
                              },
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: designationController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText:
                                        controller.designationList.isNotEmpty
                                            ? 'Search Designation'
                                            : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: const CustomDropDownLabel(
                                      icon: 'assets/images/prof2.png',
                                      containerColor:
                                          Color.fromRGBO(223, 251, 254, 1),
                                      text: 'Designation',
                                      textColor:
                                          Color.fromRGBO(40, 182, 200, 1),
                                    ),
                                    suffixIcon: (designationController
                                            .text.isEmpty)
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              hrmdesId = 0;
                                              hrmeId = 0;
                                              designationController.clear();
                                              controller.employeeList.clear();
                                              employeeController.clear();
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return controller.designationList.where((d) => d
                                    .hRMDESDesignationName!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    emplist.clear();
                                    hrmdesId = suggestion.hRMDESId!;
                                    designationController.text =
                                        '${suggestion.hRMDESDesignationName!}:${suggestion.mIName}';
                                    emplist.add({
                                      "HRMDES_DesignationName":
                                          suggestion.hRMDESDesignationName!,
                                      "HRMDES_Id": suggestion.hRMDESId,
                                      "MI_Id": suggestion.mIId,
                                      "MI_Name": suggestion.mIName,
                                      "selected": true
                                    });
                                    await feachEmpolyee(
                                        base: baseUrlFromInsCode("issuemanager",
                                            widget.mskoolController),
                                        userId:
                                            widget.loginSuccessModel.userId!,
                                        miId: widget.loginSuccessModel.mIID!,
                                        ivrmrtId:
                                            widget.loginSuccessModel.roleId!,
                                        controller: controller,
                                        list: emplist);
                                    setState(() {});
                                  },
                                  title: Text(
                                    '${suggestion.hRMDESDesignationName!} :${suggestion.mIName}',
                                    style: Get.textTheme.titleSmall,
                                  ),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  selectDesignation = suggestion;
                                });
                              },
                              noItemsFoundBuilder: (context) {
                                return const SizedBox();
                              },
                            ),
                          )
                        : const SizedBox(),
              ),
              Obx(
                () => controller.emloading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.employeeList.isNotEmpty
                        ? Container(
                            height: 60,
                            margin: const EdgeInsets.only(
                                top: 20, left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: TypeAheadFormField<EmployeeModelListValues>(
                              validator: (value) {
                                if (value == null) {
                                  return "";
                                }
                                return null;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: employeeController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: controller.employeeList.isNotEmpty
                                        ? 'Search Employee'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: const CustomDropDownLabel(
                                      icon: 'assets/images/prof4.png',
                                      containerColor:
                                          Color.fromRGBO(212, 194, 247, 1),
                                      text: 'Employee',
                                      textColor:
                                          Color.fromRGBO(107, 51, 196, 1),
                                    ),
                                    suffixIcon:
                                        (employeeController.text.isEmpty)
                                            ? const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                                size: 30,
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    employeeController.clear();
                                                    hrmeId = 0;
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return controller.employeeList.where((d) => d
                                    .userEmpName!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () {
                                    employeeController.text =
                                        '${suggestion.userEmpName!}:${suggestion.hRMDDepartmentName}';
                                    hrmeId = suggestion.hRMEId!;
                                    logger.d(hrmeId);
                                    setState(() {});
                                  },
                                  title: Text(
                                    '${suggestion.userEmpName!}:${suggestion.hRMDDepartmentName}',
                                    style: Get.textTheme.titleSmall,
                                  ),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  selectEmployee = suggestion;
                                });
                              },
                              noItemsFoundBuilder: (context) {
                                return const SizedBox();
                              },
                            ),
                          )
                        : const SizedBox(),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                child: CustomContainer(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: todayDate,
                    onTap: () async {
                      showDatePicker(
                        context: context,
                        initialDate: selecteddate,
                        selectableDayPredicate: (DateTime date) {
                          if (date.weekday == DateTime.sunday) {
                            return false;
                          }
                          return true;
                        },
                        firstDate: DateTime(DateTime.now().year - 15),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          selecteddate = value;
                          setState(() {
                            todayDate.text =
                                "${selecteddate.year}-${numberList[selecteddate.month]}-${numberList[selecteddate.day]}";

                            getDateNeed(selecteddate);
                          });
                        } else {
                          Fluttertoast.showToast(msg: "Please select date");
                        }
                      });
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(229, 243, 255, 1),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/calendar_icon.svg",
                              color: const Color(0xFF3E78AA),
                              height: 18.0,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              " Select Date ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(62, 120, 170, 1),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Select date.'.tr,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/svg/calendar_icon.svg",
                          color: const Color(0xFF3E78AA),
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    readOnly: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    drController.sList.clear();

                    if (_formKey.currentState!.validate()) {
                      if (hrmdcId == 0) {
                        Fluttertoast.showToast(msg: "Select Department");
                        return;
                      } else if (hrmdesId == 0) {
                        Fluttertoast.showToast(msg: "Select Designation");
                        return;
                      } else if (hrmeId == 0) {
                        Fluttertoast.showToast(msg: "Select Employee");
                        return;
                      } else {
                        int goto = await getdrLists(
                          roleId: widget.loginSuccessModel.roleId!,
                          miId: widget.loginSuccessModel.mIID!,
                          userId: widget.loginSuccessModel.userId!,
                          base: baseUrlFromInsCode(
                              'issuemanager', widget.mskoolController),
                          hrmdcId: hrmdcId,
                          hrmdesId: hrmdesId,
                          hrmeId: hrmeId,
                          date: todayDate.text.toString(),
                          controller: drController,
                        );
                        if (goto == 200) {
                          Get.to(() => DRApprovalScreen(
                                loginSuccessModel: widget.loginSuccessModel,
                                mskoolController: widget.mskoolController,
                                date: getDateNeed(selecteddate),
                              ));
                        }
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Please select field");
                    }
                  },
                  child: const Text("Search"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDateNeed(DateTime dt) {
    return "${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}-${dt.year}";
  }
}
