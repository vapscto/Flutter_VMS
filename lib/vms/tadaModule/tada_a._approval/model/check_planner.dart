class CheckPlannerModel {
  String? type;
  List<CheckPlannerModelValues>? values;

  CheckPlannerModel({this.type, this.values});

  CheckPlannerModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CheckPlannerModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CheckPlannerModelValues.fromJson(v));
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

class CheckPlannerModelValues {
  String? type;
  int? counts;

  CheckPlannerModelValues({this.type, this.counts});

  CheckPlannerModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    counts = json['Counts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['Counts'] = counts;
    return data;
  }
}
