// To parse this JSON data, do
//
//     final salarySlipDetailModel = salarySlipDetailModelFromJson(jsonString);

import 'dart:convert';

SalarySlipDetailModel? salarySlipDetailModelFromJson(String str) =>
    SalarySlipDetailModel.fromJson(json.decode(str));

String salarySlipDetailModelToJson(SalarySlipDetailModel? data) =>
    json.encode(data!.toJson());

class SalarySlipDetailModel {
  SalarySlipDetailModel({
    this.hreSId,
    this.mIId,
    this.hrmEId,
    this.hreSYear,
    this.hreSMonth,
    this.hrmEAge,
    this.basicamount,
    this.checkRole,
    this.roleId,
    this.logInUserId,
    this.lopAmount,
    this.lopdays,
    this.mainList,
  });

  num? hreSId;
  num? mIId;
  num? hrmEId;
  String? hreSYear;
  String? hreSMonth;
  num? hrmEAge;
  num? basicamount;
  String? checkRole;
  num? roleId;
  num? logInUserId;
  num? lopAmount;
  num? lopdays;
  MainList? mainList;

  factory SalarySlipDetailModel.fromJson(Map<String, dynamic> json) =>
      SalarySlipDetailModel(
        hreSId: json["hreS_Id"],
        mIId: json["mI_Id"],
        hrmEId: json["hrmE_Id"],
        hreSYear: json["hreS_Year"],
        hreSMonth: json["hreS_Month"],
        hrmEAge: json["hrmE_Age"],
        basicamount: json["basicamount"],
        checkRole: json["check_role"],
        roleId: json["roleId"],
        logInUserId: json["logInUserId"],
        lopAmount: json["lopAmount"],
        lopdays: json["lopdays"],
        mainList: MainList.fromJson(json["main_list"]),
      );

  Map<String, dynamic> toJson() => {
        "hreS_Id": hreSId,
        "mI_Id": mIId,
        "hrmE_Id": hrmEId,
        "hreS_Year": hreSYear,
        "hreS_Month": hreSMonth,
        "hrmE_Age": hrmEAge,
        "basicamount": basicamount,
        "check_role": checkRole,
        "roleId": roleId,
        "logInUserId": logInUserId,
        "lopAmount": lopAmount,
        "lopdays": lopdays,
        "main_list": mainList!.toJson(),
      };
}

class MainList {
  MainList({
    this.type,
    this.values,
  });

  String? type;
  List<MainListValue?>? values;

