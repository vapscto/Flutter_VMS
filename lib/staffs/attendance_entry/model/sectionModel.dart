// To parse this JSON data, do
//
//     final sectionModel = sectionModelFromJson(jsonString);

import 'dart:convert';

SectionModel sectionModelFromJson(String str) =>
    SectionModel.fromJson(json.decode(str));

String sectionModelToJson(SectionModel data) => json.encode(data.toJson());

class SectionModel {
  SectionModel({
    this.asAId,
    this.mIId,
    this.asmaYId,
    this.asAAttEntryType,
    this.asmcLId,
    this.asmSId,
    this.amsTId,
    this.asAClassAttended,
    this.sectionList,
    this.studentList,
    this.returnval,
    this.countclass,
    this.countclass1,
    this.attendanceentryflag,
    this.attdefaultdisplay,
    this.username,
    this.empCode,
    this.asalUId,
    this.userId,
    this.flag,
    this.roleId,
    this.classsecflag,
    this.ismSId,
    this.ttmPId,
    this.attcount,
    this.asasBId,
    this.getstandarad,
    this.admissionstandarad,
  });

  int? asAId;
  int? mIId;
  int? asmaYId;
  String? asAAttEntryType;
  int? asmcLId;
  int? asmSId;
  int? amsTId;
  num? asAClassAttended;
  SectionList? sectionList;
  StudentList? studentList;
  bool? returnval;
  num? countclass;
  int? countclass1;
  String? attendanceentryflag;
  int? attdefaultdisplay;
  String? username;
  int? empCode;
  int? asalUId;
  int? userId;
  String? flag;
  int? roleId;
  String? classsecflag;
  int? ismSId;
  int? ttmPId;
  int? attcount;
  int? asasBId;
  Getstandarad? getstandarad;
  Admissionstandarad? admissionstandarad;

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        asAId: json["asA_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asAAttEntryType: json["asA_Att_EntryType"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        amsTId: json["amsT_Id"],
        asAClassAttended: json["asA_Class_Attended"],
        sectionList: SectionList.fromJson(json["sectionList"]),
        studentList: StudentList.fromJson(json["studentList"]),
        returnval: json["returnval"],
        countclass: json["countclass"],
        countclass1: json["countclass1"],
        attendanceentryflag: json["attendanceentryflag"],
        attdefaultdisplay: json["attdefaultdisplay"],
        username: json["username"],
        empCode: json["emp_Code"],
        asalUId: json["asalU_Id"],
        userId: json["userId"],
        flag: json["flag"],
        roleId: json["roleId"],
        classsecflag: json["classsecflag"],
        ismSId: json["ismS_Id"],
        ttmPId: json["ttmP_Id"],
        attcount: json["attcount"],
        asasBId: json["asasB_Id"],
        getstandarad: Getstandarad.fromJson(json["getstandarad"]),
        admissionstandarad:
            Admissionstandarad.fromJson(json["admissionstandarad"]),
      );

  Map<String, dynamic> toJson() => {
        "asA_Id": asAId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asA_Att_EntryType": asAAttEntryType,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "amsT_Id": amsTId,
        "asA_Class_Attended": asAClassAttended,
        "sectionList": sectionList!.toJson(),
        "studentList": studentList!.toJson(),
        "returnval": returnval,
        "countclass": countclass,
        "countclass1": countclass1,
        "attendanceentryflag": attendanceentryflag,
        "attdefaultdisplay": attdefaultdisplay,
        "username": username,
        "emp_Code": empCode,
        "asalU_Id": asalUId,
        "userId": userId,
        "flag": flag,
        "roleId": roleId,
        "classsecflag": classsecflag,
        "ismS_Id": ismSId,
        "ttmP_Id": ttmPId,
        "attcount": attcount,
        "asasB_Id": asasBId,
        "getstandarad": getstandarad!.toJson(),
        "admissionstandarad": admissionstandarad!.toJson(),
      };
}

class Admissionstandarad {
  Admissionstandarad({
    this.type,
    this.values,
  });

  String? type;
  List<AdmissionstandaradValue?>? values;

