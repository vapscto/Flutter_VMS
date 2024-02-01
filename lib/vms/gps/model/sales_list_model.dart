class GetGpsSalesDetails {
  String? type;
  List<GetGpsSalesDetailsValues>? values;

  GetGpsSalesDetails({this.type, this.values});

  GetGpsSalesDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetGpsSalesDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetGpsSalesDetailsValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismslE_Id'] = ismslEId;
    data['ismslE_VerifiedFlg'] = ismslEVerifiedFlg;
    data['mI_Id'] = mIId;
    data['ismsmcA_Id'] = ismsmcAId;
    data['ismsmsO_Id'] = ismsmsOId;
    data['hrmE_Id'] = hrmEId;
    data['ismsmcP_Id'] = ismsmcPId;
    data['ismsmcP_ChannelPartnerFlg'] = ismsmcPChannelPartnerFlg;
    data['ismslE_LeadName'] = ismslELeadName;
    data['ismslE_ContactPerson'] = ismslEContactPerson;
    data['ismslE_ContactNo'] = ismslEContactNo;
    data['ismslE_LeadAddress1'] = ismslELeadAddress1;
    data['ismslE_VisitedDate'] = ismslEVisitedDate;
    data['ismslE_EmailId'] = ismslEEmailId;
    data['ismsmsT_Id'] = ismsmsTId;
    data['ismslE_ContactDesignation'] = ismslEContactDesignation;
    data['ivrmmC_Id'] = ivrmmCId;
    data['ivrmmS_Id'] = ivrmmSId;
    data['ismslE_StudentStrength'] = ismslEStudentStrength;
    data['ismslE_StaffStrength'] = ismslEStaffStrength;
    data['ismslE_NoOfInstitutions'] = ismslENoOfInstitutions;
    data['ismslE_OrderConfirmedFlg'] = ismslEOrderConfirmedFlg;
    data['ismslE_ActiveFlag'] = ismslEActiveFlag;
    data['createdDate'] = createdDate;
    data['ismslE_CreatedBy'] = ismslECreatedBy;
    data['ismslE_UpdatedBy'] = ismslEUpdatedBy;
    data['ismslE_DedicatedHostingFlg'] = ismslEDedicatedHostingFlg;
    data['ismslE_DedicatedMobileAppFlg'] = ismslEDedicatedMobileAppFlg;
    data['ismslE_Remarks'] = ismslERemarks;
    data['updatedDate'] = updatedDate;
    data['ismslE_ConfirmedBy'] = ismslEConfirmedBy;
    data['ismslE_Reference'] = ismslEReference;
    data['ismslE_LeadAddress2'] = ismslELeadAddress2;
    data['ismslE_LeadAddress3'] = ismslELeadAddress3;
    data['ismslE_Pincode'] = ismslEPincode;
    data['ismslE_LeadCode'] = ismslELeadCode;
    data['ismslE_QuotationValue'] = ismslEQuotationValue;
    data['ismslE_HostingServer'] = ismslEHostingServer;
    return data;
  }
}
