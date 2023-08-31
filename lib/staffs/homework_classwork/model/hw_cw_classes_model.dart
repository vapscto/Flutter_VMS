class HwCwClassesListModel {
  String? type;
  List<HwCwClassesListModelValues>? values;

  HwCwClassesListModel({this.type, this.values});

  HwCwClassesListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HwCwClassesListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HwCwClassesListModelValues.fromJson(v));
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

class HwCwClassesListModelValues {
  String? type;
  String? asmcLClassName;
  int? asmcLId;

  HwCwClassesListModelValues({this.type, this.asmcLClassName, this.asmcLId});

  HwCwClassesListModelValues.fromJson(Map<String, dynamic> json) {
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
