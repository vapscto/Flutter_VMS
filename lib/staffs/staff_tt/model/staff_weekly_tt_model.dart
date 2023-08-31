// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_weekly_gridweeks_model.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_weekly_periodlist_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_days_model.dart';

import 'package:m_skool_flutter/staffs/staff_tt/model/staff_weekly_period_model.dart';

class StaffWeeklyTTModel {
  final String dayName;
  final List<WeeklyTTDayWise> classesAt;
  StaffWeeklyTTModel({
    required this.dayName,
    required this.classesAt,
  });

  StaffWeeklyTTModel copyWith({
    String? dayName,
    List<WeeklyTTDayWise>? classesAt,
  }) {
    return StaffWeeklyTTModel(
      dayName: dayName ?? this.dayName,
      classesAt: classesAt ?? this.classesAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dayName': dayName,
      'classesAt': classesAt.map((x) => x.toMap()).toList(),
    };
  }

  factory StaffWeeklyTTModel.fromMap(Map<String, dynamic> map) {
    return StaffWeeklyTTModel(
      dayName: map['dayName'] as String,
      classesAt: List<WeeklyTTDayWise>.from(
        (map['classesAt'] as List<int>).map<WeeklyTTDayWise>(
          (x) => WeeklyTTDayWise.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffWeeklyTTModel.fromJson(String source) =>
      StaffWeeklyTTModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StaffWeeklyTTModel(dayName: $dayName, classesAt: $classesAt)';

  @override
  bool operator ==(covariant StaffWeeklyTTModel other) {
    if (identical(this, other)) return true;

    return other.dayName == dayName && listEquals(other.classesAt, classesAt);
  }

  @override
  int get hashCode => dayName.hashCode ^ classesAt.hashCode;
}

class WeeklyTTDayWise {
  final String className;
  final String periodName;
  final String subjectName;
  final String sectionName;
  final String dayName;
  WeeklyTTDayWise({
    required this.className,
    required this.periodName,
    required this.subjectName,
    required this.sectionName,
    required this.dayName,
  });

  WeeklyTTDayWise copyWith({
    String? className,
    String? periodName,
    String? sectionName,
    String? dayName,
  }) {
    return WeeklyTTDayWise(
        className: className ?? this.className,
        periodName: periodName ?? this.periodName,
        subjectName: sectionName ?? this.subjectName,
        sectionName: sectionName ?? this.sectionName,
        dayName: dayName ?? this.dayName);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'className': className,
      'periodName': periodName,
      'sectionName': subjectName,
    };
  }

  factory WeeklyTTDayWise.fromMap(Map<String, dynamic> map) {
    return WeeklyTTDayWise(
      className: map['className'] as String,
      periodName: map['periodName'] as String,
      subjectName: map['sectionName'] as String,
      sectionName: map['sectionName'] as String,
      dayName: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WeeklyTTDayWise.fromJson(String source) =>
      WeeklyTTDayWise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeeklyTTDayWise(className: $className, periodName: $periodName, sectionName: $subjectName)';

  @override
  bool operator ==(covariant WeeklyTTDayWise other) {
    if (identical(this, other)) return true;

    return other.className == className &&
        other.periodName == periodName &&
        other.subjectName == subjectName;
  }

  @override
  int get hashCode =>
      className.hashCode ^ periodName.hashCode ^ subjectName.hashCode;
}

class WeeklyTTDataModel {
  final StaffWeeklyTTPeriods periods;
  final DailyTTDaysModel days;
  final List<StaffWeeklyTTModel> tt;
  WeeklyTTDataModel({
    required this.periods,
    required this.days,
    required this.tt,
  });

  WeeklyTTDataModel copyWith({
    StaffWeeklyTTPeriods? periods,
    DailyTTDaysModel? days,
    List<StaffWeeklyTTModel>? tt,
  }) {
    return WeeklyTTDataModel(
      periods: periods ?? this.periods,
      days: days ?? this.days,
      tt: tt ?? this.tt,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'periods': periods.toMap(),
  //     'days': days.toMap(),
  //     'tt': tt.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory WeeklyTTDataModel.fromMap(Map<String, dynamic> map) {
  //   return WeeklyTTDataModel(
  //     periods: StaffWeeklyTTPeriods.fromMap(map['periods'] as Map<String,dynamic>),
  //     days: DailyTTDaysModel.fromMap(map['days'] as Map<String,dynamic>),
  //     tt: List<StaffWeeklyTTModel>.from((map['tt'] as List<int>).map<StaffWeeklyTTModel>((x) => StaffWeeklyTTModel.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory WeeklyTTDataModel.fromJson(String source) => WeeklyTTDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'WeeklyTTDataModel(periods: $periods, days: $days, tt: $tt)';

  // @override
  // bool operator ==(covariant WeeklyTTDataModel other) {
  //   if (identical(this, other)) return true;

  //   return
  //     other.periods == periods &&
  //     other.days == days &&
  //     listEquals(other.tt, tt);
  // }

  // @override
  // int get hashCode => periods.hashCode ^ days.hashCode ^ tt.hashCode;
}

class WeeklyTTData {
  final ManagerWeeklyPeriodlistModel periods;
  final ManagerWeeklyGridWeeksModel days;
  final List<StaffWeeklyTTModel> tt;
  WeeklyTTData({
    required this.periods,
    required this.days,
    required this.tt,
  });

  WeeklyTTData copyWith({
    ManagerWeeklyPeriodlistModel? periods,
    ManagerWeeklyGridWeeksModel? days,
    List<StaffWeeklyTTModel>? tt,
  }) {
    return WeeklyTTData(
      periods: periods ?? this.periods,
      days: days ?? this.days,
      tt: tt ?? this.tt,
    );
  }
}
