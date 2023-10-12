import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/online_leave/api/save_leave_application.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_name_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class ApplyLeaveWidget extends StatelessWidget {
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

  //final RxBool isHalfDay;

  @override
  Widget build(BuildContext context) {
    RxBool isHalfDay = RxBool(false);
    final TextEditingController reason = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController startDate = TextEditingController();
    final TextEditingController endDate = TextEditingController();
    final TextEditingController reportingDate = TextEditingController();
    DateTime startDT = DateTime.now();
    DateTime endDT = DateTime.now();
    DateTime reportingDT = DateTime.now();
    RxString totalDay = RxString("0");

    return Column(
      children: [
        CustomContainer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    )),
                child: Text(
                  "${values.hrmLLeaveName}",
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        TextStyle(
                          color: color,
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

                                    DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: startDT,
                                      firstDate: startDT,
                                      lastDate: endDT,
                                    );
                                    if (date == null) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "You didn't selected start date");
                                      return;
                                    }
                                    startDT = date;
                                    startDate.text =
                                        "${date.day}-${date.month}-${date.year}";
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
                              controller: endDate,
                              style: Theme.of(context).textTheme.titleSmall,

                              //maxLines: 4,
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
                                    DateTime? end = await showDatePicker(
                                      context: context,
                                      initialDate: endDT,
                                      firstDate: startDT,
                                      lastDate:
                                          DateTime(DateTime.now().year + 1),
                                    );

                                    if (end == null) {
                                      Fluttertoast.showToast(
                                          msg: "Please select end date");
                                      return;
                                    }

                                    endDT = end;
                                    endDate.text =
                                        "${end.day}-${end.month}-${end.year}";
                                    Duration difference =
                                        endDT.difference(startDT);
                                    totalDay.value = "${difference.inDays + 1}";
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
                                      isHalfDay.value = true;
                                      totalDay.value =
                                          "${(endDT.difference(startDT).inDays + 1) / 2}";
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
        const SizedBox(
          height: 16.0,
        ),
        MSkollBtn(
          title: "Apply Leave",
          onPress: () {
            if (reason.text.isEmpty) {
              Fluttertoast.showToast(msg: "Please provide reason for leave");
              return;
            }

            if (RegExp("/^[6-9]{1,1}[0-9]{9,9}?\$/").hasMatch(phone.text)) {
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
            if (values.hrmLLeaveName == 'Casual Leave') {
              if (int.parse(totalDay.value) > values.hrelTTotDays!.toInt()) {}
            }

            showDialog(
                context: context,
                barrierDismissible: false,
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
                                  miId: loginSuccessModel.mIID!,
                                  userId: loginSuccessModel.userId!,
                                  asmayId: loginSuccessModel.asmaYId!,
                                  applicationDate:
                                      DateTime.now().toLocal().toString(),
                                  contactNoOnLeave: int.parse(phone.text),
                                  leaveReason: reason.text,
                                  reportingDate:
                                      reportingDT.toLocal().toString(),
                                  supportingDocument: "undefined",
                                  frmToDate: [
                                    {
                                      "HRELAP_FromDate":
                                          startDT.toLocal().toString(),
                                      "HRELAP_ToDate":
                                          endDT.toLocal().toString(),
                                      "HRELAP_TotalDays": isHalfDay.value
                                          ? endDT.difference(startDT).inDays ~/
                                              2
                                          : endDT.difference(startDT).inDays
                                    }
                                  ],
                                  temp: [
                                    {
                                      "fromDate": startDT.toLocal().toString(),
                                      "hrelS_CBLeaves": values.hrelSCBLeaves,
                                      "hrelS_CreditedLeaves":
                                          values.hrelSCreditedLeaves,
                                      "hrelS_EncashedLeaves":
                                          values.hrelSEncashedLeaves,
                                      "hrelS_Id": values.hrelSId,
                                      "hrmL_Id": values.hrmLId,
                                      "hrmL_LeaveCreditFlg":
                                          values.hrmLLeaveCreditFlg,
                                      "hrmL_LeaveName": values.hrmLLeaveName,
                                    }
                                  ],
                                  base: baseUrlFromInsCode(
                                      "leave", mskoolController)),
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
}
