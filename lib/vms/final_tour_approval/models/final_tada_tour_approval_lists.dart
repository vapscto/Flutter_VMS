class FinalTadaTourApproval {
  String? type;
  List<FinalTadaTourApprovalValues>? values;

  FinalTadaTourApproval({this.type, this.values});

  FinalTadaTourApproval.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <FinalTadaTourApprovalValues>[];
      json['\$values'].forEach((v) {
        values!.add(new FinalTadaTourApprovalValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinalTadaTourApprovalValues {
  String? type;
  int? mIId;
  String? mIName;
  int? vTADAAId;
  int? hRMEId;
  String? vTADAAToAddress;
  String? vTADAAAppliedDate;
  String? vTADAAFromDate;
  String? vTADAAToDate;
  String? vTADAARemarks;
  int? vTADAAClientId;
  int? iVRMMCTId;
  double? vTADAATotalAppliedAmount;
  double? vTADAATotalSactionedAmount;
  double? vTADAATotalPaidAmount;
  String? vTADAAStatusFlg;
  int? userId;
  int? sanctionLevelNo;
  String? empName;
  String? clientName;
  String? cityName;
  double? vTADAAAASactionedAmount;
  int? vTADAAAId;
  String? iERID;

  FinalTadaTourApprovalValues(
      {this.type,
      this.mIId,
      this.mIName,
      this.vTADAAId,
      this.hRMEId,
      this.vTADAAToAddress,
      this.vTADAAAppliedDate,
      this.vTADAAFromDate,
      this.vTADAAToDate,
      this.vTADAARemarks,
      this.vTADAAClientId,
      this.iVRMMCTId,
      this.vTADAATotalAppliedAmount,
      this.vTADAATotalSactionedAmount,
      this.vTADAATotalPaidAmount,
      this.vTADAAStatusFlg,
      this.userId,
      this.sanctionLevelNo,
      this.empName,
      this.clientName,
      this.cityName,
      this.vTADAAAASactionedAmount,
      this.vTADAAAId,
      this.iERID});

  FinalTadaTourApprovalValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    vTADAAId = json['VTADAA_Id'];
    hRMEId = json['HRME_Id'];
    vTADAAToAddress = json['VTADAA_ToAddress'] ?? "";
    vTADAAAppliedDate = json['VTADAA_AppliedDate'];
    vTADAAFromDate = json['VTADAA_FromDate'];
    vTADAAToDate = json['VTADAA_ToDate'];
    vTADAARemarks = json['VTADAA_Remarks'];
    vTADAAClientId = json['VTADAA_ClientId'];
    iVRMMCTId = json['IVRMMCT_Id'];
    vTADAATotalAppliedAmount = json['VTADAA_TotalAppliedAmount'];
    vTADAATotalSactionedAmount = json['VTADAA_TotalSactionedAmount'];
    vTADAATotalPaidAmount = json['VTADAA_TotalPaidAmount'];
    vTADAAStatusFlg = json['VTADAA_StatusFlg'];
    userId = json['User_Id'];
    sanctionLevelNo = json['SanctionLevelNo'];
    empName = json['EmpName'];
    clientName = json['ClientName'] ??"";
    cityName = json['CityName'];
    vTADAAAASactionedAmount = json['VTADAAAA_SactionedAmount'];
    vTADAAAId = json['VTADAAA_Id'];
    iERID = json['IER_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['MI_Id'] = this.mIId;
    data['MI_Name'] = this.mIName;
    data['VTADAA_Id'] = this.vTADAAId;
    data['HRME_Id'] = this.hRMEId;
    data['VTADAA_ToAddress'] = this.vTADAAToAddress;
    data['VTADAA_AppliedDate'] = this.vTADAAAppliedDate;
    data['VTADAA_FromDate'] = this.vTADAAFromDate;
    data['VTADAA_ToDate'] = this.vTADAAToDate;
    data['VTADAA_Remarks'] = this.vTADAARemarks;
    data['VTADAA_ClientId'] = this.vTADAAClientId;
    data['IVRMMCT_Id'] = this.iVRMMCTId;
    data['VTADAA_TotalAppliedAmount'] = this.vTADAATotalAppliedAmount;
    data['VTADAA_TotalSactionedAmount'] = this.vTADAATotalSactionedAmount;
    data['VTADAA_TotalPaidAmount'] = this.vTADAATotalPaidAmount;
    data['VTADAA_StatusFlg'] = this.vTADAAStatusFlg;
    data['User_Id'] = this.userId;
    data['SanctionLevelNo'] = this.sanctionLevelNo;
    data['EmpName'] = this.empName;
    data['ClientName'] = this.clientName;
    data['CityName'] = this.cityName;
    data['VTADAAAA_SactionedAmount'] = this.vTADAAAASactionedAmount;
    data['VTADAAA_Id'] = this.vTADAAAId;
    data['IER_ID'] = this.iERID;
    return data;
  }
}
