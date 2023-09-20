class CityListModel {
  String? type;
  List<CityListModelValues>? values;

  CityListModel({this.type, this.values});

  CityListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CityListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CityListModelValues.fromJson(v));
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

class CityListModelValues {
  int? vtadaaAId;
  int? mIId;
  int? userId;
  int? ivrmmSId;
  int? ivrmmcTId;
  int? hrmdeSId;
  String? ivrmmcTName;
  int? vtadaaAClientId;
  double? vtadaaATotalAppliedAmount;
  double? vtadaaATotalSactionedAmount;
  double? vtadaaATotalPaidAmount;
  int? hrmEId;
  bool? returnvalue;
  int? hrpaoNSanctionLevelNo;
  int? ivrmuLId;
  bool? vtadaaAActiveFlg;
  bool? countBalance;

  CityListModelValues(
      {this.vtadaaAId,
      this.mIId,
      this.userId,
      this.ivrmmSId,
      this.ivrmmcTId,
      this.hrmdeSId,
      this.ivrmmcTName,
      this.vtadaaAClientId,
      this.vtadaaATotalAppliedAmount,
      this.vtadaaATotalSactionedAmount,
      this.vtadaaATotalPaidAmount,
      this.hrmEId,
      this.returnvalue,
      this.hrpaoNSanctionLevelNo,
      this.ivrmuLId,
      this.vtadaaAActiveFlg,
      this.countBalance});

  CityListModelValues.fromJson(Map<String, dynamic> json) {
    vtadaaAId = json['vtadaaA_Id'];
    mIId = json['mI_Id'];
    userId = json['userId'];
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmcTId = json['ivrmmcT_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    ivrmmcTName = json['ivrmmcT_Name'] ?? " ";
    vtadaaAClientId = json['vtadaaA_ClientId'];
    vtadaaATotalAppliedAmount = json['vtadaaA_TotalAppliedAmount'];
    vtadaaATotalSactionedAmount = json['vtadaaA_TotalSactionedAmount'];
    vtadaaATotalPaidAmount = json['vtadaaA_TotalPaidAmount'];
    hrmEId = json['hrmE_Id'];
    returnvalue = json['returnvalue'];
    hrpaoNSanctionLevelNo = json['hrpaoN_SanctionLevelNo'];
    ivrmuLId = json['ivrmuL_Id'];
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
    data['vtadaaA_ClientId'] = vtadaaAClientId;
    data['vtadaaA_TotalAppliedAmount'] = vtadaaATotalAppliedAmount;
    data['vtadaaA_TotalSactionedAmount'] = vtadaaATotalSactionedAmount;
    data['vtadaaA_TotalPaidAmount'] = vtadaaATotalPaidAmount;
    data['hrmE_Id'] = hrmEId;
    data['returnvalue'] = returnvalue;
    data['hrpaoN_SanctionLevelNo'] = hrpaoNSanctionLevelNo;
    data['ivrmuL_Id'] = ivrmuLId;
    data['vtadaaA_ActiveFlg'] = vtadaaAActiveFlg;
    data['countBalance'] = countBalance;
    return data;
  }
}
