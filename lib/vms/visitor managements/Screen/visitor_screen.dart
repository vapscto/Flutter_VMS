import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/api/assigned_api.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/api/employee_api.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/api/get_visit_api.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/api/saved_api.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/api/visitor_api.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/employee_model.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/insituional_model.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/visitor_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class VisitorManagementHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const VisitorManagementHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});
  @override
  // ignore: library_private_types_in_public_api
  _VisitorManagementHomeState createState() => _VisitorManagementHomeState();
}

class _VisitorManagementHomeState extends State<VisitorManagementHome> {
  VisitorManagementsController visitorManagementsController =
      Get.put(VisitorManagementsController());
  RxBool meetFlag = RxBool(false);

  InstitutionlistModelValues? selectedcompany;
  VisitorlistModelValues? selectedvisitor;

  int? toMeetId;
  String hours = "";
  String minutes = "";
  @override
  void initState() {
    load(1);
    super.initState();
  }

  load(int id) async {
    await getVisitorManagaementApi(
        base: baseUrlFromInsCode(
            'visitorsmanagementservicehub', widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        controller: visitorManagementsController);
  }

  DateTime? selectedDate;
  final _dateController = TextEditingController();
  final _startTime = TextEditingController();
  TextEditingController remartEt = TextEditingController();
  TextEditingController locationEt = TextEditingController();
  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Assign Visitors").getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => visitorManagementsController
                      .getrequestGetVisitorList.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 300,
                        title: "Loading Visitor Management ",
                        desc: "Please wait while we load Data",
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, right: 0, bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child:
                            DropdownButtonFormField<InstitutionlistModelValues>(
                                value: visitorManagementsController
                                    .getrequestGetVisitorList.first,
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(0, 0, 0, 0),
                                    ),
                                  ),
                                  isDense: true,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                          letterSpacing: 0.3)),
                                  hintText: visitorManagementsController
                                          .getrequestGetVisitorList.isNotEmpty
                                      ? 'select company name'
                                      : "No data available",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: const CustomDropDownLabel(
                                    icon: 'assets/images/hat.png',
                                    containerColor:
                                        Color.fromRGBO(237, 167, 167, 1),
                                    text: 'Company Name',
                                    textColor: Color.fromRGBO(21, 3, 0, 1),
                                  ),
                                ),
                                icon: const Padding(
                                  padding: EdgeInsets.only(top: 3),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                  ),
                                ),
                                iconSize: 35,
                                items: List.generate(
                                    visitorManagementsController
                                        .getrequestGetVisitorList
                                        .length, (index) {
                                  return DropdownMenuItem(
                                    value: visitorManagementsController
                                        .getrequestGetVisitorList[index],
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13, left: 5, bottom: 4),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.4,
                                        child: Text(
                                          visitorManagementsController
                                              .getrequestGetVisitorList
                                              .elementAt(index)
                                              .mIName!,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .merge(const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3)),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                onChanged: (s) async {
                                  await getVisitManagaementApi(
                                      base: baseUrlFromInsCode(
                                          'visitorsmanagementservicehub',
                                          widget.mskoolController),
                                      controller: visitorManagementsController,
                                      miId: s!.mIId!,
                                      userId: widget.loginSuccessModel.userId!);
                                }),
                      ),
                    ),
            ),
            Obx(
              () => visitorManagementsController.getrequestGetVisitList.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, right: 0, bottom: 10),
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
                        child: DropdownButtonFormField<VisitorlistModelValues>(
                          // value: visitorManagementsController.getrequestGetVisitList.first,
                          decoration: InputDecoration(
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
                            isDense: true,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText: visitorManagementsController
                                    .getrequestGetVisitList.isEmpty
                                ? 'Select Visitor'
                                : "No data available",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(10, 4, 182, 1),
                              text: 'Visitor',
                              textColor: Color.fromRGBO(223, 234, 3, 1),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 35,
                          items: List.generate(
                              visitorManagementsController
                                  .getrequestGetVisitList.length, (index) {
                            return DropdownMenuItem(
                              value: visitorManagementsController
                                  .getrequestGetVisitList[index],
                              child: SizedBox(
                                width: 300,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 13, left: 5),
                                  child: SizedBox(
                                    child: Text(
                                      visitorManagementsController
                                          .getrequestGetVisitList
                                          .elementAt(index)
                                          .vmmVVisitorName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                              fontWeight: FontWeight.w100,
                                              fontSize: 14.0,
                                              letterSpacing: 0.3)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            await getAssignedManagaementApi(
                                base: baseUrlFromInsCode(
                                    'visitorsmanagementservicehub',
                                    widget.mskoolController),
                                controller: visitorManagementsController,
                                miId: s!.mIId!,
                                userId: s.userId!,
                                vmmvId: s.vmmVId!);
                            await getemployeeManagaementApi(
                                base: baseUrlFromInsCode(
                                    'visitorsmanagementservicehub',
                                    widget.mskoolController),
                                controller: visitorManagementsController,
                                miId: s.mIId!,
                                userId: s.userId!);
                          },
                        ),
                      ),
                    ),
            ),
            Obx(() => visitorManagementsController
                    .getrequestGetgridoptionList.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomContainer(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Visitor Name: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .vMMVVisitorName,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Meeting Purpose :",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .vMMVMeetingPurpose,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Meeting Date :",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .vMMVMeetingDateTime,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Entry Time :",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .vMMVEntryDateTime
                                      .toString(),
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Meeting Date Time : ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .vMVTMTDateTime,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Assigned By : ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .aSSIGNEDBY,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    )),
                  )),
            Obx(
              () => visitorManagementsController
                      .getrequestGetemployeeList.isEmpty
                  ? const AnimatedProgressWidget(
                      title: "No Data found",
                      desc: "There is no corresponding topic available",
                      animationPath: "assets/json/nodata.json",
                      animatorHeight: 250,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, right: 0, bottom: 10),
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
                        child: DropdownButtonFormField<EmployeelistModelValues>(
                          value: visitorManagementsController
                              .getrequestGetemployeeList.first,
                          decoration: InputDecoration(
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
                            isDense: true,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText: visitorManagementsController
                                    .getrequestGetemployeeList.isEmpty
                                ? 'Select Visitor'
                                : "No data available",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(10, 4, 182, 1),
                              text: 'To Meet',
                              textColor: Color.fromRGBO(223, 234, 3, 1),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 35,
                          items: List.generate(
                              visitorManagementsController
                                  .getrequestGetemployeeList.length, (index) {
                            return DropdownMenuItem(
                              value: visitorManagementsController
                                  .getrequestGetemployeeList[index],
                              child: SizedBox(
                                width: 300,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 13, left: 5),
                                  child: SizedBox(
                                    child: Text(
                                      visitorManagementsController
                                          .getrequestGetemployeeList
                                          .elementAt(index)
                                          .hrmEEmployeeFirstName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                              fontWeight: FontWeight.w100,
                                              fontSize: 14.0,
                                              letterSpacing: 0.3)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            setState(() {
                              toMeetId = s!.hrmEId!;
                            });

                            // await getAssignedManagaementApi(base: "", controller: visitorManagementsController,
                            // miId: s!.mIId!, userId: 0);
                          },
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => Visibility(
                visible: visitorManagementsController
                    .getrequestGetemployeeList.isNotEmpty,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: CustomContainer(
                    child: TextField(
                      controller: _dateController,
                      style: Theme.of(context).textTheme.titleSmall,
                      onTap: () async {
                        selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1000),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(3050));
                        if (selectedDate != null) {
                          _dateController.text =
                              '${numberList[selectedDate!.month]}-${selectedDate!.day}-${selectedDate!.year}';
                        }
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
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/calendar_icon.svg",
                                color: const Color.fromARGB(255, 31, 2, 54),
                                height: 18.0,
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "Meet Time:",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(231, 42, 8, 1),
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
                            color: const Color.fromARGB(255, 210, 246, 6),
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
              ),
            ),
            Obx(
              () => Visibility(
                visible: visitorManagementsController
                    .getrequestGetemployeeList.isNotEmpty,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomContainer(
                            child: TextField(
                              style: Theme.of(context).textTheme.titleSmall,
                              readOnly: true,
                              controller: _startTime,
                              onTap: () async {
                                fromTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    initialEntryMode:
                                        TimePickerEntryMode.dialOnly,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: false),
                                          child: childWidget!);
                                    });

                                if (fromTime != null) {
                                  _startTime.text =
                                      '${numberList[fromTime!.hourOfPeriod]}:${numberList[fromTime!.minute]} ${fromTime!.period.name.toUpperCase()}';
                                  hours = fromTime!.hourOfPeriod.toString();
                                  minutes = fromTime!.minute.toString();
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.watch_later_outlined,
                                  color: Color(0xFF3E78AA),
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
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        color: Color(0xFF3E78AA),
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Start Time ",
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
                                hintText: 'Select Time',
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
                ),
              ),
            ),
            const SizedBox(height: 25),
            Obx(
              () => Visibility(
                visible: visitorManagementsController
                    .getrequestGetemployeeList.isNotEmpty,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomContainer(
                    child: TextField(
                      controller: locationEt,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        label: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 6.0),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    color: Colors.black12)
                              ],
                              borderRadius: BorderRadius.circular(24.0),
                              color: const Color.fromARGB(255, 11, 1, 0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/subjectfielicon.png",
                                height: 24.0,
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "Location:",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                          fontSize: 20.0,
                                          color: Color.fromARGB(
                                              255, 250, 251, 251)),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Enter Your Location',
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
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Visibility(
                visible: visitorManagementsController
                    .getrequestGetemployeeList.isNotEmpty,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: remartEt,
                    maxLines: 6,
                    style: const TextStyle(fontWeight: FontWeight.w100),
                    decoration: InputDecoration(
                      hintText: 'Enter Remarks',
                      hintStyle: const TextStyle(fontWeight: FontWeight.w100),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(08),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => Visibility(
                  visible: visitorManagementsController
                      .getrequestGetemployeeList.isNotEmpty,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: const Color.fromRGBO(14, 17, 240, .9),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: meetFlag.value,
                        onChanged: (value) {
                          meetFlag.value = value!;
                          setState(() {});
                        },
                      ),
                      const Text("Meet Flag"),
                    ],
                  ),
                )),
            Obx(
              () => Visibility(
                visible: visitorManagementsController
                    .getrequestGetemployeeList.isNotEmpty,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: MSkollBtn(
                      size: const Size.fromWidth(100),
                      title: "Save",
                      onPress: () async {
                        if (meetFlag.isFalse) {
                          await getsavedApi(
                                  base: baseUrlFromInsCode(
                                      'visitorsmanagementservicehub',
                                      widget.mskoolController),
                                  controller: visitorManagementsController,
                                  fhrors: hours,
                                  fminutes: minutes,
                                  miId: widget.loginSuccessModel.mIID!,
                                  userId: widget.loginSuccessModel.userId!,
                                  vmmvId: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .vMMVId!,
                                  vmvtmtId: visitorManagementsController
                                      .getrequestGetgridoptionList
                                      .first
                                      .vMVTMTId!,
                                  vmvtmtdate: _dateController.text,
                                  vmvtmtlocation: locationEt.text,
                                  vmvtmtmetflag: meetFlag.value,
                                  vmvtmtremarks: remartEt.text,
                                  vmvtmttomeethrmeId: toMeetId!)
                              .then(
                            (value) {
                              if (value) {
                                Fluttertoast.showToast(msg: "Saved succsfully");
                                Get.back();
                              }
                            },
                          );
                        } else {
                          Fluttertoast.showToast(msg: "Plase select checkbox");
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(100),
                        backgroundColor: const Color.fromRGBO(241, 5, 5, 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Exit",
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.3,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
