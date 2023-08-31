class ViewNoticeFilterModel {
  String? type;
  List<ViewNoticeFilterModelValues>? values;

  ViewNoticeFilterModel({this.type, this.values});

  ViewNoticeFilterModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ViewNoticeFilterModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewNoticeFilterModelValues.fromJson(v));
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

class ViewNoticeFilterModelValues {
  String? type;
  int? intBId;
  String? intBTitle;
  String? intBDescription;
  String? ntBTTSylabusFlg;
  String? intBAttachment;
  String? intBFilePath;
  String? intBDisplayDate;
  String? intBStartDate;
  String? intBEndDate;
  int? asmcLId;
  int? filecount;
  String? iNTBFLFileName;
  String? iNTBFLFilePath;

  ViewNoticeFilterModelValues(
      {this.type,
      this.intBId,
      this.intBTitle,
      this.intBDescription,
      this.ntBTTSylabusFlg,
      this.intBAttachment,
      this.intBFilePath,
      this.intBDisplayDate,
      this.intBStartDate,
      this.intBEndDate,
      this.asmcLId,
      this.filecount,
      this.iNTBFLFileName,
      this.iNTBFLFilePath});

  ViewNoticeFilterModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    intBId = json['intB_Id'];
    intBTitle = json['intB_Title'];
    intBDescription = json['intB_Description'];
    ntBTTSylabusFlg = json['ntB_TTSylabusFlg'];
    intBAttachment = json['intB_Attachment'];
    intBFilePath = json['intB_FilePath'];
    intBDisplayDate = json['intB_DisplayDate'];
    intBStartDate = json['intB_StartDate'];
    intBEndDate = json['intB_EndDate'];
    asmcLId = json['asmcL_Id'];
    filecount = json['Filecount'];
    iNTBFLFileName = json['INTBFL_FileName'];
    iNTBFLFilePath = json['INTBFL_FilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['intB_Id'] = intBId;
    data['intB_Title'] = intBTitle;
    data['intB_Description'] = intBDescription;
    data['ntB_TTSylabusFlg'] = ntBTTSylabusFlg;
    data['intB_Attachment'] = intBAttachment;
    data['intB_FilePath'] = intBFilePath;
    data['intB_DisplayDate'] = intBDisplayDate;
    data['intB_StartDate'] = intBStartDate;
    data['intB_EndDate'] = intBEndDate;
    data['asmcL_Id'] = asmcLId;
    data['Filecount'] = filecount;
    data['INTBFL_FileName'] = iNTBFLFileName;
    data['INTBFL_FilePath'] = iNTBFLFilePath;
    return data;
  }
}
