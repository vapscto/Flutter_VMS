import 'package:flutter/material.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/controller/attendance_entry_related_controller.dart';

class AttendanceCheckboxWidget extends StatefulWidget {
  int index;
  bool attendance;
  final AttendanceEntryController attendanceEntryController;
  Function(bool)? addToBoolList;
  Function(int)? removeFromStudentlist;
  final int rollNo;
  final String admNo;
  final int amstId;
  final String studentName;
  final String amstRegistrationNo;
  AttendanceCheckboxWidget({
    super.key,
    required this.index,
    required this.attendance,
    required this.attendanceEntryController,
    this.addToBoolList,
    this.removeFromStudentlist,
    required this.rollNo,
    required this.amstId,
    required this.studentName,
    required this.admNo,
    required this.amstRegistrationNo,
  });

  @override
  State<AttendanceCheckboxWidget> createState() =>
      _AttendanceCheckboxWidgetState();
}

class _AttendanceCheckboxWidgetState extends State<AttendanceCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      activeColor: Theme.of(context).primaryColor,
      value: widget.attendance,
      onChanged: (value) {
        setState(() {
          widget.attendance = value!;
          // widget.addToBoolList!(value);
        });
      },
    );
  }
}
