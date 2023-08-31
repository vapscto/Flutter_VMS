// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';

class UploadAttModel {
  final int amstId;
  final UploadHwCwModel model;
  UploadAttModel({
    required this.amstId,
    required this.model,
  });

  UploadAttModel copyWith({
    int? amstId,
    UploadHwCwModel? model,
  }) {
    return UploadAttModel(
      amstId: amstId ?? this.amstId,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amstId': amstId,
      'model': model.toMap(),
    };
  }

  factory UploadAttModel.fromMap(Map<String, dynamic> map) {
    return UploadAttModel(
      amstId: map['amstId'] as int,
      model: UploadHwCwModel.fromMap(map['model'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadAttModel.fromJson(String source) =>
      UploadAttModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadAttModel(amstId: $amstId, model: $model)';

  @override
  bool operator ==(covariant UploadAttModel other) {
    if (identical(this, other)) return true;

    return other.amstId == amstId && other.model == model;
  }

  @override
  int get hashCode => amstId.hashCode ^ model.hashCode;
}
