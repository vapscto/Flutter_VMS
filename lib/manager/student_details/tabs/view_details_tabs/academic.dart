import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class AcademicTab extends StatelessWidget {
  final ViewStudentDetailsController controller;
  const AcademicTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    int color = -1;
    return Obx(() {
      return controller.isErrorOccuredInHistory.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": controller.isErrorOccuredInHistory.value,
                },
              ),
            )
          : controller.isHistoryLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    desc: controller.historyStatus.value,
                    title: "Please wait we are loading.",
                  ),
                )
              : controller.academicHistory.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        animationPath: 'assets/json/nodata.json',
                        animatorHeight: 250,
                        desc: "There is no academic history for this student",
                        title: "Please wait we are loading.",
                      ),
                    )
                  : ListView.separated(
                      itemCount: controller.academicHistory.length,
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (_, index) {
                        color += 1;
                        if (color % 6 == 0) {
                          color = 0;
                        }
                        return CustomContainer(
                          child: Container(
                              // height: 100,
                              decoration: BoxDecoration(
                                // color: noticeBackgroundColor
                                //     .elementAt(color)
                                //     .withOpacity(0.2),

                                color: lighterColorBg.elementAt(color),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 10.0,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: borderColor.elementAt(color),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Academic Year",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .merge(
                                                        const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 12.0,
                                                ),
                                                Text(
                                                  controller.academicHistory
                                                          .elementAt(index)
                                                          .asmayYear ??
                                                      "N/a",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Class",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .merge(
                                                        const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 12.0,
                                                ),
                                                Text(
                                                  controller.academicHistory
                                                              .elementAt(index)
                                                              .classSection ==
                                                          null
                                                      ? "N/a"
                                                      : controller
                                                          .academicHistory
                                                          .elementAt(index)
                                                          .classSection!
                                                          .split("/")
                                                          .first,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Section",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .merge(
                                                        const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 12.0,
                                                ),
                                                Text(
                                                  controller.academicHistory
                                                              .elementAt(index)
                                                              .classSection ==
                                                          null
                                                      ? "N/a"
                                                      : controller
                                                          .academicHistory
                                                          .elementAt(index)
                                                          .classSection!
                                                          .split("/")
                                                          .last,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                    );
    });
  }
}
