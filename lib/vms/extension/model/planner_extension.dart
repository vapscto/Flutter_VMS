class ExtensionPlannerModel {
  String? type;
  List<ExtensionPlannerModelValues>? values;

  ExtensionPlannerModel({this.type, this.values});

  ExtensionPlannerModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ExtensionPlannerModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ExtensionPlannerModelValues.fromJson(v));
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

class ExtensionPlannerModelValues {
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

  ExtensionPlannerModelValues(
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

  ExtensionPlannerModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['hrmE_Id'] = hrmEId;
    data['employeename'] = employeename;
    data['bymployeename'] = bymployeename;
    data['hrmE_EmployeeCode'] = hrmEEmployeeCode;
    data['ismplE_Id'] = ismplEId;
    data['ismplE_FromDate'] = ismplEFromDate;
    data['ismplE_ToDate'] = ismplEToDate;
    data['ismplE_Reason'] = ismplEReason;
    data['ismplE_ActiveFlg'] = ismplEActiveFlg;
    return data;
  }
}
