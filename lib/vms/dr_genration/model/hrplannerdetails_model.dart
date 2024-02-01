class Hrplannerdetails {
  String? type;
  List<HrplannerdetailsValues>? values;

  Hrplannerdetails({this.type, this.values});

  Hrplannerdetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HrplannerdetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(HrplannerdetailsValues.fromJson(v));
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

class HrplannerdetailsValues {
  String? type;
  int? hRPDSDId;
  int? hRPLMGId;
  String? hRPDSDDate;
  String? hRPDSDPlannerName;
  String? hRPDSDPlannerDetails;
  String? hRPDSDPlannerContent;
  String? hRPDSDRepeatFlag;
  String? hRPDSDDueDate;
  String? hRPDSDCreatedDate;
  String? hRPDSDUpdatedDate;
  String? hRPDSDEmail;
  String? hRPLMGReminderFlag;

  HrplannerdetailsValues(
      {this.type,
      this.hRPDSDId,
      this.hRPLMGId,
      this.hRPDSDDate,
      this.hRPDSDPlannerName,
      this.hRPDSDPlannerDetails,
      this.hRPDSDPlannerContent,
      this.hRPDSDRepeatFlag,
      this.hRPDSDDueDate,
      this.hRPDSDCreatedDate,
      this.hRPDSDUpdatedDate,
      this.hRPDSDEmail,
      this.hRPLMGReminderFlag});

  HrplannerdetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRPDSDId = json['HRPDSD_Id'];
    hRPLMGId = json['HRPLMG_Id'];
    hRPDSDDate = json['HRPDSD_Date'];
    hRPDSDPlannerName = json['HRPDSD_PlannerName'];
    hRPDSDPlannerDetails = json['HRPDSD_PlannerDetails'];
    hRPDSDPlannerContent = json['HRPDSD_PlannerContent'];
    hRPDSDRepeatFlag = json['HRPDSD_RepeatFlag'];
    hRPDSDDueDate = json['HRPDSD_DueDate'];
    hRPDSDCreatedDate = json['HRPDSD_CreatedDate'];
    hRPDSDUpdatedDate = json['HRPDSD_UpdatedDate'];
    hRPDSDEmail = json['HRPDSD_Email'];
    hRPLMGReminderFlag = json['HRPLMG_ReminderFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRPDSD_Id'] = hRPDSDId;
    data['HRPLMG_Id'] = hRPLMGId;
    data['HRPDSD_Date'] = hRPDSDDate;
    data['HRPDSD_PlannerName'] = hRPDSDPlannerName;
    data['HRPDSD_PlannerDetails'] = hRPDSDPlannerDetails;
    data['HRPDSD_PlannerContent'] = hRPDSDPlannerContent;
    data['HRPDSD_RepeatFlag'] = hRPDSDRepeatFlag;
    data['HRPDSD_DueDate'] = hRPDSDDueDate;
    data['HRPDSD_CreatedDate'] = hRPDSDCreatedDate;
    data['HRPDSD_UpdatedDate'] = hRPDSDUpdatedDate;
    data['HRPDSD_Email'] = hRPDSDEmail;
    data['HRPLMG_ReminderFlag'] = hRPLMGReminderFlag;
    return data;
  }
}
