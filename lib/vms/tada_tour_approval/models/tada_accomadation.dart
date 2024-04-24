class TadaAccomodationModel {
  String? type;
  List<TadaAccomodationModelValues>? values;

  TadaAccomodationModel({this.type, this.values});

  TadaAccomodationModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaAccomodationModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaAccomodationModelValues.fromJson(v));
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

class TadaAccomodationModelValues {
  String? type;
  int? mIId;
  String? mIName;
  double? vTADACMAccommodationAmt;
  double? vTADACMTransportAmt;
  double? vTADACMFoodAmt;
  int? vTADACMTravelHour;
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
  double? vTADAAAASactionedAmount;
  double? vTADAAATotalPaidAmount;
  String? vTADAAAStatusFlg;
  int? userId;
  int? sanctionLevelNo;
  String? empName;
  String? iSMMCLTClientName;
  String? iVRMMCTName;
  int? vTADAAADId;
  String? vTADAAADExpenditureHead;
  double? vTADAAADAmount;
  double? vTADAAAAHSactionedAmount;
  String? vTADAAADRemarks;
  double? vTADAAADSlots;
  double? vTADAAADTotalSlots;
  int? hCNT;
  String? vTADAAAAHStatusFlg;

  TadaAccomodationModelValues(
      {this.type,
      this.mIId,
      this.mIName,
      this.vTADACMAccommodationAmt,
      this.vTADACMTransportAmt,
      this.vTADACMFoodAmt,
      this.vTADACMTravelHour,
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
      this.vTADAAAASactionedAmount,
      this.vTADAAATotalPaidAmount,
      this.vTADAAAStatusFlg,
      this.userId,
      this.sanctionLevelNo,
      this.empName,
      this.iSMMCLTClientName,
      this.iVRMMCTName,
      this.vTADAAADId,
      this.vTADAAADExpenditureHead,
      this.vTADAAADAmount,
      this.vTADAAAAHSactionedAmount,
      this.vTADAAADRemarks,
      this.vTADAAADSlots,
      this.vTADAAADTotalSlots,
      this.hCNT,
      this.vTADAAAAHStatusFlg});

  TadaAccomodationModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    vTADACMAccommodationAmt = json['VTADACM_AccommodationAmt'];
    vTADACMTransportAmt = json['VTADACM_TransportAmt'];
    vTADACMFoodAmt = json['VTADACM_FoodAmt'];
    vTADACMTravelHour = json['VTADACM_TravelHour'];
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
    vTADAAAASactionedAmount = json['VTADAAAA_SactionedAmount'];
    vTADAAATotalPaidAmount = json['VTADAAA_TotalPaidAmount'];
    vTADAAAStatusFlg = json['VTADAAA_StatusFlg'];
    userId = json['User_Id'];
    sanctionLevelNo = json['SanctionLevelNo'];
    empName = json['EmpName'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    iVRMMCTName = json['IVRMMCT_Name'];
    vTADAAADId = json['VTADAAAD_Id'];
    vTADAAADExpenditureHead = json['VTADAAAD_ExpenditureHead'];
    vTADAAADAmount = json['VTADAAAD_Amount'];
    vTADAAAAHSactionedAmount = json['VTADAAAAH_SactionedAmount'];
    vTADAAADRemarks = json['VTADAAAD_Remarks'];
    vTADAAADSlots = json['VTADAAAD_Slots']?? 0.0;
    vTADAAADTotalSlots = json['VTADAAAD_TotalSlots'] ?? 0.0;
    hCNT = json['HCNT'];
    vTADAAAAHStatusFlg = json['VTADAAAAH_StatusFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['MI_Id'] = mIId;
    data['MI_Name'] = mIName;
    data['VTADACM_AccommodationAmt'] = vTADACMAccommodationAmt;
    data['VTADACM_TransportAmt'] = vTADACMTransportAmt;
    data['VTADACM_FoodAmt'] = vTADACMFoodAmt;
    data['VTADACM_TravelHour'] = vTADACMTravelHour;
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
    data['VTADAAAA_SactionedAmount'] = vTADAAAASactionedAmount;
    data['VTADAAA_TotalPaidAmount'] = vTADAAATotalPaidAmount;
    data['VTADAAA_StatusFlg'] = vTADAAAStatusFlg;
    data['User_Id'] = userId;
    data['SanctionLevelNo'] = sanctionLevelNo;
    data['EmpName'] = empName;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['IVRMMCT_Name'] = iVRMMCTName;
    data['VTADAAAD_Id'] = vTADAAADId;
    data['VTADAAAD_ExpenditureHead'] = vTADAAADExpenditureHead;
    data['VTADAAAD_Amount'] = vTADAAADAmount;
    data['VTADAAAAH_SactionedAmount'] = vTADAAAAHSactionedAmount;
    data['VTADAAAD_Remarks'] = vTADAAADRemarks;
    data['VTADAAAD_Slots'] = vTADAAADSlots;
    data['VTADAAAD_TotalSlots'] = vTADAAADTotalSlots;
    data['HCNT'] = hCNT;
    data['VTADAAAAH_StatusFlg'] = vTADAAAAHStatusFlg;
    return data;
  }
}
