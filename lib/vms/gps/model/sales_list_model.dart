class GetGpsSalesDetails {
  String? type;
  List<GetGpsSalesDetailsValues>? values;

  GetGpsSalesDetails({this.type, this.values});

  GetGpsSalesDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetGpsSalesDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetGpsSalesDetailsValues.fromJson(v));
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

class GetGpsSalesDetailsValues {
  int? ismslEId;
  bool? ismslEVerifiedFlg;
  int? mIId;
  int? ismsmcAId;
  int? ismsmsOId;
  int? hrmEId;
  int? ismsmcPId;
  bool? ismsmcPChannelPartnerFlg;
  String? ismslELeadName;
  String? ismslEContactPerson;
  int? ismslEContactNo;
  String? ismslELeadAddress1;
  String? ismslEVisitedDate;
  String? ismslEEmailId;
  int? ismsmsTId;
  String? ismslEContactDesignation;
  int? ivrmmCId;
  int? ivrmmSId;
  int? ismslEStudentStrength;
  int? ismslEStaffStrength;
  int? ismslENoOfInstitutions;
  bool? ismslEOrderConfirmedFlg;
  bool? ismslEActiveFlag;
  String? createdDate;
  int? ismslECreatedBy;
  int? ismslEUpdatedBy;
  bool? ismslEDedicatedHostingFlg;
  bool? ismslEDedicatedMobileAppFlg;
  String? ismslERemarks;
  String? updatedDate;
  int? ismslEConfirmedBy;
  String? ismslEReference;
  String? ismslELeadAddress2;
  String? ismslELeadAddress3;
  int? ismslEPincode;
  String? ismslELeadCode;
  int? ismslEQuotationValue;
  String? ismslEHostingServer;

  GetGpsSalesDetailsValues(
      {this.ismslEId,
      this.ismslEVerifiedFlg,
      this.mIId,
      this.ismsmcAId,
      this.ismsmsOId,
      this.hrmEId,
      this.ismsmcPId,
      this.ismsmcPChannelPartnerFlg,
      this.ismslELeadName,
      this.ismslEContactPerson,
      this.ismslEContactNo,
      this.ismslELeadAddress1,
      this.ismslEVisitedDate,
      this.ismslEEmailId,
      this.ismsmsTId,
      this.ismslEContactDesignation,
      this.ivrmmCId,
      this.ivrmmSId,
      this.ismslEStudentStrength,
      this.ismslEStaffStrength,
      this.ismslENoOfInstitutions,
      this.ismslEOrderConfirmedFlg,
      this.ismslEActiveFlag,
      this.createdDate,
      this.ismslECreatedBy,
      this.ismslEUpdatedBy,
      this.ismslEDedicatedHostingFlg,
      this.ismslEDedicatedMobileAppFlg,
      this.ismslERemarks,
      this.updatedDate,
      this.ismslEConfirmedBy,
      this.ismslEReference,
      this.ismslELeadAddress2,
      this.ismslELeadAddress3,
      this.ismslEPincode,
      this.ismslELeadCode,
      this.ismslEQuotationValue,
      this.ismslEHostingServer});

