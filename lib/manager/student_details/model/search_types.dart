// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class SearchTypes {
  SearchTypes.init();
  static final SearchTypes instance = SearchTypes.init();

  List<SearchTypeModel> getTypes = [
    SearchTypeModel.fromMap(
      {
        "value": "AMST_FirstName",
        "name": "FirstName",
        "keyboardType": TextInputType.name,
      },
    ),
    SearchTypeModel.fromMap({
      "value": "AMST_MiddleName",
      "name": "MiddleName",
      "keyboardType": TextInputType.name,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_LastName",
      "name": "LastName",
      "keyboardType": TextInputType.name,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_RegistrationNo",
      "name": "RegNo",
      "keyboardType": TextInputType.text,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_AdmNo",
      "name": "AdmissionNo",
      "keyboardType": TextInputType.number,
    }),
    SearchTypeModel.fromMap({
      "value": "PASR_Age",
      "name": "Age",
      "keyboardType": TextInputType.number,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_AadharNo",
      "name": "AadharNo",
      "keyboardType": TextInputType.number,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_MobileNo",
      "name": "MobileNo",
      "keyboardType": TextInputType.number,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_Sex",
      "name": "Sex",
      "keyboardType": TextInputType.text,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_Date",
      "name": "Date",
      "keyboardType": TextInputType.datetime,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_emailId",
      "name": "Email id",
      "keyboardType": TextInputType.emailAddress,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_FatherName",
      "name": "Father Name",
      "keyboardType": TextInputType.name,
    }),
    SearchTypeModel.fromMap({
      "value": "AMST_MotherName",
      "name": "Mother Name",
      "keyboardType": TextInputType.name,
    }),
    SearchTypeModel.fromMap({
      "value": "StudentName",
      "name": "Student Name",
      "keyboardType": TextInputType.name,
    }),
    SearchTypeModel.fromMap({
      "value": "ASMCL_ClassName",
      "name": "Class",
      "keyboardType": TextInputType.name,
    }),
    SearchTypeModel.fromMap({
      "value": "ASMC_SectionName",
      "name": "Section",
      "keyboardType": TextInputType.name,
    })
  ];

  List<OperatorConditionModel> operators = [
    OperatorConditionModel.fromMap({
      "value": "=",
      "name": "Equal to",
    }),
    OperatorConditionModel.fromMap({
      "value": "!=",
      "name": "Not Equal to",
    }),
    OperatorConditionModel.fromMap({
      "value": "like",
      "name": "Like",
    }),
    OperatorConditionModel.fromMap({
      "value": ">",
      "name": "Greater than",
    }),
    OperatorConditionModel.fromMap({
      "value": "<",
      "name": "Less than",
    })
  ];

  List<OperatorConditionModel> conditions = [
    OperatorConditionModel.fromMap({
      "value": "AND",
      "name": "AND",
    }),
    OperatorConditionModel.fromMap({
      "value": "OR",
      "name": "OR",
    })
  ];
}

class SearchTypeModel {
  final String name;
  final String value;
  final TextInputType keyboardType;
  SearchTypeModel({
    required this.name,
    required this.value,
    required this.keyboardType,
  });

  SearchTypeModel copyWith({
    String? name,
    String? value,
    TextInputType? keyboardType,
  }) {
    return SearchTypeModel(
      name: name ?? this.name,
      value: value ?? this.value,
      keyboardType: keyboardType ?? this.keyboardType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'keyboardType': keyboardType,
    };
  }

  factory SearchTypeModel.fromMap(Map<String, dynamic> map) {
    return SearchTypeModel(
      name: map['name'] as String,
      value: map['value'] as String,
      keyboardType: map['keyboardType'] as TextInputType,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchTypeModel.fromJson(String source) =>
      SearchTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SearchTypeModel(name: $name, value: $value, keyboardType: $keyboardType)';

  @override
  bool operator ==(covariant SearchTypeModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.value == value &&
        other.keyboardType == keyboardType;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ keyboardType.hashCode;
}

class OperatorConditionModel {
  final String value;
  final String name;
  OperatorConditionModel({
    required this.value,
    required this.name,
  });

  OperatorConditionModel copyWith({
    String? value,
    String? name,
  }) {
    return OperatorConditionModel(
      value: value ?? this.value,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'name': name,
    };
  }

  factory OperatorConditionModel.fromMap(Map<String, dynamic> map) {
    return OperatorConditionModel(
      value: map['value'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OperatorConditionModel.fromJson(String source) =>
      OperatorConditionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OperatorConditionModel(value: $value, name: $name)';

  @override
  bool operator ==(covariant OperatorConditionModel other) {
    if (identical(this, other)) return true;

    return other.value == value && other.name == name;
  }

  @override
  int get hashCode => value.hashCode ^ name.hashCode;
}
