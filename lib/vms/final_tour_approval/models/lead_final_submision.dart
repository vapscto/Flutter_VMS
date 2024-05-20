class LeadFinalSubmission {
  String? type;
  List<LeadFinalSubmissionValues>? values;

  LeadFinalSubmission({this.type, this.values});

  LeadFinalSubmission.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <LeadFinalSubmissionValues>[];
      json['\$values'].forEach((v) {
        values!.add(new LeadFinalSubmissionValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['IER_ID'] = this.iERID;
    data['IER_EmpId'] = this.iEREmpId;
    data['IMRC_CategoryId'] = this.iMRCCategoryId;
    data['IMRC_CategoryName'] = this.iMRCCategoryName;
    data['IERPC_Percentage'] = this.iERPCPercentage;
    data['LeadCount'] = this.leadCount;
    data['ExecutionLeadCount'] = this.executionLeadCount;
    data['VTADAAA_TotalAppliedAmount'] = this.vTADAAATotalAppliedAmount;
    data['VTADAAA_TotalSactionedAmount'] = this.vTADAAATotalSactionedAmount;
    data['VTADAAA_TotalEligbleAmount'] = this.vTADAAATotalEligbleAmount;
    return data;
  }
}
