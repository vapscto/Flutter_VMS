class TimeArrayTADAData {
  String? type;
  List<TimeArrayTADADataValues>? values;

  TimeArrayTADAData({this.type, this.values});

  TimeArrayTADAData.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TimeArrayTADADataValues>[];
      json['\$values'].forEach((v) {
        values!.add(TimeArrayTADADataValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeArrayTADADataValues {
  int? vtadaaAId;
  int? mIId;
  int? hrmEId;
  String? vtadaaAAppliedDate;
  String? vtadaaAFromDate;
  String? vtadaaAToDate;
  int? vtadaaAClientId;
  String? vtadaaAToAddress;
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
  String? vtadaaAClientMultiple;

  TimeArrayTADADataValues(
      {this.vtadaaAId,
      this.mIId,
      this.hrmEId,
      this.vtadaaAAppliedDate,
      this.vtadaaAFromDate,
      this.vtadaaAToDate,
      this.vtadaaAClientId,
      this.vtadaaAToAddress,
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
      this.vtadaaAClientMultiple});

  TimeArrayTADADataValues.fromJson(Map<String, dynamic> json) {
    vtadaaAId = json['vtadaaA_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    vtadaaAAppliedDate = json['vtadaaA_AppliedDate'];
    vtadaaAFromDate = json['vtadaaA_FromDate'];
    vtadaaAToDate = json['vtadaaA_ToDate'];
    vtadaaAClientId = json['vtadaaA_ClientId'];
    vtadaaAToAddress = json['vtadaaA_ToAddress'];
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
    vtadaaAClientMultiple = json['vtadaaA_ClientMultiple'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vtadaaA_Id'] = vtadaaAId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['vtadaaA_AppliedDate'] = vtadaaAAppliedDate;
    data['vtadaaA_FromDate'] = vtadaaAFromDate;
    data['vtadaaA_ToDate'] = vtadaaAToDate;
    data['vtadaaA_ClientId'] = vtadaaAClientId;
    data['vtadaaA_ToAddress'] = vtadaaAToAddress;
    data['vtadaaA_Remarks'] = vtadaaARemarks;
    data['vtadaaA_TotalAppliedAmount'] = vtadaaATotalAppliedAmount;
    data['vtadaaA_TotalSactionedAmount'] = vtadaaATotalSactionedAmount;
    data['vtadaaA_TotalPaidAmount'] = vtadaaATotalPaidAmount;
    data['vtadaaA_StatusFlg'] = vtadaaAStatusFlg;
    data['vtadaaA_ActiveFlg'] = vtadaaAActiveFlg;
    data['vtadaaA_CreatedBy'] = vtadaaACreatedBy;
    data['vtadaaA_UpdatedBy'] = vtadaaAUpdatedBy;
    data['vtadaaA_CreatedDate'] = vtadaaACreatedDate;
    data['vtadaaA_UpdatedDate'] = vtadaaAUpdatedDate;
    data['ivrmmcT_Id'] = ivrmmcTId;
    data['vtadaaA_DepartureTime'] = vtadaaADepartureTime;
    data['vtadaaA_ArrivalTime'] = vtadaaAArrivalTime;
    data['vtadaaA_ClientMultiple'] = vtadaaAClientMultiple;
    return data;
  }
}
