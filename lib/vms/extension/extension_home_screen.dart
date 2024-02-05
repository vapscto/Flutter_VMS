import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/extension/api/employee_list_api.dart';
import 'package:m_skool_flutter/vms/extension/controller/extension_controller.dart';
import 'package:m_skool_flutter/vms/extension/extension_details.dart';
import 'package:m_skool_flutter/vms/extension/model/extension_employee_model.dart';
import 'package:m_skool_flutter/vms/extension/model/extension_month_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class ExtensionHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const ExtensionHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<ExtensionHomeScreen> createState() => _ExtensionHomeScreenState();
}

class _ExtensionHomeScreenState extends State<ExtensionHomeScreen> {
  ExtensionController controller = Get.put(ExtensionController());
  List<String> listValues = ['Planner', 'Daily Report'];
  String groupValue = 'P';

  final employeeController = TextEditingController();
  ExtensionEmployeeModelValues? selectedEmployee;
  int hrmeId = 0;
  DateTime? fromDate;
  DateTime? toDate;
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final reasonController = TextEditingController();
  final dayController = TextEditingController();
  ExtensionMonthModelValues? selectedMonth;
  _loadData() async {
    controller.employeeList.clear();
    controller.monthsList.clear();
    controller.extensionDrList.clear();
    controller.extensionPlannerList.clear();
    controller.employeeLoading(true);
    await ExtensionAPI.instance.extensionAPI(
        controller: controller,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        roleId: widget.loginSuccessModel.roleId!);
    controller.employeeLoading(false);
  }

  saveData(Map<String, dynamic> data) async {
    controller.approve(true);
    await ApproveAPI.a.approveAPI(
        controller: controller,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: data);
    controller.approve(false);
    Get.back();
  }

