import 'package:flutter/material.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final Widget? suffix;
  final double radius;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  const CustomTextField(
      {this.label,
      required this.controller,
      this.suffix,
      this.radius = 15,
      this.hintText,
      this.contentPadding,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: label == null ? null : const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              boxShadow: CustomThemeData.getShadow(),
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius)),
          child: TextFormField(
            minLines: 1,
            maxLines: 3,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            style:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),
            decoration: InputDecoration(
              suffixIcon: suffix,
              hintText: hintText,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(vertical: 17, horizontal: 18),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
          ),
        ),
        if (label != null)
          Positioned(
              top: 0,
              left: 13,
              child: Text(label!,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.white,
                      color: Color(0xff898989)))),
      ],
    );
  }
}
