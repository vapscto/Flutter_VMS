// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class PreAdmissionData {
  final String name;
  final int count;
  final Color color;
  PreAdmissionData({
    required this.name,
    required this.count,
    required this.color,
  });

  PreAdmissionData copyWith({
    String? name,
    int? count,
    Color? color,
  }) {
    return PreAdmissionData(
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

  factory PreAdmissionData.fromMap(Map<String, dynamic> map) {
    return PreAdmissionData(
      name: map['name'] as String,
      count: map['count'] as int,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PreAdmissionData.fromJson(String source) =>
      PreAdmissionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PreAdmissionData(name: $name, count: $count, color: $color)';

  @override
  bool operator ==(covariant PreAdmissionData other) {
    if (identical(this, other)) return true;

    return other.name == name && other.count == count && other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ count.hashCode ^ color.hashCode;
}
