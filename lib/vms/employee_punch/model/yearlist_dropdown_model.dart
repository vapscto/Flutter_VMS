class YearListDorpdownModel {
  String? type;
  List<YearListDorpdownValues>? values;

  YearListDorpdownModel({this.type, this.values});

  YearListDorpdownModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <YearListDorpdownValues>[];
      json['\$values'].forEach((v) {
        values!.add(YearListDorpdownValues.fromJson(v));
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

class YearListDorpdownValues {
  int? hrmlYId;
  int? mIId;
  String? hrmlYLeaveYear;
  String? hrmlYFromDate;
  String? hrmlYToDate;
  bool? hrmlYActiveFlag;
  int? hrmlYLeaveYearOrder;
  String? createdDate;
  String? updatedDate;

  YearListDorpdownValues(
      {this.hrmlYId,
      this.mIId,
      this.hrmlYLeaveYear,
      this.hrmlYFromDate,
      this.hrmlYToDate,
      this.hrmlYActiveFlag,
      this.hrmlYLeaveYearOrder,
      this.createdDate,
      this.updatedDate});

  YearListDorpdownValues.fromJson(Map<String, dynamic> json) {
    hrmlYId = json['hrmlY_Id'];
    mIId = json['mI_Id'];
    hrmlYLeaveYear = json['hrmlY_LeaveYear'];
    hrmlYFromDate = json['hrmlY_FromDate'];
    hrmlYToDate = json['hrmlY_ToDate'];
    hrmlYActiveFlag = json['hrmlY_ActiveFlag'];
    hrmlYLeaveYearOrder = json['hrmlY_LeaveYearOrder'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
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
    return data;
  }
}
