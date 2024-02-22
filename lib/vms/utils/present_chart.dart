import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PresentChart extends StatelessWidget {
  final ProfileController controller;
  const PresentChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<AttandanceData> chartData = [];
    chartData.add(AttandanceData(
        name: 'Presemt', count: controller.present.value, color: Colors.green));
    chartData.add(AttandanceData(
        name: 'Absent', count: controller.absent.value, color: Colors.red));
    chartData.add(AttandanceData(
        name: 'Holiday',
        count: controller.holiday.value,
        color: Colors.orange));
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.27,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.all(4),
      child: SfCircularChart(
        enableMultiSelection: true,
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          PieSeries<AttandanceData, String>(
              radius: "78",
              enableTooltip: true,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.inside,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16)),
              dataSource: chartData,
              pointColorMapper: ((datum, index) => datum.color),
              xValueMapper: ((datum, index) => datum.name),
              yValueMapper: ((datum, index) => datum.count)),
        ],
      ),
    );
  }
}

class AttandanceData {
  final String name;
  final int count;
  final Color color;
  AttandanceData({
    required this.name,
    required this.count,
    required this.color,
  });

  AttandanceData copyWith({
    String? name,
    int? count,
    Color? color,
  }) {
    return AttandanceData(
      name: name ?? this.name,
      count: count ?? this.count,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'count': count,
      'color': color.value,
    };
  }

  factory AttandanceData.fromMap(Map<String, dynamic> map) {
    return AttandanceData(
      name: map['name'] as String,
      count: map['count'] as int,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttandanceData.fromJson(String source) =>
      AttandanceData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PreAdmissionData(name: $name, count: $count, color: $color)';

  @override
  bool operator ==(covariant AttandanceData other) {
    if (identical(this, other)) return true;

    return other.name == name && other.count == count && other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ count.hashCode ^ color.hashCode;
}
