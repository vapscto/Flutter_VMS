class NoticeDataModel {
  String? type;
  List<NoticeDataModelValues>? values;

  NoticeDataModel({this.type, this.values});

  NoticeDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NoticeDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NoticeDataModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NoticeDataModelValues {
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

  NoticeDataModelValues({
    this.type,
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
    this.iNTBFLFilePath,
  });

  NoticeDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
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
    data['\$type'] = type;
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
