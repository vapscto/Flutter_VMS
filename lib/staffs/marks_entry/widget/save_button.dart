import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/controller/attendance_entry_related_controller.dart';
import 'package:m_skool_flutter/staffs/marks_entry/controller/marks_entry_related_controller.dart';

class SaveBtn extends StatefulWidget {
  final String title;
  final Function()? onPress;
  const SaveBtn({super.key, required this.title, this.onPress});

  @override
  State<SaveBtn> createState() => _SaveBtnState();
}

class _SaveBtnState extends State<SaveBtn> {
  final MarksEntryController marksEntryController =
      Get.put(MarksEntryController());
  final AttendanceEntryController attendanceEntryController =
      Get.put(AttendanceEntryController());
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: widget.onPress,
      child: Obx(
        () => marksEntryController.isSave.value ||
                attendanceEntryController.isSave.value
            ? Center(
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )),
              )
            : Text(
                widget.title,
                style: Theme.of(context).textTheme.labelSmall!.merge(
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 0.3,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              ),
      ),
    );
  }
}
