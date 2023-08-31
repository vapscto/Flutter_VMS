// To parse this JSON data, do
//
//     final studentAttendanceDetailModel = studentAttendanceDetailModelFromJson(jsonString);

import 'dart:convert';

StudentAttendanceDetailModel studentAttendanceDetailModelFromJson(String str) =>
    StudentAttendanceDetailModel.fromJson(json.decode(str));

String studentAttendanceDetailModelToJson(StudentAttendanceDetailModel data) =>
    json.encode(data.toJson());

class StudentAttendanceDetailModel {
  StudentAttendanceDetailModel({
    this.studentAttendanceList,
  });

  StudentAttendanceList? studentAttendanceList;

  factory StudentAttendanceDetailModel.fromJson(Map<String, dynamic> json) =>
      StudentAttendanceDetailModel(
        studentAttendanceList:
            StudentAttendanceList.fromJson(json["studentAttendanceList"]),
      );

  Map<String, dynamic> toJson() => {
        "studentAttendanceList": studentAttendanceList!.toJson(),
      };
}

class StudentAttendanceList {
  StudentAttendanceList({
    this.type,
    this.values,
  });

  String? type;
  List<StudentAttendanceListValue?>? values;

  factory StudentAttendanceList.fromJson(Map<String, dynamic> json) =>
      StudentAttendanceList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<StudentAttendanceListValue?>.from(json["\$values"]
                .map((x) => StudentAttendanceListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class StudentAttendanceListValue {
  StudentAttendanceListValue({
    this.type,
    this.amstId,
    this.name,
    this.amstAdmNo,
    this.amayRollNo,
    this.asaClassHeld,
    this.asaClassAttended,
    this.percentage,
  });

  String? type;
  int? amstId;
  String? name;
  String? amstAdmNo;
  int? amayRollNo;
  double? asaClassHeld;
  double? asaClassAttended;
  double? percentage;

  factory StudentAttendanceListValue.fromJson(Map<String, dynamic> json) =>
      StudentAttendanceListValue(
        type: json["\$type"],
        amstId: json["AMST_Id"],
        name: json["name"],
        amstAdmNo: json["AMST_AdmNo"],
        amayRollNo: json["AMAY_RollNo"],
        asaClassHeld: json["ASA_ClassHeld"],
        asaClassAttended: json["ASA_Class_Attended"],
        percentage: json["Percentage"],
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "AMST_Id": amstId,
        "name": name,
        "AMST_AdmNo": amstAdmNo,
        "AMAY_RollNo": amayRollNo,
        "ASA_ClassHeld": asaClassHeld,
        "ASA_Class_Attended": asaClassAttended,
        "Percentage": percentage,
      };
}
