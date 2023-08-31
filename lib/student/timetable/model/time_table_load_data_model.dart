class TimeTableLoadDataModel {
  int? mIId;
  int? asmaYId;
  int? amsTId;
  bool? status;
  Getyear? getyear;
  int? asmcLId;
  int? asmSId;

  TimeTableLoadDataModel(
      {this.mIId,
      this.asmaYId,
      this.amsTId,
      this.status,
      this.getyear,
      this.asmcLId,
      this.asmSId});

  TimeTableLoadDataModel.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    status = json['status'];
    getyear =
        json['getyear'] != null ? Getyear.fromJson(json['getyear']) : null;
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amsT_Id'] = amsTId;
    data['status'] = status;
    if (getyear != null) {
      data['getyear'] = getyear!.toJson();
    }
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    return data;
  }
}

class Getyear {
  String? type;
  List<Values>? values;

  Getyear({this.type, this.values});

  Getyear.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <Values>[];
      json['\$values'].forEach((v) {
        values!.add(Values.fromJson(v));
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

class Values {
  int? mIId;
  int? asmaYId;
  int? amsTId;
  bool? status;
  int? asmcLId;
  String? asmcLClassName;
  int? asmSId;
  String? asmCSectionName;
  String? asmaYYear;

  Values(
      {this.mIId,
      this.asmaYId,
      this.amsTId,
      this.status,
      this.asmcLId,
      this.asmcLClassName,
      this.asmSId,
      this.asmCSectionName,
      this.asmaYYear});

  Values.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    status = json['status'];
    asmcLId = json['asmcL_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmSId = json['asmS_Id'];
    asmCSectionName = json['asmC_SectionName'];
    asmaYYear = json['asmaY_Year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amsT_Id'] = amsTId;
    data['status'] = status;
    data['asmcL_Id'] = asmcLId;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmS_Id'] = asmSId;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmaY_Year'] = asmaYYear;
    return data;
  }
}
