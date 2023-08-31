class CustomgGrplist {
  String? type;
  List<CustomgGrplistValues>? values;

  CustomgGrplist({this.type, this.values});

  CustomgGrplist.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CustomgGrplistValues>[];
      json['\$values'].forEach((v) {
        values!.add(CustomgGrplistValues.fromJson(v));
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

class CustomgGrplistValues {
  String? fmgGGroupName;
  int? fmgGId;

  CustomgGrplistValues({this.fmgGGroupName, this.fmgGId});

  CustomgGrplistValues.fromJson(Map<String, dynamic> json) {
    fmgGGroupName = json['fmgG_GroupName'];
    fmgGId = json['fmgG_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fmgG_GroupName'] = fmgGGroupName;
    data['fmgG_Id'] = fmgGId;
    return data;
  }
}
