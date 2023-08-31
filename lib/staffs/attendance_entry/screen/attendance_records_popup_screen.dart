import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/api/attendance_entry_related_api.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/controller/attendance_entry_related_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class AttendanceRecordPopupScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int asmayId;
  final int asmclId;
  final int asmsId;
  final String attentrytype;
  const AttendanceRecordPopupScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.asmayId,
    required this.asmclId,
    required this.asmsId,
    required this.attentrytype,
  });

  @override
  State<AttendanceRecordPopupScreen> createState() =>
      _AttendanceRecordPopupScreenState();
}

class _AttendanceRecordPopupScreenState
    extends State<AttendanceRecordPopupScreen> {
  final AttendanceEntryController attendanceEntryController =
      Get.put(AttendanceEntryController());

  @override
  void initState() {
    getAttendanceRecord();
    super.initState();
  }

  getAttendanceRecord() async {
    attendanceEntryController.isviewrecordloading(true);
    await attendanceEntryController
        .getAttendanceEntryRecord(
            base: baseUrlFromInsCode('admission', widget.mskoolController),
            miId: widget.loginSuccessModel.mIID!,
            asmayId: widget.asmayId,
            asmclId: widget.asmclId,
            asmsId: widget.asmsId,
            username: widget.loginSuccessModel.userName!,
            userId: widget.loginSuccessModel.userId!,
            attentrytype: widget.attentrytype)
        .then((value) => logger.d(value));
    attendanceEntryController.isviewrecordloading(false);
  }

  deleteAttendanceRecord(int asaId) async {
    attendanceEntryController.isviewrecordloading(true);
    await deleteAttendanceEntryRecord(
            base: baseUrlFromInsCode('admission', widget.mskoolController),
            asaId: asaId,
            userId: widget.loginSuccessModel.userId!)
        .then((value) {
      if (value) {
        Fluttertoast.showToast(msg: 'Delete successfully');
        getAttendanceRecord();
      }
      Fluttertoast.showToast(msg: 'Something went wrong');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '      View Records',
              style: Theme.of(context).textTheme.labelSmall!.merge(
                  const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.white,
                      letterSpacing: 0.3)),
            ),
          ),
        ),
        Obx(
          () => attendanceEntryController.isViewRecord.value
              ? const Center(
                  child: AnimatedProgressWidget(
                      title: "Loading View Records",
                      desc: "Please wait",
                      animationPath: "assets/json/default.json",
                      animatorHeight: 65),
                )
              : attendanceEntryController.attendanceEntryRecordList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          'No record found for selected field, take attendance and try again',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: attendanceEntryController
                              .attendanceEntryRecordList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: CustomContainer(
                                        child: ListTile(
                                            minLeadingWidth: 10,
                                            // leading: Icon(
                                            //   Icons.calendar_today_outlined,
                                            //   color: Theme.of(context).primaryColor,
                                            // ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Academic Year : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).asmayYear!.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "Class : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).asmclClassName!.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "Section : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).asmcSectionName!.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "Attendance Date : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).asaEntryDateTime!.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "Entry Date : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).asaFromdate!.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "Entry By : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).employeename!.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                if (attendanceEntryController
                                                        .attendanceEntryRecordList
                                                        .elementAt(index)
                                                        .subjectName !=
                                                    null)
                                                  Text(
                                                    "Subject : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).subjectName!.toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                if (attendanceEntryController
                                                        .attendanceEntryRecordList
                                                        .elementAt(index)
                                                        .periodName !=
                                                    null)
                                                  Text(
                                                    "Period : ${attendanceEntryController.attendanceEntryRecordList.elementAt(index).periodName!.toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                              ],
                                            ),
                                            trailing: attendanceEntryController
                                                        .attendanceEntryRecordList
                                                        .elementAt(index)
                                                        .deleteFlag ==
                                                    1
                                                ? InkWell(
                                                    onTap: () async {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  "Delete Record"),
                                                              content: const Text(
                                                                  "Are you sure to delete this attendance record?"),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await deleteAttendanceRecord(attendanceEntryController
                                                                        .attendanceEntryRecordList
                                                                        .elementAt(
                                                                            index)
                                                                        .asaId!);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "Yes"),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "No"),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SvgPicture.asset(
                                                        "assets/svg/delete.svg",
                                                        color: Colors.white,
                                                        height: 24,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox())),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
        ),
      ],
    );
  }
}
