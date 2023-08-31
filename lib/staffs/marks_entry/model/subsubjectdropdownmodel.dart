// To parse this JSON data, do
//
//     final subSubjectDropdownModel = subSubjectDropdownModelFromJson(jsonString);

import 'dart:convert';

import 'package:m_skool_flutter/staffs/marks_entry/model/subexamlist.dart';

SubSubjectDropdownModel? subSubjectDropdownModelFromJson(String str) =>
    SubSubjectDropdownModel.fromJson(json.decode(str));

String subSubjectDropdownModelToJson(SubSubjectDropdownModel? data) =>
    json.encode(data!.toJson());

class SubSubjectDropdownModel {
  SubSubjectDropdownModel({
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
    this.emgRId,
    this.saveupdatecount,
    this.lastdateentry,
    this.lastdateentryflag,
    this.subsubjectlist,
    this.subExamList,
    this.emsSId,
    this.emsEId,
    this.lastdateexam,
    this.lastdateexamflag,
  });

  int? estMId;
  int? mIId;
  int? asmaYId;
  int? asmcLId;
  int? asmSId;
  int? amsTId;
  int? emEId;
  int? ismSId;
  int? roleid;
  double? estMMarks;
  int? id;
  DateTime? loginDateTime;
  bool? estMActiveFlg;
  int? emgRId;
  int? saveupdatecount;
  int? lastdateentry;
  bool? lastdateentryflag;
  Subsubjectlist? subsubjectlist;
  SubExamList? subExamList;
  int? emsSId;
  int? emsEId;
  int? lastdateexam;
  bool? lastdateexamflag;

  factory SubSubjectDropdownModel.fromJson(Map<String, dynamic> json) =>
      SubSubjectDropdownModel(
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
        emgRId: json["emgR_Id"],
        saveupdatecount: json["saveupdatecount"],
        lastdateentry: json["lastdateentry"],
        lastdateentryflag: json["lastdateentryflag"],
        subsubjectlist: json["subsubjectlist"] == null
            ? null
            : Subsubjectlist.fromJson(json["subsubjectlist"]),
        subExamList: json['subexamlist'] == null
            ? null
            : SubExamList.fromJson(json['subexamlist']),
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
        "emgR_Id": emgRId,
        "saveupdatecount": saveupdatecount,
        "lastdateentry": lastdateentry,
        "lastdateentryflag": lastdateentryflag,
        "subsubjectlist": subsubjectlist!.toJson(),
        "subExamList": subExamList!.toJson(),
        "emsS_Id": emsSId,
        "emsE_Id": emsEId,
        "lastdateexam": lastdateexam,
        "lastdateexamflag": lastdateexamflag,
      };
}

class Subsubjectlist {
  Subsubjectlist({
    this.type,
    this.values,
  });

  String? type;
  List<SubsubjectlistValue?>? values;

  factory Subsubjectlist.fromJson(Map<String, dynamic> json) => Subsubjectlist(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<SubsubjectlistValue?>.from(
                json["\$values"]!.map((x) => SubsubjectlistValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class SubsubjectlistValue {
  SubsubjectlistValue({
    this.emsSId,
    this.mIId,
    this.emsSSubSubjectName,
    this.emsSSubSubjectCode,
    this.emsSOrder,
    this.emsSActiveFlag,
    this.createdDate,
    this.updatedDate,
  });

  int? emsSId;
  int? mIId;
  String? emsSSubSubjectName;
  String? emsSSubSubjectCode;
  int? emsSOrder;
  bool? emsSActiveFlag;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory SubsubjectlistValue.fromJson(Map<String, dynamic> json) =>
      SubsubjectlistValue(
        emsSId: json["emsS_Id"],
        mIId: json["mI_Id"],
        emsSSubSubjectName: json["emsS_SubSubjectName"],
        emsSSubSubjectCode: json["emsS_SubSubjectCode"],
        emsSOrder: json["emsS_Order"],
        emsSActiveFlag: json["emsS_ActiveFlag"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "emsS_Id": emsSId,
        "mI_Id": mIId,
        "emsS_SubSubjectName": emsSSubSubjectName,
        "emsS_SubSubjectCode": emsSSubSubjectCode,
        "emsS_Order": emsSOrder,
        "emsS_ActiveFlag": emsSActiveFlag,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}
