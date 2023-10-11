class PCApprovalOnloadModel {
  String? type;
  List<PCApprovalOnloadModelValues>? values;

  PCApprovalOnloadModel({this.type, this.values});

  PCApprovalOnloadModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PCApprovalOnloadModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new PCApprovalOnloadModelValues.fromJson(v));
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

class PCApprovalOnloadModelValues {
  int? mIId;
  int? mOId;
  String? mIName;
  String? mICode;
  String? mIType;
  String? mIAddress1;
  String? mIAddress2;
  String? mIAddress3;
  String? ivrmmcTName;
  int? ivrmmSId;
  int? ivrmmCId;
  int? mIPincode;
  String? mIFormColor;
  String? mIFontColor;
  int? mIFontSize;
  String? mILogo;
  int? mIActiveFlag;
  int? mIFranchiseFlag;
  String? mIAffiliation;
  String? mISubdomain;
  String? mIAboutInstitute;
  String? mIContactDetails;
  String? mISchoolCollegeFlag;
  String? mIGSTNO;
  String? createdDate;
  String? updatedDate;
  String? mIBackgroundImage;
  String? mIDateSeparator;

  PCApprovalOnloadModelValues(
      {this.mIId,
      this.mOId,
      this.mIName,
      this.mICode,
      this.mIType,
      this.mIAddress1,
      this.mIAddress2,
      this.mIAddress3,
      this.ivrmmcTName,
      this.ivrmmSId,
      this.ivrmmCId,
      this.mIPincode,
      this.mIFormColor,
      this.mIFontColor,
      this.mIFontSize,
      this.mILogo,
      this.mIActiveFlag,
      this.mIFranchiseFlag,
      this.mIAffiliation,
      this.mISubdomain,
      this.mIAboutInstitute,
      this.mIContactDetails,
      this.mISchoolCollegeFlag,
      this.mIGSTNO,
      this.createdDate,
      this.updatedDate,
      this.mIBackgroundImage,
      this.mIDateSeparator});

  PCApprovalOnloadModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    mOId = json['mO_Id'];
    mIName = json['mI_Name'];
    mICode = json['mI_Code'];
    mIType = json['mI_Type'];
    mIAddress1 = json['mI_Address1'];
    mIAddress2 = json['mI_Address2'];
    mIAddress3 = json['mI_Address3'];
    ivrmmcTName = json['ivrmmcT_Name'];
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmCId = json['ivrmmC_Id'];
    mIPincode = json['mI_Pincode'];
    mIFormColor = json['mI_FormColor'];
    mIFontColor = json['mI_FontColor'];
    mIFontSize = json['mI_FontSize'];
    mILogo = json['mI_Logo'];
    mIActiveFlag = json['mI_ActiveFlag'];
    mIFranchiseFlag = json['mI_FranchiseFlag'];
    mIAffiliation = json['mI_Affiliation'];
    mISubdomain = json['mI_Subdomain'];
    mIAboutInstitute = json['mI_AboutInstitute'];
    mIContactDetails = json['mI_ContactDetails'];
    mISchoolCollegeFlag = json['mI_SchoolCollegeFlag'];
    mIGSTNO = json['mI_GSTNO'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    mIBackgroundImage = json['mI_BackgroundImage'];
    mIDateSeparator = json['mI_DateSeparator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['mO_Id'] = this.mOId;
    data['mI_Name'] = this.mIName;
    data['mI_Code'] = this.mICode;
    data['mI_Type'] = this.mIType;
    data['mI_Address1'] = this.mIAddress1;
    data['mI_Address2'] = this.mIAddress2;
    data['mI_Address3'] = this.mIAddress3;
    data['ivrmmcT_Name'] = this.ivrmmcTName;
    data['ivrmmS_Id'] = this.ivrmmSId;
    data['ivrmmC_Id'] = this.ivrmmCId;
    data['mI_Pincode'] = this.mIPincode;
    data['mI_FormColor'] = this.mIFormColor;
    data['mI_FontColor'] = this.mIFontColor;
    data['mI_FontSize'] = this.mIFontSize;
    data['mI_Logo'] = this.mILogo;
    data['mI_ActiveFlag'] = this.mIActiveFlag;
    data['mI_FranchiseFlag'] = this.mIFranchiseFlag;
    data['mI_Affiliation'] = this.mIAffiliation;
    data['mI_Subdomain'] = this.mISubdomain;
    data['mI_AboutInstitute'] = this.mIAboutInstitute;
    data['mI_ContactDetails'] = this.mIContactDetails;
    data['mI_SchoolCollegeFlag'] = this.mISchoolCollegeFlag;
    data['mI_GSTNO'] = this.mIGSTNO;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['mI_BackgroundImage'] = this.mIBackgroundImage;
    data['mI_DateSeparator'] = this.mIDateSeparator;
    return data;
  }
}
