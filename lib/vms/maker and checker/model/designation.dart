class DsgnModel {
  String? type;
  List<DsgnModelValues>? values;

  DsgnModel({this.type, this.values});

  DsgnModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DsgnModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DsgnModelValues.fromJson(v));
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

class DsgnModelValues {
  String? type;
  int? hRMDESId;
  int? mIId;
  String? hRMDESDesignationName;
  String? mIName;

  DsgnModelValues(
      {this.type,
      this.hRMDESId,
      this.mIId,
      this.hRMDESDesignationName,
      this.mIName});

  DsgnModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    hRMDESId = json['HRMDES_Id'];
    mIId = json['MI_Id'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
    mIName = json['MI_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['HRMDES_Id'] = hRMDESId;
    data['MI_Id'] = mIId;
    data['HRMDES_DesignationName'] = hRMDESDesignationName;
    data['MI_Name'] = mIName;
    return data;
  }
}
