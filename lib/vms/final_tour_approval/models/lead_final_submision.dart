class LeadFinalSubmission {
  String? type;
  List<LeadFinalSubmissionValues>? values;

  LeadFinalSubmission({this.type, this.values});

  LeadFinalSubmission.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <LeadFinalSubmissionValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeadFinalSubmissionValues.fromJson(v));
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

class LeadFinalSubmissionValues {
  String? type;
  int? iERID;
  int? iEREmpId;
  int? iMRCCategoryId;
  String? iMRCCategoryName;
  int? iERPCPercentage;
  int? leadCount;
  int? executionLeadCount;
  double? vTADAAATotalAppliedAmount;
  double? vTADAAATotalSactionedAmount;
  double? vTADAAATotalEligbleAmount;

  LeadFinalSubmissionValues(
      {this.type,
      this.iERID,
      this.iEREmpId,
      this.iMRCCategoryId,
      this.iMRCCategoryName,
      this.iERPCPercentage,
      this.leadCount,
      this.executionLeadCount,
      this.vTADAAATotalAppliedAmount,
      this.vTADAAATotalSactionedAmount,
      this.vTADAAATotalEligbleAmount});

  LeadFinalSubmissionValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iERID = json['IER_ID'];
    iEREmpId = json['IER_EmpId'];
    iMRCCategoryId = json['IMRC_CategoryId'];
    iMRCCategoryName = json['IMRC_CategoryName'];
    iERPCPercentage = json['IERPC_Percentage'];
    leadCount = json['LeadCount'];
    executionLeadCount = json['ExecutionLeadCount'];
    vTADAAATotalAppliedAmount = json['VTADAAA_TotalAppliedAmount'];
    vTADAAATotalSactionedAmount = json['VTADAAA_TotalSactionedAmount'];
    vTADAAATotalEligbleAmount = json['VTADAAA_TotalEligbleAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IER_ID'] = iERID;
    data['IER_EmpId'] = iEREmpId;
    data['IMRC_CategoryId'] = iMRCCategoryId;
    data['IMRC_CategoryName'] = iMRCCategoryName;
    data['IERPC_Percentage'] = iERPCPercentage;
    data['LeadCount'] = leadCount;
    data['ExecutionLeadCount'] = executionLeadCount;
    data['VTADAAA_TotalAppliedAmount'] = vTADAAATotalAppliedAmount;
    data['VTADAAA_TotalSactionedAmount'] = vTADAAATotalSactionedAmount;
    data['VTADAAA_TotalEligbleAmount'] = vTADAAATotalEligbleAmount;
    return data;
  }
}
