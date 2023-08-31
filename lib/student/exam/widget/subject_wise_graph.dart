import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:m_skool_flutter/student/exam/model/pie_data_model.dart';
import 'package:m_skool_flutter/student/exam/model/subjectoverview_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphSubjectWiseResultItem extends StatefulWidget {
  final SubjectWiseReportListValue datamodel;
  final Color chipColor;
  final Color containerColor;
  final Color gradeColor;
  final Color textColor;
  final Color obtainedColor;
  final Color pieColor;
  const GraphSubjectWiseResultItem(
      {super.key,
      required this.datamodel,
      required this.chipColor,
      required this.containerColor,
      required this.gradeColor,
      required this.textColor,
      required this.obtainedColor,
      required this.pieColor});

  @override
  State<GraphSubjectWiseResultItem> createState() =>
      _GraphSubjectWiseResultItemState();
}

class _GraphSubjectWiseResultItemState
    extends State<GraphSubjectWiseResultItem> {
  List<PieDataModel> pie = [];

  @override
  void initState() {
    // TODO: implement initState

    pie.add(PieDataModel(
        marks: widget.datamodel.estmpsMaxMarks!.toInt(),
        name: "Max Marks",
        color: widget.pieColor));
    pie.add(PieDataModel(
        marks: widget.datamodel.estmpsObtainedMarks!.toInt(),
        name: "Mark Obtained",
        color: widget.obtainedColor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.containerColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  backgroundColor: widget.chipColor,
                  label: Text(
                    widget.datamodel.emeExamName!,
                    style: TextStyle(color: widget.textColor),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   "Grade",
                    //   style: Theme.of(context).textTheme.labelMedium,
                    // ),
                    // const SizedBox(
                    //   height: 6.0,
                    // ),
                    Text(
                      "${widget.datamodel.estmpsObtainedGrade}  ",
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                            TextStyle(fontSize: 20.0, color: widget.gradeColor),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.4,
                height: Get.width * 0.4,
                child: Transform.translate(
                  offset: const Offset(-5, 0),
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<PieDataModel, String>(
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          dataSource: pie,
                          pointColorMapper: ((datum, index) => datum.color),
                          xValueMapper: ((datum, index) => datum.name),
                          yValueMapper: ((datum, index) => datum.marks)),
                      PieSeries<PieDataModel, String>(
                          dataSource: pie,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          pointColorMapper: ((datum, index) => datum.color),
                          xValueMapper: ((datum, index) => datum.name),
                          yValueMapper: ((datum, index) => datum.marks)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Maximum Marks",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsMaxMarks!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Class Highest",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsClassHighest!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Section Highest",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsSectionHighest!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Minimum Marks",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.eycesMinMarks!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Class avg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsClassAverage!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Section Avg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsSectionAverage!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }
}
