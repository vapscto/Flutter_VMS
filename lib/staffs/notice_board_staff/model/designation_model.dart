class DesignationDataModel {
  String? type;
  List<DesignationDataModelValues>? values;

  DesignationDataModel({this.type, this.values});

  DesignationDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DesignationDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DesignationDataModelValues.fromJson(v));
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

class DesignationDataModelValues {
  String? type;
  int? hRMDESId;
  int? mIId;
  String? hRMDESDesignationName;

  DesignationDataModelValues(
      {this.type, this.hRMDESId, this.mIId, this.hRMDESDesignationName});

  DesignationDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMDESId = json['HRMDES_Id'];
    mIId = json['MI_Id'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRMDES_Id'] = hRMDESId;
    data['MI_Id'] = mIId;
    data['HRMDES_DesignationName'] = hRMDESDesignationName;
    return data;
  }
}
