class TadaApprovaEditArrayModel {
  String? type;
  List<TadaApprovaEditArrayModelValues>? values;

  TadaApprovaEditArrayModel({this.type, this.values});

  TadaApprovaEditArrayModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TadaApprovaEditArrayModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaApprovaEditArrayModelValues.fromJson(v));
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

class TadaApprovaEditArrayModelValues {
  String? type;
  int? mIId;
  String? mIName;
  double? vTADACMAccommodationAmt;
  double? vTADACMTransportAmt;
  double? vTADACMFoodAmt;
  double? vTADACMTravelHour;
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
  String? iSMMCLTClientName;
  String? iVRMMCTName;
  int? vTADAADId;
  String? vTADAADExpenditureHead;
  double? vTADAADAmount;
  double? vTADAAAHSactionedAmount;
  String? vTADAADRemarks;
  dynamic vTADAADSlots;
  double? vTADAADTotalslots;
  int? hCNT;

  TadaApprovaEditArrayModelValues(
      {this.type,
      this.mIId,
      this.mIName,
      this.vTADACMAccommodationAmt,
      this.vTADACMTransportAmt,
      this.vTADACMFoodAmt,
      this.vTADACMTravelHour,
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
      this.iSMMCLTClientName,
      this.iVRMMCTName,
      this.vTADAADId,
      this.vTADAADExpenditureHead,
      this.vTADAADAmount,
      this.vTADAAAHSactionedAmount,
      this.vTADAADRemarks,
      this.vTADAADSlots,
      this.vTADAADTotalslots,
      this.hCNT});

  TadaApprovaEditArrayModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    vTADACMAccommodationAmt = json['VTADACM_AccommodationAmt'];
    vTADACMTransportAmt = json['VTADACM_TransportAmt'];
    vTADACMFoodAmt = json['VTADACM_FoodAmt'];
    vTADACMTravelHour = json['VTADACM_TravelHour'];
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
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    iVRMMCTName = json['IVRMMCT_Name'];
    vTADAADId = json['VTADAAD_Id'];
    vTADAADExpenditureHead = json['VTADAAD_ExpenditureHead'];
    vTADAADAmount = json['VTADAAD_Amount'];
    vTADAAAHSactionedAmount = json['VTADAAAH_SactionedAmount'];
    vTADAADRemarks = json['VTADAAD_Remarks'];
    vTADAADSlots = json['VTADAAD_Slots'];
    vTADAADTotalslots = json['VTADAAD_Totalslots'];
    hCNT = json['HCNT'];
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
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['IVRMMCT_Name'] = iVRMMCTName;
    data['VTADAAD_Id'] = vTADAADId;
    data['VTADAAD_ExpenditureHead'] = vTADAADExpenditureHead;
    data['VTADAAD_Amount'] = vTADAADAmount;
    data['VTADAAAH_SactionedAmount'] = vTADAAAHSactionedAmount;
    data['VTADAAD_Remarks'] = vTADAADRemarks;
    data['VTADAAD_Slots'] = vTADAADSlots;
    data['VTADAAD_Totalslots'] = vTADAADTotalslots;
    data['HCNT'] = hCNT;
    return data;
  }
}
