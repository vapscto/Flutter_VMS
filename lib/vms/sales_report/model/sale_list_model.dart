class SalesListModel {
  String? type;
  List<SalesListModelValues>? values;

  SalesListModel({this.type, this.values});

  SalesListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SalesListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SalesListModelValues.fromJson(v));
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

class SalesListModelValues {
  String? type;
  int? iSMSLEId;
  String? iSMSLELeadName;
  String? iSMSLECOMComments;
  String? iSMSLECOMCreatedDate;
  Null? iSMSLEFilePath;
  String? employeename;

  SalesListModelValues(
      {this.type,
      this.iSMSLEId,
      this.iSMSLELeadName,
      this.iSMSLECOMComments,
      this.iSMSLECOMCreatedDate,
      this.iSMSLEFilePath,
      this.employeename});

  SalesListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMSLEId = json['ISMSLE_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
    iSMSLECOMComments = json['ISMSLECOM_Comments'];
    iSMSLECOMCreatedDate = json['ISMSLECOM_CreatedDate'];
    iSMSLEFilePath = json['ISMSLE_FilePath'];
    employeename = json['employeename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMSLE_Id'] = iSMSLEId;
    data['ISMSLE_LeadName'] = iSMSLELeadName;
    data['ISMSLECOM_Comments'] = iSMSLECOMComments;
    data['ISMSLECOM_CreatedDate'] = iSMSLECOMCreatedDate;
    data['ISMSLE_FilePath'] = iSMSLEFilePath;
    data['employeename'] = employeename;
    return data;
  }
}
