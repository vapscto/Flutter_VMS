// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DateWiseModel {
  final int day;
  final String dayName;
  final String date;
  DateWiseModel({
    required this.day,
    required this.dayName,
    required this.date,
  });

  DateWiseModel copyWith({
    int? day,
    String? dayName,
    String? date,
  }) {
    return DateWiseModel(
      day: day ?? this.day,
      dayName: dayName ?? this.dayName,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'dayName': dayName,
      'date': date,
    };
  }

  factory DateWiseModel.fromMap(Map<String, dynamic> map) {
    return DateWiseModel(
      day: map['day'] as int,
      dayName: map['dayName'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DateWiseModel.fromJson(String source) =>
      DateWiseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DateWiseModel(day: $day, dayName: $dayName, date: $date)';

  @override
  bool operator ==(covariant DateWiseModel other) {
    if (identical(this, other)) return true;

    return other.day == day && other.dayName == dayName && other.date == date;
  }

  @override
  int get hashCode => day.hashCode ^ dayName.hashCode ^ date.hashCode;
}
