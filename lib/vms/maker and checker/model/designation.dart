 class dsgnModel {
  String? type;
  List<dsgnModelValues>? values;

  dsgnModel({this.type, this.values});

  dsgnModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <dsgnModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(  dsgnModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class dsgnModelValues {
  String? type;
  int? hRMDESId;
  int? mIId;
  String? hRMDESDesignationName;
  String? mIName;

  dsgnModelValues(
      {this.type,
      this.hRMDESId,
      this.mIId,
      this.hRMDESDesignationName,
      this.mIName});

  dsgnModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    hRMDESId = json['HRMDES_Id'];
    mIId = json['MI_Id'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
    mIName = json['MI_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['HRMDES_Id'] = this.hRMDESId;
    data['MI_Id'] = this.mIId;
    data['HRMDES_DesignationName'] = this.hRMDESDesignationName;
    data['MI_Name'] = this.mIName;
    return data;
  }
}
