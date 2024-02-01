class Drnotapprovedmessage {
  String? type;
  List<DrnotapprovedmessageValues>? values;

  Drnotapprovedmessage({this.type, this.values});

  Drnotapprovedmessage.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrnotapprovedmessageValues>[];
      json['\$values'].forEach((v) {
        values!.add(DrnotapprovedmessageValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['EmployeeName'] = employeeName;
    data['HRME_EmployeeCode'] = hRMEEmployeeCode;
    data['Dr_Date'] = drDate;
    data['ISMDRPT_OrdersDateFlg'] = iSMDRPTOrdersDateFlg;
    data['DR_GDate'] = dRGDate;
    data['ISMDRPT_Date'] = iSMDRPTDate;
    return data;
  }
}
