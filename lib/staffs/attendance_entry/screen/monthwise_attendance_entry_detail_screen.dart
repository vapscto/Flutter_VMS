import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/api/attendance_entry_related_api.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/controller/attendance_entry_related_controller.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/save_button.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/staff_home_fab.dart';

import '../../../controller/mskoll_controller.dart';

class MonthWiseAttendanceEntryDetailScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int asmayId;
  final int asaId;
  final int asmclId;
  final int asmsId;
  final String fromDate;
  final String toDate;
  final String classheld;

  const MonthWiseAttendanceEntryDetailScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.asmayId,
    required this.asaId,
    required this.asmclId,
    required this.asmsId,
    required this.fromDate,
    required this.classheld,
    required this.toDate,
  });

  @override
  State<MonthWiseAttendanceEntryDetailScreen> createState() =>
      _MonthWiseAttendanceEntryDetailScreenState();
}

class _MonthWiseAttendanceEntryDetailScreenState
    extends State<MonthWiseAttendanceEntryDetailScreen> {
  final AttendanceEntryController attendanceEntryController =
      Get.put(AttendanceEntryController());
  List<Map<String, dynamic>> studentList = [];
  RxString search = ''.obs;
  String date =
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Attendance Entry'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            child: SaveBtn(
              title: attendanceEntryController.updateButton.value > 0
                  ? 'Update'
                  : 'Save',
              onPress: () async {
                for (var i = 0;
                    i < attendanceEntryController.textEditingController.length;
                    i++) {
                  if (double.parse(attendanceEntryController
                          .textEditingController
                          .elementAt(i)
                          .text) >
                      attendanceEntryController.countClassHeld.value
                          .toDouble()) {
                    Fluttertoast.showToast(
                        msg:
                            'Class attended is more than class taken of Roll No. ${attendanceEntryController.monthwiseStudentList.elementAt(i).amaYRollNo}');
                    return;
                  }
                }
                studentList.clear();
                for (var i = 0;
                    i < attendanceEntryController.monthwiseStudentList.length;
                    i++) {
                  studentList.add(
                    {
                      "amaY_RollNo": attendanceEntryController
                          .monthwiseStudentList
                          .elementAt(i)
                          .amaYRollNo,
                      "amsT_AdmNo": attendanceEntryController
                          .monthwiseStudentList
                          .elementAt(i)
                          .amsTAdmNo,
                      "amsT_Id": attendanceEntryController.monthwiseStudentList
                          .elementAt(i)
                          .amsTId,
                      "studentname": attendanceEntryController
                          .monthwiseStudentList
                          .elementAt(i)
                          .studentname,
                      "pdays": double.parse(attendanceEntryController
                          .textEditingController
                          .elementAt(i)
                          .text),
                      "selected": null,
                      "ASAS_Id": attendanceEntryController.monthwiseStudentList
                          .elementAt(i)
                          .asaSId,
                      "FirstHalfflag": null,
                      "SecondHalfflag": null,
                      "asA_Dailytwice_Flag": null,
                      "asA_Id": attendanceEntryController.monthwiseStudentList
                          .elementAt(i)
                          .asAId,
                      "TTMP_Id": null,
                      "ISMS_Id": 0,
                      "asasB_Id": 0,
                      "amsT_RegistrationNo": attendanceEntryController
                          .monthwiseStudentList
                          .elementAt(i)
                          .amsTRegistrationNo
                    },
                  );
                }
                logger.d(studentList);
                attendanceEntryController.issaveloading(true);
                await saveAttendanceEntry(
                  data: {
                    "ASA_Id": widget.asaId,
                    "MI_Id": widget.loginSuccessModel.mIID!,
                    "ASMAY_Id": widget.asmayId,
                    "ASA_Att_Type": "monthly",
                    "ASA_Att_EntryType":
                        attendanceEntryController.attendanceEntryType.value ==
                                'P'
                            ? 'Present'
                            : 'Absent',
                    "ASMCL_Id": widget.asmclId,
                    "ASMS_Id": widget.asmsId,
                    "ASA_Entry_DateTime": date,
                    "ASA_FromDate": widget.fromDate,
                    "ASA_ToDate": widget.toDate,
                    "ASA_ClassHeld": widget.classheld,
                    "ASA_Regular_Extra": "Regular",
                    "ASA_Network_IP": "::1",
                    "ASAS_Id": null,
                    "AMST_Id": 0,
                    "ASA_Class_Attended": 0.0,
                    "stdList": studentList,
                    "username": widget.loginSuccessModel.userName!,
                    "userId": widget.loginSuccessModel.userId!,
                    "ismS_Id": 0,
                    "TTMP_Id": 0,
                    "attcount": 0,
                    "asasB_Id": 0
                  },
                  base: baseUrlFromInsCode(
                    'admission',
                    widget.mskoolController,
                  ),
                ).then((value) {
                  if (value) {
                    Fluttertoast.showToast(
                      msg: 'Attendance Save Successfully',
                    );
                    return;
                  }
                  Fluttertoast.showToast(
                    msg: 'Something went wrong',
                  );
                });
                attendanceEntryController.issaveloading(false);
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: InkWell(
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      Colors.white, //Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextField(
                          onChanged: (value) {
                            search.value = value;
                            logger.d(search.value);
                          },
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(0, 0, 0, 0.95),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              )),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .merge(TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 14.0,
                                    color: Colors.grey.withOpacity(0.6),
                                    letterSpacing: 0.3,
                                  )),
                              hintText: 'search by student name'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
      floatingActionButton: StaffHomeFab(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 10, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFDFD6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 250,
                  height: 30,
                  child: Center(
                    child: Text(
                      'Attendance Entry Type is ${attendanceEntryController.attendanceEntryType.value.toLowerCase() == 'a' ? 'Absent' : 'Present'}',
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                            const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xffF24E1E),
                            ),
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: DataTable(
                        dataTextStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(0, 0, 0, 0.95),
                            fontWeight: FontWeight.w500),
                        dataRowHeight: 45,
                        headingRowHeight: 40,
                        horizontalMargin: 8,
                        columnSpacing: 33,
                        dividerThickness: 1,
                        headingTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        border: TableBorder.all(
                          borderRadius: BorderRadius.circular(12),
                          width: 0.5,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        // showBottomBorder: true,
                        headingRowColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        columns: const [
                          DataColumn(
                            numeric: true,
                            label: Text(
                              'S.No',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Name',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Roll No',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Class\nTaken',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Class\nAttended',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],

                        rows: List.generate(
                            attendanceEntryController
                                .monthwiseStudentList.length, (index) {
                          var i = index + 1;
                          return DataRow(
                            cells: [
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$i',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${attendanceEntryController.monthwiseStudentList.elementAt(index).studentname}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    backgroundColor: attendanceEntryController
                                                .monthwiseStudentList
                                                .elementAt(index)
                                                .studentname!
                                                .toLowerCase()
                                                .contains(search.value
                                                    .toLowerCase()) &&
                                            search.value.isNotEmpty
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${attendanceEntryController.monthwiseStudentList.elementAt(index).amaYRollNo!}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${attendanceEntryController.countClassHeld.toInt()}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: TextField(
                                        controller: attendanceEntryController
                                            .textEditingController
                                            .elementAt(index),
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
