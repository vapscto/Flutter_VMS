class LeaveCountModel {
  String? type;
  List<LeaveCountModelValues>? values;

  LeaveCountModel({this.type, this.values});

  LeaveCountModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LeaveCountModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new LeaveCountModelValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['hrelS_Id'] = this.hrelSId;
    data['hrmL_LeaveName'] = this.hrmLLeaveName;
    data['hrmL_LeaveCode'] = this.hrmLLeaveCode;
    data['hrelS_TotalLeaves'] = this.hrelSTotalLeaves;
    data['hrelS_CreditedLeaves'] = this.hrelSCreditedLeaves;
    data['hrelS_TransLeaves'] = this.hrelSTransLeaves;
    data['hrelS_CBLeaves'] = this.hrelSCBLeaves;
    data['hrmL_Id'] = this.hrmLId;
    data['hrmE_Id'] = this.hrmEId;
    data['hrmL_WhenToApplyFlg'] = this.hrmLWhenToApplyFlg;
    data['hrmL_NoOfDays'] = this.hrmLNoOfDays;
    data['hrmL_MaxLeavesApplyPerMonth'] = this.hrmLMaxLeavesApplyPerMonth;
    data['appliedCount'] = this.appliedCount;
    return data;
  }
}
