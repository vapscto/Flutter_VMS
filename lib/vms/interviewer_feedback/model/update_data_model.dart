class InterviewUPdateModel {
  String? type;
  List<InterviewUPdateModelValues>? values;

  InterviewUPdateModel({this.type, this.values});

  InterviewUPdateModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <InterviewUPdateModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(InterviewUPdateModelValues.fromJson(v));
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

class InterviewUPdateModelValues {
  int? hrcisCId;
  int? hrcDId;
  int? mIId;
  String? hrcisCInterviewRounds;
  String? hrcisCInterviewDateTime;
  String? hrcisCInterviewVenue;
  bool? hrcisCActiveFlg;
  int? hrcisCCreatedBy;
  int? hrcisCUpdatedBy;
  int? hrcisCInterviewer;
  bool? hrcisCNotifyEmail;
  bool? hrcisCNotifySMS;
  String? hrcDFullName;
  String? hrcDPhoto;
  String? hrcDResume;
  String? entryDate;
  String? fromdate;
  String? todate;
  int? id;
  int? hrmEId;
  int? ivrmuLId;
  String? hrciSDatetime;
  int? userId;

  InterviewUPdateModelValues(
      {this.hrcisCId,
      this.hrcDId,
      this.mIId,
      this.hrcisCInterviewRounds,
      this.hrcisCInterviewDateTime,
      this.hrcisCInterviewVenue,
      this.hrcisCActiveFlg,
      this.hrcisCCreatedBy,
      this.hrcisCUpdatedBy,
      this.hrcisCInterviewer,
      this.hrcisCNotifyEmail,
      this.hrcisCNotifySMS,
      this.hrcDFullName,
      this.hrcDPhoto,
      this.hrcDResume,
      this.entryDate,
      this.fromdate,
      this.todate,
      this.id,
      this.hrmEId,
      this.ivrmuLId,
      this.hrciSDatetime,
      this.userId});

  InterviewUPdateModelValues.fromJson(Map<String, dynamic> json) {
    hrcisCId = json['hrcisC_Id'];
    hrcDId = json['hrcD_Id'];
    mIId = json['mI_Id'];
    hrcisCInterviewRounds = json['hrcisC_InterviewRounds'];
    hrcisCInterviewDateTime = json['hrcisC_InterviewDateTime'];
    hrcisCInterviewVenue = json['hrcisC_InterviewVenue'];
    hrcisCActiveFlg = json['hrcisC_ActiveFlg'];
    hrcisCCreatedBy = json['hrcisC_CreatedBy'];
    hrcisCUpdatedBy = json['hrcisC_UpdatedBy'];
    hrcisCInterviewer = json['hrcisC_Interviewer'];
    hrcisCNotifyEmail = json['hrcisC_NotifyEmail'];
    hrcisCNotifySMS = json['hrcisC_NotifySMS'];
    hrcDFullName = json['hrcD_FullName'];
    hrcDPhoto = json['hrcD_Photo'];
    hrcDResume = json['hrcD_Resume'];
    entryDate = json['entry_Date'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    id = json['id'];
    hrmEId = json['hrmE_Id'];
    ivrmuLId = json['ivrmuL_Id'];
    hrciSDatetime = json['hrciS_Datetime'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrcisC_Id'] = hrcisCId;
    data['hrcD_Id'] = hrcDId;
    data['mI_Id'] = mIId;
    data['hrcisC_InterviewRounds'] = hrcisCInterviewRounds;
    data['hrcisC_InterviewDateTime'] = hrcisCInterviewDateTime;
    data['hrcisC_InterviewVenue'] = hrcisCInterviewVenue;
    data['hrcisC_ActiveFlg'] = hrcisCActiveFlg;
    data['hrcisC_CreatedBy'] = hrcisCCreatedBy;
    data['hrcisC_UpdatedBy'] = hrcisCUpdatedBy;
    data['hrcisC_Interviewer'] = hrcisCInterviewer;
    data['hrcisC_NotifyEmail'] = hrcisCNotifyEmail;
    data['hrcisC_NotifySMS'] = hrcisCNotifySMS;
    data['hrcD_FullName'] = hrcDFullName;
    data['hrcD_Photo'] = hrcDPhoto;
    data['hrcD_Resume'] = hrcDResume;
    data['entry_Date'] = entryDate;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['id'] = id;
    data['hrmE_Id'] = hrmEId;
    data['ivrmuL_Id'] = ivrmuLId;
    data['hrciS_Datetime'] = hrciSDatetime;
    data['userId'] = userId;
    return data;
  }
}
