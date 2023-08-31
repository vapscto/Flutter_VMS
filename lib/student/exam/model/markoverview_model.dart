// To parse this JSON data, do
//
//     final markOverviewModel = markOverviewModelFromJson(jsonString);

import 'dart:convert';

MarkOverviewModel markOverviewModelFromJson(String str) =>
    MarkOverviewModel.fromJson(json.decode(str));

String markOverviewModelToJson(MarkOverviewModel data) =>
    json.encode(data.toJson());

class MarkOverviewModel {
  MarkOverviewModel({
    this.mIId,
    this.asmaYFromDate,
    this.asmaYToDate,
    this.asmaYPreAdmFDate,
    this.asmaYPreAdmTDate,
    this.asmaYOrder,
    this.asmaYActiveFlag,
    this.asmaYPreActiveFlag,
    this.asmaYCutOfDate,
    this.isActive,
    this.asmcLMinAgeYear,
    this.asmcLMinAgeMonth,
    this.asmcLMinAgeDays,
    this.asmcLMaxAgeYear,
    this.asmcLMaxAgeMonth,
    this.asmcLMaxAgeDays,
    this.asmcLOrder,
    this.asmcLActiveFlag,
    this.asmcLMaxCapacity,
    this.amsTId,
    this.asmcLId,
    this.asmSId,
    this.asmaYId,
    this.amaYRollNo,
    this.asmCOrder,
    this.asmCActiveFlag,
    this.asmCMaxCapacity,
    this.asysTId,
    this.amaYActiveFlag,
    this.estmpSId,
    this.ismSId,
    this.emEId,
    this.emEExamOrder,
    this.emEFinalExamFlag,
    this.emEActiveFlag,
    this.ismSExamFlag,
    this.ismSPreadmFlag,
    this.ismSSubjectFlag,
    this.ismSBatchAppl,
    this.ismSActiveFlag,
    this.ismSOrderFlag,
    this.ismSTtFlag,
    this.ismSAttendanceFlag,
    this.ismSLanguageFlg,
    this.ismSAtExtraFeeFlg,
    this.getexamconfig,
    this.percentage,
    this.amsTDob,
    this.hrmEId,
    this.userId,
    this.examReportList,
    this.getEmeIdDetails,
    this.type,
  });

  int? mIId;
  DateTime? asmaYFromDate;
  DateTime? asmaYToDate;
  DateTime? asmaYPreAdmFDate;
  DateTime? asmaYPreAdmTDate;
  int? asmaYOrder;
  int? asmaYActiveFlag;
  int? asmaYPreActiveFlag;
  DateTime? asmaYCutOfDate;
  bool? isActive;
  int? asmcLMinAgeYear;
  int? asmcLMinAgeMonth;
  int? asmcLMinAgeDays;
  int? asmcLMaxAgeYear;
  int? asmcLMaxAgeMonth;
  int? asmcLMaxAgeDays;
  int? asmcLOrder;
  bool? asmcLActiveFlag;
  int? asmcLMaxCapacity;
  int? amsTId;
  int? asmcLId;
  int? asmSId;
  int? asmaYId;
  int? amaYRollNo;
  int? asmCOrder;
  int? asmCActiveFlag;
  int? asmCMaxCapacity;
  int? asysTId;
  int? amaYActiveFlag;
  int? estmpSId;
  int? ismSId;
  int? emEId;
  int? emEExamOrder;
  bool? emEFinalExamFlag;
  bool? emEActiveFlag;
  int? ismSExamFlag;
  int? ismSPreadmFlag;
  int? ismSSubjectFlag;
  int? ismSBatchAppl;
  int? ismSActiveFlag;
  int? ismSOrderFlag;
  bool? ismSTtFlag;
  bool? ismSAttendanceFlag;
  int? ismSLanguageFlg;
  int? ismSAtExtraFeeFlg;
  Getexamconfig? getexamconfig;
  double? percentage;
  DateTime? amsTDob;
  int? hrmEId;
  int? userId;
  ExamWiseReportList? examReportList;
  GetEmeIdDetails? getEmeIdDetails;
  String? type;

