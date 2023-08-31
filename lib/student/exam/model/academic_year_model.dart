// To parse this JSON data, do
//
//     final academicYearModel = academicYearModelFromJson(jsonString);

import 'dart:convert';

AcademicYearModel academicYearModelFromJson(String str) =>
    AcademicYearModel.fromJson(json.decode(str));

String academicYearModelToJson(AcademicYearModel data) =>
    json.encode(data.toJson());

class Studetiallist {
  Studetiallist({
    this.type,
    this.values,
  });

  String? type;
  List<AcademicYearModel>? values;

  factory Studetiallist.fromJson(Map<String, dynamic> json) => Studetiallist(
        type: json["\$type"],
        values: List<AcademicYearModel>.from(
            json["\$values"].map((x) => AcademicYearModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class AcademicYearModel {
  AcademicYearModel({
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
    this.studetiallist,
    this.percentage,
    this.amsTDob,
    this.hrmEId,
    this.userId,
    this.asmaYYear,
    this.asmcLClassName,
    this.asmCSectionName,
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
  StudentList? studetiallist;
  double? percentage;
  DateTime? amsTDob;
  int? hrmEId;
  int? userId;
  String? asmaYYear;
  String? asmcLClassName;
  String? asmCSectionName;

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) =>
      AcademicYearModel(
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
        studetiallist: json["studetiallist"] == null
            ? null
            : StudentList.fromJson(json["studetiallist"]),
        percentage: json["percentage"],
        amsTDob: DateTime.parse(json["amsT_DOB"]),
        hrmEId: json["hrmE_ID"],
        userId: json["user_id"],
        asmaYYear: json["asmaY_Year"] == null ? null : json["asmaY_Year"],
        asmcLClassName:
            json["asmcL_ClassName"] == null ? null : json["asmcL_ClassName"],
        asmCSectionName:
            json["asmC_SectionName"] == null ? null : json["asmC_SectionName"],
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
        "studetiallist": studetiallist == null ? null : studetiallist!.toJson(),
        "percentage": percentage,
        "amsT_DOB": amsTDob!.toIso8601String(),
        "hrmE_ID": hrmEId,
        "user_id": userId,
        "asmaY_Year": asmaYYear == null ? null : asmaYYear,
        "asmcL_ClassName": asmcLClassName == null ? null : asmcLClassName,
        "asmC_SectionName": asmCSectionName == null ? null : asmCSectionName,
      };
}

class StudentList {
  StudentList({
    this.type,
    this.values,
  });
  String? type;
  List<AcademicYearValues>? values;
  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        type: json["\$type"],
        values: List<AcademicYearValues>.from(
            json["\$values"].map((x) => AcademicYearValues.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class AcademicYearValues {
  AcademicYearValues({
    this.asmaYYear,
    this.asmaYId,
  });
  String? asmaYYear;
  int? asmaYId;

  factory AcademicYearValues.fromJson(Map<String, dynamic> json) =>
      AcademicYearValues(
        asmaYYear: json["asmaY_Year"],
        asmaYId: json["asmaY_Id"],
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Year": asmaYYear,
        "asmaY_Id": asmaYId,
      };
}
