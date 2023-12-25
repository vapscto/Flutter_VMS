class BalanceApplyModel {
  String? type;
  List<BalanceApplyModelValues>? values;

  BalanceApplyModel({this.type, this.values});

  BalanceApplyModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <BalanceApplyModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(BalanceApplyModelValues.fromJson(v));
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

class BalanceApplyModelValues {
  String? type;
  int? hRMEId;
  String? appliedName;
  String? vTADAAAAppliedDate;
  String? vTADAAAFromDate;
  String? vTADAAAToDate;
  String? iSMMCLTClientName;
  String? vTADAAAToAddress;
  double? advancedAppliedAmount;
  String? vTADAAADStatusFlg;
  double? vTADAAADTotalSlots;
  double? vTADAAADSlots;
  String? vTADAAADRemarks;
  double? paidAmount;
  String? vTADAAADepartureTime;
  String? vTADAAAArrivalTime;
  String? vTADAAADExpenditureHead;
  String? approvedBy;
  double? vTADAAATotalSactionedAmount;
  int? vTADAAAASanctioningLevel;
  double? vTADAAAASactionedAmount;
  double? headWiseSactionedAmount;
  double? headWiseAppliedAmount;
  String? vTADAAAAStatusFlg;
  String? vTADAAAADate;
  String? vTADAAAARemarks;
  String? vTADAAAAHStatusFlg;
  String? vTADAAAAHRemarks;
  String? vTADAAAACreatedDate;
  double? vTADACMAccommodationAmt;
  double? vTADACMTransportAmt;
  double? vTADACMFoodAmt;

  BalanceApplyModelValues(
      {this.type,
      this.hRMEId,
      this.appliedName,
      this.vTADAAAAppliedDate,
      this.vTADAAAFromDate,
      this.vTADAAAToDate,
      this.iSMMCLTClientName,
      this.vTADAAAToAddress,
      this.advancedAppliedAmount,
      this.vTADAAADStatusFlg,
      this.vTADAAADTotalSlots,
      this.vTADAAADSlots,
      this.vTADAAADRemarks,
      this.paidAmount,
      this.vTADAAADepartureTime,
      this.vTADAAAArrivalTime,
      this.vTADAAADExpenditureHead,
      this.approvedBy,
      this.vTADAAATotalSactionedAmount,
      this.vTADAAAASanctioningLevel,
      this.vTADAAAASactionedAmount,
      this.headWiseSactionedAmount,
      this.headWiseAppliedAmount,
      this.vTADAAAAStatusFlg,
      this.vTADAAAADate,
      this.vTADAAAARemarks,
      this.vTADAAAAHStatusFlg,
      this.vTADAAAAHRemarks,
      this.vTADAAAACreatedDate,
      this.vTADACMAccommodationAmt,
      this.vTADACMTransportAmt,
      this.vTADACMFoodAmt});

  BalanceApplyModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    appliedName = json['AppliedName'];
    vTADAAAAppliedDate = json['VTADAAA_AppliedDate'];
    vTADAAAFromDate = json['VTADAAA_FromDate'];
    vTADAAAToDate = json['VTADAAA_ToDate'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    vTADAAAToAddress = json['VTADAAA_ToAddress'];
    advancedAppliedAmount = json['AdvancedAppliedAmount'];
    vTADAAADStatusFlg = json['VTADAAAD_StatusFlg'];
    vTADAAADTotalSlots = json['VTADAAAD_TotalSlots'];
    vTADAAADSlots = json['VTADAAAD_Slots'];
    vTADAAADRemarks = json['VTADAAAD_Remarks'];
    paidAmount = json['Paid_Amount'];
    vTADAAADepartureTime = json['VTADAAA_DepartureTime'];
    vTADAAAArrivalTime = json['VTADAAA_ArrivalTime'];
    vTADAAADExpenditureHead = json['VTADAAAD_ExpenditureHead'];
    approvedBy = json['ApprovedBy'];
    vTADAAATotalSactionedAmount = json['VTADAAA_TotalSactionedAmount'];
    vTADAAAASanctioningLevel = json['VTADAAAA_SanctioningLevel'];
    vTADAAAASactionedAmount = json['VTADAAAA_SactionedAmount'];
    headWiseSactionedAmount = json['HeadWiseSactionedAmount'];
    headWiseAppliedAmount = json['HeadWiseAppliedAmount'];
    vTADAAAAStatusFlg = json['VTADAAAA_StatusFlg'];
    vTADAAAADate = json['VTADAAAA_Date'];
    vTADAAAARemarks = json['VTADAAAA_Remarks'];
    vTADAAAAHStatusFlg = json['VTADAAAAH_StatusFlg'];
    vTADAAAAHRemarks = json['VTADAAAAH_Remarks'];
    vTADAAAACreatedDate = json['VTADAAAA_CreatedDate'];
    vTADACMAccommodationAmt = json['VTADACM_AccommodationAmt'];
    vTADACMTransportAmt = json['VTADACM_TransportAmt'];
    vTADACMFoodAmt = json['VTADACM_FoodAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['AppliedName'] = appliedName;
    data['VTADAAA_AppliedDate'] = vTADAAAAppliedDate;
    data['VTADAAA_FromDate'] = vTADAAAFromDate;
    data['VTADAAA_ToDate'] = vTADAAAToDate;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['VTADAAA_ToAddress'] = vTADAAAToAddress;
    data['AdvancedAppliedAmount'] = advancedAppliedAmount;
    data['VTADAAAD_StatusFlg'] = vTADAAADStatusFlg;
    data['VTADAAAD_TotalSlots'] = vTADAAADTotalSlots;
    data['VTADAAAD_Slots'] = vTADAAADSlots;
    data['VTADAAAD_Remarks'] = vTADAAADRemarks;
    data['Paid_Amount'] = paidAmount;
    data['VTADAAA_DepartureTime'] = vTADAAADepartureTime;
    data['VTADAAA_ArrivalTime'] = vTADAAAArrivalTime;
    data['VTADAAAD_ExpenditureHead'] = vTADAAADExpenditureHead;
    data['ApprovedBy'] = approvedBy;
    data['VTADAAA_TotalSactionedAmount'] = vTADAAATotalSactionedAmount;
    data['VTADAAAA_SanctioningLevel'] = vTADAAAASanctioningLevel;
    data['VTADAAAA_SactionedAmount'] = vTADAAAASactionedAmount;
    data['HeadWiseSactionedAmount'] = headWiseSactionedAmount;
    data['HeadWiseAppliedAmount'] = headWiseAppliedAmount;
    data['VTADAAAA_StatusFlg'] = vTADAAAAStatusFlg;
    data['VTADAAAA_Date'] = vTADAAAADate;
    data['VTADAAAA_Remarks'] = vTADAAAARemarks;
    data['VTADAAAAH_StatusFlg'] = vTADAAAAHStatusFlg;
    data['VTADAAAAH_Remarks'] = vTADAAAAHRemarks;
    data['VTADAAAA_CreatedDate'] = vTADAAAACreatedDate;
    data['VTADACM_AccommodationAmt'] = vTADACMAccommodationAmt;
    data['VTADACM_TransportAmt'] = vTADACMTransportAmt;
    data['VTADACM_FoodAmt'] = vTADACMFoodAmt;
    return data;
  }
}
