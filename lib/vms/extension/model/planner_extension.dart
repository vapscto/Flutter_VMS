class ExtensionPlannerModel {
  String? type;
  List<Values>? values;

  ExtensionPlannerModel({this.type, this.values});

  ExtensionPlannerModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['$values'] != null) {
      values = <Values>[];
      json['$values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? type;
  int? hrmEId;
  String? employeename;
  String? bymployeename;
  String? hrmEEmployeeCode;
  int? ismplEId;
  String? ismplEFromDate;
  String? ismplEToDate;
  String? ismplEReason;
  bool? ismplEActiveFlg;

  Values(
      {this.type,
      this.hrmEId,
      this.employeename,
      this.bymployeename,
      this.hrmEEmployeeCode,
      this.ismplEId,
      this.ismplEFromDate,
      this.ismplEToDate,
      this.ismplEReason,
      this.ismplEActiveFlg});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hrmEId = json['hrmE_Id'];
    employeename = json['employeename'];
    bymployeename = json['bymployeename'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
    ismplEId = json['ismplE_Id'];
    ismplEFromDate = json['ismplE_FromDate'];
    ismplEToDate = json['ismplE_ToDate'];
    ismplEReason = json['ismplE_Reason'];
    ismplEActiveFlg = json['ismplE_ActiveFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['hrmE_Id'] = this.hrmEId;
    data['employeename'] = this.employeename;
    data['bymployeename'] = this.bymployeename;
    data['hrmE_EmployeeCode'] = this.hrmEEmployeeCode;
    data['ismplE_Id'] = this.ismplEId;
    data['ismplE_FromDate'] = this.ismplEFromDate;
    data['ismplE_ToDate'] = this.ismplEToDate;
    data['ismplE_Reason'] = this.ismplEReason;
    data['ismplE_ActiveFlg'] = this.ismplEActiveFlg;
    return data;
  }
}
