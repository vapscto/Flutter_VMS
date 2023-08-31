import 'package:flutter/material.dart';

class AttendanceTextfieldWidget extends StatefulWidget {
  final TextEditingController textController;
  const AttendanceTextfieldWidget({
    super.key,
    required this.textController,
  });

  @override
  State<AttendanceTextfieldWidget> createState() =>
      _AttendanceTextfieldWidgetState();
}

class _AttendanceTextfieldWidgetState extends State<AttendanceTextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: widget.textController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(
              fontSize: 13,
              color: Color.fromRGBO(0, 0, 0, 0.95),
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
