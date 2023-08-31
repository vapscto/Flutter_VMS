class InsDetailModel {
  String? type;
  List<InsDetailModelValues>? values;

  InsDetailModel({this.type, this.values});

  InsDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <InsDetailModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(InsDetailModelValues.fromJson(v));
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

class InsDetailModelValues {
  int? mIId;
  int? mOId;
  String? mIName;
  String? mIType;
  String? mIAddress1;
  String? mIAddress2;
  String? mIAddress3;
  String? ivrmmcTName;
  int? ivrmmSId;
  int? ivrmmCId;
  int? mIPincode;
  String? mIBackgroundImage;
  String? mIFormColor;
  String? mIFontColor;
  int? mIFontSize;
  String? mIWeekStartDay;
  String? mIDateFormat;
  String? mIDateSeparator;
  String? mILogo;
  int? mIActiveFlag;
  int? mIFranchiseFlag;
  String? mIAffiliation;
  String? mISubdomain;
  String? mIAboutInstitute;
  String? mIContactDetails;
  String? mIHelpFile;
  String? mISchoolCollegeFlag;
  String? mINAACInstitutionTypeFlg;
  String? mINAACSubInstitutionTypeFlg;
  String? mIVCStudentFlag;
  String? mIVCOthersFlag;
  String? mIMSTeamsClientId;
  String? mIMSTeamsTenentId;
  String? mIMSTemasClinetSecretCode;
  String? mIMSTeamsAppAccessTockenURL;
  String? mIMSTeamsUserAceessTockenURL;
  String? mIMSTeamsMeetingScheduleURL;
  String? mIMSTeamsAdminUsername;
  String? mIMSTeamsAdminPassword;
  String? mIMSTeamsScope;
  String? mIMSTeamsGrantType;
  String? mISMSAlertToemailids;
  String? mIWhatsAppTextUrl;
  String? mIWhatsAppImageUrl;
  String? mIWhatsAppPdfUrl;
  String? mIWhatsAppVideoUrl;
  String? mIEntityId;
  String? createdDate;
  String? updatedDate;

  InsDetailModelValues(
      {this.mIId,
      this.mOId,
      this.mIName,
      this.mIType,
      this.mIAddress1,
      this.mIAddress2,
      this.mIAddress3,
      this.ivrmmcTName,
      this.ivrmmSId,
      this.ivrmmCId,
      this.mIPincode,
      this.mIBackgroundImage,
      this.mIFormColor,
      this.mIFontColor,
      this.mIFontSize,
      this.mIWeekStartDay,
      this.mIDateFormat,
      this.mIDateSeparator,
      this.mILogo,
      this.mIActiveFlag,
      this.mIFranchiseFlag,
      this.mIAffiliation,
      this.mISubdomain,
      this.mIAboutInstitute,
      this.mIContactDetails,
      this.mIHelpFile,
      this.mISchoolCollegeFlag,
      this.mINAACInstitutionTypeFlg,
      this.mINAACSubInstitutionTypeFlg,
      this.mIVCStudentFlag,
      this.mIVCOthersFlag,
      this.mIMSTeamsClientId,
      this.mIMSTeamsTenentId,
      this.mIMSTemasClinetSecretCode,
      this.mIMSTeamsAppAccessTockenURL,
      this.mIMSTeamsUserAceessTockenURL,
      this.mIMSTeamsMeetingScheduleURL,
      this.mIMSTeamsAdminUsername,
      this.mIMSTeamsAdminPassword,
      this.mIMSTeamsScope,
      this.mIMSTeamsGrantType,
      this.mISMSAlertToemailids,
      this.mIWhatsAppTextUrl,
      this.mIWhatsAppImageUrl,
      this.mIWhatsAppPdfUrl,
      this.mIWhatsAppVideoUrl,
      this.mIEntityId,
      this.createdDate,
      this.updatedDate});

  InsDetailModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    mOId = json['mO_Id'];
    mIName = json['mI_Name'];
    mIType = json['mI_Type'];
    mIAddress1 = json['mI_Address1'];
    mIAddress2 = json['mI_Address2'];
    mIAddress3 = json['mI_Address3'];
    ivrmmcTName = json['ivrmmcT_Name'];
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmCId = json['ivrmmC_Id'];
    mIPincode = json['mI_Pincode'];
    mIBackgroundImage = json['mI_BackgroundImage'];
    mIFormColor = json['mI_FormColor'];
    mIFontColor = json['mI_FontColor'];
    mIFontSize = json['mI_FontSize'];
    mIWeekStartDay = json['mI_WeekStartDay'];
    mIDateFormat = json['mI_DateFormat'];
    mIDateSeparator = json['mI_DateSeparator'];
    mILogo = json['mI_Logo'];
    mIActiveFlag = json['mI_ActiveFlag'];
    mIFranchiseFlag = json['mI_FranchiseFlag'];
    mIAffiliation = json['mI_Affiliation'];
    mISubdomain = json['mI_Subdomain'];
    mIAboutInstitute = json['mI_AboutInstitute'];
    mIContactDetails = json['mI_ContactDetails'];
    mIHelpFile = json['mI_HelpFile'];
    mISchoolCollegeFlag = json['mI_SchoolCollegeFlag'];
    mINAACInstitutionTypeFlg = json['mI_NAAC_InstitutionTypeFlg'];
    mINAACSubInstitutionTypeFlg = json['mI_NAAC_SubInstitutionTypeFlg'];
    mIVCStudentFlag = json['mI_VCStudentFlag'];
    mIVCOthersFlag = json['mI_VCOthersFlag'];
    mIMSTeamsClientId = json['mI_MSTeamsClientId'];
    mIMSTeamsTenentId = json['mI_MSTeamsTenentId'];
    mIMSTemasClinetSecretCode = json['mI_MSTemasClinetSecretCode'];
    mIMSTeamsAppAccessTockenURL = json['mI_MSTeamsAppAccessTockenURL'];
    mIMSTeamsUserAceessTockenURL = json['mI_MSTeamsUserAceessTockenURL'];
    mIMSTeamsMeetingScheduleURL = json['mI_MSTeamsMeetingScheduleURL'];
    mIMSTeamsAdminUsername = json['mI_MSTeamsAdminUsername'];
    mIMSTeamsAdminPassword = json['mI_MSTeamsAdminPassword'];
    mIMSTeamsScope = json['mI_MSTeamsScope'];
    mIMSTeamsGrantType = json['mI_MSTeamsGrantType'];
    mISMSAlertToemailids = json['mI_SMSAlertToemailids'];
    mIWhatsAppTextUrl = json['mI_WhatsAppTextUrl'];
    mIWhatsAppImageUrl = json['mI_WhatsAppImageUrl'];
    mIWhatsAppPdfUrl = json['mI_WhatsAppPdfUrl'];
    mIWhatsAppVideoUrl = json['mI_WhatsAppVideoUrl'];
    mIEntityId = json['mI_EntityId'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['mO_Id'] = mOId;
    data['mI_Name'] = mIName;
    data['mI_Type'] = mIType;
    data['mI_Address1'] = mIAddress1;
    data['mI_Address2'] = mIAddress2;
    data['mI_Address3'] = mIAddress3;
    data['ivrmmcT_Name'] = ivrmmcTName;
    data['ivrmmS_Id'] = ivrmmSId;
    data['ivrmmC_Id'] = ivrmmCId;
    data['mI_Pincode'] = mIPincode;
    data['mI_BackgroundImage'] = mIBackgroundImage;
    data['mI_FormColor'] = mIFormColor;
    data['mI_FontColor'] = mIFontColor;
    data['mI_FontSize'] = mIFontSize;
    data['mI_WeekStartDay'] = mIWeekStartDay;
    data['mI_DateFormat'] = mIDateFormat;
    data['mI_DateSeparator'] = mIDateSeparator;
    data['mI_Logo'] = mILogo;
    data['mI_ActiveFlag'] = mIActiveFlag;
    data['mI_FranchiseFlag'] = mIFranchiseFlag;
    data['mI_Affiliation'] = mIAffiliation;
    data['mI_Subdomain'] = mISubdomain;
    data['mI_AboutInstitute'] = mIAboutInstitute;
    data['mI_ContactDetails'] = mIContactDetails;
    data['mI_HelpFile'] = mIHelpFile;
    data['mI_SchoolCollegeFlag'] = mISchoolCollegeFlag;
    data['mI_NAAC_InstitutionTypeFlg'] = mINAACInstitutionTypeFlg;
    data['mI_NAAC_SubInstitutionTypeFlg'] = mINAACSubInstitutionTypeFlg;
    data['mI_VCStudentFlag'] = mIVCStudentFlag;
    data['mI_VCOthersFlag'] = mIVCOthersFlag;
    data['mI_MSTeamsClientId'] = mIMSTeamsClientId;
    data['mI_MSTeamsTenentId'] = mIMSTeamsTenentId;
    data['mI_MSTemasClinetSecretCode'] = mIMSTemasClinetSecretCode;
    data['mI_MSTeamsAppAccessTockenURL'] = mIMSTeamsAppAccessTockenURL;
    data['mI_MSTeamsUserAceessTockenURL'] = mIMSTeamsUserAceessTockenURL;
    data['mI_MSTeamsMeetingScheduleURL'] = mIMSTeamsMeetingScheduleURL;
    data['mI_MSTeamsAdminUsername'] = mIMSTeamsAdminUsername;
    data['mI_MSTeamsAdminPassword'] = mIMSTeamsAdminPassword;
    data['mI_MSTeamsScope'] = mIMSTeamsScope;
    data['mI_MSTeamsGrantType'] = mIMSTeamsGrantType;
    data['mI_SMSAlertToemailids'] = mISMSAlertToemailids;
    data['mI_WhatsAppTextUrl'] = mIWhatsAppTextUrl;
    data['mI_WhatsAppImageUrl'] = mIWhatsAppImageUrl;
    data['mI_WhatsAppPdfUrl'] = mIWhatsAppPdfUrl;
    data['mI_WhatsAppVideoUrl'] = mIWhatsAppVideoUrl;
    data['mI_EntityId'] = mIEntityId;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
