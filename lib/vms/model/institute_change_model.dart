class InstituteChangeModel {
  String? type;
  List<InstituteChangeModelValues>? values;

  InstituteChangeModel({this.type, this.values});

  InstituteChangeModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <InstituteChangeModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(InstituteChangeModelValues.fromJson(v));
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

class InstituteChangeModelValues {
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

  InstituteChangeModelValues(
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

  InstituteChangeModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['mO_Id'] = mOId;
    data['mI_Name'] = mIName;
    data['mI_Code'] = mICode;
    data['mI_Type'] = mIType;
    data['mI_Address1'] = mIAddress1;
    data['mI_Address2'] = mIAddress2;
    data['mI_Address3'] = mIAddress3;
    data['ivrmmcT_Name'] = ivrmmcTName;
    data['ivrmmS_Id'] = ivrmmSId;
    data['ivrmmC_Id'] = ivrmmCId;
    data['mI_Pincode'] = mIPincode;
    data['mI_FormColor'] = mIFormColor;
    data['mI_FontColor'] = mIFontColor;
    data['mI_FontSize'] = mIFontSize;
    data['mI_Logo'] = mILogo;
    data['mI_ActiveFlag'] = mIActiveFlag;
    data['mI_FranchiseFlag'] = mIFranchiseFlag;
    data['mI_Affiliation'] = mIAffiliation;
    data['mI_Subdomain'] = mISubdomain;
    data['mI_AboutInstitute'] = mIAboutInstitute;
    data['mI_ContactDetails'] = mIContactDetails;
    data['mI_SchoolCollegeFlag'] = mISchoolCollegeFlag;
    data['mI_GSTNO'] = mIGSTNO;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['mI_BackgroundImage'] = mIBackgroundImage;
    data['mI_DateSeparator'] = mIDateSeparator;
    return data;
  }
}
