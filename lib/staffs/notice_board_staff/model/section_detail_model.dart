class SectionDetailsModel {
  String? type;
  List<SectionDetailsModelValues>? values;

  SectionDetailsModel({this.type, this.values});

  SectionDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SectionDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SectionDetailsModelValues.fromJson(v));
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

class SectionDetailsModelValues {
  String? type;
  int? asmSId;
  int? asmcLId;
  String? aSMCSectionName;
  String? asmcLClassName;

  SectionDetailsModelValues(
      {this.type,
      this.asmSId,
      this.asmcLId,
      this.aSMCSectionName,
      this.asmcLClassName});

  SectionDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    asmSId = json['asmS_Id'];
    asmcLId = json['asmcL_Id'];
    aSMCSectionName = json['ASMC_SectionName'];
    asmcLClassName = json['asmcL_ClassName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['asmS_Id'] = asmSId;
    data['asmcL_Id'] = asmcLId;
    data['ASMC_SectionName'] = aSMCSectionName;
    data['asmcL_ClassName'] = asmcLClassName;
    return data;
  }
}
