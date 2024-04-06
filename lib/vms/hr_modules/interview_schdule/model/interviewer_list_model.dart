class InterviewerListModel {
  String? type;
  List<InterviewerListModelValues>? values;

  InterviewerListModel({this.type, this.values});

  InterviewerListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <InterviewerListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(InterviewerListModelValues.fromJson(v));
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

class InterviewerListModelValues {
  int? hrcisCId;
  int? hrcDId;
  int? mIId;
  String? hrcisCInterviewDateTime;
  bool? hrcisCActiveFlg;
  int? hrcisCCreatedBy;
  int? hrcisCUpdatedBy;
  int? hrcisCInterviewer;
  bool? hrcisCNotifyEmail;
  bool? hrcisCNotifySMS;
  String? entryDate;
  String? fromdate;
  String? todate;
  int? id;
  int? hrmEId;
  String? hrmEEmployeeFirstName;
  String? hrmEEmployeeMiddleName;
  String? hrmEEmployeeLastName;
  int? ivrmuLId;
  String? hrciSDatetime;
  int? userId;

  InterviewerListModelValues(
      {this.hrcisCId,
      this.hrcDId,
      this.mIId,
      this.hrcisCInterviewDateTime,
      this.hrcisCActiveFlg,
      this.hrcisCCreatedBy,
      this.hrcisCUpdatedBy,
      this.hrcisCInterviewer,
      this.hrcisCNotifyEmail,
      this.hrcisCNotifySMS,
      this.entryDate,
      this.fromdate,
      this.todate,
      this.id,
      this.hrmEId,
      this.hrmEEmployeeFirstName,
      this.hrmEEmployeeMiddleName,
      this.hrmEEmployeeLastName,
      this.ivrmuLId,
      this.hrciSDatetime,
      this.userId});

  InterviewerListModelValues.fromJson(Map<String, dynamic> json) {
    hrcisCId = json['hrcisC_Id'];
    hrcDId = json['hrcD_Id'];
    mIId = json['mI_Id'];
    hrcisCInterviewDateTime = json['hrcisC_InterviewDateTime'];
    hrcisCActiveFlg = json['hrcisC_ActiveFlg'];
    hrcisCCreatedBy = json['hrcisC_CreatedBy'];
    hrcisCUpdatedBy = json['hrcisC_UpdatedBy'];
    hrcisCInterviewer = json['hrcisC_Interviewer'];
    hrcisCNotifyEmail = json['hrcisC_NotifyEmail'];
    hrcisCNotifySMS = json['hrcisC_NotifySMS'];
    entryDate = json['entry_Date'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    id = json['id'];
    hrmEId = json['hrmE_Id'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    hrmEEmployeeMiddleName = json['hrmE_EmployeeMiddleName'];
    hrmEEmployeeLastName = json['hrmE_EmployeeLastName'];
    ivrmuLId = json['ivrmuL_Id'];
    hrciSDatetime = json['hrciS_Datetime'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrcisC_Id'] = hrcisCId;
    data['hrcD_Id'] = hrcDId;
    data['mI_Id'] = mIId;
    data['hrcisC_InterviewDateTime'] = hrcisCInterviewDateTime;
    data['hrcisC_ActiveFlg'] = hrcisCActiveFlg;
    data['hrcisC_CreatedBy'] = hrcisCCreatedBy;
    data['hrcisC_UpdatedBy'] = hrcisCUpdatedBy;
    data['hrcisC_Interviewer'] = hrcisCInterviewer;
    data['hrcisC_NotifyEmail'] = hrcisCNotifyEmail;
    data['hrcisC_NotifySMS'] = hrcisCNotifySMS;
    data['entry_Date'] = entryDate;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['id'] = id;
    data['hrmE_Id'] = hrmEId;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['hrmE_EmployeeMiddleName'] = hrmEEmployeeMiddleName;
    data['hrmE_EmployeeLastName'] = hrmEEmployeeLastName;
    data['ivrmuL_Id'] = ivrmuLId;
    data['hrciS_Datetime'] = hrciSDatetime;
    data['userId'] = userId;
    return data;
  }
}
