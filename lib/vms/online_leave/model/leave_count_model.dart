class LeaveCountModel {
  String? type;
  List<LeaveCountModelValues>? values;

  LeaveCountModel({this.type, this.values});

  LeaveCountModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LeaveCountModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeaveCountModelValues.fromJson(v));
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

class LeaveCountModelValues {
  String? type;
  int? hrelSId;
  String? hrmLLeaveName;
  String? hrmLLeaveCode;
  double? hrelSTotalLeaves;
  double? hrelSCreditedLeaves;
  double? hrelSTransLeaves;
  double? hrelSCBLeaves;
  int? hrmLId;
  int? hrmEId;
  String? hrmLWhenToApplyFlg;
  double? hrmLNoOfDays;
  int? hrmLMaxLeavesApplyPerMonth;
  double? appliedCount;

  LeaveCountModelValues(
      {this.type,
      this.hrelSId,
      this.hrmLLeaveName,
      this.hrmLLeaveCode,
      this.hrelSTotalLeaves,
      this.hrelSCreditedLeaves,
      this.hrelSTransLeaves,
      this.hrelSCBLeaves,
      this.hrmLId,
      this.hrmEId,
      this.hrmLWhenToApplyFlg,
      this.hrmLNoOfDays,
      this.hrmLMaxLeavesApplyPerMonth,
      this.appliedCount});

  LeaveCountModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hrelSId = json['hrelS_Id'];
    hrmLLeaveName = json['hrmL_LeaveName'];
    hrmLLeaveCode = json['hrmL_LeaveCode'];
    hrelSTotalLeaves = json['hrelS_TotalLeaves'];
    hrelSCreditedLeaves = json['hrelS_CreditedLeaves'];
    hrelSTransLeaves = json['hrelS_TransLeaves'];
    hrelSCBLeaves = json['hrelS_CBLeaves'];
    hrmLId = json['hrmL_Id'];
    hrmEId = json['hrmE_Id'];
    hrmLWhenToApplyFlg = json['hrmL_WhenToApplyFlg'];
    hrmLNoOfDays = json['hrmL_NoOfDays'];
    hrmLMaxLeavesApplyPerMonth = json['hrmL_MaxLeavesApplyPerMonth'];
    appliedCount = json['appliedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['hrelS_Id'] = hrelSId;
    data['hrmL_LeaveName'] = hrmLLeaveName;
    data['hrmL_LeaveCode'] = hrmLLeaveCode;
    data['hrelS_TotalLeaves'] = hrelSTotalLeaves;
    data['hrelS_CreditedLeaves'] = hrelSCreditedLeaves;
    data['hrelS_TransLeaves'] = hrelSTransLeaves;
    data['hrelS_CBLeaves'] = hrelSCBLeaves;
    data['hrmL_Id'] = hrmLId;
    data['hrmE_Id'] = hrmEId;
    data['hrmL_WhenToApplyFlg'] = hrmLWhenToApplyFlg;
    data['hrmL_NoOfDays'] = hrmLNoOfDays;
    data['hrmL_MaxLeavesApplyPerMonth'] = hrmLMaxLeavesApplyPerMonth;
    data['appliedCount'] = appliedCount;
    return data;
  }
}
