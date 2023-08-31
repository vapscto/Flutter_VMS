class NoticeStudentDetailsModel {
  String? type;
  List<NoticeStudentDetailsModelValues>? values;

  NoticeStudentDetailsModel({this.type, this.values});

  NoticeStudentDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NoticeStudentDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NoticeStudentDetailsModelValues.fromJson(v));
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

class NoticeStudentDetailsModelValues {
  String? type;
  int? amsTId;
  String? studentname;

  NoticeStudentDetailsModelValues({this.type, this.amsTId, this.studentname});

  NoticeStudentDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    amsTId = json['amsT_Id'];
    studentname = json['studentname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['amsT_Id'] = amsTId;
    data['studentname'] = studentname;
    return data;
  }
}
