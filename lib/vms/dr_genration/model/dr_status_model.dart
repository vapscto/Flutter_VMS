class DrstatusListModel {
  String? type;
  List<DrstatusListModelValues>? values;

  DrstatusListModel({this.type, this.values});

  DrstatusListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrstatusListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DrstatusListModelValues.fromJson(v));
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

class DrstatusListModelValues {
  int? ismmistSId;
  int? mIId;
  int? hrmDId;
  String? ismmistSStatusName;
  String? ismmistSStatusFlag;
  int? ismmistSOrder;
  String? ismmistSColor;
  bool? ismmistSActiveFlag;
  int? ismmistSCreatedBy;
  int? ismmistSUpdatedBy;
  String? createdDate;
  String? updatedDate;

  DrstatusListModelValues(
      {this.ismmistSId,
      this.mIId,
      this.hrmDId,
      this.ismmistSStatusName,
      this.ismmistSStatusFlag,
      this.ismmistSOrder,
      this.ismmistSColor,
      this.ismmistSActiveFlag,
      this.ismmistSCreatedBy,
      this.ismmistSUpdatedBy,
      this.createdDate,
      this.updatedDate});

  DrstatusListModelValues.fromJson(Map<String, dynamic> json) {
    ismmistSId = json['ismmistS_Id'];
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    ismmistSStatusName = json['ismmistS_StatusName'];
    ismmistSStatusFlag = json['ismmistS_StatusFlag'];
    ismmistSOrder = json['ismmistS_Order'];
    ismmistSColor = json['ismmistS_Color'];
    ismmistSActiveFlag = json['ismmistS_ActiveFlag'];
    ismmistSCreatedBy = json['ismmistS_CreatedBy'];
    ismmistSUpdatedBy = json['ismmistS_UpdatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismmistS_Id'] = ismmistSId;
    data['mI_Id'] = mIId;
    data['hrmD_Id'] = hrmDId;
    data['ismmistS_StatusName'] = ismmistSStatusName;
    data['ismmistS_StatusFlag'] = ismmistSStatusFlag;
    data['ismmistS_Order'] = ismmistSOrder;
    data['ismmistS_Color'] = ismmistSColor;
    data['ismmistS_ActiveFlag'] = ismmistSActiveFlag;
    data['ismmistS_CreatedBy'] = ismmistSCreatedBy;
    data['ismmistS_UpdatedBy'] = ismmistSUpdatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
