import 'package:flutter/material.dart';
import 'package:m_skool_flutter/vms/interaction/model/interaction_staff_list_mode.dart';

class StudentListWidget extends StatefulWidget {
  final InteractionStaffListModelValues data;
  final Function(int) function;
  final Function(int) function1;
  bool? selectAll;
  StudentListWidget({
    super.key,
    required this.data,
    required this.function,
    required this.function1,
    this.selectAll,
  });

  @override
  State<StudentListWidget> createState() => _StudentListWidgetState();
}

class _StudentListWidgetState extends State<StudentListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        checkboxShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        dense: true,
        activeColor: Theme.of(context).primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        visualDensity: const VisualDensity(horizontal: -4.0),
        title: Text(
          widget.data.employeeName!,
          style: Theme.of(context).textTheme.labelSmall!.merge(const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 15.0, letterSpacing: 0.3)),
        ),
        value: widget.selectAll,
        onChanged: (value) {
          setState(() {
            widget.selectAll = value!;
          });
          if (value!) {
            widget.function(widget.data.hRMEId!);
            return;
          }
          widget.function1(widget.data.hRMEId!);
        },
      ),
    );
  }
}
