// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResultModel {
  final String title;
  final String value;
  ResultModel({
    required this.title,
    required this.value,
  });

  ResultModel copyWith({
    String? title,
    String? value,
  }) {
    return ResultModel(
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'value': value,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      title: map['title'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) =>
      ResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResultModel(title: $title, value: $value)';

  @override
  bool operator ==(covariant ResultModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.value == value;
  }

  @override
  int get hashCode => title.hashCode ^ value.hashCode;
}
