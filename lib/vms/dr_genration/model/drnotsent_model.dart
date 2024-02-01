class Getdrnotsentdetails {
  String? type;
  List<GetdrnotsentdetailsValues>? values;

  Getdrnotsentdetails({this.type, this.values});

  Getdrnotsentdetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetdrnotsentdetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetdrnotsentdetailsValues.fromJson(v));
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

class GetdrnotsentdetailsValues {
  String? type;
  String? fromDate;
  String? remarks;

  GetdrnotsentdetailsValues({this.type, this.fromDate, this.remarks});

  GetdrnotsentdetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    fromDate = json['FromDate'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['FromDate'] = fromDate;
    data['Remarks'] = remarks;
    return data;
  }
}
