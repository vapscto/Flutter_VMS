// To parse this JSON data, do
//
//     final attendanceEntryRecordModel = attendanceEntryRecordModelFromJson(jsonString);

import 'dart:convert';

AttendanceEntryRecordModel attendanceEntryRecordModelFromJson(String str) =>
    AttendanceEntryRecordModel.fromJson(json.decode(str));

String attendanceEntryRecordModelToJson(AttendanceEntryRecordModel data) =>
    json.encode(data.toJson());

class AttendanceEntryRecordModel {
  AttendanceEntryRecordModel({
    this.viewStudentPeriodWiseAttDetails,
  });

  ViewStudentPeriodWiseAttDetails? viewStudentPeriodWiseAttDetails;

  factory AttendanceEntryRecordModel.fromJson(Map<String, dynamic> json) =>
      AttendanceEntryRecordModel(
        viewStudentPeriodWiseAttDetails:
            ViewStudentPeriodWiseAttDetails.fromJson(
                json["viewStudentPeriodWiseAttDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "viewStudentPeriodWiseAttDetails":
            viewStudentPeriodWiseAttDetails!.toJson(),
      };
}

class ViewStudentPeriodWiseAttDetails {
  ViewStudentPeriodWiseAttDetails({
    this.type,
    this.values,
  });

  String? type;
  List<ViewStudentPeriodWiseAttDetailsValue?>? values;

  factory ViewStudentPeriodWiseAttDetails.fromJson(Map<String, dynamic> json) =>
      ViewStudentPeriodWiseAttDetails(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<ViewStudentPeriodWiseAttDetailsValue?>.from(json["\$values"]
                .map((x) => ViewStudentPeriodWiseAttDetailsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class ViewStudentPeriodWiseAttDetailsValue {
  ViewStudentPeriodWiseAttDetailsValue({
    this.type,
    this.asaId,
    this.asmayYear,
    this.asmclClassName,
    this.asmcSectionName,
    this.asaFromdate,
    this.asaEntryDateTime,
    this.employeename,
    this.asmclOrder,
    this.asmcOrder,
    this.asaFRomdateTemp,
    this.deleteFlag,
    this.subjectName,
    this.periodName,
  });

  String? type;
  int? asaId;
  String? asmayYear;
  String? asmclClassName;
  String? asmcSectionName;
  String? asaFromdate;
  String? asaEntryDateTime;
  String? employeename;
  int? asmclOrder;
  int? asmcOrder;
  DateTime? asaFRomdateTemp;
  int? deleteFlag;
  String? subjectName;
  String? periodName;

  factory ViewStudentPeriodWiseAttDetailsValue.fromJson(
          Map<String, dynamic> json) =>
      ViewStudentPeriodWiseAttDetailsValue(
        type: json["\$type"],
        asaId: json["ASA_Id"],
        asmayYear: json["ASMAY_Year"],
        asmclClassName: json["ASMCL_ClassName"],
        asmcSectionName: json["ASMC_SectionName"],
        asaFromdate: json["ASA_FROMDATE"],
        asaEntryDateTime: json["ASA_Entry_DateTime"],
        employeename: json["EMPLOYEENAME"],
        asmclOrder: json["ASMCL_Order"],
        asmcOrder: json["ASMC_Order"],
        asaFRomdateTemp: DateTime.parse(json["ASA_fROMDATETemp"]),
        deleteFlag: json["DELETE_FLAG"],
        subjectName: json["ISMS_SUBJECTNAME"],
        periodName: json["TTMP_PeriodName"],
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "ASA_Id": asaId,
        "ASMAY_Year": asmayYear,
        "ASMCL_ClassName": asmclClassName,
        "ASMC_SectionName": asmcSectionName,
        "ASA_FROMDATE": asaFromdate,
        "ASA_Entry_DateTime": asaEntryDateTime,
        "EMPLOYEENAME": employeename,
        "ASMCL_Order": asmclOrder,
        "ASMC_Order": asmcOrder,
        "ASA_fROMDATETemp": asaFRomdateTemp!.toIso8601String(),
        "DELETE_FLAG": deleteFlag,
        "ISMS_SUBJECTNAME": subjectName,
        "TTMP_PeriodName": periodName,
      };
}
