// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'dart:convert';

InitialDropdownDetailModel classModelFromJson(String str) =>
    InitialDropdownDetailModel.fromJson(json.decode(str));

String classModelToJson(InitialDropdownDetailModel data) =>
    json.encode(data.toJson());

class InitialDropdownDetailModel {
  InitialDropdownDetailModel({
    this.returnval,
    this.alreadyCnt,
    this.userId,
    this.userflag,
    this.ivrmgCEnableStIntFlg,
    this.ivrmgCEnableCtIntFlg,
    this.ivrmgCEnableHodIntFlg,
    this.ivrmgCEnablePrincipalIntFlg,
    this.ivrmgCEnableAsIntFlg,
    this.asmclid,
    this.asmsid,
    this.amsTId,
    this.hrmEId1,
    this.studentId,
    this.hrmEId,
    this.userhrmEId,
    this.employeeId,
    this.asmcLId,
    this.asmSId,
    this.ivrmrTId,
    this.ivrmgCEnableEcIntFlg,
    this.roleFlag,
    this.configflag,
    this.inboxcount,
    this.isminTId,
    this.mIId,
    this.isminTInteractionId,
    this.asmaYId,
    this.isminTComposedById,
    this.isminTDateTime,
    this.isminTActiveFlag,
    this.isminTCreatedBy,
    this.isminTUpdatedBy,
    this.istinTId,
    this.istinTToId,
    this.istinTComposedById,
    this.istinTDateTime,
    this.istinTInteractionOrder,
    this.istinTActiveFlag,
    this.istinTCreatedBy,
    this.istinTUpdatedBy,
    this.roleflg,
    this.getdetails,
    this.amcsTId,
    this.amcoid,
    this.ambid,
    this.amseid,
    this.acmsid,
    this.amcOId,
    this.amBId,
    this.amsEId,
    this.amBOrder,
    this.amsESemOrder,
    this.acmSId,
    this.acmSOrder,
  });

  bool? returnval;
  bool? alreadyCnt;
  int? userId;
  String? userflag;
  bool? ivrmgCEnableStIntFlg;
  bool? ivrmgCEnableCtIntFlg;
  bool? ivrmgCEnableHodIntFlg;
  bool? ivrmgCEnablePrincipalIntFlg;
  bool? ivrmgCEnableAsIntFlg;
  int? asmclid;
  int? asmsid;
  int? amsTId;
  int? hrmEId1;
  int? studentId;
  int? hrmEId;
  int? userhrmEId;
  int? employeeId;
  int? asmcLId;
  int? asmSId;
  int? ivrmrTId;
  bool? ivrmgCEnableEcIntFlg;
  String? roleFlag;
  Configflag? configflag;
  int? inboxcount;
  int? isminTId;
  int? mIId;
  int? isminTInteractionId;
  int? asmaYId;
  int? isminTComposedById;
  DateTime? isminTDateTime;
  bool? isminTActiveFlag;
  int? isminTCreatedBy;
  int? isminTUpdatedBy;
  int? istinTId;
  int? istinTToId;
  int? istinTComposedById;
  DateTime? istinTDateTime;
  int? istinTInteractionOrder;
  bool? istinTActiveFlag;
  int? istinTCreatedBy;
  int? istinTUpdatedBy;
  String? roleflg;
  Getdetails? getdetails;
  int? amcsTId;
  int? amcoid;
  int? ambid;
  int? amseid;
  int? acmsid;
  int? amcOId;
  int? amBId;
  int? amsEId;
  int? amBOrder;
  int? amsESemOrder;
  int? acmSId;
  int? acmSOrder;

