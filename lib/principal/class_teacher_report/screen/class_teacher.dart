import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/controller/class_teacher_controller.dart';

class ClassTeacher extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ClassTeacherController controller;
  const ClassTeacher(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 6, right: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DataTable(
                  dataTextStyle: const TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(5, 5, 5, 0.945),
                      fontWeight: FontWeight.w500),
                  dataRowHeight: 40,
                  headingRowHeight: 55,
                  horizontalMargin: 10,
                  columnSpacing: 40,
                  dividerThickness: 1,

                  
                  border: TableBorder(
                    bottom: BorderSide(color: Color.fromARGB(31, 99, 98, 98)),
                    left: BorderSide(color: Color.fromARGB(31, 99, 98, 98)),
                    right: BorderSide(color: Color.fromARGB(31, 99, 98, 98)),

                    verticalInside: BorderSide(
                      color: Color.fromARGB(31, 99, 98, 98)
                    ),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  headingRowColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  columns: [
                    DataColumn(
                        label: Text("SL No",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("STAFF NAME",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("CLASS",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("SECTION",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                  ],
                  rows: List.generate(
                      controller.classTeacherList.length,
                      (index) => DataRow(cells: [
                            DataCell(Text("${index + 1}")),
                            DataCell(Text(
                                "${controller.classTeacherList.elementAt(index).iVRMSTAULUserName}")),
                            DataCell(Text(
                                "${controller.classTeacherList.elementAt(index).aSMCLClassName}")),
                            DataCell(Text(
                                "${controller.classTeacherList.elementAt(index).aSMCSectionName}")),
                          ]))),
            ],
          ),
        ),
      );
    });
  }
}
