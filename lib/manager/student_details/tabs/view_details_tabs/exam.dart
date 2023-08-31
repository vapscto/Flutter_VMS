import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/exam_model.dart';
import 'package:m_skool_flutter/manager/student_details/screen/view_individual_exam.dart';
import 'package:m_skool_flutter/student/exam/model/pie_data_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExamTab extends StatefulWidget {
  final ViewStudentDetailsController controller;
  final int miId;
  final int asmayId;
  final int amstId;
  final String base;
  const ExamTab(
      {super.key,
      required this.controller,
      required this.miId,
      required this.asmayId,
      required this.amstId,
      required this.base});

  @override
  State<ExamTab> createState() => _ExamTabState();
}

class _ExamTabState extends State<ExamTab> {
  @override
  void initState() {
    super.initState();
  }

  int color = -1;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.controller.isErrorOccured.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": widget.controller.status.value,
                },
              ),
            )
          : widget.controller.isLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    desc: widget.controller.status.value,
                    title: "Please wait we are loading.",
                  ),
                )
              : widget.controller.managerExam.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Exam Found",
                        desc:
                            "There is no exam data available currently.. Please ask your technical team to add some",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (_, index) {
                        color += 1;
                        if (color % 4 == 0) {
                          color = 0;
                        }

                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => ViewIndividualMarks(
                                amstId: widget.amstId,
                                asmayId: widget.asmayId,
                                emeId: widget.controller.managerExam
                                    .elementAt(index)
                                    .emEId!,
                                miId: widget.miId,
                                examName: widget.controller.managerExam
                                    .elementAt(index)
                                    .examName!,
                                base: widget.base,
                              ),
                            );
                          },
                          child: CustomContainer(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Chip(
                                    backgroundColor: chipColor.elementAt(color),
                                    label: Text(
                                      widget.controller.managerExam
                                              .elementAt(index)
                                              .examName ??
                                          "N/a",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(
                                            TextStyle(
                                              color: textColor.elementAt(color),
                                            ),
                                          ),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 12.0,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: SizedBox(
                                          width: Get.width * 0.4,
                                          height: Get.width * 0.4,
                                          child: ExamPie(
                                            pie: widget.controller.managerExam
                                                .elementAt(index),
                                            obtainedColor:
                                                pieColor.elementAt(color),
                                            totalMarksColor:
                                                examCardColor.elementAt(color),
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 12.0,
                                      // ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Total Marks",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .color,
                                                                fontSize: 13.0,
                                                              ),
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6.0,
                                                      ),
                                                      Text(
                                                        widget.controller
                                                            .managerExam
                                                            .elementAt(index)
                                                            .totalmarks
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              const TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12.0,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Marks Obtained",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .color,
                                                                fontSize: 13.0,
                                                              ),
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6.0,
                                                      ),
                                                      Text(
                                                        widget.controller
                                                                    .managerExam
                                                                    .elementAt(
                                                                        index)
                                                                    .obtainmarks ==
                                                                null
                                                            ? "N/a"
                                                            : widget.controller
                                                                .managerExam
                                                                .elementAt(
                                                                    index)
                                                                .obtainmarks
                                                                .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              const TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Percentage",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .color,
                                                                fontSize: 13.0,
                                                              ),
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6.0,
                                                      ),
                                                      Text(
                                                        "${widget.controller.managerExam.elementAt(index).persentage.toString()}%",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              const TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12.0,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Final Result",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .color,
                                                                fontSize: 13.0,
                                                              ),
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6.0,
                                                      ),
                                                      Text(
                                                        widget.controller
                                                            .managerExam
                                                            .elementAt(index)
                                                            .result
                                                            .toString(),
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .merge(
                                                                  TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: widget.controller.managerExam.elementAt(index).result.toString().toLowerCase() ==
                                                                            "pass"
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   height: 16.0,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                      itemCount: widget.controller.managerExam.length,
                    );
    });
  }
}

class ExamPie extends StatefulWidget {
  const ExamPie({
    super.key,
    required this.pie,
    required this.totalMarksColor,
    required this.obtainedColor,
  });

  final ManagerExamModelValues pie;
  final Color totalMarksColor;
  final Color obtainedColor;

  @override
  State<ExamPie> createState() => _ExamPieState();
}

class _ExamPieState extends State<ExamPie> {
  List<PieDataModel> pieChartVal = [];
  List<PieDataModel> pieChartVal2 = [];
  @override
  void initState() {
    pieChartVal.add(PieDataModel(
        marks:
            widget.pie.totalmarks == null ? 0 : widget.pie.totalmarks!.toInt(),
        name: "Total Marks",
        color: widget.totalMarksColor));

    pieChartVal.add(PieDataModel(
      marks:
          widget.pie.obtainmarks == null ? 0 : widget.pie.obtainmarks!.toInt(),
      name: "Obtained Marks",
      color: widget.obtainedColor,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      enableMultiSelection: true,
      series: <CircularSeries>[
        PieSeries<PieDataModel, String>(
            enableTooltip: true,
            name: "Maximum Marks",
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            dataSource: pieChartVal,
            pointColorMapper: ((datum, index) => datum.color.withOpacity(0.2)),
            xValueMapper: ((datum, index) => datum.name),
            yValueMapper: ((datum, index) => datum.marks)),
        PieSeries<PieDataModel, String>(
            dataSource: pieChartVal,
            name: "Marks Obtained",
            enableTooltip: true,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            pointColorMapper: ((datum, index) => datum.color),
            xValueMapper: ((datum, index) => datum.name),
            yValueMapper: ((datum, index) => datum.marks)),
      ],
    );
  }
}