  factory MarkOverviewModel.fromJson(Map<String, dynamic> json) =>
      MarkOverviewModel(
        mIId: json["mI_Id"],
        asmaYFromDate: DateTime.parse(json["asmaY_From_Date"]),
        asmaYToDate: DateTime.parse(json["asmaY_To_Date"]),
        asmaYPreAdmFDate: DateTime.parse(json["asmaY_PreAdm_F_Date"]),
        asmaYPreAdmTDate: DateTime.parse(json["asmaY_PreAdm_T_Date"]),
        asmaYOrder: json["asmaY_Order"],
        asmaYActiveFlag: json["asmaY_ActiveFlag"],
        asmaYPreActiveFlag: json["asmaY_Pre_ActiveFlag"],
        asmaYCutOfDate: DateTime.parse(json["asmaY_Cut_Of_Date"]),
        isActive: json["is_Active"],
        asmcLMinAgeYear: json["asmcL_MinAgeYear"],
        asmcLMinAgeMonth: json["asmcL_MinAgeMonth"],
        asmcLMinAgeDays: json["asmcL_MinAgeDays"],
        asmcLMaxAgeYear: json["asmcL_MaxAgeYear"],
        asmcLMaxAgeMonth: json["asmcL_MaxAgeMonth"],
        asmcLMaxAgeDays: json["asmcL_MaxAgeDays"],
        asmcLOrder: json["asmcL_Order"],
        asmcLActiveFlag: json["asmcL_ActiveFlag"],
        asmcLMaxCapacity: json["asmcL_MaxCapacity"],
        amsTId: json["amsT_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        asmaYId: json["asmaY_Id"],
        amaYRollNo: json["amaY_RollNo"],
        asmCOrder: json["asmC_Order"],
        asmCActiveFlag: json["asmC_ActiveFlag"],
        asmCMaxCapacity: json["asmC_MaxCapacity"],
        asysTId: json["asysT_Id"],
        amaYActiveFlag: json["amaY_ActiveFlag"],
        estmpSId: json["estmpS_Id"],
        ismSId: json["ismS_Id"],
        emEId: json["emE_Id"],
        emEExamOrder: json["emE_ExamOrder"],
        emEFinalExamFlag: json["emE_FinalExamFlag"],
        emEActiveFlag: json["emE_ActiveFlag"],
        ismSExamFlag: json["ismS_ExamFlag"],
        ismSPreadmFlag: json["ismS_PreadmFlag"],
        ismSSubjectFlag: json["ismS_SubjectFlag"],
        ismSBatchAppl: json["ismS_BatchAppl"],
        ismSActiveFlag: json["ismS_ActiveFlag"],
        ismSOrderFlag: json["ismS_OrderFlag"],
        ismSTtFlag: json["ismS_TTFlag"],
        ismSAttendanceFlag: json["ismS_AttendanceFlag"],
        ismSLanguageFlg: json["ismS_LanguageFlg"],
        ismSAtExtraFeeFlg: json["ismS_AtExtraFeeFlg"],
        getexamconfig: Getexamconfig.fromJson(json["getexamconfig"]),
        percentage: json["percentage"],
        amsTDob: DateTime.parse(json["amsT_DOB"]),
        hrmEId: json["hrmE_ID"],
        userId: json["user_id"],
        examReportList: ExamWiseReportList.fromJson(json["examReportList"]),
        getEmeIdDetails: GetEmeIdDetails.fromJson(json["get_eme_id_details"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "mI_Id": mIId,
        "asmaY_From_Date": asmaYFromDate!.toIso8601String(),
        "asmaY_To_Date": asmaYToDate!.toIso8601String(),
        "asmaY_PreAdm_F_Date": asmaYPreAdmFDate!.toIso8601String(),
        "asmaY_PreAdm_T_Date": asmaYPreAdmTDate!.toIso8601String(),
        "asmaY_Order": asmaYOrder,
        "asmaY_ActiveFlag": asmaYActiveFlag,
        "asmaY_Pre_ActiveFlag": asmaYPreActiveFlag,
        "asmaY_Cut_Of_Date": asmaYCutOfDate!.toIso8601String(),
        "is_Active": isActive,
        "asmcL_MinAgeYear": asmcLMinAgeYear,
        "asmcL_MinAgeMonth": asmcLMinAgeMonth,
        "asmcL_MinAgeDays": asmcLMinAgeDays,
        "asmcL_MaxAgeYear": asmcLMaxAgeYear,
        "asmcL_MaxAgeMonth": asmcLMaxAgeMonth,
        "asmcL_MaxAgeDays": asmcLMaxAgeDays,
        "asmcL_Order": asmcLOrder,
        "asmcL_ActiveFlag": asmcLActiveFlag,
        "asmcL_MaxCapacity": asmcLMaxCapacity,
        "amsT_Id": amsTId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "asmaY_Id": asmaYId,
        "amaY_RollNo": amaYRollNo,
        "asmC_Order": asmCOrder,
        "asmC_ActiveFlag": asmCActiveFlag,
        "asmC_MaxCapacity": asmCMaxCapacity,
        "asysT_Id": asysTId,
        "amaY_ActiveFlag": amaYActiveFlag,
        "estmpS_Id": estmpSId,
        "ismS_Id": ismSId,
        "emE_Id": emEId,
        "emE_ExamOrder": emEExamOrder,
        "emE_FinalExamFlag": emEFinalExamFlag,
        "emE_ActiveFlag": emEActiveFlag,
        "ismS_ExamFlag": ismSExamFlag,
        "ismS_PreadmFlag": ismSPreadmFlag,
        "ismS_SubjectFlag": ismSSubjectFlag,
        "ismS_BatchAppl": ismSBatchAppl,
        "ismS_ActiveFlag": ismSActiveFlag,
        "ismS_OrderFlag": ismSOrderFlag,
        "ismS_TTFlag": ismSTtFlag,
        "ismS_AttendanceFlag": ismSAttendanceFlag,
        "ismS_LanguageFlg": ismSLanguageFlg,
        "ismS_AtExtraFeeFlg": ismSAtExtraFeeFlg,
        "getexamconfig": getexamconfig!.toJson(),
        "percentage": percentage,
        "amsT_DOB": amsTDob!.toIso8601String(),
        "hrmE_ID": hrmEId,
        "user_id": userId,
        "examReportList": examReportList!.toJson(),
        "get_eme_id_details": getEmeIdDetails!.toJson(),
        "type": type,
      };
}

class ExamWiseReportList {
  ExamWiseReportList({
    this.type,
    this.values,
  });

  String? type;
  List<ExamWiseReportListValue>? values;

  factory ExamWiseReportList.fromJson(Map<String, dynamic> json) =>
      ExamWiseReportList(
        type: json["\$type"],
        values: List<ExamWiseReportListValue>.from(
            json["\$values"].map((x) => ExamWiseReportListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class ExamWiseReportListValue {
  ExamWiseReportListValue({
    this.type,
    this.ismsSubjectName,
    this.estmpsMaxMarks,
    this.eycesMinMarks,
    this.estmpsObtainedMarks,
    this.estmpsObtainedGrade,
    this.estmpsClassAverage,
    this.estmpsSectionAverage,
    this.estmpsClassHighest,
    this.estmpsSectionHighest,
    this.estmpsPassFailFlg,
    this.asmayYear,
    this.eycesSubjectOrder,
    this.asmayOrder,
    this.eycesGradeDisplayFlg,
    this.eycesMarksDisplayFlg,
    this.eycesAplResultFlg,
    this.eycesMarksGradeEntryFlg,
  });

  String? type;
  String? ismsSubjectName;
  double? estmpsMaxMarks;
  double? eycesMinMarks;
  double? estmpsObtainedMarks;
  String? estmpsObtainedGrade;
  double? estmpsClassAverage;
  double? estmpsSectionAverage;
  double? estmpsClassHighest;
  double? estmpsSectionHighest;
  String? estmpsPassFailFlg;
  String? asmayYear;
  int? eycesSubjectOrder;
  int? asmayOrder;
  bool? eycesGradeDisplayFlg;
  bool? eycesMarksDisplayFlg;
  bool? eycesAplResultFlg;
  String? eycesMarksGradeEntryFlg;

  factory ExamWiseReportListValue.fromJson(Map<String, dynamic> json) =>
      ExamWiseReportListValue(
        type: json["\$type"],
        ismsSubjectName: json["ISMS_SubjectName"],
        estmpsMaxMarks: json["ESTMPS_MaxMarks"],
        eycesMinMarks: json['EYCES_MinMarks'],
        estmpsObtainedMarks: json["ESTMPS_ObtainedMarks"],
        estmpsObtainedGrade: json["ESTMPS_ObtainedGrade"],
        estmpsClassAverage: json["ESTMPS_ClassAverage"].toDouble(),
        estmpsSectionAverage: json["ESTMPS_SectionAverage"].toDouble(),
        estmpsClassHighest: json["ESTMPS_ClassHighest"],
        estmpsSectionHighest: json["ESTMPS_SectionHighest"],
        estmpsPassFailFlg: json["ESTMPS_PassFailFlg"],
        asmayYear: json["ASMAY_Year"],
        eycesSubjectOrder: json["EYCES_SubjectOrder"],
        asmayOrder: json["ASMAY_Order"],
        eycesGradeDisplayFlg: json["EYCES_GradeDisplayFlg"],
        eycesMarksDisplayFlg: json["EYCES_MarksDisplayFlg"],
        eycesAplResultFlg: json["EYCES_AplResultFlg"],
        eycesMarksGradeEntryFlg: json["EYCES_MarksGradeEntryFlg"],
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "ISMS_SubjectName": ismsSubjectName,
        "ESTMPS_MaxMarks": estmpsMaxMarks,
        "EYCES_MinMarks": eycesMinMarks,
        "ESTMPS_ObtainedMarks": estmpsObtainedMarks,
        "ESTMPS_ObtainedGrade": estmpsObtainedGrade,
        "ESTMPS_ClassAverage": estmpsClassAverage,
        "ESTMPS_SectionAverage": estmpsSectionAverage,
        "ESTMPS_ClassHighest": estmpsClassHighest,
        "ESTMPS_SectionHighest": estmpsSectionHighest,
        "ESTMPS_PassFailFlg": estmpsPassFailFlg,
        "ASMAY_Year": asmayYear,
        "EYCES_SubjectOrder": eycesSubjectOrder,
        "ASMAY_Order": asmayOrder,
        "EYCES_GradeDisplayFlg": eycesGradeDisplayFlg,
        "EYCES_MarksDisplayFlg": eycesMarksDisplayFlg,
        "EYCES_AplResultFlg": eycesAplResultFlg,
        "EYCES_MarksGradeEntryFlg": eycesMarksGradeEntryFlg,
      };
}

class GetEmeIdDetails {
  GetEmeIdDetails({
    this.type,
    this.values,
  });

  String? type;
  List<GetEmeIdDetailsValue>? values;

  factory GetEmeIdDetails.fromJson(Map<String, dynamic> json) =>
      GetEmeIdDetails(
        type: json["\$type"],
        values: List<GetEmeIdDetailsValue>.from(
            json["\$values"].map((x) => GetEmeIdDetailsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class GetEmeIdDetailsValue {
  GetEmeIdDetailsValue({
    this.eycEId,
    this.eyCId,
    this.emEId,
    this.emgRId,
    this.eycEAttendanceFromDate,
    this.eycEAttendanceToDate,
    this.eycESubExamFlg,
    this.eycESubSubjectFlg,
    this.eycEActiveFlg,
    this.eycEBestOfApplicableFlg,
    this.createdDate,
    this.updatedDate,
  });

  int? eycEId;
  int? eyCId;
  int? emEId;
  int? emgRId;
  DateTime? eycEAttendanceFromDate;
  DateTime? eycEAttendanceToDate;
  bool? eycESubExamFlg;
  bool? eycESubSubjectFlg;
  bool? eycEActiveFlg;
  bool? eycEBestOfApplicableFlg;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory GetEmeIdDetailsValue.fromJson(Map<String, dynamic> json) =>
      GetEmeIdDetailsValue(
        eycEId: json["eycE_Id"],
        eyCId: json["eyC_Id"],
        emEId: json["emE_Id"],
        emgRId: json["emgR_Id"],
        eycEAttendanceFromDate: DateTime.parse(json["eycE_AttendanceFromDate"]),
        eycEAttendanceToDate: DateTime.parse(json["eycE_AttendanceToDate"]),
        eycESubExamFlg: json["eycE_SubExamFlg"],
        eycESubSubjectFlg: json["eycE_SubSubjectFlg"],
        eycEActiveFlg: json["eycE_ActiveFlg"],
        eycEBestOfApplicableFlg: json["eycE_BestOfApplicableFlg"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "eycE_Id": eycEId,
        "eyC_Id": eyCId,
        "emE_Id": emEId,
        "emgR_Id": emgRId,
        "eycE_AttendanceFromDate": eycEAttendanceFromDate!.toIso8601String(),
        "eycE_AttendanceToDate": eycEAttendanceToDate!.toIso8601String(),
        "eycE_SubExamFlg": eycESubExamFlg,
        "eycE_SubSubjectFlg": eycESubSubjectFlg,
        "eycE_ActiveFlg": eycEActiveFlg,
        "eycE_BestOfApplicableFlg": eycEBestOfApplicableFlg,
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
      };
}

class Getexamconfig {
  Getexamconfig({
    this.type,
    this.values,
  });

  String? type;
  List<GetexamconfigValue>? values;

  factory Getexamconfig.fromJson(Map<String, dynamic> json) => Getexamconfig(
        type: json["\$type"],
        values: List<GetexamconfigValue>.from(
            json["\$values"].map((x) => GetexamconfigValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class GetexamconfigValue {
  GetexamconfigValue({
    this.exmConfigId,
    this.mIId,
    this.exmConfigRankingMethod,
    this.exmConfigPromotionFlag,
    this.exmConfigPassFailRankFlag,
    this.exmConfigRecordsearchtype,
    this.exmConfigRemarks,
    this.exmConfigGraceAplFlg,
    this.exmConfigBonusAplFlag,
    this.exmConfigMinAttAplFlag,
    this.exmConfigMarksMultiply,
    this.exmConfigNoOfDecimal,
    this.exmConfigGroupMarksToResultFlg,
    this.exmConfigEnableFractionFlg,
    this.exmConfigEntryDateRestFlg,
    this.exmConfigAdmnoColumnDisplay,
    this.exmConfigRegnoColumnDisplay,
    this.exmConfigRollnoColumnDisplay,
    this.exmConfigRoundoffFlag,
    this.exmConfigNoOfDecimalValues,
    this.exmConfigPerRoundoffFlag,
    this.exmConfigHallTicketFlg,
    this.exmConfigFailBoldFlg,
    this.exmConfigFailItalicFlg,
    this.exmConfigFailUnderscoreFlg,
    this.exmConfigFailColorFlg,
    this.exmConfigAllSubjectAbsentFlg,
    this.exmConfigFeeDefaulterDisplayFlg,
    this.exmConfigAdmNoRegNoRollNoDefaultFlag,
    this.exmConfigClassRankFlg,
    this.exmConfigSecRankFlg,
    this.exmConfigClassPositionFlg,
    this.exmConfigSectionPositionFlg,
    this.exmConfigGroupwiseMarksFlg,
    this.exmConfigSubjectwiseClassRankFlg,
    this.createdDate,
    this.updatedDate,
  });

  int? exmConfigId;
  int? mIId;
  String? exmConfigRankingMethod;
  bool? exmConfigPromotionFlag;
  bool? exmConfigPassFailRankFlag;
  String? exmConfigRecordsearchtype;
  String? exmConfigRemarks;
  bool? exmConfigGraceAplFlg;
  bool? exmConfigBonusAplFlag;
  bool? exmConfigMinAttAplFlag;
  bool? exmConfigMarksMultiply;
  int? exmConfigNoOfDecimal;
  bool? exmConfigGroupMarksToResultFlg;
  bool? exmConfigEnableFractionFlg;
  bool? exmConfigEntryDateRestFlg;
  bool? exmConfigAdmnoColumnDisplay;
  bool? exmConfigRegnoColumnDisplay;
  bool? exmConfigRollnoColumnDisplay;
  bool? exmConfigRoundoffFlag;
  int? exmConfigNoOfDecimalValues;
  bool? exmConfigPerRoundoffFlag;
  bool? exmConfigHallTicketFlg;
  bool? exmConfigFailBoldFlg;
  bool? exmConfigFailItalicFlg;
  bool? exmConfigFailUnderscoreFlg;
  String? exmConfigFailColorFlg;
  bool? exmConfigAllSubjectAbsentFlg;
  bool? exmConfigFeeDefaulterDisplayFlg;
  String? exmConfigAdmNoRegNoRollNoDefaultFlag;
  bool? exmConfigClassRankFlg;
  bool? exmConfigSecRankFlg;
  bool? exmConfigClassPositionFlg;
  bool? exmConfigSectionPositionFlg;
  bool? exmConfigGroupwiseMarksFlg;
  bool? exmConfigSubjectwiseClassRankFlg;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory GetexamconfigValue.fromJson(Map<String, dynamic> json) =>
      GetexamconfigValue(
        exmConfigId: json["exmConfig_Id"],
        mIId: json["mI_Id"],
        exmConfigRankingMethod: json["exmConfig_RankingMethod"],
        exmConfigPromotionFlag: json["exmConfig_PromotionFlag"],
        exmConfigPassFailRankFlag: json["exmConfig_PassFailRankFlag"],
        exmConfigRecordsearchtype: json["exmConfig_Recordsearchtype"],
        exmConfigRemarks: json["exmConfig_Remarks"],
        exmConfigGraceAplFlg: json["exmConfig_GraceAplFlg"],
        exmConfigBonusAplFlag: json["exmConfig_BonusAplFlag"],
        exmConfigMinAttAplFlag: json["exmConfig_MinAttAplFlag"],
        exmConfigMarksMultiply: json["exmConfig_MarksMultiply"],
        exmConfigNoOfDecimal: json["exmConfig_NoOfDecimal"],
        exmConfigGroupMarksToResultFlg: json["exmConfig_GroupMarksToResultFlg"],
        exmConfigEnableFractionFlg: json["exmConfig_EnableFractionFlg"],
        exmConfigEntryDateRestFlg: json["exmConfig_EntryDateRestFlg"],
        exmConfigAdmnoColumnDisplay: json["exmConfig_AdmnoColumnDisplay"],
        exmConfigRegnoColumnDisplay: json["exmConfig_RegnoColumnDisplay"],
        exmConfigRollnoColumnDisplay: json["exmConfig_RollnoColumnDisplay"],
        exmConfigRoundoffFlag: json["exmConfig_RoundoffFlag"],
        exmConfigNoOfDecimalValues: json["exmConfig_NoOfDecimalValues"],
        exmConfigPerRoundoffFlag: json["exmConfig_PerRoundoffFlag"],
        exmConfigHallTicketFlg: json["exmConfig_HallTicketFlg"],
        exmConfigFailBoldFlg: json["exmConfig_FailBoldFlg"],
        exmConfigFailItalicFlg: json["exmConfig_FailItalicFlg"],
        exmConfigFailUnderscoreFlg: json["exmConfig_FailUnderscoreFlg"],
        exmConfigFailColorFlg: json["exmConfig_FailColorFlg"],
        exmConfigAllSubjectAbsentFlg: json["exmConfig_AllSubjectAbsentFlg"],
        exmConfigFeeDefaulterDisplayFlg:
            json["exmConfig_FeeDefaulterDisplayFlg"],
        exmConfigAdmNoRegNoRollNoDefaultFlag:
            json["exmConfig_AdmNoRegNoRollNo_DefaultFlag"],
        exmConfigClassRankFlg: json["exmConfig_ClassRankFlg"],
        exmConfigSecRankFlg: json["exmConfig_SecRankFlg"],
        exmConfigClassPositionFlg: json["exmConfig_ClassPositionFlg"],
        exmConfigSectionPositionFlg: json["exmConfig_SectionPositionFlg"],
        exmConfigGroupwiseMarksFlg: json["exmConfig_GroupwiseMarksFlg"],
        exmConfigSubjectwiseClassRankFlg:
            json["exmConfig_SubjectwiseClassRankFlg"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "exmConfig_Id": exmConfigId,
        "mI_Id": mIId,
        "exmConfig_RankingMethod": exmConfigRankingMethod,
        "exmConfig_PromotionFlag": exmConfigPromotionFlag,
        "exmConfig_PassFailRankFlag": exmConfigPassFailRankFlag,
        "exmConfig_Recordsearchtype": exmConfigRecordsearchtype,
        "exmConfig_Remarks": exmConfigRemarks,
        "exmConfig_GraceAplFlg": exmConfigGraceAplFlg,
        "exmConfig_BonusAplFlag": exmConfigBonusAplFlag,
        "exmConfig_MinAttAplFlag": exmConfigMinAttAplFlag,
        "exmConfig_MarksMultiply": exmConfigMarksMultiply,
        "exmConfig_NoOfDecimal": exmConfigNoOfDecimal,
        "exmConfig_GroupMarksToResultFlg": exmConfigGroupMarksToResultFlg,
        "exmConfig_EnableFractionFlg": exmConfigEnableFractionFlg,
        "exmConfig_EntryDateRestFlg": exmConfigEntryDateRestFlg,
        "exmConfig_AdmnoColumnDisplay": exmConfigAdmnoColumnDisplay,
        "exmConfig_RegnoColumnDisplay": exmConfigRegnoColumnDisplay,
        "exmConfig_RollnoColumnDisplay": exmConfigRollnoColumnDisplay,
        "exmConfig_RoundoffFlag": exmConfigRoundoffFlag,
        "exmConfig_NoOfDecimalValues": exmConfigNoOfDecimalValues,
        "exmConfig_PerRoundoffFlag": exmConfigPerRoundoffFlag,
        "exmConfig_HallTicketFlg": exmConfigHallTicketFlg,
        "exmConfig_FailBoldFlg": exmConfigFailBoldFlg,
        "exmConfig_FailItalicFlg": exmConfigFailItalicFlg,
        "exmConfig_FailUnderscoreFlg": exmConfigFailUnderscoreFlg,
        "exmConfig_FailColorFlg": exmConfigFailColorFlg,
        "exmConfig_AllSubjectAbsentFlg": exmConfigAllSubjectAbsentFlg,
        "exmConfig_FeeDefaulterDisplayFlg": exmConfigFeeDefaulterDisplayFlg,
        "exmConfig_AdmNoRegNoRollNo_DefaultFlag":
            exmConfigAdmNoRegNoRollNoDefaultFlag,
        "exmConfig_ClassRankFlg": exmConfigClassRankFlg,
        "exmConfig_SecRankFlg": exmConfigSecRankFlg,
        "exmConfig_ClassPositionFlg": exmConfigClassPositionFlg,
        "exmConfig_SectionPositionFlg": exmConfigSectionPositionFlg,
        "exmConfig_GroupwiseMarksFlg": exmConfigGroupwiseMarksFlg,
        "exmConfig_SubjectwiseClassRankFlg": exmConfigSubjectwiseClassRankFlg,
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
      };
}
