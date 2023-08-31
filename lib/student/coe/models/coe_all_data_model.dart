import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:m_skool_flutter/student/coe/models/academic_year_model.dart';
import 'package:m_skool_flutter/student/coe/models/coe_data_model.dart';

class AllCoeDataModelBind {
  final List<AttyearlistValues> academicYear;
  final List<CoereportlistValues> coeReport;
  AllCoeDataModelBind({
    required this.academicYear,
    required this.coeReport,
  });

  AllCoeDataModelBind copyWith({
    List<AttyearlistValues>? academicYear,
    List<CoereportlistValues>? coeReport,
  }) {
    return AllCoeDataModelBind(
      academicYear: academicYear ?? this.academicYear,
      coeReport: coeReport ?? this.coeReport,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'academicYear': academicYear.map((x) => x.toJson()).toList(),
      'coeReport': coeReport.map((x) => x.toJson()).toList(),
    };
  }

  factory AllCoeDataModelBind.fromMap(Map<String, dynamic> map) {
    return AllCoeDataModelBind(
      academicYear: List<AttyearlistValues>.from(
        (map['academicYear'] as List<dynamic>).map<AttyearlistValues>(
          (x) => AttyearlistValues.fromJson(x),
        ),
      ),
      coeReport: List<CoereportlistValues>.from(
        (map['coeReport'] as List<dynamic>).map<CoereportlistValues>(
          (x) => CoereportlistValues.fromJson(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllCoeDataModelBind.fromJson(String source) =>
      AllCoeDataModelBind.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CoeDataHandler(academicYear: $academicYear, coeReport: $coeReport)';

  @override
  bool operator ==(covariant AllCoeDataModelBind other) {
    if (identical(this, other)) return true;

    return listEquals(other.academicYear, academicYear) &&
        listEquals(other.coeReport, coeReport);
  }

  @override
  int get hashCode => academicYear.hashCode ^ coeReport.hashCode;
}
