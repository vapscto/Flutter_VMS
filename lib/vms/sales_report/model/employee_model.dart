class EmployeeListModel {
  String? type;
  List<EmployeeListModelValues>? values;

  EmployeeListModel({this.type, this.values});

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EmployeeListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new EmployeeListModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeListModelValues {
  int? hrmEId;
  int? mIId;
  int? hrmeTId;
  int? hrmgTId;
  int? hrmDId;
  int? hrmdeSId;
  int? hrmGId;
  String? hrmEEmployeeFirstName;
  String? hrmEEmployeeMiddleName;
  String? hrmEEmployeeLastName;
  String? hrmEEmployeeCode;
  String? hrmEBiometricCode;
  String? hrmERFCardId;
  String? hrmEPerStreet;
  String? hrmEPerArea;
  String? hrmEPerCity;
  String? hrmEPerAdd4;
  int? hrmEPerStateId;
  int? hrmEPerCountryId;
  int? hrmEPerPincode;
  String? hrmELocStreet;
  String? hrmELocArea;
  String? hrmELocCity;
  String? hrmELocAdd4;
  int? hrmELocStateId;
  int? hrmELocCountryId;
  int? hrmELocPincode;
  int? ivrmmmSId;
  int? ivrmmGId;
  int? casteCategoryId;
  int? casteId;
  int? religionId;
  String? hrmEFatherName;
  String? hrmEMotherName;
  String? hrmESpouseName;
  String? hrmESpouseOccupation;
  int? hrmESpouseMobileNo;
  int? hrmERelaxtime;
  String? hrmESpouseEmailId;
  String? hrmESpouseAddress;
  String? hrmEDOB;
  String? hrmEDOJ;
  String? hrmEExpectedRetirementDate;
  String? hrmEPFDate;
  String? hrmEESIDate;
  String? hrmEBloodGroup;
  String? hrmEPaymentType;
  String? hrmEBankAccountNo;
  bool? hrmEPFApplicableFlag;
  bool? hrmEPFMaxFlag;
  bool? hrmEPFFixedFlag;
  String? hrmEPFAccNo;
  String? hrmEESIAccNo;
  String? hrmEGratuityAccNo;
  bool? hrmEESIApplicableFlag;
  String? hrmEPhoto;
  bool? hrmELeftFlag;
  String? hrmEDOL;
  String? hrmELeavingReason;
  String? hrmEHeight;
  String? hrmEHeightUOM;
  int? hrmEWeight;
  String? hrmEWeightUOM;
  String? hrmEIdentificationMark;
  String? hrmEApprovalNo;
  String? hrmEPANCardNo;
  int? hrmEAadharCardNo;
  bool? hrmESubstituteFlag;
  String? hrmENationalSSN;
  String? hrmESalaryType;
  int? hrmEEmployeeOrder;
  bool? hrmEActiveFlag;
  String? hrmEUINumber;
  String? hrmEDOC;
  bool? hrmEExcDR;
  bool? hrmEExcPunch;
  bool? hrmEAutoPlanerApproval;
  String? createdDate;
  String? updatedDate;
  int? hrmEMobileNo;
  String? hrmEEmailId;
  int? hrmEUpdatedBy;
  String? hrmEQRCode;
  String? hrmEAppDownloadedDeviceId;
  double? hrmECTC;
  String? hrmESubjectsTaught;
  int? hrmECreatedBy;

  EmployeeListModelValues(
      {this.hrmEId,
      this.mIId,
      this.hrmeTId,
      this.hrmgTId,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmGId,
      this.hrmEEmployeeFirstName,
      this.hrmEEmployeeMiddleName,
      this.hrmEEmployeeLastName,
      this.hrmEEmployeeCode,
      this.hrmEBiometricCode,
      this.hrmERFCardId,
      this.hrmEPerStreet,
      this.hrmEPerArea,
      this.hrmEPerCity,
      this.hrmEPerAdd4,
      this.hrmEPerStateId,
      this.hrmEPerCountryId,
      this.hrmEPerPincode,
      this.hrmELocStreet,
      this.hrmELocArea,
      this.hrmELocCity,
      this.hrmELocAdd4,
      this.hrmELocStateId,
      this.hrmELocCountryId,
      this.hrmELocPincode,
      this.ivrmmmSId,
      this.ivrmmGId,
      this.casteCategoryId,
      this.casteId,
      this.religionId,
      this.hrmEFatherName,
      this.hrmEMotherName,
      this.hrmESpouseName,
      this.hrmESpouseOccupation,
      this.hrmESpouseMobileNo,
      this.hrmERelaxtime,
      this.hrmESpouseEmailId,
      this.hrmESpouseAddress,
      this.hrmEDOB,
      this.hrmEDOJ,
      this.hrmEExpectedRetirementDate,
      this.hrmEPFDate,
      this.hrmEESIDate,
      this.hrmEBloodGroup,
      this.hrmEPaymentType,
      this.hrmEBankAccountNo,
      this.hrmEPFApplicableFlag,
      this.hrmEPFMaxFlag,
      this.hrmEPFFixedFlag,
      this.hrmEPFAccNo,
      this.hrmEESIAccNo,
      this.hrmEGratuityAccNo,
      this.hrmEESIApplicableFlag,
      this.hrmEPhoto,
      this.hrmELeftFlag,
      this.hrmEDOL,
      this.hrmELeavingReason,
      this.hrmEHeight,
      this.hrmEHeightUOM,
      this.hrmEWeight,
      this.hrmEWeightUOM,
      this.hrmEIdentificationMark,
      this.hrmEApprovalNo,
      this.hrmEPANCardNo,
      this.hrmEAadharCardNo,
      this.hrmESubstituteFlag,
      this.hrmENationalSSN,
      this.hrmESalaryType,
      this.hrmEEmployeeOrder,
      this.hrmEActiveFlag,
      this.hrmEUINumber,
      this.hrmEDOC,
      this.hrmEExcDR,
      this.hrmEExcPunch,
      this.hrmEAutoPlanerApproval,
      this.createdDate,
      this.updatedDate,
      this.hrmEMobileNo,
      this.hrmEEmailId,
      this.hrmEUpdatedBy,
      this.hrmEQRCode,
      this.hrmEAppDownloadedDeviceId,
      this.hrmECTC,
      this.hrmESubjectsTaught,
      this.hrmECreatedBy});

  EmployeeListModelValues.fromJson(Map<String, dynamic> json) {
    hrmEId = json['hrmE_Id'];
    mIId = json['mI_Id'];
    hrmeTId = json['hrmeT_Id'];
    hrmgTId = json['hrmgT_Id'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmGId = json['hrmG_Id'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    hrmEEmployeeMiddleName = json['hrmE_EmployeeMiddleName'];
    hrmEEmployeeLastName = json['hrmE_EmployeeLastName'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
    hrmEBiometricCode = json['hrmE_BiometricCode'];
    hrmERFCardId = json['hrmE_RFCardId'];
    hrmEPerStreet = json['hrmE_PerStreet'];
    hrmEPerArea = json['hrmE_PerArea'];
    hrmEPerCity = json['hrmE_PerCity'];
    hrmEPerAdd4 = json['hrmE_PerAdd4'];
    hrmEPerStateId = json['hrmE_PerStateId'];
    hrmEPerCountryId = json['hrmE_PerCountryId'];
    hrmEPerPincode = json['hrmE_PerPincode'];
    hrmELocStreet = json['hrmE_LocStreet'];
    hrmELocArea = json['hrmE_LocArea'];
    hrmELocCity = json['hrmE_LocCity'];
    hrmELocAdd4 = json['hrmE_LocAdd4'];
    hrmELocStateId = json['hrmE_LocStateId'];
    hrmELocCountryId = json['hrmE_LocCountryId'];
    hrmELocPincode = json['hrmE_LocPincode'];
    ivrmmmSId = json['ivrmmmS_Id'];
    ivrmmGId = json['ivrmmG_Id'];
    casteCategoryId = json['casteCategoryId'];
    casteId = json['casteId'];
    religionId = json['religionId'];
    hrmEFatherName = json['hrmE_FatherName'];
    hrmEMotherName = json['hrmE_MotherName'];
    hrmESpouseName = json['hrmE_SpouseName'];
    hrmESpouseOccupation = json['hrmE_SpouseOccupation'];
    hrmESpouseMobileNo = json['hrmE_SpouseMobileNo'];
    hrmERelaxtime = json['hrmE_Relaxtime'];
    hrmESpouseEmailId = json['hrmE_SpouseEmailId'];
    hrmESpouseAddress = json['hrmE_SpouseAddress'];
    hrmEDOB = json['hrmE_DOB'];
    hrmEDOJ = json['hrmE_DOJ'];
    hrmEExpectedRetirementDate = json['hrmE_ExpectedRetirementDate'];
    hrmEPFDate = json['hrmE_PFDate'];
    hrmEESIDate = json['hrmE_ESIDate'];
    hrmEBloodGroup = json['hrmE_BloodGroup'];
    hrmEPaymentType = json['hrmE_PaymentType'];
    hrmEBankAccountNo = json['hrmE_BankAccountNo'];
    hrmEPFApplicableFlag = json['hrmE_PFApplicableFlag'];
    hrmEPFMaxFlag = json['hrmE_PFMaxFlag'];
    hrmEPFFixedFlag = json['hrmE_PFFixedFlag'];
    hrmEPFAccNo = json['hrmE_PFAccNo'];
    hrmEESIAccNo = json['hrmE_ESIAccNo'];
    hrmEGratuityAccNo = json['hrmE_GratuityAccNo'];
    hrmEESIApplicableFlag = json['hrmE_ESIApplicableFlag'];
    hrmEPhoto = json['hrmE_Photo'];
    hrmELeftFlag = json['hrmE_LeftFlag'];
    hrmEDOL = json['hrmE_DOL'];
    hrmELeavingReason = json['hrmE_LeavingReason'];
    hrmEHeight = json['hrmE_Height'];
    hrmEHeightUOM = json['hrmE_HeightUOM'];
    hrmEWeight = json['hrmE_Weight'];
    hrmEWeightUOM = json['hrmE_WeightUOM'];
    hrmEIdentificationMark = json['hrmE_IdentificationMark'];
    hrmEApprovalNo = json['hrmE_ApprovalNo'];
    hrmEPANCardNo = json['hrmE_PANCardNo'];
    hrmEAadharCardNo = json['hrmE_AadharCardNo'];
    hrmESubstituteFlag = json['hrmE_SubstituteFlag'];
    hrmENationalSSN = json['hrmE_NationalSSN'];
    hrmESalaryType = json['hrmE_SalaryType'];
    hrmEEmployeeOrder = json['hrmE_EmployeeOrder'];
    hrmEActiveFlag = json['hrmE_ActiveFlag'];
    hrmEUINumber = json['hrmE_UINumber'];
    hrmEDOC = json['hrmE_DOC'];
    hrmEExcDR = json['hrmE_ExcDR'];
    hrmEExcPunch = json['hrmE_ExcPunch'];
    hrmEAutoPlanerApproval = json['hrmE_AutoPlanerApproval'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    hrmEMobileNo = json['hrmE_MobileNo'];
    hrmEEmailId = json['hrmE_EmailId'];
    hrmEUpdatedBy = json['hrmE_UpdatedBy'];
    hrmEQRCode = json['hrmE_QRCode'];
    hrmEAppDownloadedDeviceId = json['hrmE_AppDownloadedDeviceId'];
    hrmECTC = json['hrmE_CTC'];
    hrmESubjectsTaught = json['hrmE_SubjectsTaught'];
    hrmECreatedBy = json['hrmE_CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hrmE_Id'] = hrmEId;
    data['mI_Id'] = mIId;
    data['hrmeT_Id'] = hrmeTId;
    data['hrmgT_Id'] = hrmgTId;
    data['hrmD_Id'] = hrmDId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['hrmG_Id'] = hrmGId;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['hrmE_EmployeeMiddleName'] = hrmEEmployeeMiddleName;
    data['hrmE_EmployeeLastName'] = hrmEEmployeeLastName;
    data['hrmE_EmployeeCode'] = hrmEEmployeeCode;
    data['hrmE_BiometricCode'] = hrmEBiometricCode;
    data['hrmE_RFCardId'] = hrmERFCardId;
    data['hrmE_PerStreet'] = hrmEPerStreet;
    data['hrmE_PerArea'] = hrmEPerArea;
    data['hrmE_PerCity'] = hrmEPerCity;
    data['hrmE_PerAdd4'] = hrmEPerAdd4;
    data['hrmE_PerStateId'] = hrmEPerStateId;
    data['hrmE_PerCountryId'] = hrmEPerCountryId;
    data['hrmE_PerPincode'] = hrmEPerPincode;
    data['hrmE_LocStreet'] = hrmELocStreet;
    data['hrmE_LocArea'] = hrmELocArea;
    data['hrmE_LocCity'] = hrmELocCity;
    data['hrmE_LocAdd4'] = hrmELocAdd4;
    data['hrmE_LocStateId'] = hrmELocStateId;
    data['hrmE_LocCountryId'] = hrmELocCountryId;
    data['hrmE_LocPincode'] = hrmELocPincode;
    data['ivrmmmS_Id'] = ivrmmmSId;
    data['ivrmmG_Id'] = ivrmmGId;
    data['casteCategoryId'] = casteCategoryId;
    data['casteId'] = casteId;
    data['religionId'] = religionId;
    data['hrmE_FatherName'] = hrmEFatherName;
    data['hrmE_MotherName'] = hrmEMotherName;
    data['hrmE_SpouseName'] = hrmESpouseName;
    data['hrmE_SpouseOccupation'] = hrmESpouseOccupation;
    data['hrmE_SpouseMobileNo'] = hrmESpouseMobileNo;
    data['hrmE_Relaxtime'] = hrmERelaxtime;
    data['hrmE_SpouseEmailId'] = hrmESpouseEmailId;
    data['hrmE_SpouseAddress'] = hrmESpouseAddress;
    data['hrmE_DOB'] = hrmEDOB;
    data['hrmE_DOJ'] = hrmEDOJ;
    data['hrmE_ExpectedRetirementDate'] = hrmEExpectedRetirementDate;
    data['hrmE_PFDate'] = hrmEPFDate;
    data['hrmE_ESIDate'] = hrmEESIDate;
    data['hrmE_BloodGroup'] = hrmEBloodGroup;
    data['hrmE_PaymentType'] = hrmEPaymentType;
    data['hrmE_BankAccountNo'] = hrmEBankAccountNo;
    data['hrmE_PFApplicableFlag'] = hrmEPFApplicableFlag;
    data['hrmE_PFMaxFlag'] = hrmEPFMaxFlag;
    data['hrmE_PFFixedFlag'] = hrmEPFFixedFlag;
    data['hrmE_PFAccNo'] = hrmEPFAccNo;
    data['hrmE_ESIAccNo'] = hrmEESIAccNo;
    data['hrmE_GratuityAccNo'] = hrmEGratuityAccNo;
    data['hrmE_ESIApplicableFlag'] = hrmEESIApplicableFlag;
    data['hrmE_Photo'] = hrmEPhoto;
    data['hrmE_LeftFlag'] = hrmELeftFlag;
    data['hrmE_DOL'] = hrmEDOL;
    data['hrmE_LeavingReason'] = hrmELeavingReason;
    data['hrmE_Height'] = hrmEHeight;
    data['hrmE_HeightUOM'] = hrmEHeightUOM;
    data['hrmE_Weight'] = hrmEWeight;
    data['hrmE_WeightUOM'] = hrmEWeightUOM;
    data['hrmE_IdentificationMark'] = hrmEIdentificationMark;
    data['hrmE_ApprovalNo'] = hrmEApprovalNo;
    data['hrmE_PANCardNo'] = hrmEPANCardNo;
    data['hrmE_AadharCardNo'] = hrmEAadharCardNo;
    data['hrmE_SubstituteFlag'] = hrmESubstituteFlag;
    data['hrmE_NationalSSN'] = hrmENationalSSN;
    data['hrmE_SalaryType'] = hrmESalaryType;
    data['hrmE_EmployeeOrder'] = hrmEEmployeeOrder;
    data['hrmE_ActiveFlag'] = hrmEActiveFlag;
    data['hrmE_UINumber'] = hrmEUINumber;
    data['hrmE_DOC'] = hrmEDOC;
    data['hrmE_ExcDR'] = hrmEExcDR;
    data['hrmE_ExcPunch'] = hrmEExcPunch;
    data['hrmE_AutoPlanerApproval'] = hrmEAutoPlanerApproval;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['hrmE_MobileNo'] = hrmEMobileNo;
    data['hrmE_EmailId'] = hrmEEmailId;
    data['hrmE_UpdatedBy'] = hrmEUpdatedBy;
    data['hrmE_QRCode'] = hrmEQRCode;
    data['hrmE_AppDownloadedDeviceId'] = hrmEAppDownloadedDeviceId;
    data['hrmE_CTC'] = hrmECTC;
    data['hrmE_SubjectsTaught'] = hrmESubjectsTaught;
    data['hrmE_CreatedBy'] = hrmECreatedBy;
    return data;
  }
}
