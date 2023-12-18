class TADAApplyListModel {
  String? type;
  List<TADAApplyListModelValues>? values;

  TADAApplyListModel({this.type, this.values});

  TADAApplyListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TADAApplyListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TADAApplyListModelValues.fromJson(v));
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

class TADAApplyListModelValues {
  String? type;
  int? vTADAAId;
  String? empName;
  String? vTADAAAppliedDate;
  String? vTADAAFromDate;
  String? vTADAAToDate;
  String? vTADAAToAddress;
  String? vTADAARemarks;
  double? vTADAATotalAppliedAmount;
  String? vTADAADepartureTime;
  String? vTADAAArrivalTime;
  String? iVRMMCTName;
  String? iVRMMSName;

  TADAApplyListModelValues(
      {this.type,
      this.vTADAAId,
      this.empName,
      this.vTADAAAppliedDate,
      this.vTADAAFromDate,
      this.vTADAAToDate,
      this.vTADAAToAddress,
      this.vTADAARemarks,
      this.vTADAATotalAppliedAmount,
      this.vTADAADepartureTime,
      this.vTADAAArrivalTime,
      this.iVRMMCTName,
      this.iVRMMSName});

  TADAApplyListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    vTADAAId = json['VTADAA_Id'];
    empName = json['EmpName'];
    vTADAAAppliedDate = json['VTADAA_AppliedDate'];
    vTADAAFromDate = json['VTADAA_FromDate'];
    vTADAAToDate = json['VTADAA_ToDate'];
    vTADAAToAddress = json['VTADAA_ToAddress'];
    vTADAARemarks = json['VTADAA_Remarks'];
    vTADAATotalAppliedAmount = json['VTADAA_TotalAppliedAmount'];
    vTADAADepartureTime = json['VTADAA_DepartureTime'];
    vTADAAArrivalTime = json['VTADAA_ArrivalTime'];
    iVRMMCTName = json['IVRMMCT_Name'];
    iVRMMSName = json['IVRMMS_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['VTADAA_Id'] = vTADAAId;
    data['EmpName'] = empName;
    data['VTADAA_AppliedDate'] = vTADAAAppliedDate;
    data['VTADAA_FromDate'] = vTADAAFromDate;
    data['VTADAA_ToDate'] = vTADAAToDate;
    data['VTADAA_ToAddress'] = vTADAAToAddress;
    data['VTADAA_Remarks'] = vTADAARemarks;
    data['VTADAA_TotalAppliedAmount'] = vTADAATotalAppliedAmount;
    data['VTADAA_DepartureTime'] = vTADAADepartureTime;
    data['VTADAA_ArrivalTime'] = vTADAAArrivalTime;
    data['IVRMMCT_Name'] = iVRMMCTName;
    data['IVRMMS_Name'] = iVRMMSName;
    return data;
  }
}
