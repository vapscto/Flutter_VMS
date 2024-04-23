class GetTourView {
  String? type;
  List<GetTourViewValues>? values;

  GetTourView({this.type, this.values});

  GetTourView.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <GetTourViewValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetTourViewValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTourViewValues {
  String? type;
  int? mIId;
  String? mIName;
  int? vTADAAAId;
  int? hRMEId;
  String? vTADAAAToAddress;
  String? vTADAAAAppliedDate;
  String? vTADAAAFromDate;
  String? vTADAAAToDate;
  String? vTADAAARemarks;
  int? vTADAAAClientId;
  int? iVRMMCTId;
  double? vTADAAATotalAppliedAmount;
  double? vTADAAATotalSactionedAmount;
  double? vTADAAATotalPaidAmount;
  String? vTADAAAStatusFlg;
  int? userId;
  int? sanctionLevelNo;
  String? empName;
  String? clientName;
  String? cityName;
  double? vTADAAAASactionedAmount;
  String? iERID;

  GetTourViewValues(
      {this.type,
      this.mIId,
      this.mIName,
      this.vTADAAAId,
      this.hRMEId,
      this.vTADAAAToAddress,
      this.vTADAAAAppliedDate,
      this.vTADAAAFromDate,
      this.vTADAAAToDate,
      this.vTADAAARemarks,
      this.vTADAAAClientId,
      this.iVRMMCTId,
      this.vTADAAATotalAppliedAmount,
      this.vTADAAATotalSactionedAmount,
      this.vTADAAATotalPaidAmount,
      this.vTADAAAStatusFlg,
      this.userId,
      this.sanctionLevelNo,
      this.empName,
      this.clientName,
      this.cityName,
      this.vTADAAAASactionedAmount,
      this.iERID});

  GetTourViewValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    vTADAAAId = json['VTADAAA_Id'];
    hRMEId = json['HRME_Id'];
    vTADAAAToAddress = json['VTADAAA_ToAddress'] ?? '';
    vTADAAAAppliedDate = json['VTADAAA_AppliedDate'];
    vTADAAAFromDate = json['VTADAAA_FromDate'];
    vTADAAAToDate = json['VTADAAA_ToDate'];
    vTADAAARemarks = json['VTADAAA_Remarks'];
    vTADAAAClientId = json['VTADAAA_ClientId'];
    iVRMMCTId = json['IVRMMCT_Id'];
    vTADAAATotalAppliedAmount = json['VTADAAA_TotalAppliedAmount'];
    vTADAAATotalSactionedAmount = json['VTADAAA_TotalSactionedAmount'];
    vTADAAATotalPaidAmount = json['VTADAAA_TotalPaidAmount'];
    vTADAAAStatusFlg = json['VTADAAA_StatusFlg'];
    userId = json['User_Id'];
    sanctionLevelNo = json['SanctionLevelNo'];
    empName = json['EmpName'];
    clientName = json['ClientName'] ?? '';
    cityName = json['CityName'];
    vTADAAAASactionedAmount = json['VTADAAAA_SactionedAmount'];
    iERID = json['IER_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['MI_Id'] = mIId;
    data['MI_Name'] = mIName;
    data['VTADAAA_Id'] = vTADAAAId;
    data['HRME_Id'] = hRMEId;
    data['VTADAAA_ToAddress'] = vTADAAAToAddress;
    data['VTADAAA_AppliedDate'] = vTADAAAAppliedDate;
    data['VTADAAA_FromDate'] = vTADAAAFromDate;
    data['VTADAAA_ToDate'] = vTADAAAToDate;
    data['VTADAAA_Remarks'] = vTADAAARemarks;
    data['VTADAAA_ClientId'] = vTADAAAClientId;
    data['IVRMMCT_Id'] = iVRMMCTId;
    data['VTADAAA_TotalAppliedAmount'] = vTADAAATotalAppliedAmount;
    data['VTADAAA_TotalSactionedAmount'] = vTADAAATotalSactionedAmount;
    data['VTADAAA_TotalPaidAmount'] = vTADAAATotalPaidAmount;
    data['VTADAAA_StatusFlg'] = vTADAAAStatusFlg;
    data['User_Id'] = userId;
    data['SanctionLevelNo'] = sanctionLevelNo;
    data['EmpName'] = empName;
    data['ClientName'] = clientName;
    data['CityName'] = cityName;
    data['VTADAAAA_SactionedAmount'] = vTADAAAASactionedAmount;
    data['IER_ID'] = iERID;
    return data;
  }
}
