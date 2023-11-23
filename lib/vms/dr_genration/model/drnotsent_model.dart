class Getdrnotsentdetails {
  String? type;
  List<GetdrnotsentdetailsValues>? values;

  Getdrnotsentdetails({this.type, this.values});

  Getdrnotsentdetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetdrnotsentdetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetdrnotsentdetailsValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['FromDate'] = this.fromDate;
    data['Remarks'] = this.remarks;
    return data;
  }
}
