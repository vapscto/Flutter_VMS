import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxContainer extends StatelessWidget {
  final RxBool isChecked;
  final String sectionName;
  final Function(bool) func;
  const CheckBoxContainer({
    super.key,
    required this.isChecked,
    required this.sectionName,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        checkboxShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        dense: true,
        activeColor: Theme.of(context).primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        visualDensity: const VisualDensity(horizontal: -4.0),
        title: Text(
          sectionName,
          style: Theme.of(context).textTheme.labelSmall!.merge(const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14.0, letterSpacing: 0.3)),
        ),
        value: isChecked.value,
        onChanged: (value) {
          isChecked.value = value!;

          func(value);
        },
      );
    });
  }
}
