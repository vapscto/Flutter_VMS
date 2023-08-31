// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel {
  final int amstId;
  final List<XFile> xfile;
  ImageModel({
    required this.amstId,
    required this.xfile,
  });

  ImageModel copyWith({
    int? amstId,
    List<XFile>? xfile,
  }) {
    return ImageModel(
      amstId: amstId ?? this.amstId,
      xfile: xfile ?? this.xfile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amstId': amstId,
      'xfile': xfile.map((x) => {"att": x}).toList(),
    };
  }

  // factory ImageModel.fromMap(Map<String, dynamic> map) {
  //   return ImageModel(
  //     amstId: map['amstId'] as int,
  //     xfile: List<XFile>.from(
  //       (map['xfile'] as List<int>).map<XFile>(
  //         (x) => x,
  //       ),
  //     ),
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory ImageModel.fromJson(String source) =>
  //     ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageModel(amstId: $amstId, xfile: $xfile)';

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;

    return other.amstId == amstId && listEquals(other.xfile, xfile);
  }

  @override
  int get hashCode => amstId.hashCode ^ xfile.hashCode;
}
