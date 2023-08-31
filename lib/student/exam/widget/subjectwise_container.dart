import 'package:flutter/material.dart';
import 'package:m_skool_flutter/student/exam/model/subjectoverview_model.dart';
import 'package:m_skool_flutter/student/exam/widget/result_analysis_item.dart';

class SubjectWiseContainer extends StatelessWidget {
  final SubjectWiseReportListValue datamodel;
  final Color chipColor;
  final Color containerColor;
  final Color gradeColor;
  const SubjectWiseContainer({
    super.key,
    required this.datamodel,
    required this.chipColor,
    required this.containerColor,
    required this.gradeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      backgroundColor: chipColor,
                      label: Text(datamodel.emeExamName!),
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
                          "${datamodel.estmpsObtainedGrade}  ",
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                              TextStyle(fontSize: 20.0, color: gradeColor)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            datamodel.eycesMarksDisplayFlg!
                                ? "${datamodel.estmpsMaxMarks!.toInt()}"
                                : "",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Maximum Marks",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(124, 124, 124, 1))),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            datamodel.eycesMarksDisplayFlg!
                                ? "${datamodel.eycesMinMarks!.toInt()}"
                                : "",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                    color: Colors.black)),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Minimum Marks",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.2,
                                    color: Color.fromRGBO(124, 124, 124, 1))),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            datamodel.eycesMarksDisplayFlg!
                                ? "${datamodel.estmpsObtainedMarks!.toInt()}"
                                : "",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .merge(const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  letterSpacing: 0.2,
                                )),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Mark Obtained",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(124, 124, 124, 1))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
            height: 1.5,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.eycesMarksDisplayFlg!
                          ? datamodel.estmpsClassHighest.toString()
                          : "",
                      title: "Class Highest",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.eycesMarksDisplayFlg!
                          ? datamodel.estmpsSectionHighest.toString()
                          : "",
                      title: "Section Highest",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.eycesMarksDisplayFlg!
                          ? datamodel.estmpsSectionAverage.toString()
                          : "",
                      title: "Section Avg",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.eycesMarksDisplayFlg!
                          ? datamodel.estmpsClassAverage.toString()
                          : "",
                      title: "Class Avg",
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
