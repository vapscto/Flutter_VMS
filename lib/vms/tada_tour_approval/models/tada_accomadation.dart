class TadaAccomodationModel {
  String? type;
  List<TadaAccomodationModelValues>? values;

  TadaAccomodationModel({this.type, this.values});

  TadaAccomodationModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaAccomodationModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(  TadaAccomodationModelValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['MI_Id'] = this.mIId;
    data['MI_Name'] = this.mIName;
    data['VTADACM_AccommodationAmt'] = this.vTADACMAccommodationAmt;
    data['VTADACM_TransportAmt'] = this.vTADACMTransportAmt;
    data['VTADACM_FoodAmt'] = this.vTADACMFoodAmt;
    data['VTADACM_TravelHour'] = this.vTADACMTravelHour;
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
    data['VTADAAAA_SactionedAmount'] = this.vTADAAAASactionedAmount;
    data['VTADAAA_TotalPaidAmount'] = this.vTADAAATotalPaidAmount;
    data['VTADAAA_StatusFlg'] = this.vTADAAAStatusFlg;
    data['User_Id'] = this.userId;
    data['SanctionLevelNo'] = this.sanctionLevelNo;
    data['EmpName'] = this.empName;
    data['ISMMCLT_ClientName'] = this.iSMMCLTClientName;
    data['IVRMMCT_Name'] = this.iVRMMCTName;
    data['VTADAAAD_Id'] = this.vTADAAADId;
    data['VTADAAAD_ExpenditureHead'] = this.vTADAAADExpenditureHead;
    data['VTADAAAD_Amount'] = this.vTADAAADAmount;
    data['VTADAAAAH_SactionedAmount'] = this.vTADAAAAHSactionedAmount;
    data['VTADAAAD_Remarks'] = this.vTADAAADRemarks;
    data['VTADAAAD_Slots'] = this.vTADAAADSlots;
    data['VTADAAAD_TotalSlots'] = this.vTADAAADTotalSlots;
    data['HCNT'] = this.hCNT;
    data['VTADAAAAH_StatusFlg'] = this.vTADAAAAHStatusFlg;
    return data;
  }
}
