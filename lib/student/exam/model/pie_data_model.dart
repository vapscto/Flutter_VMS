// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class PieDataModel {
  final int marks;
  final String name;
  final Color color;
  PieDataModel({
    required this.marks,
    required this.name,
    required this.color,
  });

  PieDataModel copyWith({
    int? marks,
    String? name,
    Color? color,
  }) {
    return PieDataModel(
      marks: marks ?? this.marks,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'marks': marks,
      'name': name,
      'color': color.value,
    };
  }

  factory PieDataModel.fromMap(Map<String, dynamic> map) {
    return PieDataModel(
      marks: map['marks'] as int,
      name: map['name'] as String,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PieDataModel.fromJson(String source) =>
      PieDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PieDataModel(marks: $marks, name: $name, color: $color)';

  @override
  bool operator ==(covariant PieDataModel other) {
    if (identical(this, other)) return true;

    return other.marks == marks && other.name == name && other.color == color;
  }

  @override
  int get hashCode => marks.hashCode ^ name.hashCode ^ color.hashCode;
}
