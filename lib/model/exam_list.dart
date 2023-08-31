class ExamListNew {
  String? type;
  List<ExamListNewValues>? values;

  ExamListNew({this.type, this.values});

  ExamListNew.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ExamListNewValues>[];
      json['\$values'].forEach((v) {
        values!.add(ExamListNewValues.fromJson(v));
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

class ExamListNewValues {
  String? type;
  int? eMEId;
  String? eMEExamName;
  int? eMEExamOrder;

  ExamListNewValues(
      {this.type, this.eMEId, this.eMEExamName, this.eMEExamOrder});

  ExamListNewValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    eMEId = json['EME_Id'];
    eMEExamName = json['EME_ExamName'];
    eMEExamOrder = json['EME_ExamOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['EME_Id'] = eMEId;
    data['EME_ExamName'] = eMEExamName;
    data['EME_ExamOrder'] = eMEExamOrder;
    return data;
  }
}
