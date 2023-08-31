class AcademicYearFeeDtlModel {
  String? type;
  List<AcademicYearFeeDtlModelValues>? values;

  AcademicYearFeeDtlModel({this.type, this.values});

  AcademicYearFeeDtlModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AcademicYearFeeDtlModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AcademicYearFeeDtlModelValues.fromJson(v));
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

class AcademicYearFeeDtlModelValues {
  String? type;
  int? aSMAYId;
  String? aSMAYYear;
  double? fSSNetAmount;
  double? fSSConcessionAmount;
  double? fSSFineAmount;
  double? fSSToBePaid;
  double? fSSPaidAmount;

  AcademicYearFeeDtlModelValues(
      {this.type,
      this.aSMAYId,
      this.aSMAYYear,
      this.fSSNetAmount,
      this.fSSConcessionAmount,
      this.fSSFineAmount,
      this.fSSToBePaid,
      this.fSSPaidAmount});

  AcademicYearFeeDtlModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aSMAYId = json['ASMAY_Id'];
    aSMAYYear = json['ASMAY_Year'];
    fSSNetAmount = json['FSS_NetAmount'] + 0.0;
    fSSConcessionAmount = json['FSS_ConcessionAmount'] + 0.0;
    fSSFineAmount = json['FSS_FineAmount'] + 0.0;
    fSSToBePaid = json['FSS_ToBePaid'] + 0.0;
    fSSPaidAmount = json['FSS_PaidAmount'] + 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['ASMAY_Id'] = aSMAYId;
    data['ASMAY_Year'] = aSMAYYear;
    data['FSS_NetAmount'] = fSSNetAmount;
    data['FSS_ConcessionAmount'] = fSSConcessionAmount;
    data['FSS_FineAmount'] = fSSFineAmount;
    data['FSS_ToBePaid'] = fSSToBePaid;
    data['FSS_PaidAmount'] = fSSPaidAmount;
    return data;
  }
}
