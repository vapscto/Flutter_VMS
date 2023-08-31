class ViewNoticeModel {
  String? type;
  List<ViewNoticeModelValues>? values;

  ViewNoticeModel({this.type, this.values});

  ViewNoticeModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ViewNoticeModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewNoticeModelValues.fromJson(v));
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

class ViewNoticeModelValues {
  String? type;
  int? iNTBId;
  String? iNTBTitle;
  String? iNTBDescription;
  String? iNTBStartDate;
  String? iNTBEndDate;
  int? hRMEId;
  int? filecount;

  ViewNoticeModelValues(
      {this.type,
      this.iNTBId,
      this.iNTBTitle,
      this.iNTBDescription,
      this.iNTBStartDate,
      this.iNTBEndDate,
      this.hRMEId,
      this.filecount});

  ViewNoticeModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    iNTBId = json['INTB_Id'];
    iNTBTitle = json['INTB_Title'];
    iNTBDescription = json['INTB_Description'];
    iNTBStartDate = json['INTB_StartDate'];
    iNTBEndDate = json['INTB_EndDate'];
    hRMEId = json['HRME_Id'];
    filecount = json['Filecount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['INTB_Id'] = iNTBId;
    data['INTB_Title'] = iNTBTitle;
    data['INTB_Description'] = iNTBDescription;
    data['INTB_StartDate'] = iNTBStartDate;
    data['INTB_EndDate'] = iNTBEndDate;
    data['HRME_Id'] = hRMEId;
    data['Filecount'] = filecount;
    return data;
  }
}
