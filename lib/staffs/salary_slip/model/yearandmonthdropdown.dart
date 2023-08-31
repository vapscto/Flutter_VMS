// To parse this JSON data, do
//
//     final yearAndMonthDropdownModel = yearAndMonthDropdownModelFromJson(jsonString);

import 'dart:convert';

YearAndMonthDropdownModel? yearAndMonthDropdownModelFromJson(String str) =>
    YearAndMonthDropdownModel.fromJson(json.decode(str));

String yearAndMonthDropdownModelToJson(YearAndMonthDropdownModel? data) =>
    json.encode(data!.toJson());

class YearAndMonthDropdownModel {
  YearAndMonthDropdownModel({
    this.hreSId,
    this.mIId,
    this.hrmEId,
    this.hrmEAge,
    this.basicamount,
    this.roleId,
    this.monthdropdown,
    this.employeedropdown,
    this.leaveyeardropdown,
    this.departmentdropdown,
    this.designationdropdown,
    this.logInUserId,
    this.groupTypedropdown,
    this.lopAmount,
    this.lopdays,
  });

  int? hreSId;
  int? mIId;
  int? hrmEId;
  int? hrmEAge;
  int? basicamount;
  int? roleId;
  MonthDropdown? monthdropdown;
  Dropdown? employeedropdown;
  YearDropdown? leaveyeardropdown;
  Dropdown? departmentdropdown;
  Dropdown? designationdropdown;
  int? logInUserId;
  Dropdown? groupTypedropdown;
  num? lopAmount;
  num? lopdays;

  factory YearAndMonthDropdownModel.fromJson(Map<String, dynamic> json) =>
      YearAndMonthDropdownModel(
        hreSId: json["hreS_Id"],
        mIId: json["mI_Id"],
        hrmEId: json["hrmE_Id"],
        hrmEAge: json["hrmE_Age"],
        basicamount: json["basicamount"],
        roleId: json["roleId"],
        monthdropdown: MonthDropdown.fromJson(json["monthdropdown"]),
        employeedropdown: Dropdown.fromJson(json["employeedropdown"]),
        leaveyeardropdown: YearDropdown.fromJson(json["leaveyeardropdown"]),
        departmentdropdown: Dropdown.fromJson(json["departmentdropdown"]),
        designationdropdown: Dropdown.fromJson(json["designationdropdown"]),
        logInUserId: json["logInUserId"],
        groupTypedropdown: Dropdown.fromJson(json["groupTypedropdown"]),
        lopAmount: json["lopAmount"],
        lopdays: json["lopdays"],
      );

  Map<String, dynamic> toJson() => {
        "hreS_Id": hreSId,
        "mI_Id": mIId,
        "hrmE_Id": hrmEId,
        "hrmE_Age": hrmEAge,
        "basicamount": basicamount,
        "roleId": roleId,
        "monthdropdown": monthdropdown!.toJson(),
        "employeedropdown": employeedropdown!.toJson(),
        "leaveyeardropdown": leaveyeardropdown!.toJson(),
        "departmentdropdown": departmentdropdown!.toJson(),
        "designationdropdown": designationdropdown!.toJson(),
        "logInUserId": logInUserId,
        "groupTypedropdown": groupTypedropdown!.toJson(),
        "lopAmount": lopAmount,
        "lopdays": lopdays,
      };
}

class Dropdown {
  Dropdown({
    this.type,
    this.values,
  });

  String? type;
  List<Value?>? values;

