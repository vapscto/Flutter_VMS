// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AttendanceTab extends StatefulWidget {
  final ViewStudentDetailsController controller;
  const AttendanceTab({super.key, required this.controller});

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  List<AttendanceChartData> present = [];
  List<AttendanceChartData> classHeld = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      logger.d(widget.controller.attendance.length);
      for (var element in widget.controller.attendance) {
        present.add(
          AttendanceChartData(
            cls: element.tOTALPRESENT ?? 0,
            month: element.mONTHNAME ?? "N/a",
            per: element.score ?? 0,
          ),
        );
        classHeld.add(
          AttendanceChartData(
            cls: int.parse(element.cLASSHELD ?? "0").toDouble(),
            month: element.mONTHNAME ?? "N/a",
            per: element.score ?? 0,
          ),
        );
      }
      setState(() {});
    });

    super.initState();
  }

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
              : widget.controller.personalData.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Attendance Found",
                        desc:
                            "There is no attendance available currently.. Please ask your technical team to add some",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.circle,
                                            color: Color(0xFFBEEDFF),
                                            size: 16.0,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text("Class Held")
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 24.0,
                                      ),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.circle,
                                            color: Color(0xFF00A5E3),
                                            size: 16.0,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text("Total Present")
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  SfCartesianChart(
                                    primaryYAxis: NumericAxis(
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                    ),
                                    primaryXAxis: CategoryAxis(
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                    ),
                                    enableSideBySideSeriesPlacement: false,
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    series: [
                                      ColumnSeries(
                                          // markerSettings: const MarkerSettings(
                                          //     isVisible: true),
                                          enableTooltip: true,
                                          color: const Color(0xFFBEEDFF),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(8.0)),
                                          dataSource: classHeld,
                                          xValueMapper: (data, index) =>
                                              data.month,
                                          yValueMapper: (data, index) =>
                                              data.cls,
                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                            builder: (data, point, series,
                                                    pointIndex, seriesIndex) =>
                                                Text(
                                              "${classHeld.elementAt(pointIndex).per}%",
                                            ),
                                          )),
                                      ColumnSeries(
                                        dataSource: present,
                                        color: const Color(0xFF00A5E3),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(8.0)),
                                        xValueMapper: (data, index) =>
                                            data.month,
                                        yValueMapper: (data, index) => data.cls,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 36.0,
                          ),
                          Image.asset(
                            "assets/images/att.png",
                            height: 250,
                          )
                        ],
                      ),
                    );
    });
  }
}

class AttendanceChartData {
  final double cls;
  final String month;
  final double per;
  AttendanceChartData({
    required this.cls,
    required this.month,
    required this.per,
  });

  AttendanceChartData copyWith({
    double? cls,
    String? month,
    double? per,
  }) {
    return AttendanceChartData(
      cls: cls ?? this.cls,
      month: month ?? this.month,
      per: per ?? this.per,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cls': cls,
      'month': month,
      'per': per,
    };
  }

  factory AttendanceChartData.fromMap(Map<String, dynamic> map) {
    return AttendanceChartData(
      cls: map['cls'] as double,
      month: map['month'] as String,
      per: map['per'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceChartData.fromJson(String source) =>
      AttendanceChartData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AttendanceChartData(cls: $cls, month: $month, per: $per)';

  @override
  bool operator ==(covariant AttendanceChartData other) {
    if (identical(this, other)) return true;

    return other.cls == cls && other.month == month && other.per == per;
  }

  @override
  int get hashCode => cls.hashCode ^ month.hashCode ^ per.hashCode;
}
