class GetTourPlanDetails {
  String? type;
  List<GetTourPlanDetailsValues>? values;

  GetTourPlanDetails({this.type, this.values});

  GetTourPlanDetails.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <GetTourPlanDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetTourPlanDetailsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTourPlanDetailsValues {
  int? ieRID;
  int? ieREmpId;
  String? ieRPlanStartDate;
  String? ieRPlanEndDate;
  int? ieRCreatedby;
  String? ieRCreatedDate;
  int? ieRUpdateby;
  String? ieRUpdateDate;
  bool? isMActive;
  String? ieRPlanName;
  String? ieRRemarks;

  GetTourPlanDetailsValues(
      {this.ieRID,
      this.ieREmpId,
      this.ieRPlanStartDate,
      this.ieRPlanEndDate,
      this.ieRCreatedby,
      this.ieRCreatedDate,
      this.ieRUpdateby,
      this.ieRUpdateDate,
      this.isMActive,
      this.ieRPlanName,
      this.ieRRemarks});

  GetTourPlanDetailsValues.fromJson(Map<String, dynamic> json) {
    ieRID = json['ieR_ID'];
    ieREmpId = json['ieR_EmpId'];
    ieRPlanStartDate = json['ieR_Plan_StartDate'];
    ieRPlanEndDate = json['ieR_Plan_EndDate'];
    ieRCreatedby = json['ieR_Createdby'];
    ieRCreatedDate = json['ieR_CreatedDate'];
    ieRUpdateby = json['ieR_Updateby'];
    ieRUpdateDate = json['ieR_UpdateDate'];
    isMActive = json['isM_Active'];
    ieRPlanName = json['ieR_PlanName'];
    ieRRemarks = json['ieR_Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ieR_ID'] = ieRID;
    data['ieR_EmpId'] = ieREmpId;
    data['ieR_Plan_StartDate'] = ieRPlanStartDate;
    data['ieR_Plan_EndDate'] = ieRPlanEndDate;
    data['ieR_Createdby'] = ieRCreatedby;
    data['ieR_CreatedDate'] = ieRCreatedDate;
    data['ieR_Updateby'] = ieRUpdateby;
    data['ieR_UpdateDate'] = ieRUpdateDate;
    data['isM_Active'] = isMActive;
    data['ieR_PlanName'] = ieRPlanName;
    data['ieR_Remarks'] = ieRRemarks;
    return data;
  }
}
