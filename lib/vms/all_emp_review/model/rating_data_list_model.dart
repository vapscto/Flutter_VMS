class RatingDataListModel {
  String? type;
  List<RatingDataListModelValues>? values;

  RatingDataListModel({this.type, this.values});

  RatingDataListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RatingDataListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RatingDataListModelValues.fromJson(v));
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

class RatingDataListModelValues {
  String? type;
  String? empName;
  String? rATMQERatingQuestions;
  dynamic january;
  dynamic february;
  dynamic march;
  dynamic april;
  dynamic may;
  dynamic june;
  dynamic july;
  dynamic august;
  dynamic september;
  dynamic october;
  dynamic november;
  dynamic december;
  dynamic totalRating;
  dynamic rATMQEId;
  dynamic hRMEId;
  dynamic overallAvg;
  dynamic totalAverage;

  RatingDataListModelValues(
      {this.type,
      this.empName,
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
      this.hRMEId,
      this.overallAvg,
      this.totalAverage});

  RatingDataListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    empName = json['EmpName'];
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
    overallAvg = json['overallAvg'];
    totalAverage = json['totalAverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['EmpName'] = empName;
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
    data['November'] = november;
    data['December'] = december;
    data['TotalRating'] = totalRating;
    data['RATMQE_Id'] = rATMQEId;
    data['HRME_Id'] = hRMEId;
    data['overallAvg'] = overallAvg;
    data['totalAverage'] = totalAverage;
    return data;
  }
}