  factory Dropdown.fromJson(Map<String, dynamic> json) => Dropdown(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<Value?>.from(
                json["\$values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class Value {
  Value({
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
    this.hrmEEsiDate,
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
    this.hrmEAppDownloadedDeviceId,
    this.hrmETechNonTeachingFlg,
    this.hrmEMsTeamsUserId,
    this.hrmEMsTeamsEmailId,
    this.hrmEMsTeamsPassword,
    this.createdDate,
    this.updatedDate,
    this.hrmlYId,
    this.hrmlYLeaveYear,
    this.hrmlYFromDate,
    this.hrmlYToDate,
    this.hrmlYActiveFlag,
    this.hrmlYLeaveYearOrder,
    this.ivrMMonthId,
    this.ivrMMonthName,
    this.isActive,
    this.ivrMMonthMaxDays,
  });

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
  String? hrmERfCardId;
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
  String? hrmESpouseEmailId;
  String? hrmESpouseAddress;
  String? hrmEDob;
  String? hrmEDoj;
  String? hrmEExpectedRetirementDate;
  String? hrmEPfDate;
  String? hrmEEsiDate;
  int? hrmEMobileNo;
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
  int? hrmEWeight;
  String? hrmEWeightUom;
  String? hrmEIdentificationMark;
  String? hrmEApprovalNo;
  String? hrmEPanCardNo;
  int? hrmEAadharCardNo;
  bool? hrmESubstituteFlag;
  String? hrmENationalSsn;
  String? hrmESalaryType;
  int? hrmEEmployeeOrder;
  bool? hrmEActiveFlag;
  String? hrmEUiNumber;
  String? hrmEAppDownloadedDeviceId;
  String? hrmETechNonTeachingFlg;
  String? hrmEMsTeamsUserId;
  String? hrmEMsTeamsEmailId;
  String? hrmEMsTeamsPassword;
  String? createdDate;
  String? updatedDate;
  int? hrmlYId;
  String? hrmlYLeaveYear;
  DateTime? hrmlYFromDate;
  DateTime? hrmlYToDate;
  bool? hrmlYActiveFlag;
  int? hrmlYLeaveYearOrder;
  int? ivrMMonthId;
  String? ivrMMonthName;
  bool? isActive;
  int? ivrMMonthMaxDays;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
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
        hrmEDob: json["hrmE_DOB"],
        hrmEDoj: json["hrmE_DOJ"],
        hrmEExpectedRetirementDate: json["hrmE_ExpectedRetirementDate"],
        hrmEPfDate: json["hrmE_PFDate"],
        hrmEEsiDate: json["hrmE_ESIDate"],
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
        hrmEAppDownloadedDeviceId: json["hrmE_AppDownloadedDeviceId"],
        hrmETechNonTeachingFlg: json["hrmE_TechNonTeachingFlg"],
        hrmEMsTeamsUserId: json["hrmE_MSTeamsUserId"],
        hrmEMsTeamsEmailId: json["hrmE_MSTeamsEmailId"],
        hrmEMsTeamsPassword: json["hrmE_MSTeamsPassword"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        hrmlYId: json["hrmlY_Id"],
        hrmlYLeaveYear: json["hrmlY_LeaveYear"],
        hrmlYFromDate: json["hrmlY_FromDate"],
        hrmlYToDate: json["hrmlY_ToDate"],
        hrmlYActiveFlag: json["hrmlY_ActiveFlag"],
        hrmlYLeaveYearOrder: json["hrmlY_LeaveYearOrder"],
        ivrMMonthId: json["ivrM_Month_Id"],
        ivrMMonthName: json["ivrM_Month_Name"],
        isActive: json["is_Active"],
        ivrMMonthMaxDays: json["ivrM_Month_Max_Days"],
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
        "hrmE_DOB": hrmEDob,
        "hrmE_DOJ": hrmEDoj,
        "hrmE_ExpectedRetirementDate": hrmEExpectedRetirementDate,
        "hrmE_PFDate": hrmEPfDate,
        "hrmE_ESIDate": hrmEEsiDate,
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
        "hrmE_AppDownloadedDeviceId": hrmEAppDownloadedDeviceId,
        "hrmE_TechNonTeachingFlg": hrmETechNonTeachingFlg,
        "hrmE_MSTeamsUserId": hrmEMsTeamsUserId,
        "hrmE_MSTeamsEmailId": hrmEMsTeamsEmailId,
        "hrmE_MSTeamsPassword": hrmEMsTeamsPassword,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "hrmlY_Id": hrmlYId,
        "hrmlY_LeaveYear": hrmlYLeaveYear,
        "hrmlY_FromDate": hrmlYFromDate,
        "hrmlY_ToDate": hrmlYToDate,
        "hrmlY_ActiveFlag": hrmlYActiveFlag,
        "hrmlY_LeaveYearOrder": hrmlYLeaveYearOrder,
        "ivrM_Month_Id": ivrMMonthId,
        "ivrM_Month_Name": ivrMMonthName,
        "is_Active": isActive,
        "ivrM_Month_Max_Days": ivrMMonthMaxDays,
      };
}

class MonthDropdown {
  MonthDropdown({
    this.type,
    this.values,
  });

  String? type;
  List<MonthDropdownValue?>? values;

  factory MonthDropdown.fromJson(Map<String, dynamic> json) => MonthDropdown(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<MonthDropdownValue?>.from(
                json["\$values"]!.map((x) => MonthDropdownValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class MonthDropdownValue {
  MonthDropdownValue({
    this.ivrMMonthId,
    this.ivrMMonthName,
    this.isActive,
    this.ivrMMonthMaxDays,
  });

  int? ivrMMonthId;
  String? ivrMMonthName;
  bool? isActive;
  int? ivrMMonthMaxDays;

  factory MonthDropdownValue.fromJson(Map<String, dynamic> json) =>
      MonthDropdownValue(
        ivrMMonthId: json["ivrM_Month_Id"],
        ivrMMonthName: json["ivrM_Month_Name"],
        isActive: json["is_Active"],
        ivrMMonthMaxDays: json["ivrM_Month_Max_Days"],
      );

  Map<String, dynamic> toJson() => {
        "ivrM_Month_Id": ivrMMonthId,
        "ivrM_Month_Name": ivrMMonthName,
        "is_Active": isActive,
        "ivrM_Month_Max_Days": ivrMMonthMaxDays,
      };
}

class YearDropdown {
  YearDropdown({
    this.type,
    this.values,
  });

  String? type;
  List<YearDropdownValue?>? values;

  factory YearDropdown.fromJson(Map<String, dynamic> json) => YearDropdown(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<YearDropdownValue?>.from(
                json["\$values"]!.map((x) => YearDropdownValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class YearDropdownValue {
  YearDropdownValue({
    this.hrmlYId,
    this.mIId,
    this.hrmlYLeaveYear,
    this.hrmlYFromDate,
    this.hrmlYToDate,
    this.hrmlYActiveFlag,
    this.hrmlYLeaveYearOrder,
    this.createdDate,
    this.updatedDate,
  });

  int? hrmlYId;
  int? mIId;
  String? hrmlYLeaveYear;
  DateTime? hrmlYFromDate;
  DateTime? hrmlYToDate;
  bool? hrmlYActiveFlag;
  int? hrmlYLeaveYearOrder;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory YearDropdownValue.fromJson(Map<String, dynamic> json) =>
      YearDropdownValue(
        hrmlYId: json["hrmlY_Id"],
        mIId: json["mI_Id"],
        hrmlYLeaveYear: json["hrmlY_LeaveYear"],
        hrmlYFromDate: DateTime.parse(json["hrmlY_FromDate"]),
        hrmlYToDate: DateTime.parse(json["hrmlY_ToDate"]),
        hrmlYActiveFlag: json["hrmlY_ActiveFlag"],
        hrmlYLeaveYearOrder: json["hrmlY_LeaveYearOrder"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "hrmlY_Id": hrmlYId,
        "mI_Id": mIId,
        "hrmlY_LeaveYear": hrmlYLeaveYear,
        "hrmlY_FromDate": hrmlYFromDate?.toIso8601String(),
        "hrmlY_ToDate": hrmlYToDate?.toIso8601String(),
        "hrmlY_ActiveFlag": hrmlYActiveFlag,
        "hrmlY_LeaveYearOrder": hrmlYLeaveYearOrder,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}
