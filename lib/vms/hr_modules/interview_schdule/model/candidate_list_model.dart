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
  String? hrcisCInterviewDateTime;
  bool? hrcisCActiveFlg;
  int? hrcisCCreatedBy;
  int? hrcisCUpdatedBy;
  int? hrcisCInterviewer;
  bool? hrcisCNotifyEmail;
  bool? hrcisCNotifySMS;
  String? hrcDFirstName;
  String? hrcDMiddleName;
  String? hrcDLastName;
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
      this.hrcisCInterviewDateTime,
      this.hrcisCActiveFlg,
      this.hrcisCCreatedBy,
      this.hrcisCUpdatedBy,
      this.hrcisCInterviewer,
      this.hrcisCNotifyEmail,
      this.hrcisCNotifySMS,
      this.hrcDFirstName,
      this.hrcDMiddleName,
      this.hrcDLastName,
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
    hrcisCInterviewDateTime = json['hrcisC_InterviewDateTime'];
    hrcisCActiveFlg = json['hrcisC_ActiveFlg'];
    hrcisCCreatedBy = json['hrcisC_CreatedBy'];
    hrcisCUpdatedBy = json['hrcisC_UpdatedBy'];
    hrcisCInterviewer = json['hrcisC_Interviewer'];
    hrcisCNotifyEmail = json['hrcisC_NotifyEmail'];
    hrcisCNotifySMS = json['hrcisC_NotifySMS'];
    hrcDFirstName = json['hrcD_FirstName'];
    hrcDMiddleName = json['hrcD_MiddleName'];
    hrcDLastName = json['hrcD_LastName'];
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
    data['hrcisC_InterviewDateTime'] = hrcisCInterviewDateTime;
    data['hrcisC_ActiveFlg'] = hrcisCActiveFlg;
    data['hrcisC_CreatedBy'] = hrcisCCreatedBy;
    data['hrcisC_UpdatedBy'] = hrcisCUpdatedBy;
    data['hrcisC_Interviewer'] = hrcisCInterviewer;
    data['hrcisC_NotifyEmail'] = hrcisCNotifyEmail;
    data['hrcisC_NotifySMS'] = hrcisCNotifySMS;
    data['hrcD_FirstName'] = hrcDFirstName;
    data['hrcD_MiddleName'] = hrcDMiddleName;
    data['hrcD_LastName'] = hrcDLastName;
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
