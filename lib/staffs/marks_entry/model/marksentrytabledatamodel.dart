// To parse this JSON data, do
//
//     final marksEntryDataTableModel = marksEntryDataTableModelFromJson(jsonString);

import 'dart:convert';

MarksEntryDataTableModel? marksEntryDataTableModelFromJson(String str) =>
    MarksEntryDataTableModel.fromJson(json.decode(str));

String marksEntryDataTableModelToJson(MarksEntryDataTableModel? data) =>
    json.encode(data!.toJson());

class MarksEntryDataTableModel {
  MarksEntryDataTableModel({
    this.estMId,
    this.mIId,
    this.asmaYId,
    this.asmcLId,
    this.asmSId,
    this.amsTId,
    this.emEId,
    this.ismSId,
    this.roleid,
    this.estMMarks,
    this.id,
    this.loginDateTime,
    this.estMActiveFlg,
    this.configuration,
    this.studentList,
    this.subMorGFlag,
    this.emgRId,
    this.marksdeleteflag,
    this.saveupdatecount,
    this.lastdateentry,
    this.lastdateentryflag,
    this.emsSId,
    this.emsEId,
    this.lastdateexam,
    this.lastdateexamflag,
    this.messagesub,
  });

  num? estMId;
  num? mIId;
  num? asmaYId;
  num? asmcLId;
  num? asmSId;
  num? amsTId;
  num? emEId;
  num? ismSId;
  num? roleid;
  num? estMMarks;
  num? id;
  DateTime? loginDateTime;
  bool? estMActiveFlg;
  Configuration? configuration;
  StudentList? studentList;
  String? subMorGFlag;
  num? emgRId;
  String? marksdeleteflag;
  num? saveupdatecount;
  num? lastdateentry;
  bool? lastdateentryflag;
  num? emsSId;
  num? emsEId;
  num? lastdateexam;
  bool? lastdateexamflag;
  String? messagesub;

  factory MarksEntryDataTableModel.fromJson(Map<String, dynamic> json) =>
      MarksEntryDataTableModel(
        estMId: json["estM_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        amsTId: json["amsT_Id"],
        emEId: json["emE_Id"],
        ismSId: json["ismS_Id"],
        roleid: json["roleid"],
        estMMarks: json["estM_Marks"],
        id: json["id"],
        loginDateTime: DateTime.parse(json["loginDateTime"]),
        estMActiveFlg: json["estM_ActiveFlg"],
        configuration: Configuration.fromJson(json["configuration"]),
        studentList: StudentList.fromJson(json["studentList"]),
        subMorGFlag: json["subMorGFlag"],
        emgRId: json["emgR_Id"],
        marksdeleteflag: json["marksdeleteflag"],
        saveupdatecount: json["saveupdatecount"],
        lastdateentry: json["lastdateentry"],
        lastdateentryflag: json["lastdateentryflag"],
        emsSId: json["emsS_Id"],
        emsEId: json["emsE_Id"],
        lastdateexam: json["lastdateexam"],
        lastdateexamflag: json["lastdateexamflag"],
        messagesub: json["messagesub"],
      );

  Map<String, dynamic> toJson() => {
        "estM_Id": estMId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "amsT_Id": amsTId,
        "emE_Id": emEId,
        "ismS_Id": ismSId,
        "roleid": roleid,
        "estM_Marks": estMMarks,
        "id": id,
        "loginDateTime": loginDateTime?.toIso8601String(),
        "estM_ActiveFlg": estMActiveFlg,
        "configuration": configuration!.toJson(),
        "studentList": studentList!.toJson(),
        "subMorGFlag": subMorGFlag,
        "emgR_Id": emgRId,
        "marksdeleteflag": marksdeleteflag,
        "saveupdatecount": saveupdatecount,
        "lastdateentry": lastdateentry,
        "lastdateentryflag": lastdateentryflag,
        "emsS_Id": emsSId,
        "emsE_Id": emsEId,
        "lastdateexam": lastdateexam,
        "lastdateexamflag": lastdateexamflag,
        "messagesub": messagesub,
      };
}

class Configuration {
  Configuration({
    this.type,
    this.values,
  });

  String? type;
  List<ConfigurationValue?>? values;

  factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<ConfigurationValue?>.from(
                json["\$values"]!.map((x) => ConfigurationValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class ConfigurationValue {
  ConfigurationValue({
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

  num? exmConfigId;
  num? mIId;
  String? exmConfigRankingMethod;
  bool? exmConfigPromotionFlag;
  bool? exmConfigPassFailRankFlag;
  String? exmConfigRecordsearchtype;
  String? exmConfigRemarks;
  bool? exmConfigGraceAplFlg;
  bool? exmConfigBonusAplFlag;
  bool? exmConfigMinAttAplFlag;
  bool? exmConfigMarksMultiply;
  num? exmConfigNoOfDecimal;
  bool? exmConfigGroupMarksToResultFlg;
  bool? exmConfigEnableFractionFlg;
  bool? exmConfigEntryDateRestFlg;
  bool? exmConfigAdmnoColumnDisplay;
  bool? exmConfigRegnoColumnDisplay;
  bool? exmConfigRollnoColumnDisplay;
  bool? exmConfigRoundoffFlag;
  num? exmConfigNoOfDecimalValues;
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

  factory ConfigurationValue.fromJson(Map<String, dynamic> json) =>
      ConfigurationValue(
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
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
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
            : List<StudentListValue?>.from(
                json["\$values"]!.map((x) => StudentListValue.fromJson(x))),
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
    this.estMId,
    this.mIId,
    this.asmaYId,
    this.asmcLId,
    this.asmSId,
    this.amsTId,
    this.emEId,
    this.ismSId,
    this.roleid,
    this.estMMarks,
    this.id,
    this.loginDateTime,
    this.estMActiveFlg,
    this.estMGrade,
    this.subjectName,
    this.totalMarks,
    this.marksEnterFor,
    this.minMarks,
    this.obtainmarks,
    this.amaYRollNo,
    this.amsTAdmNo,
    this.amsTRegistrationNo,
    this.studentname,
    this.emgRId,
    this.saveupdatecount,
    this.lastdateentry,
    this.lastdateentryflag,
    this.emsSId,
    this.emsEId,
    this.lastdateexam,
    this.lastdateexamflag,
  });

  num? estMId;
  num? mIId;
  num? asmaYId;
  num? asmcLId;
  num? asmSId;
  num? amsTId;
  num? emEId;
  num? ismSId;
  num? roleid;
  num? estMMarks;
  num? id;
  DateTime? loginDateTime;
  bool? estMActiveFlg;
  String? estMGrade;
  String? subjectName;
  num? totalMarks;
  num? marksEnterFor;
  num? minMarks;
  String? obtainmarks;
  num? amaYRollNo;
  String? amsTAdmNo;
  String? amsTRegistrationNo;
  String? studentname;
  num? emgRId;
  num? saveupdatecount;
  num? lastdateentry;
  bool? lastdateentryflag;
  num? emsSId;
  num? emsEId;
  num? lastdateexam;
  bool? lastdateexamflag;

  factory StudentListValue.fromJson(Map<String, dynamic> json) =>
      StudentListValue(
        estMId: json["estM_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        amsTId: json["amsT_Id"],
        emEId: json["emE_Id"],
        ismSId: json["ismS_Id"],
        roleid: json["roleid"],
        estMMarks: json["estM_Marks"],
        id: json["id"],
        loginDateTime: DateTime.parse(json["loginDateTime"]),
        estMActiveFlg: json["estM_ActiveFlg"],
        estMGrade: json["estM_Grade"],
        subjectName: json["subjectName"],
        totalMarks: json["totalMarks"],
        marksEnterFor: json["marksEnterFor"],
        minMarks: json["minMarks"],
        obtainmarks: json["obtainmarks"] ?? 0.00,
        amaYRollNo: json["amaY_RollNo"],
        amsTAdmNo: json["amsT_AdmNo"],
        amsTRegistrationNo: json["amsT_RegistrationNo"],
        studentname: json["studentname"],
        emgRId: json["emgR_Id"],
        saveupdatecount: json["saveupdatecount"],
        lastdateentry: json["lastdateentry"],
        lastdateentryflag: json["lastdateentryflag"],
        emsSId: json["emsS_Id"],
        emsEId: json["emsE_Id"],
        lastdateexam: json["lastdateexam"],
        lastdateexamflag: json["lastdateexamflag"],
      );

  Map<String, dynamic> toJson() => {
        "estM_Id": estMId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "amsT_Id": amsTId,
        "emE_Id": emEId,
        "ismS_Id": ismSId,
        "roleid": roleid,
        "estM_Marks": estMMarks,
        "id": id,
        "loginDateTime": loginDateTime?.toIso8601String(),
        "estM_ActiveFlg": estMActiveFlg,
        "estM_Grade": estMGrade,
        "subjectName": subjectName,
        "totalMarks": totalMarks,
        "marksEnterFor": marksEnterFor,
        "minMarks": minMarks,
        "obtainmarks": obtainmarks,
        "amaY_RollNo": amaYRollNo,
        "amsT_AdmNo": amsTAdmNo,
        "amsT_RegistrationNo": amsTRegistrationNo,
        "studentname": studentname,
        "emgR_Id": emgRId,
        "saveupdatecount": saveupdatecount,
        "lastdateentry": lastdateentry,
        "lastdateentryflag": lastdateentryflag,
        "emsS_Id": emsSId,
        "emsE_Id": emsEId,
        "lastdateexam": lastdateexam,
        "lastdateexamflag": lastdateexamflag,
      };
}
