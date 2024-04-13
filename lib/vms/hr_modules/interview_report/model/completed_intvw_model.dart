class CompletedIntvwModel {
  String? type;
  List<CompletedIntvwModelValues>? values;

  CompletedIntvwModel({this.type, this.values});

  CompletedIntvwModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CompletedIntvwModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CompletedIntvwModelValues.fromJson(v));
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

class CompletedIntvwModelValues {
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
  String? hrcDFirstName;
  String? hrcDLastName;
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
  String? hrciSInterviewFeedBack;
  int? userId;
  String? hrciSCandidateStatus;
  String? hrcDFullName;
  String? hrcDMiddleName;

  CompletedIntvwModelValues(
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
      this.hrcDFirstName,
      this.hrcDLastName,
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
      this.hrciSInterviewFeedBack,
      this.userId,
      this.hrciSCandidateStatus,
      this.hrcDFullName,
      this.hrcDMiddleName});

  CompletedIntvwModelValues.fromJson(Map<String, dynamic> json) {
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
    hrcDFirstName = json['hrcD_FirstName'];
    hrcDLastName = json['hrcD_LastName'];
    entryDate = json['entry_Date'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    id = json['id'];
    hrmEId = json['hrmE_Id'] ?? "";
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'] ?? "";
    hrmEEmployeeMiddleName = json['hrmE_EmployeeMiddleName'] ?? "";
    hrmEEmployeeLastName = json['hrmE_EmployeeLastName'] ?? "";
    ivrmuLId = json['ivrmuL_Id'] ?? "";
    hrciSDatetime = json['hrciS_Datetime'] ?? "";
    hrciSInterviewFeedBack = json['hrciS_InterviewFeedBack'] ?? "";
    userId = json['userId'] ?? "";
    hrciSCandidateStatus = json['hrciS_CandidateStatus'] ?? "";
    hrcDFullName = json['hrcD_FullName'] ?? "";
    hrcDMiddleName = json['hrcD_MiddleName'] ?? "";
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
    data['hrcD_FirstName'] = hrcDFirstName;
    data['hrcD_LastName'] = hrcDLastName;
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
    data['hrciS_InterviewFeedBack'] = hrciSInterviewFeedBack;
    data['userId'] = userId;
    data['hrciS_CandidateStatus'] = hrciSCandidateStatus;
    data['hrcD_FullName'] = hrcDFullName;
    data['hrcD_MiddleName'] = hrcDMiddleName;
    return data;
  }
}
