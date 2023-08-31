class AcademicHistory {
  String? type;
  List<AcademicHistoryValues>? values;

  AcademicHistory({this.type, this.values});

  AcademicHistory.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AcademicHistoryValues>[];
      json['\$values'].forEach((v) {
        values!.add(AcademicHistoryValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AcademicHistoryValues {
  String? type;
  int? aMSTId;
  int? yearlyCharges;
  int? concession;
  int? payable;
  int? paidAmount;
  int? outstanding;
  String? classSection;
  int? aSMCLId;
  int? aSMSId;
  int? aSMAYId;
  String? asmayYear;

  AcademicHistoryValues(
      {this.type,
      this.aMSTId,
      this.yearlyCharges,
      this.concession,
      this.payable,
      this.paidAmount,
      this.outstanding,
      this.classSection,
      this.aSMCLId,
      this.aSMSId,
      this.aSMAYId,
      this.asmayYear});

  AcademicHistoryValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aMSTId = json['AMST_Id'];
    yearlyCharges = json['YearlyCharges'];
    concession = json['Concession'];
    payable = json['Payable'];
    paidAmount = json['PaidAmount'];
    outstanding = json['Outstanding'];
    classSection = json['ClassSection'];
    aSMCLId = json['ASMCL_Id'];
    aSMSId = json['ASMS_Id'];
    aSMAYId = json['ASMAY_Id'];
    asmayYear = json['asmay_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['AMST_Id'] = aMSTId;
    data['YearlyCharges'] = yearlyCharges;
    data['Concession'] = concession;
    data['Payable'] = payable;
    data['PaidAmount'] = paidAmount;
    data['Outstanding'] = outstanding;
    data['ClassSection'] = classSection;
    data['ASMCL_Id'] = aSMCLId;
    data['ASMS_Id'] = aSMSId;
    data['ASMAY_Id'] = aSMAYId;
    data['asmay_year'] = asmayYear;
    return data;
  }
}
