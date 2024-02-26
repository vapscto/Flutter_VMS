class RatingYearModel {
  String? type;
  List<RatingYearModelValues>? values;

  RatingYearModel({this.type, this.values});

  RatingYearModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RatingYearModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RatingYearModelValues.fromJson(v));
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

class RatingYearModelValues {
  int? hrmlYId;
  int? mIId;
  String? hrmlYLeaveYear;
  String? hrmlYFromDate;
  String? hrmlYToDate;
  bool? hrmlYActiveFlag;
  int? hrmlYLeaveYearOrder;
  String? createdDate;
  String? updatedDate;
  int? hrmlYUpdatedBy;
  int? hrmlYCreatedBy;

  RatingYearModelValues(
      {this.hrmlYId,
      this.mIId,
      this.hrmlYLeaveYear,
      this.hrmlYFromDate,
      this.hrmlYToDate,
      this.hrmlYActiveFlag,
      this.hrmlYLeaveYearOrder,
      this.createdDate,
      this.updatedDate,
      this.hrmlYUpdatedBy,
      this.hrmlYCreatedBy});

  RatingYearModelValues.fromJson(Map<String, dynamic> json) {
    hrmlYId = json['hrmlY_Id'];
    mIId = json['mI_Id'];
    hrmlYLeaveYear = json['hrmlY_LeaveYear'];
    hrmlYFromDate = json['hrmlY_FromDate'];
    hrmlYToDate = json['hrmlY_ToDate'];
    hrmlYActiveFlag = json['hrmlY_ActiveFlag'];
    hrmlYLeaveYearOrder = json['hrmlY_LeaveYearOrder'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    hrmlYUpdatedBy = json['hrmlY_UpdatedBy'];
    hrmlYCreatedBy = json['hrmlY_CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmlY_Id'] = hrmlYId;
    data['mI_Id'] = mIId;
    data['hrmlY_LeaveYear'] = hrmlYLeaveYear;
    data['hrmlY_FromDate'] = hrmlYFromDate;
    data['hrmlY_ToDate'] = hrmlYToDate;
    data['hrmlY_ActiveFlag'] = hrmlYActiveFlag;
    data['hrmlY_LeaveYearOrder'] = hrmlYLeaveYearOrder;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['hrmlY_UpdatedBy'] = hrmlYUpdatedBy;
    data['hrmlY_CreatedBy'] = hrmlYCreatedBy;
    return data;
  }
}
