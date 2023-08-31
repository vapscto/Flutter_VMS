class NotificationDataModel {
  String? type;
  List<NotificationDataModelValues>? values;

  NotificationDataModel({this.type, this.values});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NotificationDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NotificationDataModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationDataModelValues {
  String? type;
  int? pNSDId;
  String? pNSDHeaderName;
  String? pNSDSentDate;
  String? pNSDSentTime;
  String? pNSDToFlag;
  String? pNSDSMSMessage;
  String? pNSDHeaderFlg;
  String? pNSDRedirectURL;
  String? pNSDDEReadStatus;
  String? pNSDDEDeliveryDate;
  String? pNSDDEDeliveryTime;
  bool? pNSDDEMakeUnreadFlg;
  String? pNSDDEApprovalLevel;
  int? pNSDDEId;
  num? pNSDTRANSACTIONID;

  NotificationDataModelValues({
    this.type,
    this.pNSDId,
    this.pNSDHeaderName,
    this.pNSDSentDate,
    this.pNSDSentTime,
    this.pNSDToFlag,
    this.pNSDSMSMessage,
    this.pNSDHeaderFlg,
    this.pNSDRedirectURL,
    this.pNSDDEReadStatus,
    this.pNSDDEDeliveryDate,
    this.pNSDDEDeliveryTime,
    this.pNSDDEMakeUnreadFlg,
    this.pNSDDEApprovalLevel,
    this.pNSDDEId,
    this.pNSDTRANSACTIONID,
  });

  NotificationDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    pNSDId = json['PNSD_Id'];
    pNSDHeaderName = json['PNSD_HeaderName'];
    pNSDSentDate = json['PNSD_SentDate'];
    pNSDSentTime = json['PNSD_SentTime'];
    pNSDToFlag = json['PNSD_ToFlag'];
    pNSDSMSMessage = json['PNSD_SMSMessage'];
    pNSDHeaderFlg = json['PNSD_Header_Flg'];
    pNSDRedirectURL = json['PNSD_RedirectURL'];
    pNSDDEReadStatus = json['PNSDDE_ReadStatus'];
    pNSDDEDeliveryDate = json['PNSDDE_DeliveryDate'];
    pNSDDEDeliveryTime = json['PNSDDE_DeliveryTime'];
    pNSDDEMakeUnreadFlg = json['PNSDDE_MakeUnreadFlg'];
    pNSDDEApprovalLevel = json['PNSDDE_ApprovalLevel'];
    pNSDDEId = json['PNSDDE_Id'];
    pNSDTRANSACTIONID = json['PNSD_TransactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['PNSD_Id'] = pNSDId;
    data['PNSD_HeaderName'] = pNSDHeaderName;
    data['PNSD_SentDate'] = pNSDSentDate;
    data['PNSD_SentTime'] = pNSDSentTime;
    data['PNSD_ToFlag'] = pNSDToFlag;
    data['PNSD_SMSMessage'] = pNSDSMSMessage;
    data['PNSD_Header_Flg'] = pNSDHeaderFlg;
    data['PNSD_RedirectURL'] = pNSDRedirectURL;
    data['PNSDDE_ReadStatus'] = pNSDDEReadStatus;
    data['PNSDDE_DeliveryDate'] = pNSDDEDeliveryDate;
    data['PNSDDE_DeliveryTime'] = pNSDDEDeliveryTime;
    data['PNSDDE_MakeUnreadFlg'] = pNSDDEMakeUnreadFlg;
    data['PNSDDE_ApprovalLevel'] = pNSDDEApprovalLevel;
    data['PNSDDE_Id'] = pNSDDEId;
    return data;
  }
}
