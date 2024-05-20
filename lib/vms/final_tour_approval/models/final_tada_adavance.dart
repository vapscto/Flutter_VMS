class FinalViewAdvancDetails {
  String? type;
  List<FinalViewAdvancDetailsValues>? values;

  FinalViewAdvancDetails({this.type, this.values});

  FinalViewAdvancDetails.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <FinalViewAdvancDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(new FinalViewAdvancDetailsValues.fromJson(v));
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

class FinalViewAdvancDetailsValues {
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
  String? vTADACMAccommodationAmt;
  String? vTADACMTransportAmt;
  String? vTADACMFoodAmt;
  String? vTADAAARemarks;
  String? iERID;

  FinalViewAdvancDetailsValues(
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
      this.vTADACMFoodAmt,
      this.vTADAAARemarks,
      this.iERID});

  FinalViewAdvancDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    appliedName = json['AppliedName'];
    vTADAAAAppliedDate = json['VTADAAA_AppliedDate'];
    vTADAAAFromDate = json['VTADAAA_FromDate'];
    vTADAAAToDate = json['VTADAAA_ToDate'];
    iSMMCLTClientName = json['ISMMCLT_ClientName']??"";
    vTADAAAToAddress = json['VTADAAA_ToAddress']??"";
    advancedAppliedAmount = json['AdvancedAppliedAmount'];
    vTADAAADStatusFlg = json['VTADAAAD_StatusFlg'];
    vTADAAADTotalSlots = json['VTADAAAD_TotalSlots']??0.0;
    vTADAAADSlots = json['VTADAAAD_Slots']??0.0;
    vTADAAADRemarks = json['VTADAAAD_Remarks']??"";
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
    vTADAAAARemarks = json['VTADAAAA_Remarks']??"";
    vTADAAAAHStatusFlg = json['VTADAAAAH_StatusFlg'];
    vTADAAAAHRemarks = json['VTADAAAAH_Remarks']??"";
    vTADAAAACreatedDate = json['VTADAAAA_CreatedDate'];
    vTADACMAccommodationAmt = json['VTADACM_AccommodationAmt'];
    vTADACMTransportAmt = json['VTADACM_TransportAmt']??"";
    vTADACMFoodAmt = json['VTADACM_FoodAmt']??"";
    vTADAAARemarks = json['VTADAAA_Remarks']??"";
    iERID = json['IER_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['HRME_Id'] = this.hRMEId;
    data['AppliedName'] = this.appliedName;
    data['VTADAAA_AppliedDate'] = this.vTADAAAAppliedDate;
    data['VTADAAA_FromDate'] = this.vTADAAAFromDate;
    data['VTADAAA_ToDate'] = this.vTADAAAToDate;
    data['ISMMCLT_ClientName'] = this.iSMMCLTClientName;
    data['VTADAAA_ToAddress'] = this.vTADAAAToAddress;
    data['AdvancedAppliedAmount'] = this.advancedAppliedAmount;
    data['VTADAAAD_StatusFlg'] = this.vTADAAADStatusFlg;
    data['VTADAAAD_TotalSlots'] = this.vTADAAADTotalSlots;
    data['VTADAAAD_Slots'] = this.vTADAAADSlots;
    data['VTADAAAD_Remarks'] = this.vTADAAADRemarks;
    data['Paid_Amount'] = this.paidAmount;
    data['VTADAAA_DepartureTime'] = this.vTADAAADepartureTime;
    data['VTADAAA_ArrivalTime'] = this.vTADAAAArrivalTime;
    data['VTADAAAD_ExpenditureHead'] = this.vTADAAADExpenditureHead;
    data['ApprovedBy'] = this.approvedBy;
    data['VTADAAA_TotalSactionedAmount'] = this.vTADAAATotalSactionedAmount;
    data['VTADAAAA_SanctioningLevel'] = this.vTADAAAASanctioningLevel;
    data['VTADAAAA_SactionedAmount'] = this.vTADAAAASactionedAmount;
    data['HeadWiseSactionedAmount'] = this.headWiseSactionedAmount;
    data['HeadWiseAppliedAmount'] = this.headWiseAppliedAmount;
    data['VTADAAAA_StatusFlg'] = this.vTADAAAAStatusFlg;
    data['VTADAAAA_Date'] = this.vTADAAAADate;
    data['VTADAAAA_Remarks'] = this.vTADAAAARemarks;
    data['VTADAAAAH_StatusFlg'] = this.vTADAAAAHStatusFlg;
    data['VTADAAAAH_Remarks'] = this.vTADAAAAHRemarks;
    data['VTADAAAA_CreatedDate'] = this.vTADAAAACreatedDate;
    data['VTADACM_AccommodationAmt'] = this.vTADACMAccommodationAmt;
    data['VTADACM_TransportAmt'] = this.vTADACMTransportAmt;
    data['VTADACM_FoodAmt'] = this.vTADACMFoodAmt;
    data['VTADAAA_Remarks'] = this.vTADAAARemarks;
    data['IER_ID'] = this.iERID;
    return data;
  }
}
