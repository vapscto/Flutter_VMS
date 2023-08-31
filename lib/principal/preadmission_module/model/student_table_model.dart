class GetStudentTableData {
  String? type;
  List<GetStudentTableDataValues>? values;

  GetStudentTableData({this.type, this.values});

  GetStudentTableData.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetStudentTableDataValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetStudentTableDataValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetStudentTableDataValues {
  String? type;
  int? mIId;
  String? emailID;
  String? mobileno;
  String? fatherName;
  String? regDate;

  GetStudentTableDataValues(
      {this.type,
      this.mIId,
      this.emailID,
      this.mobileno,
      this.fatherName,
      this.regDate});

  GetStudentTableDataValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    emailID = json['EmailID'];
    mobileno = json['Mobileno'];
    fatherName = json['FatherName'];
    regDate = json['RegDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['$type'] = type;
    data['MI_Id'] = mIId;
    data['EmailID'] = emailID;
    data['Mobileno'] = mobileno;
    data['FatherName'] = fatherName;
    data['RegDate'] = regDate;
    return data;
  }
}
