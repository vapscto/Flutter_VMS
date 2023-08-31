/// classteacher : {"\$type":"System.Object[], System.Private.CoreLib","\$values":[{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":1475,"emp_name":"PRATIMRUDRA"}]}
/// sujectteachers : {"\$type":"System.Object[], System.Private.CoreLib","\$values":[{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":446,"emp_name":"EDWIN SARAVANAN","ISMS_SubjectName":"ECONOMICS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":446,"emp_name":"EDWIN SARAVANAN","ISMS_SubjectName":"BUSINESS STUDIES"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":467,"emp_name":"PRASHANTHWESLEY","ISMS_SubjectName":"ACCOUNTANCY"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":1475,"emp_name":"PRATIMRUDRA","ISMS_SubjectName":"DATA ENTRY OPERATIONS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":1690,"emp_name":"INDRAKSHISHYAMCHOUDHURY","ISMS_SubjectName":"SOCIAL_SCIENCE"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":174,"emp_name":"MARY CHRISTINA","ISMS_SubjectName":"ENGLISH_202"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"ECONOMICS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"ENGLISH_202"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"ACCOUNTANCY"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"BUSINESS STUDIES"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"DATA ENTRY OPERATIONS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"SOCIAL_SCIENCE"}]}

class StudentProfileDetailsModel {
  StudentProfileDetailsModel({
    this.classteacher,
    this.sujectteachers,
  });

  StudentProfileDetailsModel.fromJson(dynamic json) {
    classteacher = json['classteacher'] != null
        ? Classteacher.fromJson(json['classteacher'])
        : null;
    sujectteachers = json['sujectteachers'] != null
        ? Sujectteachers.fromJson(json['sujectteachers'])
        : null;
  }
  Classteacher? classteacher;
  Sujectteachers? sujectteachers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (classteacher != null) {
      map['classteacher'] = classteacher?.toJson();
    }
    if (sujectteachers != null) {
      map['sujectteachers'] = sujectteachers?.toJson();
    }
    return map;
  }
}

/// \$type : "System.Object[], System.Private.CoreLib"
/// \$values : [{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":446,"emp_name":"EDWIN SARAVANAN","ISMS_SubjectName":"ECONOMICS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":446,"emp_name":"EDWIN SARAVANAN","ISMS_SubjectName":"BUSINESS STUDIES"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":467,"emp_name":"PRASHANTHWESLEY","ISMS_SubjectName":"ACCOUNTANCY"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":1475,"emp_name":"PRATIMRUDRA","ISMS_SubjectName":"DATA ENTRY OPERATIONS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":1690,"emp_name":"INDRAKSHISHYAMCHOUDHURY","ISMS_SubjectName":"SOCIAL_SCIENCE"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":174,"emp_name":"MARY CHRISTINA","ISMS_SubjectName":"ENGLISH_202"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"ECONOMICS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"ENGLISH_202"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"ACCOUNTANCY"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"BUSINESS STUDIES"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"DATA ENTRY OPERATIONS"},{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":895,"emp_name":"BBHSss","ISMS_SubjectName":"SOCIAL_SCIENCE"}]

class Sujectteachers {
  Sujectteachers({
    this.type,
    this.values,
  });

  Sujectteachers.fromJson(dynamic json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = [];
      json['\$values'].forEach((v) {
        values?.add(SujectteachersValues.fromJson(v));
      });
    }
  }
  String? type;
  List<SujectteachersValues>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['\$type'] = type;
    if (values != null) {
      map['\$values'] = values?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// \$type : "System.Dynamic.ExpandoObject, System.Linq.Expressions"
/// HRME_Id : 446
/// emp_name : "EDWIN SARAVANAN"
/// ISMS_SubjectName : "ECONOMICS"

class SujectteachersValues {
  SujectteachersValues({
    this.type,
    this.hRMEId,
    this.empName,
    this.iSMSSubjectName,
    this.subjectTeacher,
  });

  SujectteachersValues.fromJson(dynamic json) {
    type = json['\$type'];
    hRMEId = json['HRME_Id'];
    empName = json['emp_name'];
    iSMSSubjectName = json['ISMS_SubjectName'];
    subjectTeacher = json['SubjectTeacher'];
  }
  String? type;
  num? hRMEId;
  String? empName;
  String? iSMSSubjectName;
  String? subjectTeacher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['\$type'] = type;
    map['HRME_Id'] = hRMEId;
    map['emp_name'] = empName;
    map['ISMS_SubjectName'] = iSMSSubjectName;
    map['SubjectTeacher'] = subjectTeacher;
    return map;
  }
}

/// \$type : "System.Object[], System.Private.CoreLib"
/// \$values : [{"\$type":"System.Dynamic.ExpandoObject, System.Linq.Expressions","HRME_Id":1475,"emp_name":"PRATIMRUDRA"}]

class Classteacher {
  Classteacher({
    this.type,
    this.values,
  });

  Classteacher.fromJson(dynamic json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = [];
      json['\$values'].forEach((v) {
        values?.add(ClassteacherValues.fromJson(v));
      });
    }
  }
  String? type;
  List<ClassteacherValues>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['\$type'] = type;
    if (values != null) {
      map['\$values'] = values?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// \$type : "System.Dynamic.ExpandoObject, System.Linq.Expressions"
/// HRME_Id : 1475
/// emp_name : "PRATIMRUDRA"

class ClassteacherValues {
  ClassteacherValues({
    this.type,
    this.hRMEId,
    this.empName,
    this.classTeacher,
  });

  ClassteacherValues.fromJson(dynamic json) {
    type = json['\$type'];
    hRMEId = json['HRME_Id'];
    empName = json['emp_name'];
    classTeacher = json['ClassTeacher'];
  }
  String? type;
  num? hRMEId;
  String? empName;
  String? classTeacher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['\$type'] = type;
    map['HRME_Id'] = hRMEId;
    map['emp_name'] = empName;
    map['ClassTeacher'] = classTeacher;
    return map;
  }
}
