class DashboardLeaveModel {
  String? type;
  List<DashboardLeaveModelValues>? values;

  DashboardLeaveModel({this.type, this.values});

  DashboardLeaveModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DashboardLeaveModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DashboardLeaveModelValues.fromJson(v));
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

class DashboardLeaveModelValues {
  String? type;
  int? hRELSId;
  String? hRMLLeaveName;
  String? hRMLLeaveCode;
  double? hRELSTotalLeaves;
  double? hRELSCreditedLeaves;
  double? hRELSTransLeaves;
  double? hRELSCBLeaves;
  int? hRMLId;
  int? hRMEId;
  String? hRMLWhenToApplyFlg;
  num? hRMLNoOfDays;

  DashboardLeaveModelValues(
      {this.type,
      this.hRELSId,
      this.hRMLLeaveName,
      this.hRMLLeaveCode,
      this.hRELSTotalLeaves,
      this.hRELSCreditedLeaves,
      this.hRELSTransLeaves,
      this.hRELSCBLeaves,
      this.hRMLId,
      this.hRMEId,
      this.hRMLWhenToApplyFlg,
      this.hRMLNoOfDays});

  DashboardLeaveModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRELSId = json['HRELS_Id'];
    hRMLLeaveName = json['HRML_LeaveName'];
    hRMLLeaveCode = json['HRML_LeaveCode'];
    hRELSTotalLeaves = json['HRELS_TotalLeaves'];
    hRELSCreditedLeaves = json['HRELS_CreditedLeaves'];
    hRELSTransLeaves = json['HRELS_TransLeaves'];
    hRELSCBLeaves = json['HRELS_CBLeaves'];
    hRMLId = json['HRML_Id'];
    hRMEId = json['HRME_Id'];
    hRMLWhenToApplyFlg = json['HRML_WhenToApplyFlg'];
    hRMLNoOfDays = json['HRML_NoOfDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRELS_Id'] = hRELSId;
    data['HRML_LeaveName'] = hRMLLeaveName;
    data['HRML_LeaveCode'] = hRMLLeaveCode;
    data['HRELS_TotalLeaves'] = hRELSTotalLeaves;
    data['HRELS_CreditedLeaves'] = hRELSCreditedLeaves;
    data['HRELS_TransLeaves'] = hRELSTransLeaves;
    data['HRELS_CBLeaves'] = hRELSCBLeaves;
    data['HRML_Id'] = hRMLId;
    data['HRME_Id'] = hRMEId;
    data['HRML_WhenToApplyFlg'] = hRMLWhenToApplyFlg;
    data['HRML_NoOfDays'] = hRMLNoOfDays;
    return data;
  }
}
