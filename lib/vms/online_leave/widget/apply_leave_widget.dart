import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/online_leave/api/get_leaves_name.dart';
import 'package:m_skool_flutter/vms/online_leave/api/ol_featch_api.dart';
import 'package:m_skool_flutter/vms/online_leave/api/save_leave_application.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_count_model.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_name_model.dart';
import 'package:m_skool_flutter/vms/online_leave/model/optional_leave_model.dart';
import 'package:m_skool_flutter/vms/online_leave/model/staff_list_model.dart';
import 'package:m_skool_flutter/vms/online_leave/widget/leave_attachment.dart';
import 'package:m_skool_flutter/vms/profile/api/profile_api.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/sava_task.dart';
import 'package:m_skool_flutter/vms/utils/saveImage.dart';
import 'package:m_skool_flutter/vms/utils/showDatePicker.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class ApplyLeaveWidget extends StatefulWidget {
  final LeaveNamesModelValues values;
  final Color color;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ApplyLeaveWidget({
    Key? key,
    required this.values,
    required this.color,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  @override
  State<ApplyLeaveWidget> createState() => _ApplyLeaveWidgetState();
}

class _ApplyLeaveWidgetState extends State<ApplyLeaveWidget> {
  OpetionLeaveController controllerOL = Get.put(OpetionLeaveController());
  var addleave = 0;
  ProfileController profileController = Get.put(ProfileController());

  StaffPrevilegeListModelValues? selectedEmployee;
  _getProfileData() async {
    profileController.profileLoading(true);
    await ProfileAPI.instance.profileData(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        profileController: profileController,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        roleId: widget.loginSuccessModel.roleId!);
    phone.text =
        profileController.profileDataValue.first.hRMEMobileNo.toString();
    profileController.profileLoading(false);
  }

  @override
  void initState() {
    olLoad();
    _getProfileData();
    getleaveDate();
    setState(() {});
    super.initState();
  }

  final TextEditingController reason = TextEditingController();

  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController reportingDate = TextEditingController();
  DateTime startDT = DateTime.now();
  DateTime endDT = DateTime.now();
  DateTime reportingDT = DateTime.now();
  RxString totalDay = RxString("0");
  DateTime currentDate = DateTime.now();
  DateTime initialDt = DateTime.now();
  DateTime firstDt = DateTime.now();
  DateTime lastDt = DateTime.now();
  DateTime initialDt2 = DateTime.now();
  DateTime firstDt2 = DateTime.now();
  DateTime lastDt2 = DateTime.now();
  int max = 0;
  int min = 0;
  int transationLeave = 0;

  getleaveDate() {
    max = widget.values.hrmLMaxLeavesApplyPerMonth;
    min = widget.values.hrmLNoOfDays.round();
    transationLeave = widget.values.hrelSTransLeaves.round();
    if (widget.values.hrmLWhenToApplyFlg == "Both") {
      firstDt = currentDate.subtract(Duration(days: min));
      initialDt = currentDate;
      lastDt = currentDate.add(Duration(days: min));
    } else if (widget.values.hrmLWhenToApplyFlg == "After") {
      if (widget.values.hrmLLeaveCode == "SL") {
        initialDt = currentDate.subtract(Duration(days: min));
        firstDt = currentDate.subtract(Duration(days: min));
        lastDt = currentDate.subtract(Duration(days: 1));
      } else if (widget.values.hrmLLeaveCode == "EL") {
        initialDt = currentDate.subtract(Duration(days: min));
        firstDt = currentDate.subtract(Duration(days: min));
        lastDt = currentDate.subtract(Duration(days: transationLeave));
      } else {
        initialDt = currentDate.subtract(Duration(days: min));
        firstDt = currentDate.subtract(const Duration(days: 30));
        lastDt = currentDate.subtract(Duration(days: min));
      }
    } else if (widget.values.hrmLWhenToApplyFlg == "Before") {
      if (widget.values.hrmLLeaveCode == "SL") {
        initialDt = currentDate.add(Duration(days: min));
        firstDt = currentDate.add(Duration(days: min));
        lastDt = currentDate.add(Duration(days: 1));
      } else if (widget.values.hrmLLeaveCode == "EL") {
        initialDt = currentDate.add(Duration(days: transationLeave));
        firstDt = currentDate.add(Duration(days: min));
        lastDt = currentDate.add(Duration(days: min));
      } else {
        initialDt = currentDate.add(Duration(days: min));
        firstDt = currentDate.add(Duration(days: min));
        lastDt = currentDate.add(const Duration(days: 30));
      }
    }
  }

  getEndDate(DateTime date) {
    logger.e(max);
    firstDt2 = date;
    initialDt2 = date;
    if (widget.values.hrmLLeaveCode == "SL") {
      if (date.day == currentDate.day - 1) {
        lastDt2 = date;
      } else if (date.day == currentDate.day - 2) {
        lastDt2 = date.add(Duration(days: max - 2));
      } else {
        lastDt2 = date.add(Duration(days: max - 1));
      }
    } else if (int.parse(widget.values.hrelSCBLeaves.round().toString()) >
        max) {
      lastDt2 = date.add(Duration(days: max - 1));
      logger.i(lastDt2);
    } else if (widget.values.hrelSCBLeaves == 0.5) {
      lastDt2 = date;
    } else {
      lastDt2 = date.add(Duration(days: widget.values.hrelSCBLeaves!.round()));
      logger.i(lastDt2);
    }
    if (widget.values.hrmLLeaveCode == "PL") {
      lastDt2 = date.add(Duration(days: max - 1));
    }
  }

  _getleaveCount(String date) async {
    await GetLeaveCountApi.instance.getLeavesCount(
        base: baseUrlFromInsCode('leave', widget.mskoolController),
        data: {
          "HRELAP_FromDate": date,
          "HRML_Id": widget.values.hrmLId,
          "MI_Id": widget.loginSuccessModel.mIID!,
          "UserId": widget.loginSuccessModel.userId!
        },
        opetionLeaveController: controllerOL);
  }

  var newDate = '';
  olLoad() async {
    await getOptionalLeave(
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode('leave', widget.mskoolController),
        controller: controllerOL,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);
  }

  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    RxBool isHalfDay = RxBool(false);
    return Column(
      children: [
        CustomContainer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.2),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    )),
                child: Text(
                  "${widget.values.hrmLLeaveName}",
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        TextStyle(
                          color: widget.color,
                        ),
                      ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      child: TextField(
                        controller: reason,
                        style: Theme.of(context).textTheme.titleSmall,
                        //maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 48.0, left: 12),
                          border: const OutlineInputBorder(),
                          label: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: const Color(0xFFDFFBFE)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/images/reason.png",
                                  color: const Color(0xFF28B6C8),
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  " Reason for Leave ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFF28B6C8)),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter reason here.',
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
                    const SizedBox(
                      height: 32.0,
                    ),
                    CustomContainer(
                      child: TextField(
                        controller: phone,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLength: 10,
                        //maxLines: 4,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          counter: const SizedBox(),
                          contentPadding:
                              const EdgeInsets.only(top: 48.0, left: 12),
                          border: const OutlineInputBorder(),
                          label: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: const Color(0xFFDBFDF5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/phone.svg",
                                  color: const Color(0xFF47BA9E),
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  " Mobile Number ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF47BA9E),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter Phone Number.',
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
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (startDate.text.isEmpty) {
                                      endDT = DateTime(DateTime.now().year + 1);
                                    }
                                    //first
                                    DateTime? date = await showDatePickerLeave(
                                      context: context,
                                      initialDate: initialDt,
                                      firstDate: firstDt,
                                      lastDate: lastDt,
                                    );
                                    if (date == null) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "You didn't selected start date");
                                      return;
                                    }
                                    setState(() {
                                      _getleaveCount(
                                          '${date.year}-${date.month}-${date.day}');
                                    });

                                    if (controllerOL.totalLeaveCount.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Leave is not added for this academic year");
                                      return;
                                    }

                                    getEndDate(date);
                                    startDT = date;
                                    startDate.text =
                                        "${date.day}-${date.month}-${date.year}";
                                    if (widget.values.hrmLLeaveCode == "OL") {
                                      for (int i = 0;
                                          i <
                                              controllerOL
                                                  .optionalLeaveList.length;
                                          i++) {
                                        newDate = controllerOL
                                            .optionalLeaveList[i]
                                            .fOMHWDDFromDate!;
                                      }
                                      if (newDate.contains(
                                          "${date.year}-${date.month}-${date.day}T00:00:00")) {
                                      } else {
                                        Get.back();
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: ContinuousRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              content: SizedBox(
                                                height: 150,
                                                child: Center(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            " Selected Date Is  Not Have Optional Holiday",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .merge(const TextStyle(
                                                                    fontSize:
                                                                        24,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            7,
                                                                            85,
                                                                            255)))),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        MSkollBtn(
                                                          title: " OK ",
                                                          onPress: () {
                                                            startDate.clear();
                                                            endDate.clear();
                                                            Get.back();
                                                            Get.back();
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/svg/calendar_icon.svg',
                                    color: const Color(0xFF3E78AA),
                                    height: 22.0,
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(top: 48.0, left: 12),
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
                                hintText: ' Select Date ',
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
                              controller: endDate,
                              style: Theme.of(context).textTheme.titleSmall,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.only(top: 48.0, left: 12),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (startDate.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please select start date first");
                                      return;
                                    }
                                    endDT = startDT;
                                    //second
                                    DateTime? end = await showDatePickerLeave(
                                      context: context,
                                      initialDate: initialDt2,
                                      firstDate: firstDt2,
                                      lastDate: lastDt2,
                                    );

                                    if (end == null) {
                                      Fluttertoast.showToast(
                                          msg: "Please select end date");
                                      return;
                                    }

                                    endDT = end;
                                    endDate.text =
                                        "${end.day}-${end.month}-${end.year}";
                                    reportingDate.text =
                                        "${end.day + 1}-${end.month}-${end.year}";
                                    Duration difference =
                                        endDT.difference(startDT);
                                    totalDay.value = "${difference.inDays + 1}";
                                    double count1 =
                                        double.tryParse(totalDay.value)! +
                                            widget.values.appliedCount;
                                    if (widget.values.hrmLLeaveName ==
                                        'Privilege Leave') {
                                      if ((difference.inDays + 1) < 4 &&
                                          widget.values.hrmLLeaveCode == "PL") {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  height: 200,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      shape:
                                                          BoxShape.rectangle),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "You Can Not Apply Privilage Leave Less Then 4 Days",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .merge(const TextStyle(
                                                                  fontSize: 24,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          7,
                                                                          85,
                                                                          255)))),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      MSkollBtn(
                                                        title: " OK ",
                                                        onPress: () {
                                                          totalDay.value = '0';
                                                          reportingDate.clear();
                                                          startDate.clear();
                                                          endDate.clear();
                                                          Get.back();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                    }
                                    if (count1 >
                                        widget.values.hrelSTotalLeaves!) {
                                      logger.i(true);
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                height: 200,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    shape: BoxShape.rectangle),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text("Insufficient Leave",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .merge(const TextStyle(
                                                                fontSize: 24,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        7,
                                                                        85,
                                                                        255)))),
                                                    Text(" Balance",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .merge(const TextStyle(
                                                                fontSize: 24,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        7,
                                                                        85,
                                                                        255)))),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    MSkollBtn(
                                                      title: " OK ",
                                                      onPress: () {
                                                        totalDay.value = '0';
                                                        reportingDate.clear();
                                                        startDate.clear();
                                                        endDate.clear();
                                                        Get.back();
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                      // }
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/svg/calendar_icon.svg',
                                    color: const Color(0xFF3E78AA),
                                    height: 22.0,
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
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "No of days : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(
                                      TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .color,
                                      ),
                                    ),
                              ),
                              Obx(() {
                                return Text(totalDay.value);
                              })
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 38,
                            // padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(24.0),
                                boxShadow: CustomThemeData.getShadow()),
                            child: Row(
                              children: [
                                Expanded(child: Obx(() {
                                  return InkWell(
                                    onTap: () {
                                      if (startDate.text.isEmpty ||
                                          endDate.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Please provide leave days");
                                        return;
                                      }
                                      if (endDT.difference(startDT).inDays >=
                                          1) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "You can't apply for half day, because you are applying for more than 1 day");
                                        return;
                                      }
                                      var difference =
                                          endDT.difference(startDT).inDays + 1;
                                      isHalfDay.value = true;
                                      totalDay.value = "${difference / 2}";
                                    },
                                    child: AnimatedContainer(
                                        alignment: Alignment.center,
                                        height: 38,
                                        padding: const EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          color: isHalfDay.value
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        duration:
                                            const Duration(microseconds: 300),
                                        child: Text(
                                          "Half Day",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isHalfDay.value
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .color,
                                          ),
                                        )),
                                  );
                                })),
                                Expanded(
                                  child: Obx(() {
                                    return InkWell(
                                      onTap: () {
                                        if (startDate.text.isEmpty ||
                                            endDate.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "Please provide leave days");
                                          return;
                                        }
                                        isHalfDay.value = false;
                                        totalDay.value =
                                            "${endDT.difference(startDT).inDays + 1}";
                                      },
                                      child: AnimatedContainer(
                                        height: 38.0,
                                        curve: Curves.easeInOut,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          color: isHalfDay.value
                                              ? Colors.transparent
                                              : Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        duration:
                                            const Duration(microseconds: 300),
                                        child: Text(
                                          "Full Day",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: isHalfDay.value
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .color
                                                  : Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    CustomContainer(
                      child: TextField(
                        readOnly: true,
                        controller: reportingDate,
                        style: Theme.of(context).textTheme.titleSmall,

                        //maxLines: 4,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.only(top: 48.0, left: 12),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (endDate.text.isEmpty ||
                                  startDate.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg:
                                        "You didn't selected either of them start date or end date");
                                return;
                              }

                              DateTime? reporting = await showDatePicker(
                                  context: context,
                                  initialDate: endDT,
                                  firstDate: endDT,
                                  lastDate: DateTime(DateTime.now().year + 1));

                              if (reporting == null) {
                                Fluttertoast.showToast(
                                    msg: "You didn't selected ");
                                return;
                              }
                              reportingDT = reporting;
                              reportingDate.text =
                                  "${reporting.day}-${reporting.month}-${reporting.year}";
                            },
                            icon: SvgPicture.asset(
                              'assets/svg/calendar_icon.svg',
                              color: const Color(0xFFDE53E1),
                              height: 22.0,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          label: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: const Color(0xFFFFEDFF)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/calendar_icon.svg",
                                  color: const Color(0xFFDE53E1),
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  " Reporting Date ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFFDE53E1),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Select Date',
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
                  ],
                ),
              ),
            ],
          ),
        ),
        widget.values.hrmLLeaveCode == "PL"
            ? Container(
                margin: const EdgeInsets.only(
                    top: 30, left: 0, right: 0, bottom: 0),
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
                child: DropdownButtonFormField<StaffPrevilegeListModelValues>(
                  // value: selectedEmployee,
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
                    hintStyle: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            letterSpacing: 0.3)),
                    hintText: controllerOL.employeeList.isNotEmpty
                        ? 'Select Employee'
                        : 'No data available',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    isDense: true,
                    label: const CustomDropDownLabel(
                      icon: 'assets/images/ClassTeacher.png',
                      containerColor: Color.fromRGBO(250, 238, 253, 1),
                      text: 'Select Employee',
                      textColor: Color.fromRGBO(146, 79, 190, 1),
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
                  items:
                      List.generate(controllerOL.employeeList.length, (index) {
                    final employee = controllerOL.employeeList[index];
                    return DropdownMenuItem(
                      value: employee,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, left: 5),
                        child: Text(
                          controllerOL
                              .employeeList[index].hRMEEmployeeFirstName!,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    );
                  }),
                  onChanged: (s) {
                    setState(() {
                      selectedEmployee = s;
                    });

                    // selectedEmployee = s;
                  },
                ),
              )
            : SizedBox(),
        const SizedBox(
          height: 20,
        ),
        const LeaveAttachmentScreen(
          login: 'staff',
        ),
        const SizedBox(
          height: 16.0,
        ),
        MSkollBtn(
          title: "Apply Leave",
          onPress: () async {
            RxList<UploadHwCwModel> attachment = <UploadHwCwModel>[].obs;
            if (controllerOL.attachment.isNotEmpty) {
              for (int i = 0; i < controllerOL.attachment.length; i++) {
                try {
                  attachment.add(await uploadAtt(
                      miId: widget.loginSuccessModel.mIID!,
                      file: File(controllerOL.attachment[i]!.path)));
                } catch (e) {
                  Fluttertoast.showToast(msg: "Please Upload Image");
                  return Future.error({
                    "errorTitle": "An Error Occured",
                    "errorMsg":
                        "While trying to upload attchement, we encountered an error"
                  });
                }
              }
              file = attachment.first.path;
              logger.e(file);
            }
            if (reason.text.isEmpty) {
              Fluttertoast.showToast(msg: "Please provide reason for leave");
              return;
            }

            if (RegExp("/^[6-9]{1,1}[0-9]{9,9}?\$/").hasMatch(phone.text)) {
              Fluttertoast.showToast(
                  msg: "Please provide a valid phone number");
              return;
            }
            if (!RegExp(r'^[6789]\d{9}$').hasMatch(phone.text)) {
              Fluttertoast.showToast(
                  msg: "Please provide a valid phone number");
              return;
            }

            if (startDate.text.isEmpty) {
              Fluttertoast.showToast(msg: "Please provide start date");
              return;
            }

            if (endDate.text.isEmpty) {
              Fluttertoast.showToast(msg: "Please provide end date");
              return;
            }

            if (reportingDate.text.isEmpty) {
              Fluttertoast.showToast(msg: "Please provide reporting date");
              return;
            }

            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureBuilder<bool>(
                              future: SaveLeaveApplication.instance.saveNow(
                                  miId: widget.loginSuccessModel.mIID!,
                                  hrmeId: widget.values.hrmLLeaveCode == "PL"
                                      ? selectedEmployee!.hRMEId ?? 0
                                      : 0,
                                  userId: widget.loginSuccessModel.userId!,
                                  asmayId: widget.loginSuccessModel.asmaYId!,
                                  applicationDate:
                                      DateTime.now().toLocal().toString(),
                                  contactNoOnLeave: int.parse(phone.text),
                                  leaveReason: reason.text,
                                  reportingDate:
                                      reportingDT.toLocal().toString(),
                                  supportingDocument:
                                      (controllerOL.attachment.isNotEmpty)
                                          ? file
                                          : "undefined",
                                  frmToDate: [
                                    {
                                      "HRELAP_FromDate":
                                          startDT.toLocal().toString(),
                                      "HRELAP_ToDate":
                                          endDT.toLocal().toString(),
                                      "HRELAP_TotalDays": isHalfDay.value
                                          ? endDT.difference(startDT).inDays ~/
                                              2
                                          : endDT.difference(startDT).inDays + 1
                                    }
                                  ],
                                  temp: [
                                    {
                                      "fromDate": startDT.toLocal().toString(),
                                      "hrelS_CBLeaves":
                                          widget.values.hrelSCBLeaves,
                                      "hrelS_CreditedLeaves":
                                          widget.values.hrelSCreditedLeaves,
                                      "hrelS_Id": widget.values.hrelSId,
                                      "hrmL_Id": widget.values.hrmLId,
                                      "hrmL_LeaveName":
                                          widget.values.hrmLLeaveName,
                                    }
                                  ],
                                  base: baseUrlFromInsCode(
                                      "leave", widget.mskoolController)),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      const CircleAvatar(
                                        minRadius: 36.0,
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.check,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Text(
                                        "Leave saved successfully",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      const Text(
                                        "You can see the status of your application from home screen",
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      MSkollBtn(
                                        title: "Ok Understood",
                                        onPress: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                }

                                if (snapshot.hasError) {
                                  return ErrWidget(
                                      err: snapshot.error
                                          as Map<String, dynamic>);
                                }

                                return const AnimatedProgressWidget(
                                  title: "Saving leave application",
                                  desc:
                                      "We are sending your leave application to head....",
                                  animationPath: "assets/json/default.json",
                                );
                              }),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ],
    );
  }

  String file = '';
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
