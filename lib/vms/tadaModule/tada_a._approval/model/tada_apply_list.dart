class TadaApplyList {
  int? userId;
  int? mIId;
  int? vtadaAId;
  int? hrpaoNSanctionLevelNo;
  int? level;
  int? vtadaaAId;
  int? hrmEId;
  int? vtadaAClientId;
  int? vtadaATotalAppliedAmount;
  int? vtadaaATotalSactionedAmount;
  int? ivrmmcTId;
  int? hrmdeSId;
  int? approvecnt;
  bool? returnvalue;
  Getadvancetada? getadvancetada;

  TadaApplyList(
      {this.userId,
      this.mIId,
      this.vtadaAId,
      this.hrpaoNSanctionLevelNo,
      this.level,
      this.vtadaaAId,
      this.hrmEId,
      this.vtadaAClientId,
      this.vtadaATotalAppliedAmount,
      this.vtadaaATotalSactionedAmount,
      this.ivrmmcTId,
      this.hrmdeSId,
      this.approvecnt,
      this.returnvalue,
      this.getadvancetada});

  TadaApplyList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    mIId = json['mI_Id'];
    vtadaAId = json['vtadaA_Id'];
    hrpaoNSanctionLevelNo = json['hrpaoN_SanctionLevelNo'];
    level = json['level'];
    vtadaaAId = json['vtadaaA_Id'];
    hrmEId = json['hrmE_Id'];
    vtadaAClientId = json['vtadaA_ClientId'];
    vtadaATotalAppliedAmount = json['vtadaA_TotalAppliedAmount'];
    vtadaaATotalSactionedAmount = json['vtadaaA_TotalSactionedAmount'];
    ivrmmcTId = json['ivrmmcT_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    approvecnt = json['approvecnt'];
    returnvalue = json['returnvalue'];
    getadvancetada = json['getadvancetada'] != null
        ? Getadvancetada.fromJson(json['getadvancetada'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['mI_Id'] = mIId;
    data['vtadaA_Id'] = vtadaAId;
    data['hrpaoN_SanctionLevelNo'] = hrpaoNSanctionLevelNo;
    data['level'] = level;
    data['vtadaaA_Id'] = vtadaaAId;
    data['hrmE_Id'] = hrmEId;
    data['vtadaA_ClientId'] = vtadaAClientId;
    data['vtadaA_TotalAppliedAmount'] = vtadaATotalAppliedAmount;
    data['vtadaaA_TotalSactionedAmount'] = vtadaaATotalSactionedAmount;
    data['ivrmmcT_Id'] = ivrmmcTId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['approvecnt'] = approvecnt;
    data['returnvalue'] = returnvalue;
    if (getadvancetada != null) {
      data['getadvancetada'] = getadvancetada!.toJson();
    }
    return data;
  }
}

class Getadvancetada {
  String? type;
  List<GetadvancetadaValues>? values;

  Getadvancetada({this.type, this.values});

  Getadvancetada.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetadvancetadaValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetadvancetadaValues.fromJson(v));
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

class GetadvancetadaValues {
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

  GetadvancetadaValues(
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
      this.vTADAAAASactionedAmount});

  GetadvancetadaValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    vTADAAAId = json['VTADAAA_Id'];
    hRMEId = json['HRME_Id'];
    vTADAAAToAddress = json['VTADAAA_ToAddress'];
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
    clientName = json['ClientName'];
    cityName = json['CityName'];
    vTADAAAASactionedAmount = json['VTADAAAA_SactionedAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
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
    data['VTADAAA_TotalAppliedAmount'] = vTADAAATotalAppliedAmount!.toDouble();
    data['VTADAAA_TotalSactionedAmount'] = vTADAAATotalSactionedAmount;
    data['VTADAAA_TotalPaidAmount'] = vTADAAATotalPaidAmount;
    data['VTADAAA_StatusFlg'] = vTADAAAStatusFlg;
    data['User_Id'] = userId;
    data['SanctionLevelNo'] = sanctionLevelNo;
    data['EmpName'] = empName;
    data['ClientName'] = clientName;
    data['CityName'] = cityName;
    data['VTADAAAA_SactionedAmount'] = vTADAAAASactionedAmount;
    return data;
  }
}
