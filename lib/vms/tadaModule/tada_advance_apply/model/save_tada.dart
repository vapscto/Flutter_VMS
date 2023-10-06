class SaveTadaModel {
  int? vtadaaAId;
  int? mIId;
  int? userId;
  int? ivrmmSId;
  int? ivrmmcTId;
  int? hrmdeSId;
  String? vtadaaAFromDate;
  String? vtadaaAToDate;
  int? vtadaaAClientId;
  int? vtadaaATotalAppliedAmount;
  int? vtadaaATotalSactionedAmount;
  int? vtadaaATotalPaidAmount;
  String? vtadaaAToAddress;
  String? vtadaaARemarks;
  int? hrmEId;
  bool? returnvalue;
  String? duplicate;
  int? hrpaoNSanctionLevelNo;
  int? ivrmuLId;
  String? vtadaaADepartureTime;
  String? vtadaaAArrivalTime;
  bool? vtadaaAActiveFlg;
  String? vtadaaAClientMultiple;
  bool? countBalance;

  SaveTadaModel(
      {this.vtadaaAId,
      this.mIId,
      this.userId,
      this.ivrmmSId,
      this.ivrmmcTId,
      this.hrmdeSId,
      this.vtadaaAFromDate,
      this.vtadaaAToDate,
      this.vtadaaAClientId,
      this.vtadaaATotalAppliedAmount,
      this.vtadaaATotalSactionedAmount,
      this.vtadaaATotalPaidAmount,
      this.vtadaaAToAddress,
      this.vtadaaARemarks,
      this.hrmEId,
      this.returnvalue,
      this.duplicate,
      this.hrpaoNSanctionLevelNo,
      this.ivrmuLId,
      this.vtadaaADepartureTime,
      this.vtadaaAArrivalTime,
      this.vtadaaAActiveFlg,
      this.vtadaaAClientMultiple,
      this.countBalance});

  SaveTadaModel.fromJson(Map<String, dynamic> json) {
    vtadaaAId = json['vtadaaA_Id'];
    mIId = json['mI_Id'];
    userId = json['userId'];
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmcTId = json['ivrmmcT_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    vtadaaAFromDate = json['vtadaaA_FromDate'];
    vtadaaAToDate = json['vtadaaA_ToDate'];
    vtadaaAClientId = json['vtadaaA_ClientId'];
    vtadaaATotalAppliedAmount = json['vtadaaA_TotalAppliedAmount'];
    vtadaaATotalSactionedAmount = json['vtadaaA_TotalSactionedAmount'];
    vtadaaATotalPaidAmount = json['vtadaaA_TotalPaidAmount'];
    vtadaaAToAddress = json['vtadaaA_ToAddress'];
    vtadaaARemarks = json['vtadaaA_Remarks'];
    hrmEId = json['hrmE_Id'];
    returnvalue = json['returnvalue'];
    duplicate = json['duplicate'];
    hrpaoNSanctionLevelNo = json['hrpaoN_SanctionLevelNo'];
    ivrmuLId = json['ivrmuL_Id'];
    vtadaaADepartureTime = json['vtadaaA_DepartureTime'];
    vtadaaAArrivalTime = json['vtadaaA_ArrivalTime'];
    vtadaaAActiveFlg = json['vtadaaA_ActiveFlg'];
    vtadaaAClientMultiple = json['vtadaaA_ClientMultiple'];
    countBalance = json['countBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vtadaaA_Id'] = vtadaaAId;
    data['mI_Id'] = mIId;
    data['userId'] = userId;
    data['ivrmmS_Id'] = ivrmmSId;
    data['ivrmmcT_Id'] = ivrmmcTId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['vtadaaA_FromDate'] = vtadaaAFromDate;
    data['vtadaaA_ToDate'] = vtadaaAToDate;
    data['vtadaaA_ClientId'] = vtadaaAClientId;
    data['vtadaaA_TotalAppliedAmount'] = vtadaaATotalAppliedAmount;
    data['vtadaaA_TotalSactionedAmount'] = vtadaaATotalSactionedAmount;
    data['vtadaaA_TotalPaidAmount'] = vtadaaATotalPaidAmount;
    data['vtadaaA_ToAddress'] = vtadaaAToAddress;
    data['vtadaaA_Remarks'] = vtadaaARemarks;
    data['hrmE_Id'] = hrmEId;
    data['returnvalue'] = returnvalue;
    data['duplicate'] = duplicate;
    data['hrpaoN_SanctionLevelNo'] = hrpaoNSanctionLevelNo;
    data['ivrmuL_Id'] = ivrmuLId;
    data['vtadaaA_DepartureTime'] = vtadaaADepartureTime;
    data['vtadaaA_ArrivalTime'] = vtadaaAArrivalTime;
    data['vtadaaA_ActiveFlg'] = vtadaaAActiveFlg;
    data['vtadaaA_ClientMultiple'] = vtadaaAClientMultiple;
    data['countBalance'] = countBalance;
    return data;
  }
}
