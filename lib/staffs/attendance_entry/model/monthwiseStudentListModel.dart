// To parse this JSON data, do
//
//     final monthWiseStudentListModel = monthWiseStudentListModelFromJson(jsonString);

import 'dart:convert';

MonthWiseStudentListModel monthWiseStudentListModelFromJson(String str) =>
    MonthWiseStudentListModel.fromJson(json.decode(str));

String monthWiseStudentListModelToJson(MonthWiseStudentListModel data) =>
    json.encode(data.toJson());

class MonthWiseStudentListModel {
  MonthWiseStudentListModel({
    this.asAId,
    this.studentList,
    this.countclass,
    this.countclass1,
    this.attendanceentryflag,
  });

  int? asAId;
  MonthWiseStudentList? studentList;
  double? countclass;
  String? attendanceentryflag;
  int? countclass1;

  factory MonthWiseStudentListModel.fromJson(Map<String, dynamic> json) =>
      MonthWiseStudentListModel(
        asAId: json["asA_Id"],
        studentList: MonthWiseStudentList.fromJson(json["studentList"]),
        countclass: json["countclass"],
        countclass1: json['countclass1'],
        attendanceentryflag: json['attendanceentryflag'],
      );

  Map<String, dynamic> toJson() => {
        "asA_Id": asAId,
        "studentList": studentList!.toJson(),
        "countclass": countclass,
        "countclass1": countclass1,
        "attendanceentryflag": attendanceentryflag,
      };
}

class MonthWiseStudentList {
  MonthWiseStudentList({
    this.type,
    this.values,
  });

  String? type;
  List<MonthWiseStudentListValue?>? values;

  factory MonthWiseStudentList.fromJson(Map<String, dynamic> json) =>
      MonthWiseStudentList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<MonthWiseStudentListValue?>.from(json["\$values"]
                .map((x) => MonthWiseStudentListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class MonthWiseStudentListValue {
  MonthWiseStudentListValue({
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

  factory MonthWiseStudentListValue.fromJson(Map<String, dynamic> json) =>
      MonthWiseStudentListValue(
        amaYRollNo: json["amaY_RollNo"],
        amsTAdmNo: json["amsT_AdmNo"],
        amsTId: json["amsT_Id"],
        studentname: json["studentname"],
        pdays: json["pdays"] ?? 0.0,
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
