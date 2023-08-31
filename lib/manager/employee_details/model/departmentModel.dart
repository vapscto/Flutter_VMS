// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

DepartmentModel departmentModelFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String departmentModelToJson(DepartmentModel data) =>
    json.encode(data.toJson());

class DepartmentModel {
  DepartmentModel({
    this.filldepartment,
  });

  Filldepartment? filldepartment;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        filldepartment: Filldepartment.fromJson(json["filldepartment"]),
      );

  Map<String, dynamic> toJson() => {
        "filldepartment": filldepartment!.toJson(),
      };
}

class Filldepartment {
  Filldepartment({
    this.type,
    this.values,
  });

  String? type;
  List<FilldepartmentValue?>? values;

  factory Filldepartment.fromJson(Map<String, dynamic> json) => Filldepartment(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<FilldepartmentValue>.from(
                json["\$values"].map((x) => FilldepartmentValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class FilldepartmentValue {
  FilldepartmentValue({
    this.mIId,
    this.hrmDId,
    this.hrmDDepartmentName,
    this.hrmdeSId,
    this.hrmEId,
  });

  int? mIId;
  int? hrmDId;
  String? hrmDDepartmentName;
  int? hrmdeSId;
  int? hrmEId;

  factory FilldepartmentValue.fromJson(Map<String, dynamic> json) =>
      FilldepartmentValue(
        mIId: json["mI_Id"],
        hrmDId: json["hrmD_Id"],
        hrmDDepartmentName: json["hrmD_DepartmentName"],
        hrmdeSId: json["hrmdeS_Id"],
        hrmEId: json["hrmE_Id"],
      );

  Map<String, dynamic> toJson() => {
        "mI_Id": mIId,
        "hrmD_Id": hrmDId,
        "hrmD_DepartmentName": hrmDDepartmentName,
        "hrmdeS_Id": hrmdeSId,
        "hrmE_Id": hrmEId,
      };
}
