// To parse this JSON data, do
//
//     final overallFeeDetailModel = overallFeeDetailModelFromJson(jsonString);

import 'dart:convert';

OverallFeeDetailModel overallFeeDetailModelFromJson(String str) =>
    OverallFeeDetailModel.fromJson(json.decode(str));

String overallFeeDetailModelToJson(OverallFeeDetailModel data) =>
    json.encode(data.toJson());

class OverallFeeDetailModel {
  OverallFeeDetailModel({
    this.managerdashFeetotal,
  });

  OverallFeeDetail? managerdashFeetotal;

  factory OverallFeeDetailModel.fromJson(Map<String, dynamic> json) =>
      OverallFeeDetailModel(
        managerdashFeetotal:
            OverallFeeDetail.fromJson(json["managerdashFeetotal"]),
      );

  Map<String, dynamic> toJson() => {
        "managerdashFeetotal": managerdashFeetotal!.toJson(),
      };
}

class OverallFeeDetail {
  OverallFeeDetail({
    this.type,
    this.values,
  });

  String? type;
  List<OverallFeeDetailValue?>? values;

  factory OverallFeeDetail.fromJson(Map<String, dynamic> json) =>
      OverallFeeDetail(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<OverallFeeDetailValue?>.from(
                json["\$values"].map((x) => OverallFeeDetailValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class OverallFeeDetailValue {
  OverallFeeDetailValue({
    // this.type,
    this.asmayYear,
    this.asmayId,
    this.fssPaidAmount,
    this.balance,
    this.concession,
    this.fssCurrentYrCharges,
  });

  // String? type;
  String? asmayYear;
  num? asmayId;
  num? fssPaidAmount;
  num? balance;
  num? concession;
  num? fssCurrentYrCharges;

  factory OverallFeeDetailValue.fromJson(Map<String, dynamic> json) =>
      OverallFeeDetailValue(
        // type: json["\$type"],
        asmayYear: json["ASMAY_Year"] ?? 'N/A',
        asmayId: json["ASMAY_Id"] ?? 0.0,
        fssPaidAmount: json["FSS_PaidAmount"] ?? 0.0,
        balance: json["balance"] ?? 0.0,
        concession: json["concession"] ?? 0.0,
        fssCurrentYrCharges: json["FSS_CurrentYrCharges"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        // "\$type": type,
        "ASMAY_Year": asmayYear,
        "ASMAY_Id": asmayId,
        "FSS_PaidAmount": fssPaidAmount,
        "balance": balance,
        "concession": concession,
        "FSS_CurrentYrCharges": fssCurrentYrCharges,
      };
}
