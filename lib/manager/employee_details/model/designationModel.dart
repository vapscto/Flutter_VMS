// To parse this JSON data, do
//
//     final designationModel = designationModelFromJson(jsonString);

import 'dart:convert';

DesignationModel designationModelFromJson(String str) =>
    DesignationModel.fromJson(json.decode(str));

String designationModelToJson(DesignationModel data) =>
    json.encode(data.toJson());

class DesignationModel {
  DesignationModel({
    this.filldesignation,
  });

  Filldesignation? filldesignation;

  factory DesignationModel.fromJson(Map<String, dynamic> json) =>
      DesignationModel(
        filldesignation: Filldesignation.fromJson(json["filldesignation"]),
      );

  Map<String, dynamic> toJson() => {
        "filldesignation": filldesignation!.toJson(),
      };
}

class Filldesignation {
  Filldesignation({
    this.type,
    this.values,
  });

  String? type;
  List<FilldesignationValue?>? values;

  factory Filldesignation.fromJson(Map<String, dynamic> json) =>
      Filldesignation(
        type: json["\$type"],
        values: List<FilldesignationValue>.from(
            json["\$values"].map((x) => FilldesignationValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class FilldesignationValue {
  FilldesignationValue({
    this.mIId,
    this.hrmDId,
    this.hrmdeSId,
    this.hrmdeSDesignationName,
    this.hrmEId,
  });

  int? mIId;
  int? hrmDId;
  int? hrmdeSId;
  String? hrmdeSDesignationName;
  int? hrmEId;

  factory FilldesignationValue.fromJson(Map<String, dynamic> json) =>
      FilldesignationValue(
        mIId: json["mI_Id"],
        hrmDId: json["hrmD_Id"],
        hrmdeSId: json["hrmdeS_Id"],
        hrmdeSDesignationName: json["hrmdeS_DesignationName"],
        hrmEId: json["hrmE_Id"],
      );

  Map<String, dynamic> toJson() => {
        "mI_Id": mIId,
        "hrmD_Id": hrmDId,
        "hrmdeS_Id": hrmdeSId,
        "hrmdeS_DesignationName": hrmdeSDesignationName,
        "hrmE_Id": hrmEId,
      };
}
