// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:m_skool_flutter/staffs/salary_details/models/salary_detail_monthwise_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/salary_details_graph_model.dart';

class SalaryModel {
  final List<SalaryDetailsGraphValues> graphValues;
  final List<SalaryDetailsMonthwiseValues> monthwiseValues;
  SalaryModel({
    required this.graphValues,
    required this.monthwiseValues,
  });

  SalaryModel copyWith({
    List<SalaryDetailsGraphValues>? graphValues,
    List<SalaryDetailsMonthwiseValues>? monthwiseValues,
  }) {
    return SalaryModel(
      graphValues: graphValues ?? this.graphValues,
      monthwiseValues: monthwiseValues ?? this.monthwiseValues,
    );
  }
}
