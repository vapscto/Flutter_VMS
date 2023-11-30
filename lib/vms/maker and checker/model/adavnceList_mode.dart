class AdavanceListModel {
  String? type;
  List<AdavanceListModelValues>? values;

  AdavanceListModel({this.type, this.values});

  AdavanceListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AdavanceListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new AdavanceListModelValues.fromJson(v));
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

class AdavanceListModelValues {
  String? type;
  int? vTADAAAId;
  String? empName;
  String? vTADAAAAppliedDate;
  String? vTADAAAFromDate;
  String? vTADAAAToDate;
  String? vTADAAAToAddress;
  String? vTADAAARemarks;
  double? vTADAAATotalAppliedAmount;
  String? vTADAAADepartureTime;
  String? vTADAAAArrivalTime;
  String? iVRMMCTName;
  String? iVRMMSName;

  AdavanceListModelValues(
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

  AdavanceListModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['VTADAAA_Id'] = this.vTADAAAId;
    data['EmpName'] = this.empName;
    data['VTADAAA_AppliedDate'] = this.vTADAAAAppliedDate;
    data['VTADAAA_FromDate'] = this.vTADAAAFromDate;
    data['VTADAAA_ToDate'] = this.vTADAAAToDate;
    data['VTADAAA_ToAddress'] = this.vTADAAAToAddress;
    data['VTADAAA_Remarks'] = this.vTADAAARemarks;
    data['VTADAAA_TotalAppliedAmount'] = this.vTADAAATotalAppliedAmount;
    data['VTADAAA_DepartureTime'] = this.vTADAAADepartureTime;
    data['VTADAAA_ArrivalTime'] = this.vTADAAAArrivalTime;
    data['IVRMMCT_Name'] = this.iVRMMCTName;
    data['IVRMMS_Name'] = this.iVRMMSName;
    return data;
  }
}
