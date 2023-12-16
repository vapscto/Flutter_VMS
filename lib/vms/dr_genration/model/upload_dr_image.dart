// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UploadDrImage {
  final String name;
  final String path;
  final int index;
  UploadDrImage({required this.name, required this.path, required this.index});

  UploadDrImage copyWith({String? name, String? path, int? index}) {
    return UploadDrImage(
        name: name ?? this.name,
        path: path ?? this.path,
        index: index ?? this.index);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'path': path,
      'index': index,
    };
  }

  factory UploadDrImage.fromMap(Map<String, dynamic> map) {
    return UploadDrImage(
        name: map['name'] as String,
        path: map['path'] as String,
        index: map['index']);
  }

  String toJson() => json.encode(toMap());

  factory UploadDrImage.fromJson(String source) =>
      UploadDrImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadDrImage(name: $name, path: $path, index: $index)';

  @override
  bool operator ==(covariant UploadDrImage other) {
    if (identical(this, other)) return true;

    return other.name == name && other.path == path && other.index == index;
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode ^ index.hashCode;
}
