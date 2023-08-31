class ClassNameDetailsModel {
  String? type;
  List<ClassNameDetailsModelValues>? values;

  ClassNameDetailsModel({this.type, this.values});

  ClassNameDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClassNameDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ClassNameDetailsModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassNameDetailsModelValues {
  String? type;
  String? asmcLClassName;
  int? asmcLId;

  ClassNameDetailsModelValues({this.type, this.asmcLClassName, this.asmcLId});

  ClassNameDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    asmcLClassName = json['asmcL_ClassName'];
    asmcLId = json['asmcL_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmcL_Id'] = asmcLId;
    return data;
  }
}
