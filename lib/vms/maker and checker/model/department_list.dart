class DepartmentModelList {
  String? type;
  List<DepartmentModelListValues>? values;

  DepartmentModelList({this.type, this.values});

  DepartmentModelList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DepartmentModelListValues>[];
      json['\$values'].forEach((v) {
        values!.add(new DepartmentModelListValues.fromJson(v));
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

class DepartmentModelListValues {
  String? type;
  String? hRMDCName;
  int? hRMDCID;

  DepartmentModelListValues({this.type, this.hRMDCName, this.hRMDCID});

  DepartmentModelListValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    hRMDCName = json['HRMDC_Name'];
    hRMDCID = json['HRMDC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['HRMDC_Name'] = this.hRMDCName;
    data['HRMDC_ID'] = this.hRMDCID;
    return data;
  }
}