  factory InitialDropdownDetailModel.fromJson(Map<String, dynamic> json) =>
      InitialDropdownDetailModel(
        returnval: json["returnval"],
        alreadyCnt: json["already_cnt"],
        userId: json["userId"],
        userflag: json["userflag"],
        ivrmgCEnableStIntFlg: json["ivrmgC_EnableSTIntFlg"],
        ivrmgCEnableCtIntFlg: json["ivrmgC_EnableCTIntFlg"],
        ivrmgCEnableHodIntFlg: json["ivrmgC_EnableHODIntFlg"],
        ivrmgCEnablePrincipalIntFlg: json["ivrmgC_EnablePrincipalIntFlg"],
        ivrmgCEnableAsIntFlg: json["ivrmgC_EnableASIntFlg"],
        asmclid: json["asmclid"],
        asmsid: json["asmsid"],
        amsTId: json["amsT_Id"],
        hrmEId1: json["hrmE_Id1"],
        studentId: json["student_Id"],
        hrmEId: json["hrmE_Id"],
        userhrmEId: json["userhrmE_Id"],
        employeeId: json["employee_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        ivrmrTId: json["ivrmrT_Id"],
        ivrmgCEnableEcIntFlg: json["ivrmgC_EnableECIntFlg"],
        roleFlag: json["role_flag"],
        configflag: Configflag.fromJson(json["configflag"]),
        inboxcount: json["inboxcount"],
        isminTId: json["isminT_Id"],
        mIId: json["mI_Id"],
        isminTInteractionId: json["isminT_InteractionId"],
        asmaYId: json["asmaY_Id"],
        isminTComposedById: json["isminT_ComposedById"],
        isminTDateTime: DateTime.parse(json["isminT_DateTime"]),
        isminTActiveFlag: json["isminT_ActiveFlag"],
        isminTCreatedBy: json["isminT_CreatedBy"],
        isminTUpdatedBy: json["isminT_UpdatedBy"],
        istinTId: json["istinT_Id"],
        istinTToId: json["istinT_ToId"],
        istinTComposedById: json["istinT_ComposedById"],
        istinTDateTime: DateTime.parse(json["istinT_DateTime"]),
        istinTInteractionOrder: json["istinT_InteractionOrder"],
        istinTActiveFlag: json["istinT_ActiveFlag"],
        istinTCreatedBy: json["istinT_CreatedBy"],
        istinTUpdatedBy: json["istinT_UpdatedBy"],
        roleflg: json["roleflg"],
        getdetails: Getdetails.fromJson(json["getdetails"]),
        amcsTId: json["amcsT_Id"],
        amcoid: json["amcoid"],
        ambid: json["ambid"],
        amseid: json["amseid"],
        acmsid: json["acmsid"],
        amcOId: json["amcO_Id"],
        amBId: json["amB_Id"],
        amsEId: json["amsE_Id"],
        amBOrder: json["amB_Order"],
        amsESemOrder: json["amsE_SEMOrder"],
        acmSId: json["acmS_Id"],
        acmSOrder: json["acmS_Order"],
      );

  Map<String, dynamic> toJson() => {
        "returnval": returnval,
        "already_cnt": alreadyCnt,
        "userId": userId,
        "userflag": userflag,
        "ivrmgC_EnableSTIntFlg": ivrmgCEnableStIntFlg,
        "ivrmgC_EnableCTIntFlg": ivrmgCEnableCtIntFlg,
        "ivrmgC_EnableHODIntFlg": ivrmgCEnableHodIntFlg,
        "ivrmgC_EnablePrincipalIntFlg": ivrmgCEnablePrincipalIntFlg,
        "ivrmgC_EnableASIntFlg": ivrmgCEnableAsIntFlg,
        "asmclid": asmclid,
        "asmsid": asmsid,
        "amsT_Id": amsTId,
        "hrmE_Id1": hrmEId1,
        "student_Id": studentId,
        "hrmE_Id": hrmEId,
        "userhrmE_Id": userhrmEId,
        "employee_Id": employeeId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "ivrmrT_Id": ivrmrTId,
        "ivrmgC_EnableECIntFlg": ivrmgCEnableEcIntFlg,
        "role_flag": roleFlag,
        "configflag": configflag!.toJson(),
        "inboxcount": inboxcount,
        "isminT_Id": isminTId,
        "mI_Id": mIId,
        "isminT_InteractionId": isminTInteractionId,
        "asmaY_Id": asmaYId,
        "isminT_ComposedById": isminTComposedById,
        "isminT_DateTime": isminTDateTime!.toIso8601String(),
        "isminT_ActiveFlag": isminTActiveFlag,
        "isminT_CreatedBy": isminTCreatedBy,
        "isminT_UpdatedBy": isminTUpdatedBy,
        "istinT_Id": istinTId,
        "istinT_ToId": istinTToId,
        "istinT_ComposedById": istinTComposedById,
        "istinT_DateTime": istinTDateTime!.toIso8601String(),
        "istinT_InteractionOrder": istinTInteractionOrder,
        "istinT_ActiveFlag": istinTActiveFlag,
        "istinT_CreatedBy": istinTCreatedBy,
        "istinT_UpdatedBy": istinTUpdatedBy,
        "roleflg": roleflg,
        "getdetails": getdetails!.toJson(),
        "amcsT_Id": amcsTId,
        "amcoid": amcoid,
        "ambid": ambid,
        "amseid": amseid,
        "acmsid": acmsid,
        "amcO_Id": amcOId,
        "amB_Id": amBId,
        "amsE_Id": amsEId,
        "amB_Order": amBOrder,
        "amsE_SEMOrder": amsESemOrder,
        "acmS_Id": acmSId,
        "acmS_Order": acmSOrder,
      };
}

class Configflag {
  Configflag({
    this.type,
    this.values,
  });

