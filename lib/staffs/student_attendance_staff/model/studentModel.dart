// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.studentAttendanceList,
  });

  StudentList? studentAttendanceList;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        studentAttendanceList:
            StudentList.fromJson(json["studentAttendanceList"]),
      );

  Map<String, dynamic> toJson() => {
        "studentAttendanceList": studentAttendanceList!.toJson(),
      };
}

class StudentList {
  StudentList({
    this.type,
    this.values,
  });

  String? type;
  List<StudentListValue?>? values;

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<StudentListValue>.from(
                json["\$values"].map((x) => StudentListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class StudentListValue {
  StudentListValue({
    this.type,
    this.amstId,
    this.name,
    this.amstAdmNo,
  });

  String? type;
  int? amstId;
  String? name;
  String? amstAdmNo;

  factory StudentListValue.fromJson(Map<String, dynamic> json) =>
      StudentListValue(
        type: json["\$type"],
        amstId: json["AMST_Id"],
        name: json["name"],
        amstAdmNo: json["AMST_AdmNo"],
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "AMST_Id": amstId,
        "name": name,
        "AMST_AdmNo": amstAdmNo,
      };
}
