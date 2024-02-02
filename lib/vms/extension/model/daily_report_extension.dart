class ExtensionDailyModel {
  String? type;
  List<Values>? values;

  ExtensionDailyModel({this.type, this.values});

  ExtensionDailyModel.fromJson(Map<String, dynamic> json) {
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
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
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
  int? ismodEId;
  int? ivrMMonthId;
  String? ivrMMonthName;
  String? ismodENoofdays;
  String? ismodEDate;
  String? ismodEReason;
  bool? ismodEActiveFlg;

  Values(
      {this.type,
      this.hrmEId,
      this.employeename,
      this.bymployeename,
      this.hrmEEmployeeCode,
      this.ismodEId,
      this.ivrMMonthId,
      this.ivrMMonthName,
      this.ismodENoofdays,
      this.ismodEDate,
      this.ismodEReason,
      this.ismodEActiveFlg});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hrmEId = json['hrmE_Id'];
    employeename = json['employeename'];
    bymployeename = json['bymployeename'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
    ismodEId = json['ismodE_Id'];
    ivrMMonthId = json['ivrM_Month_Id'];
    ivrMMonthName = json['ivrM_Month_Name'];
    ismodENoofdays = json['ismodE_Noofdays'];
    ismodEDate = json['ismodE_Date'];
    ismodEReason = json['ismodE_Reason'];
    ismodEActiveFlg = json['ismodE_ActiveFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['hrmE_Id'] = hrmEId;
    data['employeename'] = employeename;
    data['bymployeename'] = bymployeename;
    data['hrmE_EmployeeCode'] = hrmEEmployeeCode;
    data['ismodE_Id'] = ismodEId;
    data['ivrM_Month_Id'] = ivrMMonthId;
    data['ivrM_Month_Name'] = ivrMMonthName;
    data['ismodE_Noofdays'] = ismodENoofdays;
    data['ismodE_Date'] = ismodEDate;
    data['ismodE_Reason'] = ismodEReason;
    data['ismodE_ActiveFlg'] = ismodEActiveFlg;
    return data;
  }
}
