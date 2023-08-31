// To parse this JSON data, do
//
//     final typeModel = typeModelFromJson(jsonString);

import 'dart:convert';

TypeModel typeModelFromJson(String str) => TypeModel.fromJson(json.decode(str));

String typeModelToJson(TypeModel data) => json.encode(data.toJson());

class TypeModel {
  TypeModel({
    this.filltypes,
  });

  Filltypes? filltypes;

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        filltypes: Filltypes.fromJson(json["filltypes"]),
      );

  Map<String, dynamic> toJson() => {
        "filltypes": filltypes!.toJson(),
      };
}

class Filltypes {
  Filltypes({
    this.type,
    this.values,
  });

  String? type;
  List<FilltypesValue?>? values;

  factory Filltypes.fromJson(Map<String, dynamic> json) => Filltypes(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<FilltypesValue>.from(
                json["\$values"].map((x) => FilltypesValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class FilltypesValue {
  FilltypesValue({
    this.hrmgTId,
    this.mIId,
    this.hrmgTEmployeeGroupType,
    this.hrmgTCode,
    this.hrmgTOrder,
    this.hrmgTActiveFlag,
    this.createdDate,
    this.updatedDate,
  });

  int? hrmgTId;
  int? mIId;
  String? hrmgTEmployeeGroupType;
  String? hrmgTCode;
  int? hrmgTOrder;
  bool? hrmgTActiveFlag;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory FilltypesValue.fromJson(Map<String, dynamic> json) => FilltypesValue(
        hrmgTId: json["hrmgT_Id"],
        mIId: json["mI_Id"],
        hrmgTEmployeeGroupType: json["hrmgT_EmployeeGroupType"],
        hrmgTCode: json["hrmgT_Code"],
        hrmgTOrder: json["hrmgT_Order"],
        hrmgTActiveFlag: json["hrmgT_ActiveFlag"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "hrmgT_Id": hrmgTId,
        "mI_Id": mIId,
        "hrmgT_EmployeeGroupType": hrmgTEmployeeGroupType,
        "hrmgT_Code": hrmgTCode,
        "hrmgT_Order": hrmgTOrder,
        "hrmgT_ActiveFlag": hrmgTActiveFlag,
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
      };
}
