class TadaTimeArray {
  String? type;
  List<TadaTimeArrayValues>? values;

  TadaTimeArray({this.type, this.values});

  TadaTimeArray.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaTimeArrayValues>[];
      json['\$values'].forEach((v) {
        values!.add(new TadaTimeArrayValues.fromJson(v));
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

class TadaTimeArrayValues {
  int? vtadaaAId;
  int? mIId;
  int? hrmEId;
  String? vtadaaAAppliedDate;
  String? vtadaaAFromDate;
  String? vtadaaAToDate;
  int? vtadaaAClientId;
  String? vtadaaARemarks;
  double? vtadaaATotalAppliedAmount;
  double? vtadaaATotalSactionedAmount;
  double? vtadaaATotalPaidAmount;
  String? vtadaaAStatusFlg;
  bool? vtadaaAActiveFlg;
  int? vtadaaACreatedBy;
  int? vtadaaAUpdatedBy;
  String? vtadaaACreatedDate;
  String? vtadaaAUpdatedDate;
  int? ivrmmcTId;
  String? vtadaaADepartureTime;
  String? vtadaaAArrivalTime;
  String? ieRID;

  TadaTimeArrayValues(
      {this.vtadaaAId,
      this.mIId,
      this.hrmEId,
      this.vtadaaAAppliedDate,
      this.vtadaaAFromDate,
      this.vtadaaAToDate,
      this.vtadaaAClientId,
      this.vtadaaARemarks,
      this.vtadaaATotalAppliedAmount,
      this.vtadaaATotalSactionedAmount,
      this.vtadaaATotalPaidAmount,
      this.vtadaaAStatusFlg,
      this.vtadaaAActiveFlg,
      this.vtadaaACreatedBy,
      this.vtadaaAUpdatedBy,
      this.vtadaaACreatedDate,
      this.vtadaaAUpdatedDate,
      this.ivrmmcTId,
      this.vtadaaADepartureTime,
      this.vtadaaAArrivalTime,
      this.ieRID});

  TadaTimeArrayValues.fromJson(Map<String, dynamic> json) {
    vtadaaAId = json['vtadaaA_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    vtadaaAAppliedDate = json['vtadaaA_AppliedDate'];
    vtadaaAFromDate = json['vtadaaA_FromDate'];
    vtadaaAToDate = json['vtadaaA_ToDate'];
    vtadaaAClientId = json['vtadaaA_ClientId'];
    vtadaaARemarks = json['vtadaaA_Remarks'];
    vtadaaATotalAppliedAmount = json['vtadaaA_TotalAppliedAmount'];
    vtadaaATotalSactionedAmount = json['vtadaaA_TotalSactionedAmount'];
    vtadaaATotalPaidAmount = json['vtadaaA_TotalPaidAmount'];
    vtadaaAStatusFlg = json['vtadaaA_StatusFlg'];
    vtadaaAActiveFlg = json['vtadaaA_ActiveFlg'];
    vtadaaACreatedBy = json['vtadaaA_CreatedBy'];
    vtadaaAUpdatedBy = json['vtadaaA_UpdatedBy'];
    vtadaaACreatedDate = json['vtadaaA_CreatedDate'];
    vtadaaAUpdatedDate = json['vtadaaA_UpdatedDate'];
    ivrmmcTId = json['ivrmmcT_Id'];
    vtadaaADepartureTime = json['vtadaaA_DepartureTime'];
    vtadaaAArrivalTime = json['vtadaaA_ArrivalTime'];
    ieRID = json['ieR_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vtadaaA_Id'] = this.vtadaaAId;
    data['mI_Id'] = this.mIId;
    data['hrmE_Id'] = this.hrmEId;
    data['vtadaaA_AppliedDate'] = this.vtadaaAAppliedDate;
    data['vtadaaA_FromDate'] = this.vtadaaAFromDate;
    data['vtadaaA_ToDate'] = this.vtadaaAToDate;
    data['vtadaaA_ClientId'] = this.vtadaaAClientId;
    data['vtadaaA_Remarks'] = this.vtadaaARemarks;
    data['vtadaaA_TotalAppliedAmount'] = this.vtadaaATotalAppliedAmount;
    data['vtadaaA_TotalSactionedAmount'] = this.vtadaaATotalSactionedAmount;
    data['vtadaaA_TotalPaidAmount'] = this.vtadaaATotalPaidAmount;
    data['vtadaaA_StatusFlg'] = this.vtadaaAStatusFlg;
    data['vtadaaA_ActiveFlg'] = this.vtadaaAActiveFlg;
    data['vtadaaA_CreatedBy'] = this.vtadaaACreatedBy;
    data['vtadaaA_UpdatedBy'] = this.vtadaaAUpdatedBy;
    data['vtadaaA_CreatedDate'] = this.vtadaaACreatedDate;
    data['vtadaaA_UpdatedDate'] = this.vtadaaAUpdatedDate;
    data['ivrmmcT_Id'] = this.ivrmmcTId;
    data['vtadaaA_DepartureTime'] = this.vtadaaADepartureTime;
    data['vtadaaA_ArrivalTime'] = this.vtadaaAArrivalTime;
    data['ieR_ID'] = this.ieRID;
    return data;
  }
}
