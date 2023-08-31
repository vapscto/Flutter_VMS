// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DashboardItemModel {
  final String assetLoc;
  final String title;
  DashboardItemModel({
    required this.assetLoc,
    required this.title,
  });

  DashboardItemModel copyWith({
    String? assetLoc,
    String? title,
  }) {
    return DashboardItemModel(
      assetLoc: assetLoc ?? this.assetLoc,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'assetLoc': assetLoc,
      'title': title,
    };
  }

  factory DashboardItemModel.fromMap(Map<String, dynamic> map) {
    return DashboardItemModel(
      assetLoc: map['assetLoc'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardItemModel.fromJson(String source) =>
      DashboardItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DashboardItemModel(assetLoc: $assetLoc, title: $title)';

  @override
  bool operator ==(covariant DashboardItemModel other) {
    if (identical(this, other)) return true;

    return other.assetLoc == assetLoc && other.title == title;
  }

  @override
  int get hashCode => assetLoc.hashCode ^ title.hashCode;
}
