class StateListModel {
  String? type;
  List<StateListModelValues>? values;

  StateListModel({this.type, this.values});

  StateListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StateListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StateListModelValues.fromJson(v));
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

class StateListModelValues {
  int? ivrmmSId;
  String? ivrmmSName;
  String? ivrmmSCode;
  int? ivrmmCId;
  String? createdDate;
  String? updatedDate;

  StateListModelValues(
      {this.ivrmmSId,
      this.ivrmmSName,
      this.ivrmmSCode,
      this.ivrmmCId,
      this.createdDate,
      this.updatedDate});

  StateListModelValues.fromJson(Map<String, dynamic> json) {
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmSName = json['ivrmmS_Name'];
    ivrmmSCode = json['ivrmmS_Code'];
    ivrmmCId = json['ivrmmC_Id'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ivrmmS_Id'] = ivrmmSId;
    data['ivrmmS_Name'] = ivrmmSName;
    data['ivrmmS_Code'] = ivrmmSCode;
    data['ivrmmC_Id'] = ivrmmCId;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
