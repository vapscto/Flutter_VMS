class GetTourView {
  String? type;
  List<GetTourViewValues>? values;

  GetTourView({this.type, this.values});

  GetTourView.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <GetTourViewValues>[];
      json['\$values'].forEach((v) {
        values!.add( GetTourViewValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['MI_Id'] = this.mIId;
    data['MI_Name'] = this.mIName;
    data['VTADAAA_Id'] = this.vTADAAAId;
    data['HRME_Id'] = this.hRMEId;
    data['VTADAAA_ToAddress'] = this.vTADAAAToAddress;
    data['VTADAAA_AppliedDate'] = this.vTADAAAAppliedDate;
    data['VTADAAA_FromDate'] = this.vTADAAAFromDate;
    data['VTADAAA_ToDate'] = this.vTADAAAToDate;
    data['VTADAAA_Remarks'] = this.vTADAAARemarks;
    data['VTADAAA_ClientId'] = this.vTADAAAClientId;
    data['IVRMMCT_Id'] = this.iVRMMCTId;
    data['VTADAAA_TotalAppliedAmount'] = this.vTADAAATotalAppliedAmount;
    data['VTADAAA_TotalSactionedAmount'] = this.vTADAAATotalSactionedAmount;
    data['VTADAAA_TotalPaidAmount'] = this.vTADAAATotalPaidAmount;
    data['VTADAAA_StatusFlg'] = this.vTADAAAStatusFlg;
    data['User_Id'] = this.userId;
    data['SanctionLevelNo'] = this.sanctionLevelNo;
    data['EmpName'] = this.empName;
    data['ClientName'] = this.clientName;
    data['CityName'] = this.cityName;
    data['VTADAAAA_SactionedAmount'] = this.vTADAAAASactionedAmount;
    data['IER_ID'] = this.iERID;
    return data;
  }
}