  int day = 0;
  int dayCount(DateTime from, DateTime to) {
    return to.difference(from).inDays + 1;
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          Text(
            "Give ${widget.title}",
            style: Get.textTheme.titleMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 6),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.indigo)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(listValues.length, (index) {
                return Expanded(
                  child: Theme(
                    data: ThemeData(
                        unselectedWidgetColor: Theme.of(context).primaryColor),
                    child: RadioListTile(
                        title: Text(
                          listValues[index],
                          style: Get.textTheme.titleSmall,
                        ),
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        contentPadding: EdgeInsets.zero,
                        activeColor: Theme.of(context).primaryColor,
                        value: (listValues[index] == 'Planner') ? 'P' : 'D',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                            logger.i(groupValue);
                            _startDate.clear();
                            _endDate.clear();
                            _loadData();
                            hrmeId = 0;
                            reasonController.clear();
                            employeeController.clear();
                          });
                        }),
                  ),
                );
              }),
            ),
          ),
          Obx(
            () => controller.isEmployeeLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.employeeList.isNotEmpty
                    ? Container(
                        height: 60,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: TypeAheadFormField<ExtensionEmployeeModelValues>(
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
                                    .copyWith(color: Colors.grey, fontSize: 14),
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
                                  textColor: Color.fromRGBO(107, 51, 196, 1),
                                ),
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 30,
                                )),
                          ),
                          suggestionsCallback: (pattern) {
                            return controller.employeeList.where((fruit) =>
                                fruit.employeeName!
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              onTap: () {
                                employeeController.text =
                                    '${suggestion.employeeName!}:${suggestion.hRMDDepartmentName}';
                                hrmeId = suggestion.hRMEId!;
                                logger.d(hrmeId);
                              },
                              title: Text(
                                '${suggestion.employeeName!}:${suggestion.hRMDDepartmentName}',
                                style: Get.textTheme.titleSmall,
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            setState(() {
                              selectedEmployee = suggestion;
                            });
                          },
                          noItemsFoundBuilder: (context) {
                            return const SizedBox();
                          },
                        ),
                      )
                    : const SizedBox(),
          ),
          (groupValue == 'P')
              ? Padding(
                  padding: const EdgeInsets.only(top: 30.0),
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
                                helpText: "Select From Data",
                                firstDate: DateTime(2000),
                                initialDate: DateTime.now(),
                                lastDate: DateTime(3050),
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
                                    helpText: "Select From Data",
                                    context: context,
                                    firstDate: DateTime(2000),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(3050),
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
                              if (fromDate != null) {
                                toDate = await showDatePicker(
                                  context: context,
                                  helpText: "Select To Date",
                                  firstDate: fromDate!,
                                  initialDate: fromDate!,
                                  lastDate: DateTime(3050),
                                );
                                if (toDate != null) {
                                  _endDate.text =
                                      "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                  day = dayCount(fromDate!, toDate!);
                                  setState(() {});
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
                                  if (fromDate != null) {
                                    toDate = await showDatePicker(
                                      context: context,
                                      helpText: "Select To Date",
                                      firstDate: fromDate!,
                                      initialDate: fromDate!,
                                      lastDate: DateTime(3050),
                                      fieldHintText: 'Date:Month:Year',
                                    );
                                    if (toDate != null) {
                                      _endDate.text =
                                          "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                      day = dayCount(fromDate!, toDate!);
                                      setState(() {});
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
                )
              : Obx(() => controller.monthsList.isEmpty
                  ? const SizedBox()
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 8,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<
                              ExtensionMonthModelValues>(
                            validator: (value) {
                              if (value == null) {
                                return "";
                              }
                              return null;
                            },
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
                                  .labelSmall!
                                  .merge(const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                      letterSpacing: 0.3)),
                              hintText: controller.monthsList.isNotEmpty
                                  ? 'Select Month'
                                  : 'No data available',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              isDense: true,
                              label: const CustomDropDownLabel(
                                icon: 'assets/images/hat.png',
                                containerColor:
                                    Color.fromRGBO(223, 251, 254, 1),
                                text: 'Month',
                                textColor: Color.fromRGBO(40, 182, 200, 1),
                              ),
                            ),
                            icon: const Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              ),
                            ),
                            iconSize: 30,
                            items: List.generate(controller.monthsList.length,
                                (index) {
                              return DropdownMenuItem(
                                value: controller.monthsList[index],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 13, left: 5),
                                  child: Text(
                                    overflow: TextOverflow.clip,
                                    controller.monthsList[index].ivrMMonthName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.0,
                                            letterSpacing: 0.3)),
                                  ),
                                ),
                              );
                            }),
                            onChanged: (s) async {
                              selectedMonth = s;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: CustomContainer(
                            child: SizedBox(
                              height: 60,
                              child: TextField(
                                style: Theme.of(context).textTheme.titleSmall,
                                keyboardType: TextInputType.number,
                                controller: dayController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      top: 10.0, left: 12),
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
                                          "assets/svg/class_.svg",
                                          color: const Color(0xFF3E78AA),
                                          height: 18,
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          "No. of Days",
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
                                  hintText: 'No. of Days',
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
                        ),
                      ],
                    )),
          (_endDate.text.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Total Days:- $day",
                      style: Get.textTheme.titleMedium!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              : const SizedBox(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CustomContainer(
              child: TextFormField(
                controller: reasonController,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                style: Get.textTheme.titleSmall!.copyWith(fontSize: 15),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Reason",
                  label: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFFBFE),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/cap.png",
                          height: 28.0,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Reason",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                    backgroundColor: Color(0xFFDFFBFE),
                                    fontSize: 20.0,
                                    color: Color(0xFF28B6C8)),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(() {
            return Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTileTheme(
                      horizontalTitleGap: 2,
                      child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity:
                              const VisualDensity(vertical: 0, horizontal: -4),
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          checkColor: Theme.of(context).primaryColor,
                          title: Text(
                            "Notification",
                            style: Get.textTheme.titleSmall,
                          ),
                          contentPadding: EdgeInsets.zero,
                          value: notification.value,
                          onChanged: (v) {
                            notification.value = v!;
                          }),
                    ),
                  ),
                  Expanded(
                    child: ListTileTheme(
                      horizontalTitleGap: 2,
                      child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity:
                              const VisualDensity(vertical: 0, horizontal: -4),
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          checkColor: Theme.of(context).primaryColor,
                          title: Text(
                            "Email",
                            style: Get.textTheme.titleSmall,
                          ),
                          contentPadding: EdgeInsets.zero,
                          value: email.value,
                          onChanged: (v) {
                            email.value = v!;
                          }),
                    ),
                  ),
                ],
              ),
            );
          }),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: (controller.isApprove.value)
                    ? const CircularProgressIndicator()
                    : MSkollBtn(
                        title: "Approve",
                        onPress: () {
                          if (groupValue == 'P') {
                            if (hrmeId == 0) {
                              Fluttertoast.showToast(msg: "Select Employee");
                              return;
                            } else if (_endDate.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Select Data");
                              return;
                            } else if (reasonController.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Enter Reason");
                            } else {
                              saveData({
                                "UserId": widget.loginSuccessModel.userId,
                                "ExtensionType": groupValue,
                                "HRME_Id": hrmeId,
                                "ISMPLE_FromDate": fromDate!.toIso8601String(),
                                "ISMPLE_ToDate": toDate!.toIso8601String(),
                                "ISMPLE_Reason": reasonController.text,
                                "notifi_chk": notification.value,
                                "email_chk": email.value,
                              });
                            }
                          } else if (groupValue == 'D') {
                            if (hrmeId == 0) {
                              Fluttertoast.showToast(msg: "Select Employee");
                              return;
                            } else if (selectedMonth == null) {
                              Fluttertoast.showToast(msg: "Select Month");
                              return;
                            } else if (dayController.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Enter Days");
                              return;
                            } else if (reasonController.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Enter Reason");
                              return;
                            } else {
                              saveData({
                                "UserId": widget.loginSuccessModel.userId,
                                "ExtensionType": groupValue,
                                "HRME_Id": hrmeId,
                                "IVRM_Month_Id": selectedMonth!.ivrMMonthId!,
                                "ismodE_Noofdays":
                                    int.parse(dayController.text),
                                "ISMODE_Reason": reasonController.text,
                                "notifi_chk": notification.value,
                                "email_chk": email.value,
                              });
                            }
                          }
                        }),
              ),
            );
          }),
          Obx(() {
            return (controller.isEmployeeLoading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () {
                          logger.i("click");
                          moveToNextScreen();
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.title} Details",
                                  style: Get.textTheme.titleMedium!.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
          }),
        ],
      ),
    );
  }

  bool isLoading = false;
  RxBool notification = RxBool(true);
  RxBool email = RxBool(false);
  void moveToNextScreen() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 10));
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExtensionDetails(
                controller: controller,
              )),
    );

    setState(() {
      isLoading = false;
    });
  }
}