  factory MainList.fromJson(Map<String, dynamic> json) => MainList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<MainListValue?>.from(
                json["\$values"]!.map((x) => MainListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class MainListValue {
  MainListValue({
    this.hreSId,
    this.mIId,
    this.hrmEId,
    this.hreSYear,
    this.hreSMonth,
    this.hrmEAge,
    this.basicamount,
    this.roleId,
    this.logInUserId,
    this.institutionDetails,
    this.currentemployeeDetails,
    this.departmentName,
    this.designationName,
    this.genderName,
    this.employeeSalaryslipDetails,
    this.lopAmount,
    this.lopdays,
    this.employeeLeaveDetails,
    this.empsaldetail,
    this.payrollStandard,
  });

  num? hreSId;
  num? mIId;
  num? hrmEId;
  String? hreSYear;
  String? hreSMonth;
  num? hrmEAge;
  num? basicamount;
  num? roleId;
  num? logInUserId;
  InstitutionDetails? institutionDetails;
  CurrentemployeeDetails? currentemployeeDetails;
  String? departmentName;
  String? designationName;
  String? genderName;
  EmployeeSalaryslipDetails? employeeSalaryslipDetails;
  num? lopAmount;
  num? lopdays;
  EmployeeLeaveDetails? employeeLeaveDetails;
  Empsaldetail? empsaldetail;
  PayrollStandard? payrollStandard;

  factory MainListValue.fromJson(Map<String, dynamic> json) => MainListValue(
        hreSId: json["hreS_Id"],
        mIId: json["mI_Id"],
        hrmEId: json["hrmE_Id"],
        hreSYear: json["hreS_Year"],
        hreSMonth: json["hreS_Month"],
        hrmEAge: json["hrmE_Age"],
        basicamount: json["basicamount"],
        roleId: json["roleId"],
        logInUserId: json["logInUserId"],
        institutionDetails:
            InstitutionDetails.fromJson(json["institutionDetails"]),
        currentemployeeDetails:
            CurrentemployeeDetails.fromJson(json["currentemployeeDetails"]),
        departmentName: json["departmentName"],
        designationName: json["designationName"],
        genderName: json["genderName"],
        employeeSalaryslipDetails: EmployeeSalaryslipDetails.fromJson(
            json["employeeSalaryslipDetails"]),
        lopAmount: json["lopAmount"],
        lopdays: json["lopdays"],
        employeeLeaveDetails:
            EmployeeLeaveDetails.fromJson(json["employeeLeaveDetails"] ?? {}),
        empsaldetail: Empsaldetail.fromJson(json["empsaldetail"] ?? {}),
        payrollStandard:
            PayrollStandard.fromJson(json["payrollStandard"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "hreS_Id": hreSId,
        "mI_Id": mIId,
        "hrmE_Id": hrmEId,
        "hreS_Year": hreSYear,
        "hreS_Month": hreSMonth,
        "hrmE_Age": hrmEAge,
        "basicamount": basicamount,
        "roleId": roleId,
        "logInUserId": logInUserId,
        "institutionDetails": institutionDetails!.toJson(),
        "currentemployeeDetails": currentemployeeDetails!.toJson(),
        "departmentName": departmentName,
        "designationName": designationName,
        "genderName": genderName,
        "employeeSalaryslipDetails": employeeSalaryslipDetails!.toJson(),
        "lopAmount": lopAmount,
        "lopdays": lopdays,
        "employeeLeaveDetails": employeeLeaveDetails!.toJson(),
        "empsaldetail": empsaldetail!.toJson(),
        "payrollStandard": payrollStandard!.toJson(),
      };
}

class CurrentemployeeDetails {
  CurrentemployeeDetails({
    this.hrmEId,
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
    this.hrmERfCardId,
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
    this.hrmESpouseEmailId,
    this.hrmESpouseAddress,
    this.hrmEDob,
    this.hrmEDoj,
    this.hrmEExpectedRetirementDate,
    this.hrmEPfDate,
    // this.hrmEEsiDate,
    this.hrmEMobileNo,
    this.hrmEEmailId,
    this.hrmEBloodGroup,
    this.hrmEPaymentType,
    this.hrmEBankAccountNo,
    this.hrmEPfApplicableFlag,
    this.hrmEPfMaxFlag,
    this.hrmEPfFixedFlag,
    this.hrmEPfAccNo,
    this.hrmEEsiAccNo,
    this.hrmEGratuityAccNo,
    this.hrmEEsiApplicableFlag,
    this.hrmEPhoto,
    this.hrmELeftFlag,
    this.hrmELeavingReason,
    this.hrmEHeight,
    this.hrmEHeightUom,
    this.hrmEWeight,
    this.hrmEWeightUom,
    this.hrmEIdentificationMark,
    this.hrmEApprovalNo,
    this.hrmEPanCardNo,
    this.hrmEAadharCardNo,
    this.hrmESubstituteFlag,
    this.hrmENationalSsn,
    this.hrmESalaryType,
    this.hrmEEmployeeOrder,
    this.hrmEActiveFlag,
    this.hrmEUiNumber,
    this.hrmETechNonTeachingFlg,
    this.ivrmuLId,
    this.logInUserId,
    this.imCId,
    this.hrmeQId,
    this.hrmEMsTeamsUserId,
    this.hrmEMsTeamsEmailId,
    this.hrmEMsTeamsPassword,
    this.createdDate,
    this.updatedDate,
  });

  num? hrmEId;
  num? mIId;
  num? hrmeTId;
  num? hrmgTId;
  num? hrmDId;
  num? hrmdeSId;
  num? hrmGId;
  String? hrmEEmployeeFirstName;
  String? hrmEEmployeeMiddleName;
  String? hrmEEmployeeLastName;
  String? hrmEEmployeeCode;
  String? hrmEBiometricCode;
  String? hrmERfCardId;
  String? hrmEPerStreet;
  String? hrmEPerArea;
  String? hrmEPerCity;
  String? hrmEPerAdd4;
  num? hrmEPerStateId;
  num? hrmEPerCountryId;
  num? hrmEPerPincode;
  String? hrmELocStreet;
  String? hrmELocArea;
  String? hrmELocCity;
  String? hrmELocAdd4;
  num? hrmELocStateId;
  num? hrmELocCountryId;
  num? hrmELocPincode;
  num? ivrmmmSId;
  num? ivrmmGId;
  num? casteCategoryId;
  num? casteId;
  num? religionId;
  String? hrmEFatherName;
  String? hrmEMotherName;
  String? hrmESpouseName;
  String? hrmESpouseOccupation;
  String? hrmESpouseEmailId;
  String? hrmESpouseAddress;
  DateTime? hrmEDob;
  DateTime? hrmEDoj;
  DateTime? hrmEExpectedRetirementDate;
  DateTime? hrmEPfDate;
  // DateTime? hrmEEsiDate;
  num? hrmEMobileNo;
  String? hrmEEmailId;
  String? hrmEBloodGroup;
  String? hrmEPaymentType;
  String? hrmEBankAccountNo;
  bool? hrmEPfApplicableFlag;
  bool? hrmEPfMaxFlag;
  bool? hrmEPfFixedFlag;
  String? hrmEPfAccNo;
  String? hrmEEsiAccNo;
  String? hrmEGratuityAccNo;
  bool? hrmEEsiApplicableFlag;
  String? hrmEPhoto;
  bool? hrmELeftFlag;
  String? hrmELeavingReason;
  String? hrmEHeight;
  String? hrmEHeightUom;
  num? hrmEWeight;
  String? hrmEWeightUom;
  String? hrmEIdentificationMark;
  String? hrmEApprovalNo;
  String? hrmEPanCardNo;
  num? hrmEAadharCardNo;
  bool? hrmESubstituteFlag;
  String? hrmENationalSsn;
  String? hrmESalaryType;
  num? hrmEEmployeeOrder;
  bool? hrmEActiveFlag;
  String? hrmEUiNumber;
  String? hrmETechNonTeachingFlg;
  num? ivrmuLId;
  num? logInUserId;
  num? imCId;
  num? hrmeQId;
  String? hrmEMsTeamsUserId;
  String? hrmEMsTeamsEmailId;
  String? hrmEMsTeamsPassword;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory CurrentemployeeDetails.fromJson(Map<String, dynamic> json) =>
      CurrentemployeeDetails(
        hrmEId: json["hrmE_Id"],
        mIId: json["mI_Id"],
        hrmeTId: json["hrmeT_Id"],
        hrmgTId: json["hrmgT_Id"],
        hrmDId: json["hrmD_Id"],
        hrmdeSId: json["hrmdeS_Id"],
        hrmGId: json["hrmG_Id"],
        hrmEEmployeeFirstName: json["hrmE_EmployeeFirstName"],
        hrmEEmployeeMiddleName: json["hrmE_EmployeeMiddleName"],
        hrmEEmployeeLastName: json["hrmE_EmployeeLastName"],
        hrmEEmployeeCode: json["hrmE_EmployeeCode"],
        hrmEBiometricCode: json["hrmE_BiometricCode"],
        hrmERfCardId: json["hrmE_RFCardId"],
        hrmEPerStreet: json["hrmE_PerStreet"],
        hrmEPerArea: json["hrmE_PerArea"],
        hrmEPerCity: json["hrmE_PerCity"],
        hrmEPerAdd4: json["hrmE_PerAdd4"],
        hrmEPerStateId: json["hrmE_PerStateId"],
        hrmEPerCountryId: json["hrmE_PerCountryId"],
        hrmEPerPincode: json["hrmE_PerPincode"],
        hrmELocStreet: json["hrmE_LocStreet"],
        hrmELocArea: json["hrmE_LocArea"],
        hrmELocCity: json["hrmE_LocCity"],
        hrmELocAdd4: json["hrmE_LocAdd4"],
        hrmELocStateId: json["hrmE_LocStateId"],
        hrmELocCountryId: json["hrmE_LocCountryId"],
        hrmELocPincode: json["hrmE_LocPincode"],
        ivrmmmSId: json["ivrmmmS_Id"],
        ivrmmGId: json["ivrmmG_Id"],
        casteCategoryId: json["casteCategoryId"],
        casteId: json["casteId"],
        religionId: json["religionId"],
        hrmEFatherName: json["hrmE_FatherName"],
        hrmEMotherName: json["hrmE_MotherName"],
        hrmESpouseName: json["hrmE_SpouseName"],
        hrmESpouseOccupation: json["hrmE_SpouseOccupation"],
        hrmESpouseEmailId: json["hrmE_SpouseEmailId"],
        hrmESpouseAddress: json["hrmE_SpouseAddress"],
        hrmEDob: DateTime.parse(json["hrmE_DOB"]),
        hrmEDoj: DateTime.parse(json["hrmE_DOJ"]),
        hrmEExpectedRetirementDate:
            DateTime.parse(json["hrmE_ExpectedRetirementDate"]),
        hrmEPfDate: DateTime.parse(json["hrmE_PFDate"]),
        // hrmEEsiDate: DateTime.parse(json["hrmE_ESIDate"] ?? DateTime.now()),
        hrmEMobileNo: json["hrmE_MobileNo"],
        hrmEEmailId: json["hrmE_EmailId"],
        hrmEBloodGroup: json["hrmE_BloodGroup"],
        hrmEPaymentType: json["hrmE_PaymentType"],
        hrmEBankAccountNo: json["hrmE_BankAccountNo"],
        hrmEPfApplicableFlag: json["hrmE_PFApplicableFlag"],
        hrmEPfMaxFlag: json["hrmE_PFMaxFlag"],
        hrmEPfFixedFlag: json["hrmE_PFFixedFlag"],
        hrmEPfAccNo: json["hrmE_PFAccNo"],
        hrmEEsiAccNo: json["hrmE_ESIAccNo"],
        hrmEGratuityAccNo: json["hrmE_GratuityAccNo"],
        hrmEEsiApplicableFlag: json["hrmE_ESIApplicableFlag"],
        hrmEPhoto: json["hrmE_Photo"],
        hrmELeftFlag: json["hrmE_LeftFlag"],
        hrmELeavingReason: json["hrmE_LeavingReason"],
        hrmEHeight: json["hrmE_Height"],
        hrmEHeightUom: json["hrmE_HeightUOM"],
        hrmEWeight: json["hrmE_Weight"],
        hrmEWeightUom: json["hrmE_WeightUOM"],
        hrmEIdentificationMark: json["hrmE_IdentificationMark"],
        hrmEApprovalNo: json["hrmE_ApprovalNo"],
        hrmEPanCardNo: json["hrmE_PANCardNo"],
        hrmEAadharCardNo: json["hrmE_AadharCardNo"],
        hrmESubstituteFlag: json["hrmE_SubstituteFlag"],
        hrmENationalSsn: json["hrmE_NationalSSN"],
        hrmESalaryType: json["hrmE_SalaryType"],
        hrmEEmployeeOrder: json["hrmE_EmployeeOrder"],
        hrmEActiveFlag: json["hrmE_ActiveFlag"],
        hrmEUiNumber: json["hrmE_UINumber"],
        hrmETechNonTeachingFlg: json["hrmE_TechNonTeachingFlg"],
        ivrmuLId: json["ivrmuL_Id"],
        logInUserId: json["logInUserId"],
        imCId: json["imC_Id"],
        hrmeQId: json["hrmeQ_Id"],
        hrmEMsTeamsUserId: json["hrmE_MSTeamsUserId"],
        hrmEMsTeamsEmailId: json["hrmE_MSTeamsEmailId"],
        hrmEMsTeamsPassword: json["hrmE_MSTeamsPassword"],
        createdDate:
            DateTime.parse(json["createdDate"] ?? DateTime.now().toString()),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "hrmE_Id": hrmEId,
        "mI_Id": mIId,
        "hrmeT_Id": hrmeTId,
        "hrmgT_Id": hrmgTId,
        "hrmD_Id": hrmDId,
        "hrmdeS_Id": hrmdeSId,
        "hrmG_Id": hrmGId,
        "hrmE_EmployeeFirstName": hrmEEmployeeFirstName,
        "hrmE_EmployeeMiddleName": hrmEEmployeeMiddleName,
        "hrmE_EmployeeLastName": hrmEEmployeeLastName,
        "hrmE_EmployeeCode": hrmEEmployeeCode,
        "hrmE_BiometricCode": hrmEBiometricCode,
        "hrmE_RFCardId": hrmERfCardId,
        "hrmE_PerStreet": hrmEPerStreet,
        "hrmE_PerArea": hrmEPerArea,
        "hrmE_PerCity": hrmEPerCity,
        "hrmE_PerAdd4": hrmEPerAdd4,
        "hrmE_PerStateId": hrmEPerStateId,
        "hrmE_PerCountryId": hrmEPerCountryId,
        "hrmE_PerPincode": hrmEPerPincode,
        "hrmE_LocStreet": hrmELocStreet,
        "hrmE_LocArea": hrmELocArea,
        "hrmE_LocCity": hrmELocCity,
        "hrmE_LocAdd4": hrmELocAdd4,
        "hrmE_LocStateId": hrmELocStateId,
        "hrmE_LocCountryId": hrmELocCountryId,
        "hrmE_LocPincode": hrmELocPincode,
        "ivrmmmS_Id": ivrmmmSId,
        "ivrmmG_Id": ivrmmGId,
        "casteCategoryId": casteCategoryId,
        "casteId": casteId,
        "religionId": religionId,
        "hrmE_FatherName": hrmEFatherName,
        "hrmE_MotherName": hrmEMotherName,
        "hrmE_SpouseName": hrmESpouseName,
        "hrmE_SpouseOccupation": hrmESpouseOccupation,
        "hrmE_SpouseEmailId": hrmESpouseEmailId,
        "hrmE_SpouseAddress": hrmESpouseAddress,
        "hrmE_DOB": hrmEDob?.toIso8601String(),
        "hrmE_DOJ": hrmEDoj?.toIso8601String(),
        "hrmE_ExpectedRetirementDate":
            hrmEExpectedRetirementDate?.toIso8601String(),
        "hrmE_PFDate": hrmEPfDate?.toIso8601String(),
        // "hrmE_ESIDate": hrmEEsiDate?.toIso8601String(),
        "hrmE_MobileNo": hrmEMobileNo,
        "hrmE_EmailId": hrmEEmailId,
        "hrmE_BloodGroup": hrmEBloodGroup,
        "hrmE_PaymentType": hrmEPaymentType,
        "hrmE_BankAccountNo": hrmEBankAccountNo,
        "hrmE_PFApplicableFlag": hrmEPfApplicableFlag,
        "hrmE_PFMaxFlag": hrmEPfMaxFlag,
        "hrmE_PFFixedFlag": hrmEPfFixedFlag,
        "hrmE_PFAccNo": hrmEPfAccNo,
        "hrmE_ESIAccNo": hrmEEsiAccNo,
        "hrmE_GratuityAccNo": hrmEGratuityAccNo,
        "hrmE_ESIApplicableFlag": hrmEEsiApplicableFlag,
        "hrmE_Photo": hrmEPhoto,
        "hrmE_LeftFlag": hrmELeftFlag,
        "hrmE_LeavingReason": hrmELeavingReason,
        "hrmE_Height": hrmEHeight,
        "hrmE_HeightUOM": hrmEHeightUom,
        "hrmE_Weight": hrmEWeight,
        "hrmE_WeightUOM": hrmEWeightUom,
        "hrmE_IdentificationMark": hrmEIdentificationMark,
        "hrmE_ApprovalNo": hrmEApprovalNo,
        "hrmE_PANCardNo": hrmEPanCardNo,
        "hrmE_AadharCardNo": hrmEAadharCardNo,
        "hrmE_SubstituteFlag": hrmESubstituteFlag,
        "hrmE_NationalSSN": hrmENationalSsn,
        "hrmE_SalaryType": hrmESalaryType,
        "hrmE_EmployeeOrder": hrmEEmployeeOrder,
        "hrmE_ActiveFlag": hrmEActiveFlag,
        "hrmE_UINumber": hrmEUiNumber,
        "hrmE_TechNonTeachingFlg": hrmETechNonTeachingFlg,
        "ivrmuL_Id": ivrmuLId,
        "logInUserId": logInUserId,
        "imC_Id": imCId,
        "hrmeQ_Id": hrmeQId,
        "hrmE_MSTeamsUserId": hrmEMsTeamsUserId,
        "hrmE_MSTeamsEmailId": hrmEMsTeamsEmailId,
        "hrmE_MSTeamsPassword": hrmEMsTeamsPassword,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}

class EmployeeLeaveDetails {
  EmployeeLeaveDetails({
    this.type,
    this.values,
  });

  String? type;
  List<EmployeeLeaveDetailsValue?>? values;

  factory EmployeeLeaveDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeLeaveDetails(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<EmployeeLeaveDetailsValue?>.from(json["\$values"]!
                .map((x) => EmployeeLeaveDetailsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class EmployeeLeaveDetailsValue {
  EmployeeLeaveDetailsValue({
    this.hrelSId,
    this.mIId,
    this.hrmEId,
    this.hrmLId,
    this.hrmlYId,
    this.hrelSObLeaves,
    this.hrelSCreditedLeaves,
    this.hrelSTotalLeaves,
    this.hrelSTransLeaves,
    this.hrelSEncashedLeaves,
    this.hrelSCbLeaves,
    this.hrmLLeaveName,
  });

  num? hrelSId;
  num? mIId;
  num? hrmEId;
  num? hrmLId;
  num? hrmlYId;
  num? hrelSObLeaves;
  num? hrelSCreditedLeaves;
  num? hrelSTotalLeaves;
  num? hrelSTransLeaves;
  num? hrelSEncashedLeaves;
  num? hrelSCbLeaves;
  String? hrmLLeaveName;

  factory EmployeeLeaveDetailsValue.fromJson(Map<String, dynamic> json) =>
      EmployeeLeaveDetailsValue(
        hrelSId: json["hrelS_Id"],
        mIId: json["mI_Id"],
        hrmEId: json["hrmE_Id"],
        hrmLId: json["hrmL_Id"],
        hrmlYId: json["hrmlY_Id"],
        hrelSObLeaves: json["hrelS_OBLeaves"],
        hrelSCreditedLeaves: json["hrelS_CreditedLeaves"],
        hrelSTotalLeaves: json["hrelS_TotalLeaves"],
        hrelSTransLeaves: json["hrelS_TransLeaves"],
        hrelSEncashedLeaves: json["hrelS_EncashedLeaves"],
        hrelSCbLeaves: json["hrelS_CBLeaves"],
        hrmLLeaveName: json["hrmL_LeaveName"],
      );

  Map<String, dynamic> toJson() => {
        "hrelS_Id": hrelSId,
        "mI_Id": mIId,
        "hrmE_Id": hrmEId,
        "hrmL_Id": hrmLId,
        "hrmlY_Id": hrmlYId,
        "hrelS_OBLeaves": hrelSObLeaves,
        "hrelS_CreditedLeaves": hrelSCreditedLeaves,
        "hrelS_TotalLeaves": hrelSTotalLeaves,
        "hrelS_TransLeaves": hrelSTransLeaves,
        "hrelS_EncashedLeaves": hrelSEncashedLeaves,
        "hrelS_CBLeaves": hrelSCbLeaves,
        "hrmL_LeaveName": hrmLLeaveName,
      };
}

class EmployeeSalaryslipDetails {
  EmployeeSalaryslipDetails({
    this.type,
    this.values,
  });

  String? type;
  List<EmployeeSalaryslipDetailsValue?>? values;

  factory EmployeeSalaryslipDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeSalaryslipDetails(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<EmployeeSalaryslipDetailsValue?>.from(json["\$values"]!
                .map((x) => EmployeeSalaryslipDetailsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class EmployeeSalaryslipDetailsValue {
  EmployeeSalaryslipDetailsValue({
    this.type,
    this.miId,
    this.hrmeId,
    this.hresYear,
    this.hresMonth,
    this.hrmedId,
    this.hrmedEarnDedFlag,
    this.hrmedAmountPercentFlag,
    this.hrmedEdTypeFlag,
    this.hrmedName,
    this.amount,
    this.hrmedOrder,
  });

  String? type;
  num? miId;
  num? hrmeId;
  String? hresYear;
  String? hresMonth;
  num? hrmedId;
  String? hrmedEarnDedFlag;
  String? hrmedAmountPercentFlag;
  String? hrmedEdTypeFlag;
  String? hrmedName;
  double? amount;
  num? hrmedOrder;

  factory EmployeeSalaryslipDetailsValue.fromJson(Map<String, dynamic> json) =>
      EmployeeSalaryslipDetailsValue(
        type: json["\$type"],
        miId: json["MI_Id"],
        hrmeId: json["HRME_Id"],
        hresYear: json["HRES_Year"],
        hresMonth: json["HRES_Month"],
        hrmedId: json["HRMED_Id"],
        hrmedEarnDedFlag: json["HRMED_EarnDedFlag"],
        hrmedAmountPercentFlag: json["HRMED_AmountPercentFlag"],
        hrmedEdTypeFlag: json["HRMED_EDTypeFlag"] ?? "",
        hrmedName: json["HRMED_Name"],
        amount: json["Amount"],
        hrmedOrder: json["HRMED_Order"],
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "MI_Id": miId,
        "HRME_Id": hrmeId,
        "HRES_Year": hresYear,
        "HRES_Month": hresMonth,
        "HRMED_Id": hrmedId,
        "HRMED_EarnDedFlag": hrmedEarnDedFlag,
        "HRMED_AmountPercentFlag": hrmedAmountPercentFlag,
        "HRMED_EDTypeFlag": hrmedEdTypeFlag,
        "HRMED_Name": hrmedName,
        "Amount": amount,
        "HRMED_Order": hrmedOrder,
      };
}

class Empsaldetail {
  Empsaldetail({
    this.hreSId,
    this.mIId,
    this.hrmEId,
    this.hreSYear,
    this.hreSMonth,
    this.hreSWorkingDays,
    this.hreSDailyRates,
    this.hreSEpf,
    this.hreSFpf,
    this.hreSAc21,
    this.hreSAc22,
    this.hreSAc5,
    // this.hreSFromDate,
    // this.hreSToDate,
    this.hreSBankCashFlag,
    this.hrmgTId,
    this.hrmDId,
    this.hrmdeSId,
    this.hreSBankCode,
    this.hreSAccountNo,
    this.hrmEAge,
    this.basicamount,
    this.roleId,
    this.logInUserId,
    this.lopAmount,
    this.lopdays,
  });

  num? hreSId;
  num? mIId;
  num? hrmEId;
  String? hreSYear;
  String? hreSMonth;
  num? hreSWorkingDays;
  String? hreSDailyRates;
  num? hreSEpf;
  num? hreSFpf;
  num? hreSAc21;
  num? hreSAc22;
  num? hreSAc5;
  // DateTime? hreSFromDate;
  // DateTime? hreSToDate;
  String? hreSBankCashFlag;
  num? hrmgTId;
  num? hrmDId;
  num? hrmdeSId;
  String? hreSBankCode;
  String? hreSAccountNo;
  num? hrmEAge;
  num? basicamount;
  num? roleId;
  num? logInUserId;
  num? lopAmount;
  num? lopdays;

  factory Empsaldetail.fromJson(Map<String, dynamic> json) => Empsaldetail(
        hreSId: json["hreS_Id"],
        mIId: json["mI_Id"],
        hrmEId: json["hrmE_Id"],
        hreSYear: json["hreS_Year"],
        hreSMonth: json["hreS_Month"],
        hreSWorkingDays: json["hreS_WorkingDays"],
        hreSDailyRates: json["hreS_DailyRates"],
        hreSEpf: json["hreS_EPF"],
        hreSFpf: json["hreS_FPF"],
        hreSAc21: json["hreS_Ac21"],
        hreSAc22: json["hreS_Ac22"],
        hreSAc5: json["hreS_Ac5"],
        // hreSFromDate: DateTime.parse(json["hreS_FromDate"]),
        // hreSToDate: DateTime.parse(json["hreS_ToDate"]),
        hreSBankCashFlag: json["hreS_BankCashFlag"],
        hrmgTId: json["hrmgT_Id"],
        hrmDId: json["hrmD_Id"],
        hrmdeSId: json["hrmdeS_Id"],
        hreSBankCode: json["hreS_BankCode"],
        hreSAccountNo: json["hreS_AccountNo"],
        hrmEAge: json["hrmE_Age"],
        basicamount: json["basicamount"],
        roleId: json["roleId"],
        logInUserId: json["logInUserId"],
        lopAmount: json["lopAmount"],
        lopdays: json["lopdays"],
      );

  Map<String, dynamic> toJson() => {
        "hreS_Id": hreSId,
        "mI_Id": mIId,
        "hrmE_Id": hrmEId,
        "hreS_Year": hreSYear,
        "hreS_Month": hreSMonth,
        "hreS_WorkingDays": hreSWorkingDays,
        "hreS_DailyRates": hreSDailyRates,
        "hreS_EPF": hreSEpf,
        "hreS_FPF": hreSFpf,
        "hreS_Ac21": hreSAc21,
        "hreS_Ac22": hreSAc22,
        "hreS_Ac5": hreSAc5,
        // "hreS_FromDate": hreSFromDate?.toIso8601String(),
        // "hreS_ToDate": hreSToDate?.toIso8601String(),
        "hreS_BankCashFlag": hreSBankCashFlag,
        "hrmgT_Id": hrmgTId,
        "hrmD_Id": hrmDId,
        "hrmdeS_Id": hrmdeSId,
        "hreS_BankCode": hreSBankCode,
        "hreS_AccountNo": hreSAccountNo,
        "hrmE_Age": hrmEAge,
        "basicamount": basicamount,
        "roleId": roleId,
        "logInUserId": logInUserId,
        "lopAmount": lopAmount,
        "lopdays": lopdays,
      };
}

class InstitutionDetails {
  InstitutionDetails({
    this.mIId,
    this.mOId,
    this.mvidcoNId,
    this.mIName,
    this.mIVcStudentFlag,
    this.mIVcOthersFlag,
    this.mIType,
    this.mIAddress1,
    this.mIAddress2,
    this.mIAddress3,
    this.ivrmmcTName,
    this.ivrmmSId,
    this.mIMsTeamsAdminUsername,
    this.mIMsTeamsAdminPassword,
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
    this.mINaacInstitutionTypeFlg,
    this.mIAffiliation,
    this.ivrmPId,
    this.sessionMiId,
    this.sessionMoId,
    this.mISubdomain,
    this.userId,
    this.roleId,
    this.mIContactDetails,
    this.mIAboutInstitute,
    this.mIFranchiseFlag,
    this.mISchoolCollegeFlag,
    this.mINaacSubInstitutionTypeFlg,
    this.mIMsTeamsClientId,
    this.mIMsTeamsTenentId,
    this.mIMsTemasClinetSecretCode,
    this.mIMsTeamsAppAccessTockenUrl,
    this.mIMsTeamsUserAceessTockenUrl,
    this.mIMsTeamsMeetingScheduleUrl,
    this.mIMsTeamsGrantType,
    this.mIMsTeamsScope,
    this.mIEntityId,
    this.perviousMiId,
    this.currentMiId,
    this.createdDate,
    this.updatedDate,
  });

  num? mIId;
  num? mOId;
  num? mvidcoNId;
  String? mIName;
  String? mIVcStudentFlag;
  String? mIVcOthersFlag;
  String? mIType;
  String? mIAddress1;
  String? mIAddress2;
  String? mIAddress3;
  String? ivrmmcTName;
  num? ivrmmSId;
  String? mIMsTeamsAdminUsername;
  String? mIMsTeamsAdminPassword;
  num? ivrmmCId;
  num? mIPincode;
  String? mIBackgroundImage;
  String? mIFormColor;
  String? mIFontColor;
  num? mIFontSize;
  String? mIWeekStartDay;
  String? mIDateFormat;
  String? mIDateSeparator;
  String? mILogo;
  num? mIActiveFlag;
  String? mINaacInstitutionTypeFlg;
  String? mIAffiliation;
  num? ivrmPId;
  num? sessionMiId;
  num? sessionMoId;
  String? mISubdomain;
  num? userId;
  num? roleId;
  String? mIContactDetails;
  String? mIAboutInstitute;
  num? mIFranchiseFlag;
  String? mISchoolCollegeFlag;
  String? mINaacSubInstitutionTypeFlg;
  String? mIMsTeamsClientId;
  String? mIMsTeamsTenentId;
  String? mIMsTemasClinetSecretCode;
  String? mIMsTeamsAppAccessTockenUrl;
  String? mIMsTeamsUserAceessTockenUrl;
  String? mIMsTeamsMeetingScheduleUrl;
  String? mIMsTeamsGrantType;
  String? mIMsTeamsScope;
  String? mIEntityId;
  num? perviousMiId;
  num? currentMiId;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory InstitutionDetails.fromJson(Map<String, dynamic> json) =>
      InstitutionDetails(
        mIId: json["mI_Id"],
        mOId: json["mO_Id"],
        mvidcoNId: json["mvidcoN_Id"],
        mIName: json["mI_Name"],
        mIVcStudentFlag: json["mI_VCStudentFlag"],
        mIVcOthersFlag: json["mI_VCOthersFlag"],
        mIType: json["mI_Type"],
        mIAddress1: json["mI_Address1"],
        mIAddress2: json["mI_Address2"],
        mIAddress3: json["mI_Address3"],
        ivrmmcTName: json["ivrmmcT_Name"],
        ivrmmSId: json["ivrmmS_Id"],
        mIMsTeamsAdminUsername: json["mI_MSTeamsAdminUsername"],
        mIMsTeamsAdminPassword: json["mI_MSTeamsAdminPassword"],
        ivrmmCId: json["ivrmmC_Id"],
        mIPincode: json["mI_Pincode"],
        mIBackgroundImage: json["mI_BackgroundImage"],
        mIFormColor: json["mI_FormColor"],
        mIFontColor: json["mI_FontColor"],
        mIFontSize: json["mI_FontSize"],
        mIWeekStartDay: json["mI_WeekStartDay"],
        mIDateFormat: json["mI_DateFormat"],
        mIDateSeparator: json["mI_DateSeparator"],
        mILogo: json["mI_Logo"],
        mIActiveFlag: json["mI_ActiveFlag"],
        mINaacInstitutionTypeFlg: json["mI_NAAC_InstitutionTypeFlg"],
        mIAffiliation: json["mI_Affiliation"],
        ivrmPId: json["ivrmP_Id"],
        sessionMiId: json["sessionMI_Id"],
        sessionMoId: json["sessionMO_Id"],
        mISubdomain: json["mI_Subdomain"],
        userId: json["userId"],
        roleId: json["roleId"],
        mIContactDetails: json["mI_ContactDetails"],
        mIAboutInstitute: json["mI_AboutInstitute"],
        mIFranchiseFlag: json["mI_FranchiseFlag"],
        mISchoolCollegeFlag: json["mI_SchoolCollegeFlag"],
        mINaacSubInstitutionTypeFlg: json["mI_NAAC_SubInstitutionTypeFlg"],
        mIMsTeamsClientId: json["mI_MSTeamsClientId"],
        mIMsTeamsTenentId: json["mI_MSTeamsTenentId"],
        mIMsTemasClinetSecretCode: json["mI_MSTemasClinetSecretCode"],
        mIMsTeamsAppAccessTockenUrl: json["mI_MSTeamsAppAccessTockenURL"],
        mIMsTeamsUserAceessTockenUrl: json["mI_MSTeamsUserAceessTockenURL"],
        mIMsTeamsMeetingScheduleUrl: json["mI_MSTeamsMeetingScheduleURL"],
        mIMsTeamsGrantType: json["mI_MSTeamsGrantType"],
        mIMsTeamsScope: json["mI_MSTeamsScope"],
        mIEntityId: json["mI_EntityId"],
        perviousMiId: json["pervious_MI_Id"],
        currentMiId: json["current_MI_Id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "mI_Id": mIId,
        "mO_Id": mOId,
        "mvidcoN_Id": mvidcoNId,
        "mI_Name": mIName,
        "mI_VCStudentFlag": mIVcStudentFlag,
        "mI_VCOthersFlag": mIVcOthersFlag,
        "mI_Type": mIType,
        "mI_Address1": mIAddress1,
        "mI_Address2": mIAddress2,
        "mI_Address3": mIAddress3,
        "ivrmmcT_Name": ivrmmcTName,
        "ivrmmS_Id": ivrmmSId,
        "mI_MSTeamsAdminUsername": mIMsTeamsAdminUsername,
        "mI_MSTeamsAdminPassword": mIMsTeamsAdminPassword,
        "ivrmmC_Id": ivrmmCId,
        "mI_Pincode": mIPincode,
        "mI_BackgroundImage": mIBackgroundImage,
        "mI_FormColor": mIFormColor,
        "mI_FontColor": mIFontColor,
        "mI_FontSize": mIFontSize,
        "mI_WeekStartDay": mIWeekStartDay,
        "mI_DateFormat": mIDateFormat,
        "mI_DateSeparator": mIDateSeparator,
        "mI_Logo": mILogo,
        "mI_ActiveFlag": mIActiveFlag,
        "mI_NAAC_InstitutionTypeFlg": mINaacInstitutionTypeFlg,
        "mI_Affiliation": mIAffiliation,
        "ivrmP_Id": ivrmPId,
        "sessionMI_Id": sessionMiId,
        "sessionMO_Id": sessionMoId,
        "mI_Subdomain": mISubdomain,
        "userId": userId,
        "roleId": roleId,
        "mI_ContactDetails": mIContactDetails,
        "mI_AboutInstitute": mIAboutInstitute,
        "mI_FranchiseFlag": mIFranchiseFlag,
        "mI_SchoolCollegeFlag": mISchoolCollegeFlag,
        "mI_NAAC_SubInstitutionTypeFlg": mINaacSubInstitutionTypeFlg,
        "mI_MSTeamsClientId": mIMsTeamsClientId,
        "mI_MSTeamsTenentId": mIMsTeamsTenentId,
        "mI_MSTemasClinetSecretCode": mIMsTemasClinetSecretCode,
        "mI_MSTeamsAppAccessTockenURL": mIMsTeamsAppAccessTockenUrl,
        "mI_MSTeamsUserAceessTockenURL": mIMsTeamsUserAceessTockenUrl,
        "mI_MSTeamsMeetingScheduleURL": mIMsTeamsMeetingScheduleUrl,
        "mI_MSTeamsGrantType": mIMsTeamsGrantType,
        "mI_MSTeamsScope": mIMsTeamsScope,
        "mI_EntityId": mIEntityId,
        "pervious_MI_Id": perviousMiId,
        "current_MI_Id": currentMiId,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}

class PayrollStandard {
  PayrollStandard({
    this.hrCId,
    this.mIId,
    this.hrCPfMaxAmt,
    this.hrCFpfPer,
    this.hrCEpfPer,
    this.hrCAsPerEmpFlag,
    this.hrCPfAccNoPrefix,
    this.hrCAccNo2,
    this.hrCAccNo21,
    this.hrCAccNo22,
    this.hrCRetirementYrs,
    this.hrCECodePrefix,
    this.hrCEsiMax,
    this.hrCEsiEmplrCont,
    this.hrCPayMethodFlg,
    this.hrCArrSalaryFlag,
    this.hrCCummArrFlag,
    this.hrCSalaryFromDay,
    this.hrCSalaryToDay,
    this.hrCArtfpfPer,
    this.hrCArtepfPer,
    this.hrCEsiMaxAmount,
    this.hrCAc2MinAmount,
    this.hrCAc21MinAmount,
    this.hrCAc22MinAmount,
    this.hrCSalAdvApprovalFlg,
    this.hrCLoanApprovalFlg,
    this.hrCSalApprovalFlg,
    this.hrCEducationCess,
    this.roleId,
    this.hrCIncrementMonth,
    this.hrCMinimumWorkingPeriod,
    this.hrCFixedIncrmentFlg,
    this.hrCNoOfOptionalHolidays,
    this.hrCIncrementOnceInMonths,
    this.hrCAlertDay,
  });

  num? hrCId;
  num? mIId;
  num? hrCPfMaxAmt;
  double? hrCFpfPer;
  double? hrCEpfPer;
  bool? hrCAsPerEmpFlag;
  String? hrCPfAccNoPrefix;
  double? hrCAccNo2;
  double? hrCAccNo21;
  double? hrCAccNo22;
  num? hrCRetirementYrs;
  String? hrCECodePrefix;
  double? hrCEsiMax;
  double? hrCEsiEmplrCont;
  String? hrCPayMethodFlg;
  bool? hrCArrSalaryFlag;
  bool? hrCCummArrFlag;
  num? hrCSalaryFromDay;
  num? hrCSalaryToDay;
  num? hrCArtfpfPer;
  num? hrCArtepfPer;
  num? hrCEsiMaxAmount;
  num? hrCAc2MinAmount;
  num? hrCAc21MinAmount;
  num? hrCAc22MinAmount;
  bool? hrCSalAdvApprovalFlg;
  bool? hrCLoanApprovalFlg;
  bool? hrCSalApprovalFlg;
  num? hrCEducationCess;
  num? roleId;
  String? hrCIncrementMonth;
  num? hrCMinimumWorkingPeriod;
  bool? hrCFixedIncrmentFlg;
  num? hrCNoOfOptionalHolidays;
  num? hrCIncrementOnceInMonths;
  num? hrCAlertDay;

  factory PayrollStandard.fromJson(Map<String, dynamic> json) =>
      PayrollStandard(
        hrCId: json["hrC_Id"],
        mIId: json["mI_Id"],
        hrCPfMaxAmt: json["hrC_PFMaxAmt"],
        hrCFpfPer: json["hrC_FPFPer"].toDouble(),
        hrCEpfPer: json["hrC_EPFPer"].toDouble(),
        hrCAsPerEmpFlag: json["hrC_AsPerEmpFlag"],
        hrCPfAccNoPrefix: json["hrC_PFAccNoPrefix"],
        hrCAccNo2: json["hrC_AccNo2"].toDouble(),
        hrCAccNo21: json["hrC_AccNo21"].toDouble(),
        hrCAccNo22: json["hrC_AccNo22"].toDouble(),
        hrCRetirementYrs: json["hrC_RetirementYrs"],
        hrCECodePrefix: json["hrC_ECodePrefix"],
        hrCEsiMax: json["hrC_ESIMax"].toDouble(),
        hrCEsiEmplrCont: json["hrC_ESIEmplrCont"].toDouble(),
        hrCPayMethodFlg: json["hrC_PayMethodFlg"],
        hrCArrSalaryFlag: json["hrC_ArrSalaryFlag"],
        hrCCummArrFlag: json["hrC_CummArrFlag"],
        hrCSalaryFromDay: json["hrC_SalaryFromDay"],
        hrCSalaryToDay: json["hrC_SalaryToDay"],
        hrCArtfpfPer: json["hrC_ARTFPFPer"],
        hrCArtepfPer: json["hrC_ARTEPFPer"],
        hrCEsiMaxAmount: json["hrC_ESIMaxAmount"],
        hrCAc2MinAmount: json["hrC_AC2MinAmount"],
        hrCAc21MinAmount: json["hrC_AC21MinAmount"],
        hrCAc22MinAmount: json["hrC_AC22MinAmount"],
        hrCSalAdvApprovalFlg: json["hrC_SalAdvApprovalFlg"],
        hrCLoanApprovalFlg: json["hrC_LoanApprovalFlg"],
        hrCSalApprovalFlg: json["hrC_SalApprovalFlg"],
        hrCEducationCess: json["hrC_EducationCess"],
        roleId: json["roleId"],
        hrCIncrementMonth: json["hrC_IncrementMonth"],
        hrCMinimumWorkingPeriod: json["hrC_MinimumWorkingPeriod"],
        hrCFixedIncrmentFlg: json["hrC_FixedIncrmentFlg"],
        hrCNoOfOptionalHolidays: json["hrC_NoOfOptionalHolidays"],
        hrCIncrementOnceInMonths: json["hrC_IncrementOnceInMonths"],
        hrCAlertDay: json["hrC_AlertDay"],
      );

  Map<String, dynamic> toJson() => {
        "hrC_Id": hrCId,
        "mI_Id": mIId,
        "hrC_PFMaxAmt": hrCPfMaxAmt,
        "hrC_FPFPer": hrCFpfPer,
        "hrC_EPFPer": hrCEpfPer,
        "hrC_AsPerEmpFlag": hrCAsPerEmpFlag,
        "hrC_PFAccNoPrefix": hrCPfAccNoPrefix,
        "hrC_AccNo2": hrCAccNo2,
        "hrC_AccNo21": hrCAccNo21,
        "hrC_AccNo22": hrCAccNo22,
        "hrC_RetirementYrs": hrCRetirementYrs,
        "hrC_ECodePrefix": hrCECodePrefix,
        "hrC_ESIMax": hrCEsiMax,
        "hrC_ESIEmplrCont": hrCEsiEmplrCont,
        "hrC_PayMethodFlg": hrCPayMethodFlg,
        "hrC_ArrSalaryFlag": hrCArrSalaryFlag,
        "hrC_CummArrFlag": hrCCummArrFlag,
        "hrC_SalaryFromDay": hrCSalaryFromDay,
        "hrC_SalaryToDay": hrCSalaryToDay,
        "hrC_ARTFPFPer": hrCArtfpfPer,
        "hrC_ARTEPFPer": hrCArtepfPer,
        "hrC_ESIMaxAmount": hrCEsiMaxAmount,
        "hrC_AC2MinAmount": hrCAc2MinAmount,
        "hrC_AC21MinAmount": hrCAc21MinAmount,
        "hrC_AC22MinAmount": hrCAc22MinAmount,
        "hrC_SalAdvApprovalFlg": hrCSalAdvApprovalFlg,
        "hrC_LoanApprovalFlg": hrCLoanApprovalFlg,
        "hrC_SalApprovalFlg": hrCSalApprovalFlg,
        "hrC_EducationCess": hrCEducationCess,
        "roleId": roleId,
        "hrC_IncrementMonth": hrCIncrementMonth,
        "hrC_MinimumWorkingPeriod": hrCMinimumWorkingPeriod,
        "hrC_FixedIncrmentFlg": hrCFixedIncrmentFlg,
        "hrC_NoOfOptionalHolidays": hrCNoOfOptionalHolidays,
        "hrC_IncrementOnceInMonths": hrCIncrementOnceInMonths,
        "hrC_AlertDay": hrCAlertDay,
      };
}
