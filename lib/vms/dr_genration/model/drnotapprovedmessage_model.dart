class Drnotapprovedmessage {
  String? type;
  List<DrnotapprovedmessageValues>? values;

  Drnotapprovedmessage({this.type, this.values});

  Drnotapprovedmessage.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrnotapprovedmessageValues>[];
      json['\$values'].forEach((v) {
        values!.add(new DrnotapprovedmessageValues.fromJson(v));
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

class DrnotapprovedmessageValues {
  String? type;
  int? hRMEId;
  String? employeeName;
  String? hRMEEmployeeCode;
  String? drDate;
  bool? iSMDRPTOrdersDateFlg;
  String? dRGDate;
  String? iSMDRPTDate;

  DrnotapprovedmessageValues(
      {this.type,
      this.hRMEId,
      this.employeeName,
      this.hRMEEmployeeCode,
      this.drDate,
      this.iSMDRPTOrdersDateFlg,
      this.dRGDate,
      this.iSMDRPTDate});

  DrnotapprovedmessageValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    employeeName = json['EmployeeName'];
    hRMEEmployeeCode = json['HRME_EmployeeCode'];
    drDate = json['Dr_Date'];
    iSMDRPTOrdersDateFlg = json['ISMDRPT_OrdersDateFlg'];
    dRGDate = json['DR_GDate'];
    iSMDRPTDate = json['ISMDRPT_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['HRME_Id'] = this.hRMEId;
    data['EmployeeName'] = this.employeeName;
    data['HRME_EmployeeCode'] = this.hRMEEmployeeCode;
    data['Dr_Date'] = this.drDate;
    data['ISMDRPT_OrdersDateFlg'] = this.iSMDRPTOrdersDateFlg;
    data['DR_GDate'] = this.dRGDate;
    data['ISMDRPT_Date'] = this.iSMDRPTDate;
    return data;
  }
}