  factory Admissionstandarad.fromJson(Map<String, dynamic> json) =>
      Admissionstandarad(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<AdmissionstandaradValue?>.from(json["\$values"]
                .map((x) => AdmissionstandaradValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class AdmissionstandaradValue {
  AdmissionstandaradValue({
    this.asCId,
    this.mIId,
    this.asCAdmAddFieldsFlag,
    this.asCTcAddFieldsFlag,
    this.asCAttDefaultEntryType,
    this.asCMaxAgeAplFlag,
    this.asCMinAgeAplFlag,
    this.asCDefaultGender,
    this.asCParentsMonthlyIncomeFlag,
    this.asCParentsAnnualIncomeFlag,
    this.asCLogoPath,
    this.asCDefaultSmsFlag,
    this.asCSchoolAddress,
    this.asCCategoryAddress,
    this.asCDefaultPhotoUpload,
    this.asCAttDefaultOrderFlag,
    this.asCDefaultClmAdmFlag,
    this.asCDefaultClmRolFlag,
    this.asCDefaultClmRegFlag,
    this.admCTcAllowBalanceFlg,
    this.asCEcsFlag,
    this.createdDate,
    this.updatedDate,
  });

  int? asCId;
  int? mIId;
  int? asCAdmAddFieldsFlag;
  int? asCTcAddFieldsFlag;
  String? asCAttDefaultEntryType;
  int? asCMaxAgeAplFlag;
  int? asCMinAgeAplFlag;
  String? asCDefaultGender;
  String? asCParentsMonthlyIncomeFlag;
  String? asCParentsAnnualIncomeFlag;
  String? asCLogoPath;
  String? asCDefaultSmsFlag;
  int? asCSchoolAddress;
  int? asCCategoryAddress;
  String? asCDefaultPhotoUpload;
  int? asCAttDefaultOrderFlag;
  int? asCDefaultClmAdmFlag;
  int? asCDefaultClmRolFlag;
  int? asCDefaultClmRegFlag;
  int? admCTcAllowBalanceFlg;
  int? asCEcsFlag;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory AdmissionstandaradValue.fromJson(Map<String, dynamic> json) =>
      AdmissionstandaradValue(
        asCId: json["asC_Id"],
        mIId: json["mI_Id"],
        asCAdmAddFieldsFlag: json["asC_Adm_AddFieldsFlag"],
        asCTcAddFieldsFlag: json["asC_TC_AddFieldsFlag"],
        asCAttDefaultEntryType: json["asC_Att_DefaultEntry_Type"],
        asCMaxAgeAplFlag: json["asC_MaxAgeApl_Flag"],
        asCMinAgeAplFlag: json["asC_MinAgeApl_Flag"],
        asCDefaultGender: json["asC_Default_Gender"],
        asCParentsMonthlyIncomeFlag: json["asC_ParentsMonthlyIncome_Flag"],
        asCParentsAnnualIncomeFlag: json["asC_ParentsAnnualIncome_Flag"],
        asCLogoPath: json["asC_Logo_Path"],
        asCDefaultSmsFlag: json["asC_DefaultSMS_Flag"],
        asCSchoolAddress: json["asC_School_Address"],
        asCCategoryAddress: json["asC_Category_Address"],
        asCDefaultPhotoUpload: json["asC_DefaultPhotoUpload"],
        asCAttDefaultOrderFlag: json["asC_Att_Default_OrderFlag"],
        asCDefaultClmAdmFlag: json["asC_Default_Clm__Adm_Flag"],
        asCDefaultClmRolFlag: json["asC_Default_Clm__Rol_Flag"],
        asCDefaultClmRegFlag: json["asC_Default_Clm__Reg_Flag"],
        admCTcAllowBalanceFlg: json["admC_TCAllowBalanceFlg"],
        asCEcsFlag: json["asC_ECS_Flag"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "asC_Id": asCId,
        "mI_Id": mIId,
        "asC_Adm_AddFieldsFlag": asCAdmAddFieldsFlag,
        "asC_TC_AddFieldsFlag": asCTcAddFieldsFlag,
        "asC_Att_DefaultEntry_Type": asCAttDefaultEntryType,
        "asC_MaxAgeApl_Flag": asCMaxAgeAplFlag,
        "asC_MinAgeApl_Flag": asCMinAgeAplFlag,
        "asC_Default_Gender": asCDefaultGender,
        "asC_ParentsMonthlyIncome_Flag": asCParentsMonthlyIncomeFlag,
        "asC_ParentsAnnualIncome_Flag": asCParentsAnnualIncomeFlag,
        "asC_Logo_Path": asCLogoPath,
        "asC_DefaultSMS_Flag": asCDefaultSmsFlag,
        "asC_School_Address": asCSchoolAddress,
        "asC_Category_Address": asCCategoryAddress,
        "asC_DefaultPhotoUpload": asCDefaultPhotoUpload,
        "asC_Att_Default_OrderFlag": asCAttDefaultOrderFlag,
        "asC_Default_Clm__Adm_Flag": asCDefaultClmAdmFlag,
        "asC_Default_Clm__Rol_Flag": asCDefaultClmRolFlag,
        "asC_Default_Clm__Reg_Flag": asCDefaultClmRegFlag,
        "admC_TCAllowBalanceFlg": admCTcAllowBalanceFlg,
        "asC_ECS_Flag": asCEcsFlag,
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
      };
}

class Getstandarad {
  Getstandarad({
    this.type,
    this.values,
  });

  String? type;
  List<GetstandaradValue?>? values;

  factory Getstandarad.fromJson(Map<String, dynamic> json) => Getstandarad(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<GetstandaradValue?>.from(
                json["\$values"].map((x) => GetstandaradValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class GetstandaradValue {
  GetstandaradValue({
    this.ivrmgCId,
    this.mIId,
    this.ivrmgCMobileValOtpFlag,
    this.ivrmgCOtpMobileNo,
    this.ivrmgCOtpMailId,
    this.ivrmgCEmailValOtpFlag,
    this.ivrmgCStudentPhotoPath,
    this.ivrmgCStaffPhotoPath,
    this.ivrmgCComTrasaNoFlag,
    this.ivrmgCSmsDomain,
    this.ivrmgCSmsurl,
    this.ivrmgCSmsUserName,
    this.ivrmgCSmsPassword,
    this.ivrmgCSmsSenderId,
    this.ivrmgCSmsWorkingKey,
    this.ivrmgCSmsFooter,
    this.ivrmgCSmsActiveFlag,
    this.ivrmgCEmailUserName,
    this.ivrmgCEmailPassword,
    this.ivrmgCHostName,
    this.ivrmgCPortNo,
    this.ivrmgCMailGenralDesc,
    this.ivrmgCWebiste,
    this.ivrmgCEmailid,
    this.ivrmgCEmailFooter,
    this.ivrmgCCcMail,
    this.ivrmgCBccMail,
    this.ivrmgCToMail,
    this.ivrmgCEmailActiveFlag,
    this.ivrmgCPagination,
    this.ivrmgCReminderDays,
    this.ivrmgCClassCapacity,
    this.ivrmgCSectionCapacity,
    this.ivrmgCScLockingPeriod,
    this.ivrmgCFpLockingPeriod,
    this.ivrmgCScActive,
    this.ivrmgCFpActive,
    this.ivrmgCOnlineFpActive,
    this.ivrmgCFaceReaderActive,
    this.ivrmgCDefaultStudentSelection,
    this.updatedDate,
    this.ivrmgCPagePagination,
    this.ivrmgCReportPagination,
    this.ivrmgCAdmnoColumnDisplay,
    this.ivrmgCRegnoColumnDisplay,
    this.ivrmgCRollnoColumnDisplay,
    this.ivrmgCDisclaimer,
    this.ivrmgCAdmNoRegNoRollNoDefaultFlag,
    this.ivrmgCTransportRequired,
    this.ivrmgCClasswisePayment,
    this.ivrmgCApiOrSmtpFlg,
    this.ivrmgCEnableStIntFlg,
    this.ivrmgCEnableCtIntFlg,
    this.ivrmgCEnableHodIntFlg,
    this.ivrmgCEnablePrincipalIntFlg,
    this.ivrmgCEnableAsIntFlg,
    this.ivrmgCSendGridKey,
    this.ivrmgCSportsPointsDropdownFlg,
    this.ivrmgCStudentDataChangeAlertFlg,
    this.ivrmgCStudentDataChangeAlertDays,
    this.ivrmgCEnableStsubtIntFlg,
    this.ivrmgCEnableStctIntFlg,
    this.ivrmgCEnableSthodIntFlg,
    this.ivrmgCEnableStPrincipalIntFlg,
    this.ivrmgCEnableStasIntFlg,
    this.ivrmgCEnableStecIntFlg,
    this.ivrmgCGmrdtoallFlg,
    this.ivrmgCEnableStaffwiseIntFlg,
    this.ivrmgCEnableCtstIntFlg,
    this.ivrmgCEnableHodstIntFlg,
    this.ivrmgCEnablePrincipalStIntFlg,
    this.ivrmgCEnableAsstIntFlg,
    this.ivrmgCEnableEcstIntFlg,
    this.ivrmgCEnableSubtstuIntFlg,
    this.ivrmgCCatLogoFlg,
  });

  int? ivrmgCId;
  int? mIId;
  bool? ivrmgCMobileValOtpFlag;
  int? ivrmgCOtpMobileNo;
  String? ivrmgCOtpMailId;
  bool? ivrmgCEmailValOtpFlag;
  String? ivrmgCStudentPhotoPath;
  String? ivrmgCStaffPhotoPath;
  bool? ivrmgCComTrasaNoFlag;
  String? ivrmgCSmsDomain;
  String? ivrmgCSmsurl;
  String? ivrmgCSmsUserName;
  String? ivrmgCSmsPassword;
  String? ivrmgCSmsSenderId;
  String? ivrmgCSmsWorkingKey;
  String? ivrmgCSmsFooter;
  bool? ivrmgCSmsActiveFlag;
  String? ivrmgCEmailUserName;
  String? ivrmgCEmailPassword;
  String? ivrmgCHostName;
  int? ivrmgCPortNo;
  String? ivrmgCMailGenralDesc;
  String? ivrmgCWebiste;
  String? ivrmgCEmailid;
  String? ivrmgCEmailFooter;
  String? ivrmgCCcMail;
  String? ivrmgCBccMail;
  String? ivrmgCToMail;
  bool? ivrmgCEmailActiveFlag;
  int? ivrmgCPagination;
  int? ivrmgCReminderDays;
  int? ivrmgCClassCapacity;
  int? ivrmgCSectionCapacity;
  int? ivrmgCScLockingPeriod;
  int? ivrmgCFpLockingPeriod;
  bool? ivrmgCScActive;
  bool? ivrmgCFpActive;
  bool? ivrmgCOnlineFpActive;
  bool? ivrmgCFaceReaderActive;
  bool? ivrmgCDefaultStudentSelection;
  DateTime? updatedDate;
  int? ivrmgCPagePagination;
  int? ivrmgCReportPagination;
  bool? ivrmgCAdmnoColumnDisplay;
  bool? ivrmgCRegnoColumnDisplay;
  bool? ivrmgCRollnoColumnDisplay;
  String? ivrmgCDisclaimer;
  String? ivrmgCAdmNoRegNoRollNoDefaultFlag;
  int? ivrmgCTransportRequired;
  String? ivrmgCClasswisePayment;
  String? ivrmgCApiOrSmtpFlg;
  bool? ivrmgCEnableStIntFlg;
  bool? ivrmgCEnableCtIntFlg;
  bool? ivrmgCEnableHodIntFlg;
  bool? ivrmgCEnablePrincipalIntFlg;
  bool? ivrmgCEnableAsIntFlg;
  String? ivrmgCSendGridKey;
  bool? ivrmgCSportsPointsDropdownFlg;
  bool? ivrmgCStudentDataChangeAlertFlg;
  int? ivrmgCStudentDataChangeAlertDays;
  bool? ivrmgCEnableStsubtIntFlg;
  bool? ivrmgCEnableStctIntFlg;
  bool? ivrmgCEnableSthodIntFlg;
  bool? ivrmgCEnableStPrincipalIntFlg;
  bool? ivrmgCEnableStasIntFlg;
  bool? ivrmgCEnableStecIntFlg;
  bool? ivrmgCGmrdtoallFlg;
  bool? ivrmgCEnableStaffwiseIntFlg;
  bool? ivrmgCEnableCtstIntFlg;
  bool? ivrmgCEnableHodstIntFlg;
  bool? ivrmgCEnablePrincipalStIntFlg;
  bool? ivrmgCEnableAsstIntFlg;
  bool? ivrmgCEnableEcstIntFlg;
  bool? ivrmgCEnableSubtstuIntFlg;
  bool? ivrmgCCatLogoFlg;

  factory GetstandaradValue.fromJson(Map<String, dynamic> json) =>
      GetstandaradValue(
        ivrmgCId: json["ivrmgC_Id"],
        mIId: json["mI_Id"],
        ivrmgCMobileValOtpFlag: json["ivrmgC_MobileValOTPFlag"],
        ivrmgCOtpMobileNo: json["ivrmgC_OTPMobileNo"],
        ivrmgCOtpMailId: json["ivrmgC_OTPMailId"],
        ivrmgCEmailValOtpFlag: json["ivrmgC_emailValOTPFlag"],
        ivrmgCStudentPhotoPath: json["ivrmgC_StudentPhotoPath"],
        ivrmgCStaffPhotoPath: json["ivrmgC_StaffPhotoPath"],
        ivrmgCComTrasaNoFlag: json["ivrmgC_ComTrasaNoFlag"],
        ivrmgCSmsDomain: json["ivrmgC_SMSDomain"],
        ivrmgCSmsurl: json["ivrmgC_SMSURL"],
        ivrmgCSmsUserName: json["ivrmgC_SMSUserName"],
        ivrmgCSmsPassword: json["ivrmgC_SMSPassword"],
        ivrmgCSmsSenderId: json["ivrmgC_SMSSenderId"],
        ivrmgCSmsWorkingKey: json["ivrmgC_SMSWorkingKey"],
        ivrmgCSmsFooter: json["ivrmgC_SMSFooter"],
        ivrmgCSmsActiveFlag: json["ivrmgC_SMSActiveFlag"],
        ivrmgCEmailUserName: json["ivrmgC_emailUserName"],
        ivrmgCEmailPassword: json["ivrmgC_emailPassword"],
        ivrmgCHostName: json["ivrmgC_HostName"],
        ivrmgCPortNo: json["ivrmgC_PortNo"],
        ivrmgCMailGenralDesc: json["ivrmgC_MailGenralDesc"],
        ivrmgCWebiste: json["ivrmgC_Webiste"],
        ivrmgCEmailid: json["ivrmgC_emailid"],
        ivrmgCEmailFooter: json["ivrmgC_emailFooter"],
        ivrmgCCcMail: json["ivrmgC_CCMail"],
        ivrmgCBccMail: json["ivrmgC_BCCMail"],
        ivrmgCToMail: json["ivrmgC_ToMail"],
        ivrmgCEmailActiveFlag: json["ivrmgC_EmailActiveFlag"],
        ivrmgCPagination: json["ivrmgC_Pagination"],
        ivrmgCReminderDays: json["ivrmgC_ReminderDays"],
        ivrmgCClassCapacity: json["ivrmgC_ClassCapacity"],
        ivrmgCSectionCapacity: json["ivrmgC_SectionCapacity"],
        ivrmgCScLockingPeriod: json["ivrmgC_SCLockingPeriod"],
        ivrmgCFpLockingPeriod: json["ivrmgC_FPLockingPeriod"],
        ivrmgCScActive: json["ivrmgC_SCActive"],
        ivrmgCFpActive: json["ivrmgC_FPActive"],
        ivrmgCOnlineFpActive: json["ivrmgC_OnlineFPActive"],
        ivrmgCFaceReaderActive: json["ivrmgC_FaceReaderActive"],
        ivrmgCDefaultStudentSelection: json["ivrmgC_DefaultStudentSelection"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        ivrmgCPagePagination: json["ivrmgC_PagePagination"],
        ivrmgCReportPagination: json["ivrmgC_ReportPagination"],
        ivrmgCAdmnoColumnDisplay: json["ivrmgC_AdmnoColumnDisplay"],
        ivrmgCRegnoColumnDisplay: json["ivrmgC_RegnoColumnDisplay"],
        ivrmgCRollnoColumnDisplay: json["ivrmgC_RollnoColumnDisplay"],
        ivrmgCDisclaimer: json["ivrmgC_Disclaimer"],
        ivrmgCAdmNoRegNoRollNoDefaultFlag:
            json["ivrmgC_AdmNo_RegNo_RollNo_DefaultFlag"],
        ivrmgCTransportRequired: json["ivrmgC_TransportRequired"],
        ivrmgCClasswisePayment: json["ivrmgC_Classwise_Payment"],
        ivrmgCApiOrSmtpFlg: json["ivrmgC_APIOrSMTPFlg"],
        ivrmgCEnableStIntFlg: json["ivrmgC_EnableSTIntFlg"],
        ivrmgCEnableCtIntFlg: json["ivrmgC_EnableCTIntFlg"],
        ivrmgCEnableHodIntFlg: json["ivrmgC_EnableHODIntFlg"],
        ivrmgCEnablePrincipalIntFlg: json["ivrmgC_EnablePrincipalIntFlg"],
        ivrmgCEnableAsIntFlg: json["ivrmgC_EnableASIntFlg"],
        ivrmgCSendGridKey: json["ivrmgC_SendGrid_Key"],
        ivrmgCSportsPointsDropdownFlg: json["ivrmgC_SportsPointsDropdownFlg"],
        ivrmgCStudentDataChangeAlertFlg:
            json["ivrmgC_StudentDataChangeAlertFlg"],
        ivrmgCStudentDataChangeAlertDays:
            json["ivrmgC_StudentDataChangeAlertDays"],
        ivrmgCEnableStsubtIntFlg: json["ivrmgC_EnableSTSUBTIntFlg"],
        ivrmgCEnableStctIntFlg: json["ivrmgC_EnableSTCTIntFlg"],
        ivrmgCEnableSthodIntFlg: json["ivrmgC_EnableSTHODIntFlg"],
        ivrmgCEnableStPrincipalIntFlg: json["ivrmgC_EnableSTPrincipalIntFlg"],
        ivrmgCEnableStasIntFlg: json["ivrmgC_EnableSTASIntFlg"],
        ivrmgCEnableStecIntFlg: json["ivrmgC_EnableSTECIntFlg"],
        ivrmgCGmrdtoallFlg: json["ivrmgC_GMRDTOALLFlg"],
        ivrmgCEnableStaffwiseIntFlg: json["ivrmgC_EnableStaffwiseIntFlg"],
        ivrmgCEnableCtstIntFlg: json["ivrmgC_EnableCTSTIntFlg"],
        ivrmgCEnableHodstIntFlg: json["ivrmgC_EnableHODSTIntFlg"],
        ivrmgCEnablePrincipalStIntFlg: json["ivrmgC_EnablePrincipalSTIntFlg"],
        ivrmgCEnableAsstIntFlg: json["ivrmgC_EnableASSTIntFlg"],
        ivrmgCEnableEcstIntFlg: json["ivrmgC_EnableECSTIntFlg"],
        ivrmgCEnableSubtstuIntFlg: json["ivrmgC_EnableSUBTSTUIntFlg"],
        ivrmgCCatLogoFlg: json["ivrmgC_CatLogoFlg"],
      );

  Map<String, dynamic> toJson() => {
        "ivrmgC_Id": ivrmgCId,
        "mI_Id": mIId,
        "ivrmgC_MobileValOTPFlag": ivrmgCMobileValOtpFlag,
        "ivrmgC_OTPMobileNo": ivrmgCOtpMobileNo,
        "ivrmgC_OTPMailId": ivrmgCOtpMailId,
        "ivrmgC_emailValOTPFlag": ivrmgCEmailValOtpFlag,
        "ivrmgC_StudentPhotoPath": ivrmgCStudentPhotoPath,
        "ivrmgC_StaffPhotoPath": ivrmgCStaffPhotoPath,
        "ivrmgC_ComTrasaNoFlag": ivrmgCComTrasaNoFlag,
        "ivrmgC_SMSDomain": ivrmgCSmsDomain,
        "ivrmgC_SMSURL": ivrmgCSmsurl,
        "ivrmgC_SMSUserName": ivrmgCSmsUserName,
        "ivrmgC_SMSPassword": ivrmgCSmsPassword,
        "ivrmgC_SMSSenderId": ivrmgCSmsSenderId,
        "ivrmgC_SMSWorkingKey": ivrmgCSmsWorkingKey,
        "ivrmgC_SMSFooter": ivrmgCSmsFooter,
        "ivrmgC_SMSActiveFlag": ivrmgCSmsActiveFlag,
        "ivrmgC_emailUserName": ivrmgCEmailUserName,
        "ivrmgC_emailPassword": ivrmgCEmailPassword,
        "ivrmgC_HostName": ivrmgCHostName,
        "ivrmgC_PortNo": ivrmgCPortNo,
        "ivrmgC_MailGenralDesc": ivrmgCMailGenralDesc,
        "ivrmgC_Webiste": ivrmgCWebiste,
        "ivrmgC_emailid": ivrmgCEmailid,
        "ivrmgC_emailFooter": ivrmgCEmailFooter,
        "ivrmgC_CCMail": ivrmgCCcMail,
        "ivrmgC_BCCMail": ivrmgCBccMail,
        "ivrmgC_ToMail": ivrmgCToMail,
        "ivrmgC_EmailActiveFlag": ivrmgCEmailActiveFlag,
        "ivrmgC_Pagination": ivrmgCPagination,
        "ivrmgC_ReminderDays": ivrmgCReminderDays,
        "ivrmgC_ClassCapacity": ivrmgCClassCapacity,
        "ivrmgC_SectionCapacity": ivrmgCSectionCapacity,
        "ivrmgC_SCLockingPeriod": ivrmgCScLockingPeriod,
        "ivrmgC_FPLockingPeriod": ivrmgCFpLockingPeriod,
        "ivrmgC_SCActive": ivrmgCScActive,
        "ivrmgC_FPActive": ivrmgCFpActive,
        "ivrmgC_OnlineFPActive": ivrmgCOnlineFpActive,
        "ivrmgC_FaceReaderActive": ivrmgCFaceReaderActive,
        "ivrmgC_DefaultStudentSelection": ivrmgCDefaultStudentSelection,
        "updatedDate": updatedDate!.toIso8601String(),
        "ivrmgC_PagePagination": ivrmgCPagePagination,
        "ivrmgC_ReportPagination": ivrmgCReportPagination,
        "ivrmgC_AdmnoColumnDisplay": ivrmgCAdmnoColumnDisplay,
        "ivrmgC_RegnoColumnDisplay": ivrmgCRegnoColumnDisplay,
        "ivrmgC_RollnoColumnDisplay": ivrmgCRollnoColumnDisplay,
        "ivrmgC_Disclaimer": ivrmgCDisclaimer,
        "ivrmgC_AdmNo_RegNo_RollNo_DefaultFlag":
            ivrmgCAdmNoRegNoRollNoDefaultFlag,
        "ivrmgC_TransportRequired": ivrmgCTransportRequired,
        "ivrmgC_Classwise_Payment": ivrmgCClasswisePayment,
        "ivrmgC_APIOrSMTPFlg": ivrmgCApiOrSmtpFlg,
        "ivrmgC_EnableSTIntFlg": ivrmgCEnableStIntFlg,
        "ivrmgC_EnableCTIntFlg": ivrmgCEnableCtIntFlg,
        "ivrmgC_EnableHODIntFlg": ivrmgCEnableHodIntFlg,
        "ivrmgC_EnablePrincipalIntFlg": ivrmgCEnablePrincipalIntFlg,
        "ivrmgC_EnableASIntFlg": ivrmgCEnableAsIntFlg,
        "ivrmgC_SendGrid_Key": ivrmgCSendGridKey,
        "ivrmgC_SportsPointsDropdownFlg": ivrmgCSportsPointsDropdownFlg,
        "ivrmgC_StudentDataChangeAlertFlg": ivrmgCStudentDataChangeAlertFlg,
        "ivrmgC_StudentDataChangeAlertDays": ivrmgCStudentDataChangeAlertDays,
        "ivrmgC_EnableSTSUBTIntFlg": ivrmgCEnableStsubtIntFlg,
        "ivrmgC_EnableSTCTIntFlg": ivrmgCEnableStctIntFlg,
        "ivrmgC_EnableSTHODIntFlg": ivrmgCEnableSthodIntFlg,
        "ivrmgC_EnableSTPrincipalIntFlg": ivrmgCEnableStPrincipalIntFlg,
        "ivrmgC_EnableSTASIntFlg": ivrmgCEnableStasIntFlg,
        "ivrmgC_EnableSTECIntFlg": ivrmgCEnableStecIntFlg,
        "ivrmgC_GMRDTOALLFlg": ivrmgCGmrdtoallFlg,
        "ivrmgC_EnableStaffwiseIntFlg": ivrmgCEnableStaffwiseIntFlg,
        "ivrmgC_EnableCTSTIntFlg": ivrmgCEnableCtstIntFlg,
        "ivrmgC_EnableHODSTIntFlg": ivrmgCEnableHodstIntFlg,
        "ivrmgC_EnablePrincipalSTIntFlg": ivrmgCEnablePrincipalStIntFlg,
        "ivrmgC_EnableASSTIntFlg": ivrmgCEnableAsstIntFlg,
        "ivrmgC_EnableECSTIntFlg": ivrmgCEnableEcstIntFlg,
        "ivrmgC_EnableSUBTSTUIntFlg": ivrmgCEnableSubtstuIntFlg,
        "ivrmgC_CatLogoFlg": ivrmgCCatLogoFlg,
      };
}

class SectionList {
  SectionList({
    this.type,
    this.values,
  });

  String? type;
  List<SectionListValue?>? values;

  factory SectionList.fromJson(Map<String, dynamic> json) => SectionList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<SectionListValue?>.from(
                json["\$values"].map((x) => SectionListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class SectionListValue {
  SectionListValue({
    this.asAId,
    this.mIId,
    this.asmaYId,
    this.asmcLId,
    this.asmSId,
    this.asmCSectionName,
    this.amsTId,
    this.asAClassAttended,
    this.returnval,
    this.countclass,
    this.countclass1,
    this.attdefaultdisplay,
    this.empCode,
    this.asalUId,
    this.userId,
    this.roleId,
    this.ismSId,
    this.ttmPId,
    this.attcount,
    this.asasBId,
  });

  int? asAId;
  int? mIId;
  int? asmaYId;
  int? asmcLId;
  int? asmSId;
  String? asmCSectionName;
  int? amsTId;
  num? asAClassAttended;
  bool? returnval;
  num? countclass;
  int? countclass1;
  int? attdefaultdisplay;
  int? empCode;
  int? asalUId;
  int? userId;
  int? roleId;
  int? ismSId;
  int? ttmPId;
  int? attcount;
  int? asasBId;

  factory SectionListValue.fromJson(Map<String, dynamic> json) =>
      SectionListValue(
        asAId: json["asA_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        asmCSectionName: json["asmC_SectionName"],
        amsTId: json["amsT_Id"],
        asAClassAttended: json["asA_Class_Attended"],
        returnval: json["returnval"],
        countclass: json["countclass"],
        countclass1: json["countclass1"],
        attdefaultdisplay: json["attdefaultdisplay"],
        empCode: json["emp_Code"],
        asalUId: json["asalU_Id"],
        userId: json["userId"],
        roleId: json["roleId"],
        ismSId: json["ismS_Id"],
        ttmPId: json["ttmP_Id"],
        attcount: json["attcount"],
        asasBId: json["asasB_Id"],
      );

  Map<String, dynamic> toJson() => {
        "asA_Id": asAId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "asmC_SectionName": asmCSectionName,
        "amsT_Id": amsTId,
        "asA_Class_Attended": asAClassAttended,
        "returnval": returnval,
        "countclass": countclass,
        "countclass1": countclass1,
        "attdefaultdisplay": attdefaultdisplay,
        "emp_Code": empCode,
        "asalU_Id": asalUId,
        "userId": userId,
        "roleId": roleId,
        "ismS_Id": ismSId,
        "ttmP_Id": ttmPId,
        "attcount": attcount,
        "asasB_Id": asasBId,
      };
}

class StudentList {
  StudentList({
    this.type,
    this.values,
  });

  String? type;
  List<StudentListValue?>? values;

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<StudentListValue>.from(
                json["\$values"].map((x) => StudentListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class StudentListValue {
  StudentListValue({
    this.amaYRollNo,
    this.amsTAdmNo,
    this.amsTId,
    this.studentname,
    this.asAId,
    this.ismSId,
    this.asasBId,
    this.amsTRegistrationNo,
  });

  int? amaYRollNo;
  String? amsTAdmNo;
  int? amsTId;
  String? studentname;
  int? asAId;
  int? ismSId;
  int? asasBId;
  String? amsTRegistrationNo;

  factory StudentListValue.fromJson(Map<String, dynamic> json) =>
      StudentListValue(
        amaYRollNo: json["amaY_RollNo"],
        amsTAdmNo: json["amsT_AdmNo"],
        amsTId: json["amsT_Id"],
        studentname: json["studentname"],
        asAId: json["asA_Id"],
        ismSId: json["ismS_Id"],
        asasBId: json["asasB_Id"],
        amsTRegistrationNo: json["amsT_RegistrationNo"],
      );

  Map<String, dynamic> toJson() => {
        "amaY_RollNo": amaYRollNo,
        "amsT_AdmNo": amsTAdmNo,
        "amsT_Id": amsTId,
        "studentname": studentname,
        "asA_Id": asAId,
        "ismS_Id": ismSId,
        "asasB_Id": asasBId,
        "amsT_RegistrationNo": amsTRegistrationNo,
      };
}
