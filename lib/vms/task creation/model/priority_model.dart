class GetPriorityModel {
  String? type;
  List<GetPriorityModelValues>? values;

  GetPriorityModel({this.type, this.values});

  GetPriorityModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetPriorityModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetPriorityModelValues.fromJson(v));
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

class GetPriorityModelValues {
  int? hrmpRId;
  int? mIId;
  String? hrmPName;
  int? hrmPOrder;
  bool? hrmPActiveFlag;
  int? hrmPCreatedBy;
  int? hrmPUpdatedBy;
  String? createdDate;
  String? updatedDate;

  GetPriorityModelValues(
      {this.hrmpRId,
      this.mIId,
      this.hrmPName,
      this.hrmPOrder,
      this.hrmPActiveFlag,
      this.hrmPCreatedBy,
      this.hrmPUpdatedBy,
      this.createdDate,
      this.updatedDate});

  GetPriorityModelValues.fromJson(Map<String, dynamic> json) {
    hrmpRId = json['hrmpR_Id'];
    mIId = json['mI_Id'];
    hrmPName = json['hrmP_Name'];
    hrmPOrder = json['hrmP_Order'];
    hrmPActiveFlag = json['hrmP_ActiveFlag'];
    hrmPCreatedBy = json['hrmP_CreatedBy'];
    hrmPUpdatedBy = json['hrmP_UpdatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmpR_Id'] = hrmpRId;
    data['mI_Id'] = mIId;
    data['hrmP_Name'] = hrmPName;
    data['hrmP_Order'] = hrmPOrder;
    data['hrmP_ActiveFlag'] = hrmPActiveFlag;
    data['hrmP_CreatedBy'] = hrmPCreatedBy;
    data['hrmP_UpdatedBy'] = hrmPUpdatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
