class DeviationDetailsModel {
  String? type;
  List<DeviationDetailsModelValues>? values;

  DeviationDetailsModel({this.type, this.values});

  DeviationDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DeviationDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DeviationDetailsModelValues.fromJson(v));
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

class DeviationDetailsModelValues {
  String? type;
  int? iSMTPLId;
  int? hRMEId;
  String? iSMTPLPlannerName;
  String? employeename;
  String? iSMTPLStartDate;
  String? iSMTPLEndDate;
  String? totalEffort;
  String? completedEffort;
  String? notCompletedEffort;
  double? completedPercentage;
  double? deviationPercentage;

  DeviationDetailsModelValues(
      {this.type,
      this.iSMTPLId,
      this.hRMEId,
      this.iSMTPLPlannerName,
      this.employeename,
      this.iSMTPLStartDate,
      this.iSMTPLEndDate,
      this.totalEffort,
      this.completedEffort,
      this.notCompletedEffort,
      this.completedPercentage,
      this.deviationPercentage});

  DeviationDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTPLId = json['ISMTPL_Id'];
    hRMEId = json['HRME_Id'];
    iSMTPLPlannerName = json['ISMTPL_PlannerName'];
    employeename = json['employeename'];
    iSMTPLStartDate = json['ISMTPL_StartDate'];
    iSMTPLEndDate = json['ISMTPL_EndDate'];
    totalEffort = json['Total_Effort'];
    completedEffort = json['Completed_Effort'];
    notCompletedEffort = json['NotCompleted_Effort'];
    completedPercentage = json['Completed_Percentage'];
    deviationPercentage = json['Deviation_Percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMTPL_Id'] = iSMTPLId;
    data['HRME_Id'] = hRMEId;
    data['ISMTPL_PlannerName'] = iSMTPLPlannerName;
    data['employeename'] = employeename;
    data['ISMTPL_StartDate'] = iSMTPLStartDate;
    data['ISMTPL_EndDate'] = iSMTPLEndDate;
    data['Total_Effort'] = totalEffort;
    data['Completed_Effort'] = completedEffort;
    data['NotCompleted_Effort'] = notCompletedEffort;
    data['Completed_Percentage'] = completedPercentage;
    data['Deviation_Percentage'] = deviationPercentage;
    return data;
  }
}
