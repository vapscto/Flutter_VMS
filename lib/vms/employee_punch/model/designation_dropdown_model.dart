class DesignationDropdownModel {
  String? type;
  List<DesignationDropdownValues>? values;

  DesignationDropdownModel({this.type, this.values});

  DesignationDropdownModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DesignationDropdownValues>[];
      json['\$values'].forEach((v) {
        values!.add(new DesignationDropdownValues.fromJson(v));
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

class DesignationDropdownValues {
  int? mIId;
  int? hrmDId;
  int? hrmdeSId;
  String? hrmdeSDesignationName;
  int? hrmEId;

  DesignationDropdownValues(
      {this.mIId,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmdeSDesignationName,
      this.hrmEId});

  DesignationDropdownValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmdeSDesignationName = json['hrmdeS_DesignationName'];
    hrmEId = json['hrmE_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['hrmD_Id'] = this.hrmDId;
    data['hrmdeS_Id'] = this.hrmdeSId;
    data['hrmdeS_DesignationName'] = this.hrmdeSDesignationName;
    data['hrmE_Id'] = this.hrmEId;
    return data;
  }
}
