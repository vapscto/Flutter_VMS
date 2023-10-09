class DesignationListModel {
  String? type;
  List<DesignationListModelValues>? values;

  DesignationListModel({this.type, this.values});

  DesignationListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DesignationListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DesignationListModelValues.fromJson(v));
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

class DesignationListModelValues {
  int? hrmdeSId;
  int? mIId;
  String? hrmdeSDesignationName;
  double? hrmdeSBasicAmount;
  int? hrmdeSSanctionedSeats;
  bool? hrmdeSDisplaySanctionedSeatsFlag;
  int? hrmdeSOrder;
  bool? hrmdeSActiveFlag;
  int? hrmdCID;
  String? createdDate;
  String? updatedDate;
  int? hrmdeSCreatedBy;
  int? hrmdeSUpdatedBy;

  DesignationListModelValues(
      {this.hrmdeSId,
      this.mIId,
      this.hrmdeSDesignationName,
      this.hrmdeSBasicAmount,
      this.hrmdeSSanctionedSeats,
      this.hrmdeSDisplaySanctionedSeatsFlag,
      this.hrmdeSOrder,
      this.hrmdeSActiveFlag,
      this.hrmdCID,
      this.createdDate,
      this.updatedDate,
      this.hrmdeSCreatedBy,
      this.hrmdeSUpdatedBy});

  DesignationListModelValues.fromJson(Map<String, dynamic> json) {
    hrmdeSId = json['hrmdeS_Id'];
    mIId = json['mI_Id'];
    hrmdeSDesignationName = json['hrmdeS_DesignationName'];
    hrmdeSBasicAmount = json['hrmdeS_BasicAmount'];
    hrmdeSSanctionedSeats = json['hrmdeS_SanctionedSeats'];
    hrmdeSDisplaySanctionedSeatsFlag =
        json['hrmdeS_DisplaySanctionedSeatsFlag'];
    hrmdeSOrder = json['hrmdeS_Order'];
    hrmdeSActiveFlag = json['hrmdeS_ActiveFlag'];
    hrmdCID = json['hrmdC_ID'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    hrmdeSCreatedBy = json['hrmdeS_CreatedBy'];
    hrmdeSUpdatedBy = json['hrmdeS_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmdeS_Id'] = hrmdeSId;
    data['mI_Id'] = mIId;
    data['hrmdeS_DesignationName'] = hrmdeSDesignationName;
    data['hrmdeS_BasicAmount'] = hrmdeSBasicAmount;
    data['hrmdeS_SanctionedSeats'] = hrmdeSSanctionedSeats;
    data['hrmdeS_DisplaySanctionedSeatsFlag'] =
        hrmdeSDisplaySanctionedSeatsFlag;
    data['hrmdeS_Order'] = hrmdeSOrder;
    data['hrmdeS_ActiveFlag'] = hrmdeSActiveFlag;
    data['hrmdC_ID'] = hrmdCID;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['hrmdeS_CreatedBy'] = hrmdeSCreatedBy;
    data['hrmdeS_UpdatedBy'] = hrmdeSUpdatedBy;
    return data;
  }
}
