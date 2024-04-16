class CandidateDetailsModel {
  String? type;
  List<CandidateDetailsModelValues>? values;

  CandidateDetailsModel({this.type, this.values});

  CandidateDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CandidateDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CandidateDetailsModelValues.fromJson(v));
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

class CandidateDetailsModelValues {
  dynamic hrcDId;
  dynamic mIId;
  dynamic hrmpTId;
  dynamic hrmCId;
  dynamic hrcDMRFNO;
  String? hrcDFirstName;
  String? hrcDMiddleName;
  String? hrcDLastName;
  dynamic hrmJId;
  String? hrcDSkills;
  String? hrcDDOB;
  dynamic ivrmmGId;
  dynamic hrcDMobileNo;
  String? hrcDEmailId;
  double? hrcDExpFrom;
  dynamic hrcDExpTo;
  String? hrcDCurrentCompany;
  String? hrcDResumeSource;
  String? hrcDJobPortalName;
  String? hrcDRefCode;
  dynamic hrcDLastCTC;
  dynamic hrcDExpectedCTC;
  String? hrcDAppDate;
  String? hrcDInterviewDate;
  dynamic hrcDNoticePeriod;
  String? hrcDRemarks;
  String? hrcDResume;
  String? hrcDRecruitmentStatus;
  bool? hrcDActiveFlg;
  dynamic hrcDCreatedBy;
  dynamic hrcDUpdatedBy;
  String? createdDate;
  String? updatedDate;
  String? hrcDPhoto;
  dynamic hrcDAadharNo;
  String? hrcDAddressLocal;
  String? hrcDAddressPermanent;
  dynamic hrcDNationalityId;
  dynamic hrcDReligion;
  dynamic hrcDMaritalStatus;
  String? hrcDBloodGroup;
  dynamic hrcDCasteId;
  String? hrcDAddLocalPlace;
  dynamic hrcDAddLocalPIN;
  String? hrcDAddPermanentPlace;
  dynamic hrcDAddPermanentPIN;
  dynamic hrmPId;
  String? department;
  String? designation;

  CandidateDetailsModelValues(
      {this.hrcDId,
      this.mIId,
      this.hrmpTId,
      this.hrmCId,
      this.hrcDMRFNO,
      this.hrcDFirstName,
      this.hrcDMiddleName,
      this.hrcDLastName,
      this.hrmJId,
      this.hrcDSkills,
      this.hrcDDOB,
      this.ivrmmGId,
      this.hrcDMobileNo,
      this.hrcDEmailId,
      this.hrcDExpFrom,
      this.hrcDExpTo,
      this.hrcDCurrentCompany,
      this.hrcDResumeSource,
      this.hrcDJobPortalName,
      this.hrcDRefCode,
      this.hrcDLastCTC,
      this.hrcDExpectedCTC,
      this.hrcDAppDate,
      this.hrcDInterviewDate,
      this.hrcDNoticePeriod,
      this.hrcDRemarks,
      this.hrcDResume,
      this.hrcDRecruitmentStatus,
      this.hrcDActiveFlg,
      this.hrcDCreatedBy,
      this.hrcDUpdatedBy,
      this.createdDate,
      this.updatedDate,
      this.hrcDPhoto,
      this.hrcDAadharNo,
      this.hrcDAddressLocal,
      this.hrcDAddressPermanent,
      this.hrcDNationalityId,
      this.hrcDReligion,
      this.hrcDMaritalStatus,
      this.hrcDBloodGroup,
      this.hrcDCasteId,
      this.hrcDAddLocalPlace,
      this.hrcDAddLocalPIN,
      this.hrcDAddPermanentPlace,
      this.hrcDAddPermanentPIN,
      this.hrmPId,
      this.department,
      this.designation});

