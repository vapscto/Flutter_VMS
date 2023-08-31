// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:m_skool_flutter/staffs/salary_details/models/salary_deduction_mode.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/salary_earning_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/total_deduction_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/total_earning_model.dart';

class SplitSalaryModel {
  final TotalEarningModel totalEarningModel;
  final TotalDeductionModel totalDeductionModel;
  final SalaryDeductionModel salaryDeductionModel;
  final SalaryEarningModel salaryEarningModel;
  SplitSalaryModel({
    required this.totalEarningModel,
    required this.totalDeductionModel,
    required this.salaryDeductionModel,
    required this.salaryEarningModel,
  });

  SplitSalaryModel copyWith({
    TotalEarningModel? totalEarningModel,
    TotalDeductionModel? totalDeductionModel,
    SalaryDeductionModel? salaryDeductionModel,
    SalaryEarningModel? salaryEarningModel,
  }) {
    return SplitSalaryModel(
      totalEarningModel: totalEarningModel ?? this.totalEarningModel,
      totalDeductionModel: totalDeductionModel ?? this.totalDeductionModel,
      salaryDeductionModel: salaryDeductionModel ?? this.salaryDeductionModel,
      salaryEarningModel: salaryEarningModel ?? this.salaryEarningModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalEarningModel': totalEarningModel.toJson(),
      'totalDeductionModel': totalDeductionModel.toJson(),
      'salaryDeductionModel': salaryDeductionModel.toJson(),
      'salaryEarningModel': salaryEarningModel.toJson(),
    };
  }

  factory SplitSalaryModel.fromMap(Map<String, dynamic> map) {
    return SplitSalaryModel(
      totalEarningModel: TotalEarningModel.fromJson(
          map['totalEarningModel'] as Map<String, dynamic>),
      totalDeductionModel: TotalDeductionModel.fromJson(
          map['totalDeductionModel'] as Map<String, dynamic>),
      salaryDeductionModel: SalaryDeductionModel.fromJson(
          map['salaryDeductionModel'] as Map<String, dynamic>),
      salaryEarningModel: SalaryEarningModel.fromJson(
          map['salaryEarningModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SplitSalaryModel.fromJson(String source) =>
      SplitSalaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SplitSalaryModel(totalEarningModel: $totalEarningModel, totalDeductionModel: $totalDeductionModel, salaryDeductionModel: $salaryDeductionModel, salaryEarningModel: $salaryEarningModel)';
  }

  @override
  bool operator ==(covariant SplitSalaryModel other) {
    if (identical(this, other)) return true;

    return other.totalEarningModel == totalEarningModel &&
        other.totalDeductionModel == totalDeductionModel &&
        other.salaryDeductionModel == salaryDeductionModel &&
        other.salaryEarningModel == salaryEarningModel;
  }

  @override
  int get hashCode {
    return totalEarningModel.hashCode ^
        totalDeductionModel.hashCode ^
        salaryDeductionModel.hashCode ^
        salaryEarningModel.hashCode;
  }
}
