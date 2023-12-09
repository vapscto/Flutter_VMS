class AdvanceApplyModel {
  String? type;
  List<AdvanceApplyModelValues>? values;

  AdvanceApplyModel({this.type, this.values});

  AdvanceApplyModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AdvanceApplyModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AdvanceApplyModelValues.fromJson(v));
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

class AdvanceApplyModelValues {
  String? type;
  int? vTADAAAId;
  String? empName;
  String? vTADAAAAppliedDate;
  String? vTADAAAFromDate;
  String? vTADAAAToDate;
  String? vTADAAAToAddress;
  String? vTADAAARemarks;
  int? vTADAAATotalAppliedAmount;
  String? vTADAAADepartureTime;
  String? vTADAAAArrivalTime;
  String? iVRMMCTName;
  String? iVRMMSName;

  AdvanceApplyModelValues(
      {this.type,
      this.vTADAAAId,
      this.empName,
      this.vTADAAAAppliedDate,
      this.vTADAAAFromDate,
      this.vTADAAAToDate,
      this.vTADAAAToAddress,
      this.vTADAAARemarks,
      this.vTADAAATotalAppliedAmount,
      this.vTADAAADepartureTime,
      this.vTADAAAArrivalTime,
      this.iVRMMCTName,
      this.iVRMMSName});

  AdvanceApplyModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    vTADAAAId = json['VTADAAA_Id'];
    empName = json['EmpName'];
    vTADAAAAppliedDate = json['VTADAAA_AppliedDate'];
    vTADAAAFromDate = json['VTADAAA_FromDate'];
    vTADAAAToDate = json['VTADAAA_ToDate'];
    vTADAAAToAddress = json['VTADAAA_ToAddress'];
    vTADAAARemarks = json['VTADAAA_Remarks'];
    vTADAAATotalAppliedAmount = json['VTADAAA_TotalAppliedAmount'];
    vTADAAADepartureTime = json['VTADAAA_DepartureTime'];
    vTADAAAArrivalTime = json['VTADAAA_ArrivalTime'];
    iVRMMCTName = json['IVRMMCT_Name'];
    iVRMMSName = json['IVRMMS_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['VTADAAA_Id'] = vTADAAAId;
    data['EmpName'] = empName;
    data['VTADAAA_AppliedDate'] = vTADAAAAppliedDate;
    data['VTADAAA_FromDate'] = vTADAAAFromDate;
    data['VTADAAA_ToDate'] = vTADAAAToDate;
    data['VTADAAA_ToAddress'] = vTADAAAToAddress;
    data['VTADAAA_Remarks'] = vTADAAARemarks;
    data['VTADAAA_TotalAppliedAmount'] = vTADAAATotalAppliedAmount;
    data['VTADAAA_DepartureTime'] = vTADAAADepartureTime;
    data['VTADAAA_ArrivalTime'] = vTADAAAArrivalTime;
    data['IVRMMCT_Name'] = iVRMMCTName;
    data['IVRMMS_Name'] = iVRMMSName;
    return data;
  }
}
