class ReportDataModel {
  String? type;
  List<ReportDataModelValues>? values;

  ReportDataModel({this.type, this.values});

  ReportDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ReportDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ReportDataModelValues.fromJson(v));
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

class ReportDataModelValues {
  String? type;
  String? empName;
  String? rATMTRatingTypeName;
  String? rATMQERatingQuestions;
  int? january;
  int? february;
  int? march;
  int? april;
  int? may;
  int? june;
  int? july;
  int? august;
  int? september;
  int? october;
  int? november;
  int? december;
  int? totalRating;
  int? rATMQEId;
  int? hRMEId;

  ReportDataModelValues(
      {this.type,
      this.empName,
      this.rATMTRatingTypeName,
      this.rATMQERatingQuestions,
      this.january,
      this.february,
      this.march,
      this.april,
      this.may,
      this.june,
      this.july,
      this.august,
      this.september,
      this.october,
      this.november,
      this.december,
      this.totalRating,
      this.rATMQEId,
      this.hRMEId});

  ReportDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    empName = json['EmpName'];
    rATMTRatingTypeName = json['RATMT_RatingTypeName'];
    rATMQERatingQuestions = json['RATMQE_RatingQuestions'];
    january = json['January'];
    february = json['February'];
    march = json['March'];
    april = json['April'];
    may = json['May'];
    june = json['June'];
    july = json['July'];
    august = json['August'];
    september = json['September'];
    october = json['October'];
    november = json['November'];
    december = json['December'];
    totalRating = json['TotalRating'];
    rATMQEId = json['RATMQE_Id'];
    hRMEId = json['HRME_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['EmpName'] = empName;
    data['RATMT_RatingTypeName'] = rATMTRatingTypeName;
    data['RATMQE_RatingQuestions'] = rATMQERatingQuestions;
    data['January'] = january;
    data['February'] = february;
    data['March'] = march;
    data['April'] = april;
    data['May'] = may;
    data['June'] = june;
    data['July'] = july;
    data['August'] = august;
    data['September'] = september;
    data['October'] = october;
    data['Novemver'] = november;
    data['December'] = december;
    data['TotalRating'] = totalRating;
    data['RATMQE_Id'] = rATMQEId;
    data['HRME_Id'] = hRMEId;
    return data;
  }
}
