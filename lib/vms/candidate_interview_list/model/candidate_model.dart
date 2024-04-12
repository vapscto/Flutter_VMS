class CandidateListModel {
  String? type;
  List<CandidateListModelValues>? values;

  CandidateListModel({this.type, this.values});

  CandidateListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CandidateListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CandidateListModelValues.fromJson(v));
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

class CandidateListModelValues {
  int? hrcisCId;
  int? hrcDId;
  int? mIId;
  String? hrcisCInterviewRounds;
  String? hrcisCInterviewDateTime;
  bool? hrcisCActiveFlg;
  int? hrcisCCreatedBy;
  int? hrcisCUpdatedBy;
  int? hrcisCInterviewer;
  String? hrcisCStatus;
  bool? hrcisCNotifyEmail;
  bool? hrcisCNotifySMS;
  String? hrcisCInterviewDate;
  String? hrcDFullName;
  String? entryDate;
  String? fromdate;
  String? todate;
  int? id;
  int? hrmEId;
  int? ivrmuLId;
  String? hrciSDatetime;
  int? userId;

  CandidateListModelValues(
      {this.hrcisCId,
      this.hrcDId,
      this.mIId,
      this.hrcisCInterviewRounds,
      this.hrcisCInterviewDateTime,
      this.hrcisCActiveFlg,
      this.hrcisCCreatedBy,
      this.hrcisCUpdatedBy,
      this.hrcisCInterviewer,
      this.hrcisCStatus,
      this.hrcisCNotifyEmail,
      this.hrcisCNotifySMS,
      this.hrcisCInterviewDate,
      this.hrcDFullName,
      this.entryDate,
      this.fromdate,
      this.todate,
      this.id,
      this.hrmEId,
      this.ivrmuLId,
      this.hrciSDatetime,
      this.userId});

  CandidateListModelValues.fromJson(Map<String, dynamic> json) {
    hrcisCId = json['hrcisC_Id'];
    hrcDId = json['hrcD_Id'];
    mIId = json['mI_Id'];
    hrcisCInterviewRounds = json['hrcisC_InterviewRounds'];
    hrcisCInterviewDateTime = json['hrcisC_InterviewDateTime'];
    hrcisCActiveFlg = json['hrcisC_ActiveFlg'];
    hrcisCCreatedBy = json['hrcisC_CreatedBy'];
    hrcisCUpdatedBy = json['hrcisC_UpdatedBy'];
    hrcisCInterviewer = json['hrcisC_Interviewer'];
    hrcisCStatus = json['hrcisC_Status'];
    hrcisCNotifyEmail = json['hrcisC_NotifyEmail'];
    hrcisCNotifySMS = json['hrcisC_NotifySMS'];
    hrcisCInterviewDate = json['hrcisC_InterviewDate'];
    hrcDFullName = json['hrcD_FullName'];
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
    data['hrcisC_ActiveFlg'] = hrcisCActiveFlg;
    data['hrcisC_CreatedBy'] = hrcisCCreatedBy;
    data['hrcisC_UpdatedBy'] = hrcisCUpdatedBy;
    data['hrcisC_Interviewer'] = hrcisCInterviewer;
    data['hrcisC_Status'] = hrcisCStatus;
    data['hrcisC_NotifyEmail'] = hrcisCNotifyEmail;
    data['hrcisC_NotifySMS'] = hrcisCNotifySMS;
    data['hrcisC_InterviewDate'] = hrcisCInterviewDate;
    data['hrcD_FullName'] = hrcDFullName;
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
