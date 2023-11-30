class ApplyListModel {
  String? type;
  List<ApplyListModelValues>? values;

  ApplyListModel({this.type, this.values});

  ApplyListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ApplyListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ApplyListModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApplyListModelValues {
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

  ApplyListModelValues(
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

  ApplyListModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['VTADAA_Id'] = this.vTADAAId;
    data['EmpName'] = this.empName;
    data['VTADAA_AppliedDate'] = this.vTADAAAppliedDate;
    data['VTADAA_FromDate'] = this.vTADAAFromDate;
    data['VTADAA_ToDate'] = this.vTADAAToDate;
    data['VTADAA_ToAddress'] = this.vTADAAToAddress;
    data['VTADAA_Remarks'] = this.vTADAARemarks;
    data['VTADAA_TotalAppliedAmount'] = this.vTADAATotalAppliedAmount;
    data['VTADAA_DepartureTime'] = this.vTADAADepartureTime;
    data['VTADAA_ArrivalTime'] = this.vTADAAArrivalTime;
    data['IVRMMCT_Name'] = this.iVRMMCTName;
    data['IVRMMS_Name'] = this.iVRMMSName;
    return data;
  }
}
