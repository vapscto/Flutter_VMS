import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  ExtensionMonthModelValues? selectedMonth;
  _loadData() async {
    controller.employeeLoading(true);
    await ExtensionAPI.instance.extensionAPI(
        controller: controller,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        roleId: widget.loginSuccessModel.roleId!);
    controller.employeeLoading(false);
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
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownSearch<ExtensionEmployeeModelValues>(
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          dropdownButtonProps: const IconButtonProps(
                              icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.black,
                          )),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            textStyle: const TextStyle(fontSize: 14),
                            fit: FlexFit.loose,
                            menuProps: MenuProps(
                                textStyle: const TextStyle(fontSize: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            loadingBuilder: (context, searchEntry) {
                              return const CircularProgressIndicator();
                            },
                            searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(6),
                                  hintText: 'Select Employee',
                                  hintStyle: Get.textTheme.titleSmall!
                                      .copyWith(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                ),
                                controller: employeeController,
                                style: Get.textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w400)),
                            scrollbarProps: const ScrollbarProps(
                              thickness: 1,
                            ),
                          ),
                          dropdownSearchTextStyle: Get.textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w400),
                          dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Employee',
                              hintStyle: Get.textTheme.titleSmall!
                                  .copyWith(fontWeight: FontWeight.w400),
                              label: const CustomDropDownLabel(
                                icon: 'assets/images/prof4.png',
                                containerColor:
                                    Color.fromRGBO(212, 194, 247, 1),
                                text: 'Employee',
                                textColor: Color.fromRGBO(107, 51, 196, 1),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                          dropdownSearchTextAlign: TextAlign.start,
                          items: controller.employeeList,
                          itemAsString: (item) =>
                              "${item.employeeName!}:${item.hRMDDepartmentName}",
                          onChanged: (s) async {
                            hrmeId = s!.hRMEId!;
                          },
                          selectedItem: selectedEmployee,
                        ))
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
                  : Container(
                      margin: const EdgeInsets.only(top: 30),
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
                      child: DropdownButtonFormField<ExtensionMonthModelValues>(
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
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
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
                              padding: const EdgeInsets.only(top: 13, left: 5),
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
                    )),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: MSkollBtn(title: "Approve", onPress: () {}),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => ExtensionDetails(
                    controller: controller,
                  ));
            },
            child: Row(
              children: [
                Text(
                  "${widget.title} Details",
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
