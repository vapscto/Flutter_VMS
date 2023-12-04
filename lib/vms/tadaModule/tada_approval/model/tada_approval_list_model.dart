class TadaApprovalListModel {
  String? type;
  List<TadaApprovalListModelValues>? values;

  TadaApprovalListModel({this.type, this.values});

  TadaApprovalListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TadaApprovalListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaApprovalListModelValues.fromJson(v));
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

class TadaApprovalListModelValues {
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

  TadaApprovalListModelValues(
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
      this.vTADAAAId});

  TadaApprovalListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    vTADAAId = json['VTADAA_Id'];
    hRMEId = json['HRME_Id'];
    vTADAAToAddress = json['VTADAA_ToAddress'];
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
    clientName = json['ClientName'];
    cityName = json['CityName'];
    vTADAAAASactionedAmount = json['VTADAAAA_SactionedAmount'];
    vTADAAAId = json['VTADAAA_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['MI_Id'] = mIId;
    data['MI_Name'] = mIName;
    data['VTADAA_Id'] = vTADAAId;
    data['HRME_Id'] = hRMEId;
    data['VTADAA_ToAddress'] = vTADAAToAddress;
    data['VTADAA_AppliedDate'] = vTADAAAppliedDate;
    data['VTADAA_FromDate'] = vTADAAFromDate;
    data['VTADAA_ToDate'] = vTADAAToDate;
    data['VTADAA_Remarks'] = vTADAARemarks;
    data['VTADAA_ClientId'] = vTADAAClientId;
    data['IVRMMCT_Id'] = iVRMMCTId;
    data['VTADAA_TotalAppliedAmount'] = vTADAATotalAppliedAmount;
    data['VTADAA_TotalSactionedAmount'] = vTADAATotalSactionedAmount;
    data['VTADAA_TotalPaidAmount'] = vTADAATotalPaidAmount;
    data['VTADAA_StatusFlg'] = vTADAAStatusFlg;
    data['User_Id'] = userId;
    data['SanctionLevelNo'] = sanctionLevelNo;
    data['EmpName'] = empName;
    data['ClientName'] = clientName;
    data['CityName'] = cityName;
    data['VTADAAAA_SactionedAmount'] = vTADAAAASactionedAmount;
    data['VTADAAA_Id'] = vTADAAAId;
    return data;
  }
}
