// ignore_for_file: public_member_api_docs, sort_constructors_first

class SalaryGraphDetModel {
  final double salary;
  final String month;
  final String type;
  SalaryGraphDetModel({
    required this.salary,
    required this.month,
    required this.type,
  });

  SalaryGraphDetModel copyWith({
    double? salary,
    String? month,
    String? type,
  }) {
    return SalaryGraphDetModel(
      salary: salary ?? this.salary,
      month: month ?? this.month,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'salary': salary,
      'month': month,
    };
  }

  // factory SalaryGraphDetModel.fromMap(Map<String, dynamic> map) {
  //   return SalaryGraphDetModel(
  //     salary: map['salary'] as double,
  //     month: map['month'] as String,

  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory SalaryGraphDetModel.fromJson(String source) =>
  //     SalaryGraphDetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'SalaryGraphDetModel(salary: $salary, month: $month)';

  // @override
  // bool operator ==(covariant SalaryGraphDetModel other) {
  //   if (identical(this, other)) return true;

  //   return other.salary == salary && other.month == month;
  // }

  // @override
  // int get hashCode => salary.hashCode ^ month.hashCode;
}
