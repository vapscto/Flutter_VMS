class StudentBdayModel {
  String? type;
  List<StudentBdayModelValues>? values;

  StudentBdayModel({this.type, this.values});

  StudentBdayModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StudentBdayModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StudentBdayModelValues.fromJson(v));
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

class StudentBdayModelValues {
  String? type;
  int? aMSTId;
  String? studentname;
  String? classname;
  String? fathername;
  String? sectionname;
  String? admno;
  int? mobileno;
  String? emailid;
  String? amstDob;
  String? amstPhoto;
  String? stdaddress;
  String? perpincode;
  String? percountry;

  StudentBdayModelValues(
      {this.type,
      this.aMSTId,
      this.studentname,
      this.classname,
      this.fathername,
      this.sectionname,
      this.admno,
      this.mobileno,
      this.emailid,
      this.amstDob,
      this.amstPhoto,
      this.stdaddress,
      this.perpincode,
      this.percountry});

  StudentBdayModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    aMSTId = json['AMST_Id'];
    studentname = json['studentname'];
    classname = json['classname'];
    fathername = json['fathername'];
    sectionname = json['sectionname'];
    admno = json['admno'];
    mobileno = json['mobileno'];
    emailid = json['emailid'];
    amstDob = json['amst_dob'];
    amstPhoto = json['amst_photo'];
    stdaddress = json['stdaddress'].toString();
    perpincode = json['perpincode'].toString();
    percountry = json['percountry'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['AMST_Id'] = aMSTId;
    data['studentname'] = studentname;
    data['classname'] = classname;
    data['fathername'] = fathername;
    data['sectionname'] = sectionname;
    data['admno'] = admno;
    data['mobileno'] = mobileno;
    data['emailid'] = emailid;
    data['amst_dob'] = amstDob;
    data['amst_photo'] = amstPhoto;
    data['stdaddress'] = stdaddress;
    data['perpincode'] = perpincode;
    data['percountry'] = percountry;
    return data;
  }
}
