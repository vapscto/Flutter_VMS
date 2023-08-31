// To parse this JSON data, do
//
//     final classDropdownModel = classDropdownModelFromJson(jsonString);

import 'dart:convert';

ClassDropdownModel? classDropdownModelFromJson(String str) =>
    ClassDropdownModel.fromJson(json.decode(str));

String classDropdownModelToJson(ClassDropdownModel? data) =>
    json.encode(data!.toJson());

class ClassDropdownModel {
  ClassDropdownModel({
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
    this.ctlist,
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
  Ctlist? ctlist;
  num? emgRId;
  num? saveupdatecount;
  num? lastdateentry;
  bool? lastdateentryflag;
  num? emsSId;
  num? emsEId;
  num? lastdateexam;
  bool? lastdateexamflag;

  factory ClassDropdownModel.fromJson(Map<String, dynamic> json) =>
      ClassDropdownModel(
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
        ctlist: Ctlist.fromJson(json["ctlist"]),
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
        "ctlist": ctlist!.toJson(),
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

class Ctlist {
  Ctlist({
    this.type,
    this.values,
  });

  String? type;
  List<CtlistValue?>? values;

  factory Ctlist.fromJson(Map<String, dynamic> json) => Ctlist(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<CtlistValue?>.from(
                json["\$values"]!.map((x) => CtlistValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class CtlistValue {
  CtlistValue({
    this.asmcLId,
    this.asmcLClassName,
    this.asmcLOrder,
    this.mIId,
    this.asmcLMinAgeYear,
    this.asmcLMinAgeMonth,
    this.asmcLMinAgeDays,
    this.asmcLMaxAgeYear,
    this.asmcLMaxAgeMonth,
    this.asmcLMaxAgeDays,
    this.asmcLMaxCapacity,
    this.asmcLActiveFlag,
    this.asmcLPreadmFlag,
    this.createdDate,
    this.updatedDate,
  });

  num? asmcLId;
  String? asmcLClassName;
  num? asmcLOrder;
  num? mIId;
  num? asmcLMinAgeYear;
  num? asmcLMinAgeMonth;
  num? asmcLMinAgeDays;
  num? asmcLMaxAgeYear;
  num? asmcLMaxAgeMonth;
  num? asmcLMaxAgeDays;
  num? asmcLMaxCapacity;
  bool? asmcLActiveFlag;
  num? asmcLPreadmFlag;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory CtlistValue.fromJson(Map<String, dynamic> json) => CtlistValue(
        asmcLId: json["asmcL_Id"],
        asmcLClassName: json["asmcL_ClassName"],
        asmcLOrder: json["asmcL_Order"],
        mIId: json["mI_Id"],
        asmcLMinAgeYear: json["asmcL_MinAgeYear"],
        asmcLMinAgeMonth: json["asmcL_MinAgeMonth"],
        asmcLMinAgeDays: json["asmcL_MinAgeDays"],
        asmcLMaxAgeYear: json["asmcL_MaxAgeYear"],
        asmcLMaxAgeMonth: json["asmcL_MaxAgeMonth"],
        asmcLMaxAgeDays: json["asmcL_MaxAgeDays"],
        asmcLMaxCapacity: json["asmcL_MaxCapacity"],
        asmcLActiveFlag: json["asmcL_ActiveFlag"],
        asmcLPreadmFlag: json["asmcL_PreadmFlag"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "asmcL_Id": asmcLId,
        "asmcL_ClassName": asmcLClassName,
        "asmcL_Order": asmcLOrder,
        "mI_Id": mIId,
        "asmcL_MinAgeYear": asmcLMinAgeYear,
        "asmcL_MinAgeMonth": asmcLMinAgeMonth,
        "asmcL_MinAgeDays": asmcLMinAgeDays,
        "asmcL_MaxAgeYear": asmcLMaxAgeYear,
        "asmcL_MaxAgeMonth": asmcLMaxAgeMonth,
        "asmcL_MaxAgeDays": asmcLMaxAgeDays,
        "asmcL_MaxCapacity": asmcLMaxCapacity,
        "asmcL_ActiveFlag": asmcLActiveFlag,
        "asmcL_PreadmFlag": asmcLPreadmFlag,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}
