// To parse this JSON data, do
//
//     final overallFeeAcademicYearModel = overallFeeAcademicYearModelFromJson(jsonString);

import 'dart:convert';

OverallFeeAcademicYearModel overallFeeAcademicYearModelFromJson(String str) =>
    OverallFeeAcademicYearModel.fromJson(json.decode(str));

String overallFeeAcademicYearModelToJson(OverallFeeAcademicYearModel data) =>
    json.encode(data.toJson());

class OverallFeeAcademicYearModel {
  OverallFeeAcademicYearModel({
    this.yearlist,
  });

  Yearlist? yearlist;

  factory OverallFeeAcademicYearModel.fromJson(Map<String, dynamic> json) =>
      OverallFeeAcademicYearModel(
        yearlist: Yearlist.fromJson(json["yearlist"]),
      );

  Map<String, dynamic> toJson() => {
        "yearlist": yearlist!.toJson(),
      };
}

class Yearlist {
  Yearlist({
    this.type,
    this.values,
  });

  String? type;
  List<YearlistValue?>? values;

  factory Yearlist.fromJson(Map<String, dynamic> json) => Yearlist(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<YearlistValue>.from(
                json["\$values"].map((x) => YearlistValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class YearlistValue {
  YearlistValue({
    this.asmaYId,
    this.mIId,
    this.asmaYYear,
    this.asmaYOrder,
    this.asmaYActiveFlag,
    this.asmaYPreActiveFlag,
    this.asmaYCreatedBy,
    this.asmaYUpdatedBy,
    this.asmaYAcademicYearCode,
  });

  int? asmaYId;
  int? mIId;
  String? asmaYYear;
  int? asmaYOrder;
  int? asmaYActiveFlag;
  int? asmaYPreActiveFlag;
  bool? isActive;
  bool? asmaYReggularFlg;
  bool? asmaYNewFlg;
  bool? asmaYNewAdmissionFlg;
  int? asmaYCreatedBy;
  int? asmaYUpdatedBy;
  String? asmaYAcademicYearCode;

  factory YearlistValue.fromJson(Map<String, dynamic> json) => YearlistValue(
        asmaYId: json["asmaY_Id"],
        mIId: json["mI_Id"],
        asmaYYear: json["asmaY_Year"],
        asmaYOrder: json["asmaY_Order"],
        asmaYActiveFlag: json["asmaY_ActiveFlag"],
        asmaYPreActiveFlag: json["asmaY_Pre_ActiveFlag"],
        asmaYCreatedBy: json["asmaY_CreatedBy"],
        asmaYUpdatedBy: json["asmaY_UpdatedBy"],
        asmaYAcademicYearCode: json["asmaY_AcademicYearCode"],
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Id": asmaYId,
        "mI_Id": mIId,
        "asmaY_Year": asmaYYear,
        "asmaY_Order": asmaYOrder,
        "asmaY_ActiveFlag": asmaYActiveFlag,
        "asmaY_Pre_ActiveFlag": asmaYPreActiveFlag,
        "is_Active": isActive,
        "asmaY_ReggularFlg": asmaYReggularFlg,
        "asmaY_NewFlg": asmaYNewFlg,
        "asmaY_NewAdmissionFlg": asmaYNewAdmissionFlg,
        "asmaY_CreatedBy": asmaYCreatedBy,
        "asmaY_UpdatedBy": asmaYUpdatedBy,
        "asmaY_AcademicYearCode": asmaYAcademicYearCode,
      };
}
