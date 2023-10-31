class DrstatusListModel {
  String? type;
  List<DrstatusListModelValues>? values;

  DrstatusListModel({this.type, this.values});

  DrstatusListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrstatusListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new DrstatusListModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismmistS_Id'] = this.ismmistSId;
    data['mI_Id'] = this.mIId;
    data['hrmD_Id'] = this.hrmDId;
    data['ismmistS_StatusName'] = this.ismmistSStatusName;
    data['ismmistS_StatusFlag'] = this.ismmistSStatusFlag;
    data['ismmistS_Order'] = this.ismmistSOrder;
    data['ismmistS_Color'] = this.ismmistSColor;
    data['ismmistS_ActiveFlag'] = this.ismmistSActiveFlag;
    data['ismmistS_CreatedBy'] = this.ismmistSCreatedBy;
    data['ismmistS_UpdatedBy'] = this.ismmistSUpdatedBy;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
