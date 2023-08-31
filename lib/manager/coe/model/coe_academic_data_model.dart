class CoeAcademicDataModel {
  String? type;
  List<CoeAcademicDataModelValues>? values;

  CoeAcademicDataModel({this.type, this.values});

  CoeAcademicDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CoeAcademicDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CoeAcademicDataModelValues.fromJson(v));
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

class CoeAcademicDataModelValues {
  int? hrmlYId;
  int? mIId;
  String? hrmlYLeaveYear;
  String? hrmlYFromDate;
  String? hrmlYToDate;
  bool? hrmlYActiveFlag;
  int? roleId;
  String? asmaYFromDate;
  String? asmaYToDate;
  int? hrmlYLeaveYearOrder;

  CoeAcademicDataModelValues(
      {this.hrmlYId,
      this.mIId,
      this.hrmlYLeaveYear,
      this.hrmlYFromDate,
      this.hrmlYToDate,
      this.hrmlYActiveFlag,
      this.roleId,
      this.asmaYFromDate,
      this.asmaYToDate,
      this.hrmlYLeaveYearOrder});

  CoeAcademicDataModelValues.fromJson(Map<String, dynamic> json) {
    hrmlYId = json['hrmlY_Id'];
    mIId = json['mI_Id'];
    hrmlYLeaveYear = json['hrmlY_LeaveYear'];
    hrmlYFromDate = json['hrmlY_FromDate'];
    hrmlYToDate = json['hrmlY_ToDate'];
    hrmlYActiveFlag = json['hrmlY_ActiveFlag'];
    roleId = json['roleId'];
    asmaYFromDate = json['asmaY_From_Date'];
    asmaYToDate = json['asmaY_To_Date'];
    hrmlYLeaveYearOrder = json['hrmlY_LeaveYearOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmlY_Id'] = hrmlYId;
    data['mI_Id'] = mIId;
    data['hrmlY_LeaveYear'] = hrmlYLeaveYear;
    data['hrmlY_FromDate'] = hrmlYFromDate;
    data['hrmlY_ToDate'] = hrmlYToDate;
    data['hrmlY_ActiveFlag'] = hrmlYActiveFlag;
    data['roleId'] = roleId;
    data['asmaY_From_Date'] = asmaYFromDate;
    data['asmaY_To_Date'] = asmaYToDate;
    data['hrmlY_LeaveYearOrder'] = hrmlYLeaveYearOrder;
    return data;
  }
}
