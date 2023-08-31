// To parse this JSON data, do
//
//     final employeDetailsModel = employeDetailsModelFromJson(jsonString);

import 'dart:convert';

EmployeDetailsModel employeDetailsModelFromJson(String str) =>
    EmployeDetailsModel.fromJson(json.decode(str));

String employeDetailsModelToJson(EmployeDetailsModel data) =>
    json.encode(data.toJson());

class EmployeDetailsModel {
  EmployeDetailsModel({
    this.employeeDetailsfromDatabase,
  });

  EmployeeDetails? employeeDetailsfromDatabase;

  factory EmployeDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployeDetailsModel(
        employeeDetailsfromDatabase:
            EmployeeDetails.fromJson(json["employeeDetailsfromDatabase"]),
      );

  Map<String, dynamic> toJson() => {
        "employeeDetailsfromDatabase": employeeDetailsfromDatabase!.toJson(),
      };
}

class EmployeeDetails {
  EmployeeDetails({
    this.type,
    this.values,
  });

  String? type;
  List<EmployeeDetailsValue?>? values;

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<EmployeeDetailsValue?>.from(
                json["\$values"].map((x) => EmployeeDetailsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class EmployeeDetailsValue {
  EmployeeDetailsValue({
    this.type,
    this.hrmeFatherName,
    this.hrmeEmployeeCode,
    this.hrmeEmployeeFirstName,
    this.hrmeMobileNo,
    this.hrmeEmailId,
    this.hrmeDob,
    this.hrmeAmount,
    this.hrmeDoj,
    this.hrmeExpectedRetirementDate,
    this.hrmePerStreet,
    this.hrmePhoto,
  });

  String? type;
  String? hrmeFatherName;
  String? hrmeEmployeeCode;
  String? hrmeEmployeeFirstName;
  String? hrmeMobileNo;
  String? hrmeEmailId;
  String? hrmeDob;
  String? hrmePhoto;
  String? hrmeDoj;
  String? hrmeExpectedRetirementDate;
  String? hrmePerStreet;
  String? hrmeAmount;

  factory EmployeeDetailsValue.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsValue(
        type: json["\$type"],
        hrmeFatherName: json["HRME_FatherName"] ?? "N/A",
        hrmeEmployeeCode: json["HRME_EmployeeCode"] ?? "N/A",
        hrmeEmployeeFirstName: json["HRME_EmployeeFirstName"] ?? "N/A",
        hrmeMobileNo: json["HRME_MobileNo"] ?? "N/A",
        hrmeEmailId: json["HRME_EmailId"] ?? "N/A",
        hrmeDob: json["HRME_DOB"] ?? "N/A",
        hrmePhoto: json["HRME_Photo"] ?? "N/A",
        hrmeDoj: json["HRME_DOJ"] ?? "N/A",
        hrmeExpectedRetirementDate:
            json["HRME_ExpectedRetirementDate"] ?? "N/A",
        hrmePerStreet: json["HRME_PerStreet"] ?? "N/A",
        hrmeAmount: json["HREED_Amount"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "HRME_FatherName": hrmeFatherName,
        "HRME_EmployeeCode": hrmeEmployeeCode,
        "HRME_EmployeeFirstName": hrmeEmployeeFirstName,
        "HRME_MobileNo": hrmeMobileNo,
        "HRME_EmailId": hrmeEmailId,
        "HRME_DOB": hrmeDob,
      };
}