  GetGpsSalesDetailsValues.fromJson(Map<String, dynamic> json) {
    ismslEId = json['ismslE_Id'];
    ismslEVerifiedFlg = json['ismslE_VerifiedFlg'];
    mIId = json['mI_Id'];
    ismsmcAId = json['ismsmcA_Id'];
    ismsmsOId = json['ismsmsO_Id'];
    hrmEId = json['hrmE_Id'];
    ismsmcPId = json['ismsmcP_Id'];
    ismsmcPChannelPartnerFlg = json['ismsmcP_ChannelPartnerFlg'];
    ismslELeadName = json['ismslE_LeadName'];
    ismslEContactPerson = json['ismslE_ContactPerson'];
    ismslEContactNo = json['ismslE_ContactNo'];
    ismslELeadAddress1 = json['ismslE_LeadAddress1'];
    ismslEVisitedDate = json['ismslE_VisitedDate'];
    ismslEEmailId = json['ismslE_EmailId'];
    ismsmsTId = json['ismsmsT_Id'];
    ismslEContactDesignation = json['ismslE_ContactDesignation'];
    ivrmmCId = json['ivrmmC_Id'];
    ivrmmSId = json['ivrmmS_Id'];
    ismslEStudentStrength = json['ismslE_StudentStrength'];
    ismslEStaffStrength = json['ismslE_StaffStrength'];
    ismslENoOfInstitutions = json['ismslE_NoOfInstitutions'];
    ismslEOrderConfirmedFlg = json['ismslE_OrderConfirmedFlg'];
    ismslEActiveFlag = json['ismslE_ActiveFlag'];
    createdDate = json['createdDate'];
    ismslECreatedBy = json['ismslE_CreatedBy'];
    ismslEUpdatedBy = json['ismslE_UpdatedBy'];
    ismslEDedicatedHostingFlg = json['ismslE_DedicatedHostingFlg'];
    ismslEDedicatedMobileAppFlg = json['ismslE_DedicatedMobileAppFlg'];
    ismslERemarks = json['ismslE_Remarks'];
    updatedDate = json['updatedDate'];
    ismslEConfirmedBy = json['ismslE_ConfirmedBy'];
    ismslEReference = json['ismslE_Reference'];
    ismslELeadAddress2 = json['ismslE_LeadAddress2'];
    ismslELeadAddress3 = json['ismslE_LeadAddress3'];
    ismslEPincode = json['ismslE_Pincode'];
    ismslELeadCode = json['ismslE_LeadCode'];
    ismslEQuotationValue = json['ismslE_QuotationValue'];
    ismslEHostingServer = json['ismslE_HostingServer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismslE_Id'] = this.ismslEId;
    data['ismslE_VerifiedFlg'] = this.ismslEVerifiedFlg;
    data['mI_Id'] = this.mIId;
    data['ismsmcA_Id'] = this.ismsmcAId;
    data['ismsmsO_Id'] = this.ismsmsOId;
    data['hrmE_Id'] = this.hrmEId;
    data['ismsmcP_Id'] = this.ismsmcPId;
    data['ismsmcP_ChannelPartnerFlg'] = this.ismsmcPChannelPartnerFlg;
    data['ismslE_LeadName'] = this.ismslELeadName;
    data['ismslE_ContactPerson'] = this.ismslEContactPerson;
    data['ismslE_ContactNo'] = this.ismslEContactNo;
    data['ismslE_LeadAddress1'] = this.ismslELeadAddress1;
    data['ismslE_VisitedDate'] = this.ismslEVisitedDate;
    data['ismslE_EmailId'] = this.ismslEEmailId;
    data['ismsmsT_Id'] = this.ismsmsTId;
    data['ismslE_ContactDesignation'] = this.ismslEContactDesignation;
    data['ivrmmC_Id'] = this.ivrmmCId;
    data['ivrmmS_Id'] = this.ivrmmSId;
    data['ismslE_StudentStrength'] = this.ismslEStudentStrength;
    data['ismslE_StaffStrength'] = this.ismslEStaffStrength;
    data['ismslE_NoOfInstitutions'] = this.ismslENoOfInstitutions;
    data['ismslE_OrderConfirmedFlg'] = this.ismslEOrderConfirmedFlg;
    data['ismslE_ActiveFlag'] = this.ismslEActiveFlag;
    data['createdDate'] = this.createdDate;
    data['ismslE_CreatedBy'] = this.ismslECreatedBy;
    data['ismslE_UpdatedBy'] = this.ismslEUpdatedBy;
    data['ismslE_DedicatedHostingFlg'] = this.ismslEDedicatedHostingFlg;
    data['ismslE_DedicatedMobileAppFlg'] = this.ismslEDedicatedMobileAppFlg;
    data['ismslE_Remarks'] = this.ismslERemarks;
    data['updatedDate'] = this.updatedDate;
    data['ismslE_ConfirmedBy'] = this.ismslEConfirmedBy;
    data['ismslE_Reference'] = this.ismslEReference;
    data['ismslE_LeadAddress2'] = this.ismslELeadAddress2;
    data['ismslE_LeadAddress3'] = this.ismslELeadAddress3;
    data['ismslE_Pincode'] = this.ismslEPincode;
    data['ismslE_LeadCode'] = this.ismslELeadCode;
    data['ismslE_QuotationValue'] = this.ismslEQuotationValue;
    data['ismslE_HostingServer'] = this.ismslEHostingServer;
    return data;
  }
}
