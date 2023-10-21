class OpetionLeaveModel {
  String? type;
  List<OpetionLeaveModelValues>? values;

  OpetionLeaveModel({this.type, this.values});

  OpetionLeaveModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <OpetionLeaveModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new OpetionLeaveModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OpetionLeaveModelValues {
  String? type;
  String? fOMHWDDFromDate;
  String? fOMHWDDName;

  OpetionLeaveModelValues({this.type, this.fOMHWDDFromDate, this.fOMHWDDName});

  OpetionLeaveModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    fOMHWDDFromDate = json['FOMHWDD_FromDate'];
    fOMHWDDName = json['FOMHWDD_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['FOMHWDD_FromDate'] = this.fOMHWDDFromDate;
    data['FOMHWDD_Name'] = this.fOMHWDDName;
    return data;
  }
}
