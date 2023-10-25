class EditModel {
  String? type;
  List<EditModelValues>? values;

  EditModel({this.type, this.values});

  EditModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EditModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(EditModelValues.fromJson(v));
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

class EditModelValues {
  int? vtadaaAId;
  int? mIId;
  int? userId;
  int? ivrmmSId;
  int? ivrmmcTId;
  int? hrmdeSId;
  String? ivrmmcTName;
  String? vtadaaAFromDate;
  String? vtadaaAToDate;
  int? vtadaaAClientId;
  double? vtadaaATotalAppliedAmount;
  double? vtadaaATotalSactionedAmount;
  double? vtadaaATotalPaidAmount;
  String? vtadaaAToAddress;
  String? ivrmmSName;
  String? vtadaaARemarks;
  int? hrmEId;
  bool? returnvalue;
  int? hrpaoNSanctionLevelNo;
  int? ivrmuLId;
  String? vtadaaADepartureTime;
  String? vtadaaAArrivalTime;
  bool? vtadaaAActiveFlg;
  bool? countBalance;

  EditModelValues(
      {this.vtadaaAId,
      this.mIId,
      this.userId,
      this.ivrmmSId,
      this.ivrmmcTId,
      this.hrmdeSId,
      this.ivrmmcTName,
      this.vtadaaAFromDate,
      this.vtadaaAToDate,
      this.vtadaaAClientId,
      this.vtadaaATotalAppliedAmount,
      this.vtadaaATotalSactionedAmount,
      this.vtadaaATotalPaidAmount,
      this.vtadaaAToAddress,
      this.ivrmmSName,
      this.vtadaaARemarks,
      this.hrmEId,
      this.returnvalue,
      this.hrpaoNSanctionLevelNo,
      this.ivrmuLId,
      this.vtadaaADepartureTime,
      this.vtadaaAArrivalTime,
      this.vtadaaAActiveFlg,
      this.countBalance});

  EditModelValues.fromJson(Map<String, dynamic> json) {
    vtadaaAId = json['vtadaaA_Id'];
    mIId = json['mI_Id'];
    userId = json['userId'];
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmcTId = json['ivrmmcT_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    ivrmmcTName = json['ivrmmcT_Name'];
    vtadaaAFromDate = json['vtadaaA_FromDate'];
    vtadaaAToDate = json['vtadaaA_ToDate'];
    vtadaaAClientId = json['vtadaaA_ClientId'];
    vtadaaATotalAppliedAmount = json['vtadaaA_TotalAppliedAmount'];
    vtadaaATotalSactionedAmount = json['vtadaaA_TotalSactionedAmount'];
    vtadaaATotalPaidAmount = json['vtadaaA_TotalPaidAmount'];
    vtadaaAToAddress = json['vtadaaA_ToAddress'];
    ivrmmSName = json['ivrmmS_Name'];
    vtadaaARemarks = json['vtadaaA_Remarks'];
    hrmEId = json['hrmE_Id'];
    returnvalue = json['returnvalue'];
    hrpaoNSanctionLevelNo = json['hrpaoN_SanctionLevelNo'];
    ivrmuLId = json['ivrmuL_Id'];
    vtadaaADepartureTime = json['vtadaaA_DepartureTime'];
    vtadaaAArrivalTime = json['vtadaaA_ArrivalTime'];
    vtadaaAActiveFlg = json['vtadaaA_ActiveFlg'];
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
    data['ivrmmcT_Name'] = ivrmmcTName;
    data['vtadaaA_FromDate'] = vtadaaAFromDate;
    data['vtadaaA_ToDate'] = vtadaaAToDate;
    data['vtadaaA_ClientId'] = vtadaaAClientId;
    data['vtadaaA_TotalAppliedAmount'] = vtadaaATotalAppliedAmount;
    data['vtadaaA_TotalSactionedAmount'] = vtadaaATotalSactionedAmount;
    data['vtadaaA_TotalPaidAmount'] = vtadaaATotalPaidAmount;
    data['vtadaaA_ToAddress'] = vtadaaAToAddress;
    data['ivrmmS_Name'] = ivrmmSName;
    data['vtadaaA_Remarks'] = vtadaaARemarks;
    data['hrmE_Id'] = hrmEId;
    data['returnvalue'] = returnvalue;
    data['hrpaoN_SanctionLevelNo'] = hrpaoNSanctionLevelNo;
    data['ivrmuL_Id'] = ivrmuLId;
    data['vtadaaA_DepartureTime'] = vtadaaADepartureTime;
    data['vtadaaA_ArrivalTime'] = vtadaaAArrivalTime;
    data['vtadaaA_ActiveFlg'] = vtadaaAActiveFlg;
    data['countBalance'] = countBalance;
    return data;
  }
}
