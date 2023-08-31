// To parse this JSON data, do
//
//     final subjectDropdownModel = subjectDropdownModelFromJson(jsonString);

import 'dart:convert';

SubjectDropdownModel? subjectDropdownModelFromJson(String str) =>
    SubjectDropdownModel.fromJson(json.decode(str));

String subjectDropdownModelToJson(SubjectDropdownModel? data) =>
    json.encode(data!.toJson());

class SubjectDropdownModel {
  SubjectDropdownModel({
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
    this.subjectlist,
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
  Subjectlist? subjectlist;
  num? emgRId;
  num? saveupdatecount;
  num? lastdateentry;
  bool? lastdateentryflag;
  num? emsSId;
  num? emsEId;
  num? lastdateexam;
  bool? lastdateexamflag;

  factory SubjectDropdownModel.fromJson(Map<String, dynamic> json) =>
      SubjectDropdownModel(
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
        subjectlist: Subjectlist.fromJson(json["subjectlist"]),
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
        "subjectlist": subjectlist!.toJson(),
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

class Subjectlist {
  Subjectlist({
    this.type,
    this.values,
  });

  String? type;
  List<SubjectlistValue?>? values;

  factory Subjectlist.fromJson(Map<String, dynamic> json) => Subjectlist(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<SubjectlistValue?>.from(
                json["\$values"]!.map((x) => SubjectlistValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class SubjectlistValue {
  SubjectlistValue({
    this.ismSId,
    this.mIId,
    this.ismSSubjectName,
    this.ismSSubjectCode,
    this.ismSIvrsSubjectName,
    this.ismSMaxMarks,
    this.ismSMinMarks,
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
    this.createdDate,
    this.updatedDate,
  });

  num? ismSId;
  num? mIId;
  String? ismSSubjectName;
  String? ismSSubjectCode;
  String? ismSIvrsSubjectName;
  num? ismSMaxMarks;
  num? ismSMinMarks;
  num? ismSExamFlag;
  num? ismSPreadmFlag;
  num? ismSSubjectFlag;
  num? ismSBatchAppl;
  num? ismSActiveFlag;
  num? ismSOrderFlag;
  bool? ismSTtFlag;
  bool? ismSAttendanceFlag;
  num? ismSLanguageFlg;
  num? ismSAtExtraFeeFlg;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory SubjectlistValue.fromJson(Map<String, dynamic> json) =>
      SubjectlistValue(
        ismSId: json["ismS_Id"],
        mIId: json["mI_Id"],
        ismSSubjectName: json["ismS_SubjectName"],
        ismSSubjectCode: json["ismS_SubjectCode"],
        ismSIvrsSubjectName: json["ismS_IVRSSubjectName"],
        ismSMaxMarks: json["ismS_Max_Marks"],
        ismSMinMarks: json["ismS_Min_Marks"],
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
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "ismS_Id": ismSId,
        "mI_Id": mIId,
        "ismS_SubjectName": ismSSubjectName,
        "ismS_SubjectCode": ismSSubjectCode,
        "ismS_IVRSSubjectName": ismSIvrsSubjectName,
        "ismS_Max_Marks": ismSMaxMarks,
        "ismS_Min_Marks": ismSMinMarks,
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
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}
