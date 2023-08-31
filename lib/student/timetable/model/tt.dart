// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:m_skool_flutter/student/timetable/model/daywise_tt.dart';
import 'package:m_skool_flutter/student/timetable/model/grid_week_model.dart';
import 'package:m_skool_flutter/student/timetable/model/periods_lst_model.dart';
import 'package:m_skool_flutter/student/timetable/model/tt_model.dart';

class TT {
  final TTModel tt;
  final GridWeekModel gridWeeks;
  final PeriodsListModel periodsList;
  final List<DayWisett> dayWise;
  TT({
    required this.tt,
    required this.gridWeeks,
    required this.periodsList,
    required this.dayWise,
  });

  TT copyWith({
    TTModel? tt,
    GridWeekModel? gridWeeks,
    PeriodsListModel? periodsList,
    List<DayWisett>? dayWise,
  }) {
    return TT(
      tt: tt ?? this.tt,
      gridWeeks: gridWeeks ?? this.gridWeeks,
      periodsList: periodsList ?? this.periodsList,
      dayWise: dayWise ?? this.dayWise,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tt': tt.toJson(),
      'gridWeeks': gridWeeks.toJson(),
      'periodsList': periodsList.toJson(),
      'dayWise': dayWise.map((x) => x.toMap()).toList(),
    };
  }

  factory TT.fromMap(Map<String, dynamic> map) {
    return TT(
      tt: TTModel.fromJson(map['tt'] as Map<String, dynamic>),
      gridWeeks:
          GridWeekModel.fromJson(map['gridWeeks'] as Map<String, dynamic>),
      periodsList:
          PeriodsListModel.fromJson(map['periodsList'] as Map<String, dynamic>),
      dayWise: List<DayWisett>.from(
        (map['dayWise'] as List<int>).map<DayWisett>(
          (x) => DayWisett.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TT.fromJson(String source) =>
      TT.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TT(tt: $tt, gridWeeks: $gridWeeks, periodsList: $periodsList, dayWise: $dayWise)';
  }

  @override
  bool operator ==(covariant TT other) {
    if (identical(this, other)) return true;

    return other.tt == tt &&
        other.gridWeeks == gridWeeks &&
        other.periodsList == periodsList &&
        listEquals(other.dayWise, dayWise);
  }

  @override
  int get hashCode {
    return tt.hashCode ^
        gridWeeks.hashCode ^
        periodsList.hashCode ^
        dayWise.hashCode;
  }
}
