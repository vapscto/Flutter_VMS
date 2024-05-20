class FinalTourPlanDetails {
  String? type;
  List<FinalTourPlanDetailsValues>? values;

  FinalTourPlanDetails({this.type, this.values});

  FinalTourPlanDetails.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <FinalTourPlanDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(FinalTourPlanDetailsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinalTourPlanDetailsValues {
  String? type;
  String? iERPlanName;
  String? iERRemarks;
  String? vTADAAAFromDate;
  String? vTADAAAToDate;
  String? vTADAAADepartureTime;
  String? vTADAAAArrivalTime;
  String? mIName;
  String? vTADAAAAppliedDate;
  String? hRMEEmployeeFirstName;
  double? vTADAAATotalAppliedAmount;
  int? vTADAAAId;

  FinalTourPlanDetailsValues(
      {this.type,
      this.iERPlanName,
      this.iERRemarks,
      this.vTADAAAFromDate,
      this.vTADAAAToDate,
      this.vTADAAADepartureTime,
      this.vTADAAAArrivalTime,
      this.mIName,
      this.vTADAAAAppliedDate,
      this.hRMEEmployeeFirstName,
      this.vTADAAATotalAppliedAmount,
      this.vTADAAAId});

  FinalTourPlanDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iERPlanName = json['IER_PlanName'];
    iERRemarks = json['IER_Remarks'];
    vTADAAAFromDate = json['VTADAAA_FromDate'];
    vTADAAAToDate = json['VTADAAA_ToDate'];
    vTADAAADepartureTime = json['VTADAAA_DepartureTime'];
    vTADAAAArrivalTime = json['VTADAAA_ArrivalTime'];
    mIName = json['MI_Name'];
    vTADAAAAppliedDate = json['VTADAAA_AppliedDate'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    vTADAAATotalAppliedAmount = json['VTADAAA_TotalAppliedAmount'];
    vTADAAAId = json['VTADAAA_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IER_PlanName'] = iERPlanName;
    data['IER_Remarks'] = iERRemarks;
    data['VTADAAA_FromDate'] = vTADAAAFromDate;
    data['VTADAAA_ToDate'] = vTADAAAToDate;
    data['VTADAAA_DepartureTime'] = vTADAAADepartureTime;
    data['VTADAAA_ArrivalTime'] = vTADAAAArrivalTime;
    data['MI_Name'] = mIName;
    data['VTADAAA_AppliedDate'] = vTADAAAAppliedDate;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['VTADAAA_TotalAppliedAmount'] = vTADAAATotalAppliedAmount;
    data['VTADAAA_Id'] = vTADAAAId;
    return data;
  }
}
