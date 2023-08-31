// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class HomePageModel {
  final String title;
  final String icon;
  final Widget page;
  final double? size;
  final Color selectedColor;
  HomePageModel({
    required this.title,
    required this.icon,
    required this.page,
    required this.selectedColor,
    this.size,
  });

  HomePageModel copyWith({
    String? title,
    String? icon,
    Widget? page,
    Color? selectedColor,
  }) {
    return HomePageModel(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      page: page ?? this.page,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'icon': icon,
      'page': page,
      'selectedColor': selectedColor.value,
    };
  }

  factory HomePageModel.fromMap(Map<String, dynamic> map) {
    return HomePageModel(
      title: map['title'] as String,
      icon: map['icon'] as String,
      page: map['page'],
      selectedColor: Color(map['selectedColor'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageModel.fromJson(String source) =>
      HomePageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomePageModel(title: $title, icon: $icon, page: $page, selectedColor: $selectedColor)';
  }

  @override
  bool operator ==(covariant HomePageModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.icon == icon &&
        other.page == page &&
        other.selectedColor == selectedColor;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        icon.hashCode ^
        page.hashCode ^
        selectedColor.hashCode;
  }
}
