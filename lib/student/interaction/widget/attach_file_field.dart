import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';

class AttachFileField extends StatelessWidget {
  final String label;
  const AttachFileField({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FilePicker.platform.pickFiles();
          },
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: CustomThemeData.getShadow(),
              ),
              child: SizedBox(
                height: 58,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("(Optional)", style: TextStyle(fontSize: 16)),
                      SvgPicture.asset("assets/svg/upload-cloud.svg")
                    ],
                  ),
                ),
              )),
        ),
        Positioned(
            top: 0,
            left: 13,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff898989)))),
      ],
    );
  }
}
