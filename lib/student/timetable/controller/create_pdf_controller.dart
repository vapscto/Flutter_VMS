// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

class CreatePdfController extends GetxController {
  RxList<List<PdfTTModel>> ttSub = RxList();

  void updateTTSub(List<List<PdfTTModel>> sub) {
    if (ttSub.isNotEmpty) {
      ttSub.clear();
    }

    ttSub.addAll(sub);
  }
}

class PdfTTModel {
  final String index;
  final String subTeacher;
  PdfTTModel({
    required this.index,
    required this.subTeacher,
  });

  PdfTTModel copyWith({
    String? index,
    String? subTeacher,
  }) {
    return PdfTTModel(
      index: index ?? this.index,
      subTeacher: subTeacher ?? this.subTeacher,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'subTeacher': subTeacher,
    };
  }

  factory PdfTTModel.fromMap(Map<String, dynamic> map) {
    return PdfTTModel(
      index: map['index'] as String,
      subTeacher: map['subTeacher'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PdfTTModel.fromJson(String source) =>
      PdfTTModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PdfTTModel(index: $index, subTeacher: $subTeacher)';

  @override
  bool operator ==(covariant PdfTTModel other) {
    if (identical(this, other)) return true;

    return other.index == index && other.subTeacher == subTeacher;
  }

  @override
  int get hashCode => index.hashCode ^ subTeacher.hashCode;
}
