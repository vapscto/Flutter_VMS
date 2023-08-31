import 'package:flutter/material.dart';

class CustomDropDownLabel extends StatelessWidget {
  final String icon;
  final String text;
  final Color containerColor;
  final Color textColor;
  const CustomDropDownLabel(
      {super.key,
      required this.icon,
      required this.text,
      required this.containerColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            height: 24.0,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium!.merge(
                  TextStyle(fontSize: 20.0, color: textColor),
                ),
          ),
        ],
      ),
    );
  }
}
