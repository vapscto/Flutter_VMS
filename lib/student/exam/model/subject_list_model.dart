// To parse this JSON data, do
//
//     final subjectListModel = subjectListModelFromJson(jsonString);

import 'dart:convert';

SubjectListModel subjectListModelFromJson(String str) =>
    SubjectListModel.fromJson(json.decode(str));

String subjectListModelToJson(SubjectListModel data) =>
    json.encode(data.toJson());

class SubjectListModel {
  SubjectListModel({
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
    this.subjectlist,
    this.percentage,
    this.amsTDob,
    this.hrmEId,
    this.userId,
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
  Subjectlist? subjectlist;
  double? percentage;
  DateTime? amsTDob;
  int? hrmEId;
  int? userId;
  String? type;

  factory SubjectListModel.fromJson(Map<String, dynamic> json) =>
      SubjectListModel(
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
        subjectlist: Subjectlist.fromJson(json["subjectlist"]),
        percentage: json["percentage"],
        amsTDob: DateTime.parse(json["amsT_DOB"]),
        hrmEId: json["hrmE_ID"],
        userId: json["user_id"],
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
        "subjectlist": subjectlist!.toJson(),
        "percentage": percentage,
        "amsT_DOB": amsTDob!.toIso8601String(),
        "hrmE_ID": hrmEId,
        "user_id": userId,
        "type": type,
      };
}

class Subjectlist {
  Subjectlist({
    this.type,
    this.values,
  });

  String? type;
  List<SubjectListValue>? values;

  factory Subjectlist.fromJson(Map<String, dynamic> json) => Subjectlist(
        type: json["\$type"],
        values: List<SubjectListValue>.from(
            json["\$values"].map((x) => SubjectListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class SubjectListValue {
  SubjectListValue({
    this.emEId,
    this.mIId,
    this.emEExamOrder,
    this.emEFinalExamFlag,
    this.emEActiveFlag,
    this.returnval,
    this.amsTId,
    this.elPId,
    this.asmaYId,
    this.loginId,
    this.elPActiveFlg,
    this.elpSId,
    this.asmcLId,
    this.asmSId,
    this.ismSId,
    this.elPsActiveFlg,
    this.elpsSId,
    this.emsSId,
    this.eyceSAplResultFlg,
    this.userId,
    this.emGId,
    this.emcAId,
    this.ecaCId,
    this.ismSSubjectName,
    this.ismSSubjectCode,
    this.ismSOrder,
    this.eyceSSubjectOrder,
    this.amsTDob,
    this.amaYRollNo,
    this.emgRId,
    this.hrmEId,
    this.ivrmulFId,
    this.empCode,
    this.estmpSId,
    this.estmPId,
    this.estmPClassRank,
    this.estmPSectionRank,
  });

  int? emEId;
  int? mIId;
  int? emEExamOrder;
  bool? emEFinalExamFlag;
  bool? emEActiveFlag;
  bool? returnval;
  int? amsTId;
  int? elPId;
  int? asmaYId;
  int? loginId;
  bool? elPActiveFlg;
  int? elpSId;
  int? asmcLId;
  int? asmSId;
  int? ismSId;
  bool? elPsActiveFlg;
  int? elpsSId;
  int? emsSId;
  bool? eyceSAplResultFlg;
  int? userId;
  int? emGId;
  int? emcAId;
  int? ecaCId;
  String? ismSSubjectName;
  String? ismSSubjectCode;
  int? ismSOrder;
  int? eyceSSubjectOrder;
  DateTime? amsTDob;
  int? amaYRollNo;
  int? emgRId;
  int? hrmEId;
  int? ivrmulFId;
  int? empCode;
  int? estmpSId;
  int? estmPId;
  int? estmPClassRank;
  int? estmPSectionRank;

  factory SubjectListValue.fromJson(Map<String, dynamic> json) =>
      SubjectListValue(
        emEId: json["emE_Id"],
        mIId: json["mI_Id"],
        emEExamOrder: json["emE_ExamOrder"],
        emEFinalExamFlag: json["emE_FinalExamFlag"],
        emEActiveFlag: json["emE_ActiveFlag"],
        returnval: json["returnval"],
        amsTId: json["amsT_Id"],
        elPId: json["elP_Id"],
        asmaYId: json["asmaY_Id"],
        loginId: json["login_Id"],
        elPActiveFlg: json["elP_ActiveFlg"],
        elpSId: json["elpS_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        ismSId: json["ismS_Id"],
        elPsActiveFlg: json["elPs_ActiveFlg"],
        elpsSId: json["elpsS_Id"],
        emsSId: json["emsS_Id"],
        eyceSAplResultFlg: json["eyceS_AplResultFlg"],
        userId: json["user_Id"],
        emGId: json["emG_Id"],
        emcAId: json["emcA_Id"],
        ecaCId: json["ecaC_Id"],
        ismSSubjectName: json["ismS_SubjectName"],
        ismSSubjectCode: json["ismS_SubjectCode"],
        ismSOrder: json["ismS_Order"],
        eyceSSubjectOrder: json["eyceS_SubjectOrder"],
        amsTDob: DateTime.parse(json["amsT_DOB"]),
        amaYRollNo: json["amaY_RollNo"],
        emgRId: json["emgR_Id"],
        hrmEId: json["hrmE_Id"],
        ivrmulFId: json["ivrmulF_Id"],
        empCode: json["emp_Code"],
        estmpSId: json["estmpS_Id"],
        estmPId: json["estmP_Id"],
        estmPClassRank: json["estmP_ClassRank"],
        estmPSectionRank: json["estmP_SectionRank"],
      );

  Map<String, dynamic> toJson() => {
        "emE_Id": emEId,
        "mI_Id": mIId,
        "emE_ExamOrder": emEExamOrder,
        "emE_FinalExamFlag": emEFinalExamFlag,
        "emE_ActiveFlag": emEActiveFlag,
        "returnval": returnval,
        "amsT_Id": amsTId,
        "elP_Id": elPId,
        "asmaY_Id": asmaYId,
        "login_Id": loginId,
        "elP_ActiveFlg": elPActiveFlg,
        "elpS_Id": elpSId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "ismS_Id": ismSId,
        "elPs_ActiveFlg": elPsActiveFlg,
        "elpsS_Id": elpsSId,
        "emsS_Id": emsSId,
        "eyceS_AplResultFlg": eyceSAplResultFlg,
        "user_Id": userId,
        "emG_Id": emGId,
        "emcA_Id": emcAId,
        "ecaC_Id": ecaCId,
        "ismS_SubjectName": ismSSubjectName,
        "ismS_SubjectCode": ismSSubjectCode,
        "ismS_Order": ismSOrder,
        "eyceS_SubjectOrder": eyceSSubjectOrder,
        "amsT_DOB": amsTDob!.toIso8601String(),
        "amaY_RollNo": amaYRollNo,
        "emgR_Id": emgRId,
        "hrmE_Id": hrmEId,
        "ivrmulF_Id": ivrmulFId,
        "emp_Code": empCode,
        "estmpS_Id": estmpSId,
        "estmP_Id": estmPId,
        "estmP_ClassRank": estmPClassRank,
        "estmP_SectionRank": estmPSectionRank,
      };
}
