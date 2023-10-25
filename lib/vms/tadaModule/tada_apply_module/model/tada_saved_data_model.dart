class TadaSavedModel {
  String? type;
  List<TadaSavedModelValues>? values;

  TadaSavedModel({this.type, this.values});

  TadaSavedModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TadaSavedModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaSavedModelValues.fromJson(v));
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

class TadaSavedModelValues {
  int? userId;
  int? mIId;
  int? vtadaAId;
  int? hrmEId;
  String? vtadaAStatusFlg;
  String? vtadaAFromDate;
  String? vtadaAToDate;
  String? vtadaACreatedDate;
  int? vtadaAClientId;
  String? vtadaAToAddress;
  double? vtadaATotalAppliedAmount;
  double? vtadaATotalSactionedAmount;
  double? vtadaATotalPaidAmount;
  int? ivrmmcTId;
  int? ivrmmSId;
  int? hrmdeSId;
  bool? returnvalue;
  String? ivrmmcTName;
  String? vtadaADepartureTime;
  String? vtadaAArrivalTime;
  bool? vtadaAActiveFlg;

  TadaSavedModelValues(
      {this.userId,
      this.mIId,
      this.vtadaAId,
      this.hrmEId,
      this.vtadaAStatusFlg,
      this.vtadaAFromDate,
      this.vtadaAToDate,
      this.vtadaACreatedDate,
      this.vtadaAClientId,
      this.vtadaAToAddress,
      this.vtadaATotalAppliedAmount,
      this.vtadaATotalSactionedAmount,
      this.vtadaATotalPaidAmount,
      this.ivrmmcTId,
      this.ivrmmSId,
      this.hrmdeSId,
      this.returnvalue,
      this.ivrmmcTName,
      this.vtadaADepartureTime,
      this.vtadaAArrivalTime,
      this.vtadaAActiveFlg});

  TadaSavedModelValues.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    mIId = json['mI_Id'];
    vtadaAId = json['vtadaA_Id'];
    hrmEId = json['hrmE_Id'];
    vtadaAStatusFlg = json['vtadaA_StatusFlg'];
    vtadaAFromDate = json['vtadaA_FromDate'];
    vtadaAToDate = json['vtadaA_ToDate'];
    vtadaACreatedDate = json['vtadaA_CreatedDate'];
    vtadaAClientId = json['vtadaA_ClientId'];
    vtadaAToAddress = json['vtadaA_ToAddress'];
    vtadaATotalAppliedAmount = json['vtadaA_TotalAppliedAmount'];
    vtadaATotalSactionedAmount = json['vtadaA_TotalSactionedAmount'];
    vtadaATotalPaidAmount = json['vtadaA_TotalPaidAmount'];
    ivrmmcTId = json['ivrmmcT_Id'];
    ivrmmSId = json['ivrmmS_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    returnvalue = json['returnvalue'];
    ivrmmcTName = json['ivrmmcT_Name'];
    vtadaADepartureTime = json['vtadaA_DepartureTime'];
    vtadaAArrivalTime = json['vtadaA_ArrivalTime'];
    vtadaAActiveFlg = json['vtadaA_ActiveFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['mI_Id'] = mIId;
    data['vtadaA_Id'] = vtadaAId;
    data['hrmE_Id'] = hrmEId;
    data['vtadaA_StatusFlg'] = vtadaAStatusFlg;
    data['vtadaA_FromDate'] = vtadaAFromDate;
    data['vtadaA_ToDate'] = vtadaAToDate;
    data['vtadaA_CreatedDate'] = vtadaACreatedDate;
    data['vtadaA_ClientId'] = vtadaAClientId;
    data['vtadaA_ToAddress'] = vtadaAToAddress;
    data['vtadaA_TotalAppliedAmount'] = vtadaATotalAppliedAmount;
    data['vtadaA_TotalSactionedAmount'] = vtadaATotalSactionedAmount;
    data['vtadaA_TotalPaidAmount'] = vtadaATotalPaidAmount;
    data['ivrmmcT_Id'] = ivrmmcTId;
    data['ivrmmS_Id'] = ivrmmSId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['returnvalue'] = returnvalue;
    data['ivrmmcT_Name'] = ivrmmcTName;
    data['vtadaA_DepartureTime'] = vtadaADepartureTime;
    data['vtadaA_ArrivalTime'] = vtadaAArrivalTime;
    data['vtadaA_ActiveFlg'] = vtadaAActiveFlg;
    return data;
  }
}
