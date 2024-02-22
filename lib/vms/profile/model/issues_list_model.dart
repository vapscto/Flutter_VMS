class TaskIssuesListModel {
  String? type;
  List<TaskIssuesListModelValues>? values;

  TaskIssuesListModel({this.type, this.values});

  TaskIssuesListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TaskIssuesListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TaskIssuesListModelValues.fromJson(v));
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

class TaskIssuesListModelValues {
  String? type;
  int? iSMTCRId;
  String? iSMTCRTitle;
  String? iSMTCRDesc;
  String? iSMTCRTaskNo;
  String? iSMTCRASTOStartDate;
  String? iSMTCRASTOEndDate;
  int? totaldeviation;
  String? createdBy;
  String? assignedBy;

  TaskIssuesListModelValues(
      {this.type,
      this.iSMTCRId,
      this.iSMTCRTitle,
      this.iSMTCRDesc,
      this.iSMTCRTaskNo,
      this.iSMTCRASTOStartDate,
      this.iSMTCRASTOEndDate,
      this.totaldeviation,
      this.createdBy,
      this.assignedBy});

  TaskIssuesListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTCRId = json['ISMTCR_Id'];
    iSMTCRTitle = json['ISMTCR_Title'];
    iSMTCRDesc = json['ISMTCR_Desc'];
    iSMTCRTaskNo = json['ISMTCR_TaskNo'];
    iSMTCRASTOStartDate = json['ISMTCRASTO_StartDate'];
    iSMTCRASTOEndDate = json['ISMTCRASTO_EndDate'];
    totaldeviation = json['totaldeviation'];
    createdBy = json['CreatedBy'];
    assignedBy = json['AssignedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMTCR_Id'] = iSMTCRId;
    data['ISMTCR_Title'] = iSMTCRTitle;
    data['ISMTCR_Desc'] = iSMTCRDesc;
    data['ISMTCR_TaskNo'] = iSMTCRTaskNo;
    data['ISMTCRASTO_StartDate'] = iSMTCRASTOStartDate;
    data['ISMTCRASTO_EndDate'] = iSMTCRASTOEndDate;
    data['totaldeviation'] = totaldeviation;
    data['CreatedBy'] = createdBy;
    data['AssignedBy'] = assignedBy;
    return data;
  }
}
