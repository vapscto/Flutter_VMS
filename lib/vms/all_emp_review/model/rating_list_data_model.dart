class RatingListData {
  String? type;
  List<RatingListDataValues>? values;

  RatingListData({this.type, this.values});

  RatingListData.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RatingListDataValues>[];
      json['\$values'].forEach((v) {
        values!.add(RatingListDataValues.fromJson(v));
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

class RatingListDataValues {
  String? type;
  String? employeeName;
  String? rating;

  RatingListDataValues({this.type, this.employeeName, this.rating});

  RatingListDataValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    employeeName = json['EmployeeName'];
    rating = json['Rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['EmployeeName'] = employeeName;
    data['Rating'] = rating;
    return data;
  }
}
