class TaskDeviationModel {
  String? type;
  List<TaskDeviationModelValues>? values;

  TaskDeviationModel({this.type, this.values});

  TaskDeviationModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TaskDeviationModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TaskDeviationModelValues.fromJson(v));
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

class TaskDeviationModelValues {
  String? type;
  int? hRMEId;
  double? deviationPercentage;

  TaskDeviationModelValues({this.type, this.hRMEId, this.deviationPercentage});

  TaskDeviationModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    deviationPercentage = json['Deviation_Percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['Deviation_Percentage'] = deviationPercentage;
    return data;
  }
}
