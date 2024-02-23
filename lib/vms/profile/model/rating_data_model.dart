class RatingDataModel {
  String? type;
  List<RatingDataModelValues>? values;

  RatingDataModel({this.type, this.values});

  RatingDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RatingDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RatingDataModelValues.fromJson(v));
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

class RatingDataModelValues {
  String? type;
  double? overallRating;

  RatingDataModelValues({this.type, this.overallRating});

  RatingDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    overallRating = json['OverallRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['OverallRating'] = overallRating;
    return data;
  }
}
