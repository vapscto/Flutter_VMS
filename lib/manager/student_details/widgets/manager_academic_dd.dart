// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_academic.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_section_api.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_student_api.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_academic_year.dart';
import 'package:m_skool_flutter/manager/student_details/widgets/manager_class_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ManagerAcademicYearDD extends StatelessWidget {
  final StudentDetailsController studentDetails;

  final String baseUrl;
  final int miId;
  const ManagerAcademicYearDD({
    Key? key,
    required this.studentDetails,
    required this.baseUrl,
    required this.miId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: DropdownButtonFormField<ManagerAcademiCYearModelValues>(
              value: studentDetails.selectedAcademicYear.value,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFBFE),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/hat.png",
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Academic Year ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  backgroundColor: Color(0xFFDFFBFE),
                                  fontSize: 20.0,
                                  color: Color(0xFF28B6C8)),
                            ),
                      ),
                    ],
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              icon: const Padding(
                padding: EdgeInsets.only(top: 4.5),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
              ),
              items: studentDetails.academicYear
                  .map((e) => DropdownMenuItem<ManagerAcademiCYearModelValues>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 5),
                        child: Text(e.asmaYYear ?? "N/a"),
                      )))
                  .toList(),
              onChanged: (e) async {
                studentDetails.updateSelectedAcademicYear(e!);
                await loadAgain();
              }),
        ),
        const SizedBox(
          height: 32.0,
        ),
        Obx(() {
          return studentDetails.isErrorOccuredWhileLoadingClass.value
              ? Center(
                  child: ErrWidget(
                    err: {
                      "errorTitle": "Unexpected ErrorOccured",
                      "errorMsg": studentDetails.status.value,
                    },
                  ),
                )
              : studentDetails.isLoadingClasses.value
                  ? Center(
                      child: AnimatedProgressWidget(
                        animationPath: 'assets/json/default.json',
                        desc: studentDetails.status.value,
                        title: "Please wait we are loading.",
                      ),
                    )
                  : studentDetails.className.isEmpty
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "No Class Found",
                            desc:
                                "There is no class available currently.. Please ask your technical team to add some",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : ManagerClassDD(
                          baseUrl: baseUrl,
                          miId: miId,
                          studentDetails: studentDetails,
                        );
        }),
      ],
    );
  }

  Future<void> loadAgain() async {
    await ManagerGetAcademic.instance.getClassName(
      miId: miId,
      asmayId: studentDetails.selectedAcademicYear.value.asmaYId!,
      base: baseUrl,
      controller: studentDetails,
    );

    if (studentDetails.isErrorOccuredWhileLoadingClass.value ||
        studentDetails.className.isEmpty) {
      return;
    }
    await GetSectionApi.instance.getSection(
      miId: miId,
      asmayId: studentDetails.selectedAcademicYear.value.asmaYId!,
      asmclId: studentDetails.selectedClass.value.asmcLId!,
      base: baseUrl,
      controller: studentDetails,
    );
    if (studentDetails.isErrorOccuredWhileLoadingSection.value ||
        studentDetails.sections.isEmpty) {
      return;
    }
    await GetStudentApi.instance.getStudents(
      miId: miId,
      asmayId: studentDetails.selectedAcademicYear.value.asmaYId!,
      asmcld: studentDetails.selectedClass.value.asmcLId!,
      asmsId: studentDetails.selectedSections.value.asmSId!,
      base: baseUrl,
      controller: studentDetails,
    );
  }
}
