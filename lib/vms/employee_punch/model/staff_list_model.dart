class StaffListModel {
  String? type;
  List<StaffListValues>? values;

  StaffListModel({this.type, this.values});

  StaffListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffListValues>[];
      json['\$values'].forEach((v) {
        values!.add( StaffListValues.fromJson(v));
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

class StaffListValues {
  int? mIId;
  int? hrmDId;
  int? hrmdeSId;
  int? hrmEId;
  String? ename;
  String? hrmEEmployeeCode;

  StaffListValues(
      {this.mIId,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmEId,
      this.ename,
      this.hrmEEmployeeCode});

  StaffListValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmEId = json['hrmE_Id'];
    ename = json['ename'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['hrmD_Id'] = this.hrmDId;
    data['hrmdeS_Id'] = this.hrmdeSId;
    data['hrmE_Id'] = this.hrmEId;
    data['ename'] = this.ename;
    data['hrmE_EmployeeCode'] = this.hrmEEmployeeCode;
    return data;
  }
}
