// To parse this JSON data, do
//
//     final periodWiseStudentListModel = periodWiseStudentListModelFromJson(jsonString);

import 'dart:convert';

PeriodWiseStudentListModel periodWiseStudentListModelFromJson(String str) =>
    PeriodWiseStudentListModel.fromJson(json.decode(str));

String periodWiseStudentListModelToJson(PeriodWiseStudentListModel data) =>
    json.encode(data.toJson());

class PeriodWiseStudentListModel {
  PeriodWiseStudentListModel({
    this.attendanceEntryFlag,
    this.asaAttEntryType,
    this.asAId,
    this.studentList,
    this.countclass1,
  });
  String? attendanceEntryFlag;
  String? asaAttEntryType;
  int? asAId;
  int? countclass1;

  StudentList? studentList;

  factory PeriodWiseStudentListModel.fromJson(Map<String, dynamic> json) =>
      PeriodWiseStudentListModel(
        attendanceEntryFlag: json["attendanceentryflag"],
        asaAttEntryType: json["asA_Att_EntryType"],
        asAId: json["asA_Id"],
        studentList: StudentList.fromJson(json["studentList"]),
        countclass1: json["countclass1"],
      );

  Map<String, dynamic> toJson() => {
        "attendanceentryflag": attendanceEntryFlag,
        "asA_Att_EntryType": asaAttEntryType,
        "asA_Id": asAId,
        "studentList": studentList!.toJson(),
        "countclass1": countclass1,
      };
}

class StudentList {
  StudentList({
    this.type,
    this.values,
  });

  String? type;
  List<PeroidWiseStudentListValue?>? values;

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<PeroidWiseStudentListValue?>.from(json["\$values"]
                .map((x) => PeroidWiseStudentListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class PeroidWiseStudentListValue {
  PeroidWiseStudentListValue({
    this.amaYRollNo,
    this.amsTAdmNo,
    this.amsTId,
    this.studentname,
    this.pdays,
    this.asaSId,
    this.asAId,
    this.ismSId,
    this.asasBId,
    this.amsTRegistrationNo,
  });

  int? amaYRollNo;
  String? amsTAdmNo;
  int? amsTId;
  String? studentname;
  double? pdays;
  int? asaSId;
  int? asAId;
  int? ismSId;
  int? asasBId;
  String? amsTRegistrationNo;

  factory PeroidWiseStudentListValue.fromJson(Map<String, dynamic> json) =>
      PeroidWiseStudentListValue(
        amaYRollNo: json["amaY_RollNo"],
        amsTAdmNo: json["amsT_AdmNo"],
        amsTId: json["amsT_Id"],
        studentname: json["studentname"],
        pdays: json["pdays"] ?? 0.00,
        asaSId: json["asaS_Id"] ?? 0,
        asAId: json["asA_Id"],
        ismSId: json["ismS_Id"],
        asasBId: json["asasB_Id"],
        amsTRegistrationNo: json["amsT_RegistrationNo"],
      );

  Map<String, dynamic> toJson() => {
        "amaY_RollNo": amaYRollNo,
        "amsT_AdmNo": amsTAdmNo,
        "amsT_Id": amsTId,
        "studentname": studentname,
        "pdays": pdays,
        "asaS_Id": asaSId,
        "asA_Id": asAId,
        "ismS_Id": ismSId,
        "asasB_Id": asasBId,
        "amsT_RegistrationNo": amsTRegistrationNo,
      };
}
