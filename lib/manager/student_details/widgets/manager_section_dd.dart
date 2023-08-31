import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_student_api.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_section_model.dart';
import 'package:m_skool_flutter/manager/student_details/widgets/manager_student_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ManagerSectionDD extends StatelessWidget {
  final StudentDetailsController studentDetailsController;
  final int miId;
  final String baseUrl;
  const ManagerSectionDD(
      {super.key,
      required this.studentDetailsController,
      required this.miId,
      required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return studentDetailsController.isErrorOccuredWhileLoadingSection.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected ErrorOccured",
                  "errorMsg": studentDetailsController.status.value,
                },
              ),
            )
          : studentDetailsController.isSectionLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    desc: studentDetailsController.status.value,
                    title: "Please wait we are loading.",
                  ),
                )
              : studentDetailsController.sections.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Section Found",
                        desc:
                            "There is no Section available currently.. Please ask your technical team to add some",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : Column(
                      children: [
                        CustomContainer(
                          child: DropdownButtonFormField<
                                  ManagerSectionModelValues>(
                              value: studentDetailsController
                                  .selectedSections.value,
                              style:
                                  Theme.of(context).textTheme.titleSmall!.merge(
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
                                    color: const Color(0xFFDBFDF5),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/section.png",
                                        height: 24.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Sections ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  // backgroundColor:
                                                  //     Color(0xFFDFFBFE),
                                                  fontSize: 20.0,
                                                  color: Color(0xFF47BA9E)),
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
                              items: studentDetailsController.sections
                                  .map((e) => DropdownMenuItem<
                                          ManagerSectionModelValues>(
                                      value: e,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 5),
                                        child: Text(e.asmCSectionName ?? "N/a"),
                                      )))
                                  .toList(),
                              onChanged: (e) async {
                                studentDetailsController
                                    .updateSelectedSection(e!);
                                await loadAgain();
                              }),
                        ),
                        const SizedBox(height: 32.0),
                        ManagerStudentDD(
                          controller: studentDetailsController,
                          baseUrl: baseUrl,
                          miId: miId,
                        ),
                      ],
                    );
    });
  }

  Future<void> loadAgain() async {
    await GetStudentApi.instance.getStudents(
      miId: miId,
      asmayId: studentDetailsController.selectedAcademicYear.value.asmaYId!,
      asmcld: studentDetailsController.selectedClass.value.asmcLId!,
      asmsId: studentDetailsController.selectedSections.value.asmSId!,
      base: baseUrl,
      controller: studentDetailsController,
    );
  }
}
