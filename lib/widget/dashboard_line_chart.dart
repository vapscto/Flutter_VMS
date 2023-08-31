// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/dashboard_exam_api.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/exam_graph_model.dart';
import 'package:m_skool_flutter/model/exam_list.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardLineChart extends StatelessWidget {
  final ExamListNewValues selectedExam;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final DynamicAnalyticsController dashboardController;
  const DashboardLineChart(
      {super.key,
      required this.selectedExam,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.dashboardController});

  @override
  Widget build(BuildContext context) {
    return ChartDataLoader(
      loginSuccessModel: loginSuccessModel,
      selectedExam: selectedExam,
      mskoolController: mskoolController,
      dashboardController: dashboardController,
    );
  }
}

class ChartDataLoader extends StatefulWidget {
  const ChartDataLoader({
    Key? key,
    required this.loginSuccessModel,
    required this.selectedExam,
    required this.mskoolController,
    required this.dashboardController,
  }) : super(key: key);

  final LoginSuccessModel loginSuccessModel;
  final ExamListNewValues selectedExam;
  final MskoolController mskoolController;
  final DynamicAnalyticsController dashboardController;

  @override
  State<ChartDataLoader> createState() => _ChartDataLoaderState();
}

class _ChartDataLoaderState extends State<ChartDataLoader> {
  @override
  void initState() {
    DashboardExamApi.instance.loadExamData(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        asmclId: widget.loginSuccessModel.asmcLId!,
        asmsId: widget.loginSuccessModel.asmSId!,
        amstId: widget.loginSuccessModel.amsTId!,
        emeId: widget.selectedExam.eMEId ?? 0,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        dashboardController: widget.dashboardController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.dashboardController.isLoadingGraphData.value
          ? const AnimatedProgressWidget(
              title: "Loading Exam Data",
              desc: "we are gathering all you exam details and creating a view",
              animationPath: "assets/json/default.json")
          : widget.dashboardController.examGraphVal.isEmpty
              ? const AnimatedProgressWidget(
                  title: "No Exam data",
                  desc: "Sorry but for this exam we couldn't find ant data.",
                  animationPath: "assets/json/nodata.json")
              : Chart(value: widget.dashboardController.examGraphVal);
    });
  }
}

class Chart extends StatefulWidget {
  final List<ExamGraphListValues> value;
  const Chart({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ExamGraphModel> source = [];
  List<Color> clr = [];

  @override
  void initState() {
    clr.addAll(noticeColor);
    clr.addAll(pieColor);
    clr.addAll(colors);
    for (int i = 0; i < widget.value.length; i++) {
      source.add(ExamGraphModel(
          percentage: widget.value.elementAt(i).eSTMPSObtainedMarks == 0 ||
                  widget.value.elementAt(i).eSTMPSMaxMarks == null
              ? 0
              : (widget.value.elementAt(i).eSTMPSObtainedMarks! /
                      widget.value.elementAt(i).eSTMPSMaxMarks!) *
                  100,
          subjectName: widget.value.elementAt(i).iSMSSubjectName ?? "N/a",
          color: clr.elementAt(i)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfCartesianChart(
          //legend: Legend(isVisible: true),
          primaryYAxis: NumericAxis(
            labelFormat: "{value}",
            majorGridLines: const MajorGridLines(width: 0.0),
          ),
          primaryXAxis: CategoryAxis(
            name: 'Subjects',
            isVisible: false,
            maximumLabelWidth: 60,
            //edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelRotation: 45,
            labelStyle: Theme.of(context)
                .textTheme
                .labelSmall!
                .merge(const TextStyle(letterSpacing: 0.2, fontSize: 12.0)),
            majorGridLines: const MajorGridLines(width: 1.0, dashArray: [
              10.0,
            ]),
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <LineSeries>[
            LineSeries<ExamGraphModel, String>(
                name: "Result",
                isVisible: true,
                isVisibleInLegend: true,
                dataSource: source,
                markerSettings: const MarkerSettings(isVisible: true),
                pointColorMapper: (datum, index) => datum.color,
                xValueMapper: ((datum, index) => datum.subjectName),
                yValueMapper: ((datum, index) => datum.percentage))
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 8.0,
            spacing: 8.0,
            children: List.generate(
                source.length,
                (index) => SizedBox(
                      width: 80,
                      // margin: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: source.elementAt(index).color,
                            size: 14.0,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Expanded(
                              child: Text(
                            source.elementAt(index).subjectName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                        ],
                      ),
                    )))
      ],
    );
  }
}

class ExamGraphModel {
  final double percentage;
  final String subjectName;
  final Color color;
  ExamGraphModel({
    required this.percentage,
    required this.subjectName,
    required this.color,
  });

  ExamGraphModel copyWith({
    double? percentage,
    String? subjectName,
    Color? color,
  }) {
    return ExamGraphModel(
      percentage: percentage ?? this.percentage,
      subjectName: subjectName ?? this.subjectName,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'percentage': percentage,
      'subjectName': subjectName,
      'color': color.value,
    };
  }

  factory ExamGraphModel.fromMap(Map<String, dynamic> map) {
    return ExamGraphModel(
      percentage: map['percentage'] as double,
      subjectName: map['subjectName'] as String,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamGraphModel.fromJson(String source) =>
      ExamGraphModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExamGraphModel(percentage: $percentage, subjectName: $subjectName, color: $color)';

  @override
  bool operator ==(covariant ExamGraphModel other) {
    if (identical(this, other)) return true;

    return other.percentage == percentage &&
        other.subjectName == subjectName &&
        other.color == color;
  }

  @override
  int get hashCode =>
      percentage.hashCode ^ subjectName.hashCode ^ color.hashCode;
}