  CandidateDetailsModelValues.fromJson(Map<String, dynamic> json) {
    hrcDId = json['hrcD_Id'];
    mIId = json['mI_Id'];
    hrmpTId = json['hrmpT_Id'];
    hrmCId = json['hrmC_Id'];
    hrcDMRFNO = json['hrcD_MRFNO'];
    hrcDFirstName = json['hrcD_FirstName'];
    hrcDMiddleName = json['hrcD_MiddleName'];
    hrcDLastName = json['hrcD_LastName'];
    hrmJId = json['hrmJ_Id'];
    hrcDSkills = json['hrcD_Skills'];
    hrcDDOB = json['hrcD_DOB'];
    ivrmmGId = json['ivrmmG_Id'];
    hrcDMobileNo = json['hrcD_MobileNo'];
    hrcDEmailId = json['hrcD_EmailId'];
    hrcDExpFrom = json['hrcD_ExpFrom'];
    hrcDExpTo = json['hrcD_ExpTo'];
    hrcDCurrentCompany = json['hrcD_CurrentCompany'];
    hrcDResumeSource = json['hrcD_ResumeSource'];
    hrcDJobPortalName = json['hrcD_JobPortalName'];
    hrcDRefCode = json['hrcD_RefCode'];
    hrcDLastCTC = json['hrcD_LastCTC'];
    hrcDExpectedCTC = json['hrcD_ExpectedCTC'];
    hrcDAppDate = json['hrcD_AppDate'];
    hrcDInterviewDate = json['hrcD_InterviewDate'];
    hrcDNoticePeriod = json['hrcD_NoticePeriod'];
    hrcDRemarks = json['hrcD_Remarks'];
    hrcDResume = json['hrcD_Resume'];
    hrcDRecruitmentStatus = json['hrcD_RecruitmentStatus'];
    hrcDActiveFlg = json['hrcD_ActiveFlg'];
    hrcDCreatedBy = json['hrcD_CreatedBy'];
    hrcDUpdatedBy = json['hrcD_UpdatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    hrcDPhoto = json['hrcD_Photo'];
    hrcDAadharNo = json['hrcD_AadharNo'];
    hrcDAddressLocal = json['hrcD_AddressLocal'];
    hrcDAddressPermanent = json['hrcD_AddressPermanent'];
    hrcDNationalityId = json['hrcD_NationalityId'];
    hrcDReligion = json['hrcD_Religion'];
    hrcDMaritalStatus = json['hrcD_MaritalStatus'];
    hrcDBloodGroup = json['hrcD_BloodGroup'];
    hrcDCasteId = json['hrcD_CasteId'];
    hrcDAddLocalPlace = json['hrcD_AddLocalPlace'];
    hrcDAddLocalPIN = json['hrcD_AddLocalPIN'];
    hrcDAddPermanentPlace = json['hrcD_AddPermanentPlace'];
    hrcDAddPermanentPIN = json['hrcD_AddPermanentPIN'];
    hrmPId = json['hrmP_Id'];
    department = json['hrcD_Department'] ?? "";
    designation = json['hrcD_Designation'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrcD_Id'] = hrcDId;
    data['mI_Id'] = mIId;
    data['hrmpT_Id'] = hrmpTId;
    data['hrmC_Id'] = hrmCId;
    data['hrcD_MRFNO'] = hrcDMRFNO;
    data['hrcD_FirstName'] = hrcDFirstName;
    data['hrcD_MiddleName'] = hrcDMiddleName;
    data['hrcD_LastName'] = hrcDLastName;
    data['hrmJ_Id'] = hrmJId;
    data['hrcD_Skills'] = hrcDSkills;
    data['hrcD_DOB'] = hrcDDOB;
    data['ivrmmG_Id'] = ivrmmGId;
    data['hrcD_MobileNo'] = hrcDMobileNo;
    data['hrcD_EmailId'] = hrcDEmailId;
    data['hrcD_ExpFrom'] = hrcDExpFrom;
    data['hrcD_ExpTo'] = hrcDExpTo;
    data['hrcD_CurrentCompany'] = hrcDCurrentCompany;
    data['hrcD_ResumeSource'] = hrcDResumeSource;
    data['hrcD_JobPortalName'] = hrcDJobPortalName;
    data['hrcD_RefCode'] = hrcDRefCode;
    data['hrcD_LastCTC'] = hrcDLastCTC;
    data['hrcD_ExpectedCTC'] = hrcDExpectedCTC;
    data['hrcD_AppDate'] = hrcDAppDate;
    data['hrcD_InterviewDate'] = hrcDInterviewDate;
    data['hrcD_NoticePeriod'] = hrcDNoticePeriod;
    data['hrcD_Remarks'] = hrcDRemarks;
    data['hrcD_Resume'] = hrcDResume;
    data['hrcD_RecruitmentStatus'] = hrcDRecruitmentStatus;
    data['hrcD_ActiveFlg'] = hrcDActiveFlg;
    data['hrcD_CreatedBy'] = hrcDCreatedBy;
    data['hrcD_UpdatedBy'] = hrcDUpdatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['hrcD_Photo'] = hrcDPhoto;
    data['hrcD_AadharNo'] = hrcDAadharNo;
    data['hrcD_AddressLocal'] = hrcDAddressLocal;
    data['hrcD_AddressPermanent'] = hrcDAddressPermanent;
    data['hrcD_NationalityId'] = hrcDNationalityId;
    data['hrcD_Religion'] = hrcDReligion;
    data['hrcD_MaritalStatus'] = hrcDMaritalStatus;
    data['hrcD_BloodGroup'] = hrcDBloodGroup;
    data['hrcD_CasteId'] = hrcDCasteId;
    data['hrcD_AddLocalPlace'] = hrcDAddLocalPlace;
    data['hrcD_AddLocalPIN'] = hrcDAddLocalPIN;
    data['hrcD_AddPermanentPlace'] = hrcDAddPermanentPlace;
    data['hrcD_AddPermanentPIN'] = hrcDAddPermanentPIN;
    data['hrmP_Id'] = hrmPId;
    data['hrcD_Department'] = department;
    data['hrcD_Designation'] = designation;
    return data;
  }
}
