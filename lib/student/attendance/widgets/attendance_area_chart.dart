// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports

class AttendanceAreaChart extends StatefulWidget {
  const AttendanceAreaChart({super.key});

  @override
  State<AttendanceAreaChart> createState() => _AttendanceAreaChartState();
}

class _AttendanceAreaChartState extends State<AttendanceAreaChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      series: [
        AreaSeries<AttendanceValue, int>(
          dataSource: getChartData(),
          xValueMapper: ((datum, index) => datum.totalPresent),
          yValueMapper: ((datum, index) => datum.classHeld),
        )
      ],
    );
  }

  List<AttendanceValue> getChartData() {
    return [
      AttendanceValue(classHeld: 22, totalPresent: 19, month: "Nov"),
      AttendanceValue(classHeld: 21, totalPresent: 15, month: "Dec"),
      AttendanceValue(classHeld: 20, totalPresent: 18, month: "Jan"),
    ];
  }
}

class AttendanceValue {
  final int classHeld;
  final int totalPresent;
  final String month;
  AttendanceValue({
    required this.classHeld,
    required this.totalPresent,
    required this.month,
  });

  AttendanceValue copyWith({
    int? classHeld,
    int? totalPresent,
    String? month,
  }) {
    return AttendanceValue(
      classHeld: classHeld ?? this.classHeld,
      totalPresent: totalPresent ?? this.totalPresent,
      month: month ?? this.month,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'classHeld': classHeld,
      'totalPresent': totalPresent,
      'month': month,
    };
  }

  factory AttendanceValue.fromMap(Map<String, dynamic> map) {
    return AttendanceValue(
      classHeld: map['classHeld'] as int,
      totalPresent: map['totalPresent'] as int,
      month: map['month'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceValue.fromJson(String source) =>
      AttendanceValue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AttendanceValue(classHeld: $classHeld, totalPresent: $totalPresent, month: $month)';

  @override
  bool operator ==(covariant AttendanceValue other) {
    if (identical(this, other)) return true;

    return other.classHeld == classHeld &&
        other.totalPresent == totalPresent &&
        other.month == month;
  }

  @override
  int get hashCode =>
      classHeld.hashCode ^ totalPresent.hashCode ^ month.hashCode;
}
