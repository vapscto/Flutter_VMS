import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_section_api.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_student_api.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_class_model.dart';
import 'package:m_skool_flutter/manager/student_details/widgets/manager_section_dd.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ManagerClassDD extends StatelessWidget {
  final StudentDetailsController studentDetails;
  final String baseUrl;
  final int miId;
  const ManagerClassDD(
      {super.key,
      required this.studentDetails,
      required this.baseUrl,
      required this.miId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: DropdownButtonFormField<ManagerClassModelValues>(
              value: studentDetails.selectedClass.value,
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
                    color: const Color(0xFFFFEBEA),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/red_class.svg",
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Select Class ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  // backgroundColor: Color(0xFFDFFBFE),
                                  fontSize: 20.0,
                                  color: Color(0xFFFF6F67)),
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
              items: studentDetails.className
                  .map((e) => DropdownMenuItem<ManagerClassModelValues>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 5),
                        child: Text(e.asmcLClassName ?? "N/a"),
                      )))
                  .toList(),
              onChanged: (e) async {
                studentDetails.updateSelectedClass(e!);
                await loadAgain();
              }),
        ),
        const SizedBox(height: 32.0),
        ManagerSectionDD(
          studentDetailsController: studentDetails,
          baseUrl: baseUrl,
          miId: miId,
        ),
      ],
    );
  }

  Future<void> loadAgain() async {
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
