class LeaveNamesModel {
  String? type;
  List<LeaveNamesModelValues>? values;

  LeaveNamesModel({this.type, this.values});

  LeaveNamesModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LeaveNamesModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeaveNamesModelValues.fromJson(v));
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

class LeaveNamesModelValues {
  String? type;
  int? hrelSId;
  String? hrmLLeaveName;
  String? hrmLLeaveCode;
  dynamic hrelSTotalLeaves;
  dynamic hrelSCreditedLeaves;
  dynamic hrelSTransLeaves;
  dynamic hrelSCBLeaves;
  int? hrmLId;
  int? hrmEId;
  dynamic hrmLWhenToApplyFlg;
  dynamic hrmLNoOfDays;
  dynamic hrmLMaxLeavesApplyPerMonth;
  dynamic appliedCount;
  bool? probationary;
  String? hrmeDoc;

  LeaveNamesModelValues(
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
      this.appliedCount,
      this.probationary,
      this.hrmeDoc});

  LeaveNamesModelValues.fromJson(Map<String, dynamic> json) {
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
    probationary = json['HRML_ProbationaryNAFlg'] ?? false;
    hrmeDoc = json['HRME_doc'];
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
    data['HRML_ProbationaryNAFlg'] = probationary;
    data['HRME_doc'] = hrmeDoc;
    return data;
  }
}
