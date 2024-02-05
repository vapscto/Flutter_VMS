class NotificationListModel {
  String? type;
  List<NotificationListModelValues>? values;

  NotificationListModel({this.type, this.values});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NotificationListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NotificationListModelValues.fromJson(v));
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

class NotificationListModelValues {
  String? type;
  int? iSMNOId;
  int? mIId;
  int? hRMEId;
  String? iSMNONotification;
  String? iSMNONoticationDate;
  String? iSMNONotificationType;
  bool? iSMNOReadFlg;
  bool? iSMNOMakeUnReadFlg;
  bool? iSMNOActiveFlag;
  int? iSMNOCreatedBy;
  int? iSMNOUpdatedBy;
  String? updatedDate;
  String? iSMNOResponse;
  String? iSMNOModeFlg;
  String? iSMNORedirectURL;
  String? createdby;
  String? createdDate;
  String? createdTime;

  NotificationListModelValues(
      {this.type,
      this.iSMNOId,
      this.mIId,
      this.hRMEId,
      this.iSMNONotification,
      this.iSMNONoticationDate,
      this.iSMNONotificationType,
      this.iSMNOReadFlg,
      this.iSMNOMakeUnReadFlg,
      this.iSMNOActiveFlag,
      this.iSMNOCreatedBy,
      this.iSMNOUpdatedBy,
      this.updatedDate,
      this.iSMNOResponse,
      this.iSMNOModeFlg,
      this.iSMNORedirectURL,
      this.createdby,
      this.createdDate,
      this.createdTime});

  NotificationListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMNOId = json['ISMNO_Id'];
    mIId = json['MI_Id'];
    hRMEId = json['HRME_Id'];
    iSMNONotification = json['ISMNO_Notification'];
    iSMNONoticationDate = json['ISMNO_NoticationDate'];
    iSMNONotificationType = json['ISMNO_NotificationType'];
    iSMNOReadFlg = json['ISMNO_ReadFlg'];
    iSMNOMakeUnReadFlg = json['ISMNO_MakeUnReadFlg'];
    iSMNOActiveFlag = json['ISMNO_ActiveFlag'];
    iSMNOCreatedBy = json['ISMNO_CreatedBy'];
    iSMNOUpdatedBy = json['ISMNO_UpdatedBy'];
    updatedDate = json['UpdatedDate'];
    iSMNOResponse = json['ISMNO_Response'] ?? '';
    iSMNOModeFlg = json['ISMNO_ModeFlg'];
    iSMNORedirectURL = json['ISMNO_RedirectURL'];
    createdby = json['createdby'];
    createdDate = json['CreatedDate'];
    createdTime = json['CreatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMNO_Id'] = iSMNOId;
    data['MI_Id'] = mIId;
    data['HRME_Id'] = hRMEId;
    data['ISMNO_Notification'] = iSMNONotification;
    data['ISMNO_NoticationDate'] = iSMNONoticationDate;
    data['ISMNO_NotificationType'] = iSMNONotificationType;
    data['ISMNO_ReadFlg'] = iSMNOReadFlg;
    data['ISMNO_MakeUnReadFlg'] = iSMNOMakeUnReadFlg;
    data['ISMNO_ActiveFlag'] = iSMNOActiveFlag;
    data['ISMNO_CreatedBy'] = iSMNOCreatedBy;
    data['ISMNO_UpdatedBy'] = iSMNOUpdatedBy;
    data['UpdatedDate'] = updatedDate;
    data['ISMNO_Response'] = iSMNOResponse;
    data['ISMNO_ModeFlg'] = iSMNOModeFlg;
    data['ISMNO_RedirectURL'] = iSMNORedirectURL;
    data['createdby'] = createdby;
    data['CreatedDate'] = createdDate;
    data['CreatedTime'] = createdTime;
    return data;
  }
}
