class ClassTeacherListModel {
  String? type;
  List<ClassTeacherListModelValues>? values;

  ClassTeacherListModel({this.type, this.values});

  ClassTeacherListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClassTeacherListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ClassTeacherListModelValues.fromJson(v));
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

class ClassTeacherListModelValues {
  String? type;
  int? aSALUId;
  String? iVRMSTAULUserName;
  String? aSMCLClassName;
  String? aSMCSectionName;
  int? aSALUCId;
  int? aSALUCSId;
  String? pAMSSubjectName;
  int? aSMCLOrder;
  int? aSMCOrder;

  ClassTeacherListModelValues(
      {this.type,
      this.aSALUId,
      this.iVRMSTAULUserName,
      this.aSMCLClassName,
      this.aSMCSectionName,
      this.aSALUCId,
      this.aSALUCSId,
      this.pAMSSubjectName,
      this.aSMCLOrder,
      this.aSMCOrder});

  ClassTeacherListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    aSALUId = json['ASALU_Id'];
    iVRMSTAULUserName = json['IVRMSTAUL_UserName'];
    aSMCLClassName = json['ASMCL_ClassName'];
    aSMCSectionName = json['ASMC_SectionName'];
    aSALUCId = json['ASALUC_Id'];
    aSALUCSId = json['ASALUCS_Id'];
    pAMSSubjectName = json['PAMS_SubjectName'];
    aSMCLOrder = json['ASMCL_Order'];
    aSMCOrder = json['ASMC_Order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['ASALU_Id'] = this.aSALUId;
    data['IVRMSTAUL_UserName'] = this.iVRMSTAULUserName;
    data['ASMCL_ClassName'] = this.aSMCLClassName;
    data['ASMC_SectionName'] = this.aSMCSectionName;
    data['ASALUC_Id'] = this.aSALUCId;
    data['ASALUCS_Id'] = this.aSALUCSId;
    data['PAMS_SubjectName'] = this.pAMSSubjectName;
    data['ASMCL_Order'] = this.aSMCLOrder;
    data['ASMC_Order'] = this.aSMCOrder;
    return data;
  }
}
