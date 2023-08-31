class AcademicYearModel {
  int? mIId;
  int? asmaYId;
  int? amsTId;
  bool? status;
  Currentyear? currentyear;
  Currentyear? attyearlist;
  int? asmaYOrder;

  AcademicYearModel(
      {this.mIId,
      this.asmaYId,
      this.amsTId,
      this.status,
      this.currentyear,
      this.attyearlist,
      this.asmaYOrder});

  AcademicYearModel.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    status = json['status'];
    currentyear = json['currentyear'] != null
        ? Currentyear.fromJson(json['currentyear'])
        : null;
    attyearlist = json['attyearlist'] != null
        ? Currentyear.fromJson(json['attyearlist'])
        : null;
    asmaYOrder = json['asmaY_Order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amsT_Id'] = amsTId;
    data['status'] = status;
    if (currentyear != null) {
      data['currentyear'] = currentyear!.toJson();
    }
    if (attyearlist != null) {
      data['attyearlist'] = attyearlist!.toJson();
    }
    data['asmaY_Order'] = asmaYOrder;
    return data;
  }
}

class Currentyear {
  String? type;
  List<AttyearlistValues>? values;

  Currentyear({this.type, this.values});

  Currentyear.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AttyearlistValues>[];
      json['\$values'].forEach((v) {
        values!.add(AttyearlistValues.fromJson(v));
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

class AttyearlistValues {
  int? mIId;
  int? asmaYId;
  int? amsTId;
  bool? status;
  String? asmaYYear;
  int? asmaYOrder;

  AttyearlistValues(
      {this.mIId,
      this.asmaYId,
      this.amsTId,
      this.status,
      this.asmaYYear,
      this.asmaYOrder});

  AttyearlistValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    status = json['status'];
    asmaYYear = json['asmaY_Year'];
    asmaYOrder = json['asmaY_Order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amsT_Id'] = amsTId;
    data['status'] = status;
    data['asmaY_Year'] = asmaYYear;
    data['asmaY_Order'] = asmaYOrder;
    return data;
  }
}