  String? type;
  List<ConfigflagValue?>? values;

  factory Configflag.fromJson(Map<String, dynamic> json) => Configflag(
        type: json["\$type"],
        values: List<ConfigflagValue?>.from(
            json["\$values"].map((x) => ConfigflagValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class ConfigflagValue {
  ConfigflagValue({
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

  factory ConfigflagValue.fromJson(Map<String, dynamic> json) =>
      ConfigflagValue(
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

class Getdetails {
  Getdetails({
    this.type,
    this.values,
  });

  String? type;
  List<GetdetailsValues?>? values;

  factory Getdetails.fromJson(Map<String, dynamic> json) => Getdetails(
        type: json["\$type"],
        values: List<GetdetailsValues?>.from(
            json["\$values"].map((x) => GetdetailsValues.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class GetdetailsValues {
  GetdetailsValues({
    this.type,
    this.asmclId,
    this.asmclClassName,
    this.asmayId,
    this.iD,
    this.id,
    this.empName,
    this.hrmeEmployeeCode,
    this.examCoordinatorName,
  });

  String? type;
  int? asmclId;
  String? asmclClassName;
  int? asmayId;
  int? iD; // for teacherId,hodId,ASId,
  int? id; // for principalId,EC..
  String? empName;

  String? hrmeEmployeeCode;
  String? examCoordinatorName;

  factory GetdetailsValues.fromJson(Map<String, dynamic> json) =>
      GetdetailsValues(
        type: json["\$type"],
        asmclId: json["ASMCL_Id"],
        asmclClassName: json["ASMCL_ClassName"],
        asmayId: json["ASMAY_Id"],
        iD: json["HRME_Id"],
        id: json["hrmE_Id"],
        empName: json["EmpName"],
        hrmeEmployeeCode: json["HRME_EmployeeCode"],
        examCoordinatorName: json["empName"],
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "ASMCL_Id": asmclId,
        "ASMCL_ClassName": asmclClassName,
        "ASMAY_Id": asmayId,
        "HRME_Id": iD,
        "EmpName": empName,
        "HRME_EmployeeCode": hrmeEmployeeCode,
        "hrmE_Id": id,
        "empName": examCoordinatorName,
      };
}
