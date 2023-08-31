import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_student_model.dart';
import 'package:m_skool_flutter/manager/student_details/screen/view_individual_student_details.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class ManagerStudentDD extends StatelessWidget {
  final StudentDetailsController controller;
  final int miId;
  final String baseUrl;
  const ManagerStudentDD(
      {super.key,
      required this.controller,
      required this.miId,
      required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isErrorOccuredWhileLoadingStudent.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected ErrorOccured",
                  "errorMsg": controller.status.value,
                },
              ),
            )
          : controller.isStudentLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    desc: controller.status.value,
                    title: "Please wait we are loading.",
                  ),
                )
              : controller.students.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Student Found",
                        desc:
                            "There is no Student available currently.. Please ask your technical team to add some",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : Column(
                      children: [
                        CustomContainer(
                          child: DropdownButtonFormField<
                                  ManagerStudentModelValues>(
                              value: controller.selectedStudent.value,
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
                                    color: const Color(0xFFE5F3FF),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                          "assets/images/profileiconsa.png",
                                          height: 24.0,
                                          color: const Color(0xFF3E78AA)),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Select Student ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                color: Color(0xFF3E78AA),
                                                fontSize: 20.0,
                                              ),
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
                              items: controller.students
                                  .map((e) => DropdownMenuItem<
                                          ManagerStudentModelValues>(
                                      value: e,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 5),
                                        child: Text(
                                            "${e.amsTFirstName ?? "N/a"} ${e.amsTMiddleName ?? "N/a"} ${e.amsTLastName ?? "N/a"}"),
                                      )))
                                  .toList(),
                              onChanged: (e) async {
                                controller.updateSelectedStudent(e!);
                                // await loadAgain();
                              }),
                        ),
                        const SizedBox(
                          height: 48.0,
                        ),
                        MSkollBtn(
                          onPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return ViewStudentIndividualDetails(
                                amstId:
                                    controller.selectedStudent.value.amsTId!,
                                asmayId: controller
                                    .selectedAcademicYear.value.asmaYId!,
                                baseUrl: baseUrl,
                                miId: miId,
                              );
                            }));
                          },
                          title: "View Details",
                          size: Size(Get.width * 0.4, 50),
                        ),
                      ],
                    );
    });
  }
}
