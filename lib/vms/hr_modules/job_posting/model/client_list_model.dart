class ClientListModel {
  String? type;
  List<ClientListModelValues>? values;

  ClientListModel({this.type, this.values});

  ClientListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClientListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ClientListModelValues.fromJson(v));
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

class ClientListModelValues {
  dynamic hrmrfRId;
  dynamic mIId;
  dynamic hrmPId;
  dynamic hrmlOId;
  dynamic hrmDId;
  dynamic hrmpRId;
  dynamic hrmpTId;
  dynamic hrmrfRMRFNO;
  dynamic hrmCId;
  dynamic hrmrfRNoofPosition;
  dynamic hrmrfRExpFrom;
  dynamic hrmrfRExpTo;
  dynamic hrmrfRAge;
  dynamic ivrmmGId;
  bool? hrmrfRWrittenTestFlg;
  bool? hrmrfROnlineTestFlg;
  bool? hrmrfRTechnicalInterviewFlg;
  bool? hrmrfRActiveFlag;
  dynamic hrmrfRCreatedBy;
  dynamic hrmrfRUpdatedBy;
  bool? hrmrfRManagerFlag;
  bool? hrmrfRHRFlag;
  dynamic userid;
  dynamic ismmclTId;
  String? ismmclTClientName;
  dynamic hrmEId;
  dynamic hrmcoNId;
  dynamic hrmcoNState;
  dynamic hrmcoNPINCode;
  bool? hrmcoNActiveFlg;
  dynamic hrmeTId;
  dynamic roleId;
  bool? returnval;

  ClientListModelValues(
      {this.hrmrfRId,
      this.mIId,
      this.hrmPId,
      this.hrmlOId,
      this.hrmDId,
      this.hrmpRId,
      this.hrmpTId,
      this.hrmrfRMRFNO,
      this.hrmCId,
      this.hrmrfRNoofPosition,
      this.hrmrfRExpFrom,
      this.hrmrfRExpTo,
      this.hrmrfRAge,
      this.ivrmmGId,
      this.hrmrfRWrittenTestFlg,
      this.hrmrfROnlineTestFlg,
      this.hrmrfRTechnicalInterviewFlg,
      this.hrmrfRActiveFlag,
      this.hrmrfRCreatedBy,
      this.hrmrfRUpdatedBy,
      this.hrmrfRManagerFlag,
      this.hrmrfRHRFlag,
      this.userid,
      this.ismmclTId,
      this.ismmclTClientName,
      this.hrmEId,
      this.hrmcoNId,
      this.hrmcoNState,
      this.hrmcoNPINCode,
      this.hrmcoNActiveFlg,
      this.hrmeTId,
      this.roleId,
      this.returnval});

  ClientListModelValues.fromJson(Map<String, dynamic> json) {
    hrmrfRId = json['hrmrfR_Id'];
    mIId = json['mI_Id'];
    hrmPId = json['hrmP_Id'];
    hrmlOId = json['hrmlO_Id'];
    hrmDId = json['hrmD_Id'];
    hrmpRId = json['hrmpR_Id'];
    hrmpTId = json['hrmpT_Id'];
    hrmrfRMRFNO = json['hrmrfR_MRFNO'];
    hrmCId = json['hrmC_Id'];
    hrmrfRNoofPosition = json['hrmrfR_NoofPosition'];
    hrmrfRExpFrom = json['hrmrfR_ExpFrom'];
    hrmrfRExpTo = json['hrmrfR_ExpTo'];
    hrmrfRAge = json['hrmrfR_Age'];
    ivrmmGId = json['ivrmmG_Id'];
    hrmrfRWrittenTestFlg = json['hrmrfR_WrittenTestFlg'];
    hrmrfROnlineTestFlg = json['hrmrfR_OnlineTestFlg'];
    hrmrfRTechnicalInterviewFlg = json['hrmrfR_TechnicalInterviewFlg'];
    hrmrfRActiveFlag = json['hrmrfR_ActiveFlag'];
    hrmrfRCreatedBy = json['hrmrfR_CreatedBy'];
    hrmrfRUpdatedBy = json['hrmrfR_UpdatedBy'];
    hrmrfRManagerFlag = json['hrmrfR_ManagerFlag'];
    hrmrfRHRFlag = json['hrmrfR_HRFlag'];
    userid = json['userid'];
    ismmclTId = json['ismmclT_Id'];
    ismmclTClientName = json['ismmclT_ClientName'];
    hrmEId = json['hrmE_Id'];
    hrmcoNId = json['hrmcoN_Id'];
    hrmcoNState = json['hrmcoN_State'];
    hrmcoNPINCode = json['hrmcoN_PINCode'];
    hrmcoNActiveFlg = json['hrmcoN_ActiveFlg'];
    hrmeTId = json['hrmeT_Id'];
    roleId = json['roleId'];
    returnval = json['returnval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmrfR_Id'] = hrmrfRId;
    data['mI_Id'] = mIId;
    data['hrmP_Id'] = hrmPId;
    data['hrmlO_Id'] = hrmlOId;
    data['hrmD_Id'] = hrmDId;
    data['hrmpR_Id'] = hrmpRId;
    data['hrmpT_Id'] = hrmpTId;
    data['hrmrfR_MRFNO'] = hrmrfRMRFNO;
    data['hrmC_Id'] = hrmCId;
    data['hrmrfR_NoofPosition'] = hrmrfRNoofPosition;
    data['hrmrfR_ExpFrom'] = hrmrfRExpFrom;
    data['hrmrfR_ExpTo'] = hrmrfRExpTo;
    data['hrmrfR_Age'] = hrmrfRAge;
    data['ivrmmG_Id'] = ivrmmGId;
    data['hrmrfR_WrittenTestFlg'] = hrmrfRWrittenTestFlg;
    data['hrmrfR_OnlineTestFlg'] = hrmrfROnlineTestFlg;
    data['hrmrfR_TechnicalInterviewFlg'] = hrmrfRTechnicalInterviewFlg;
    data['hrmrfR_ActiveFlag'] = hrmrfRActiveFlag;
    data['hrmrfR_CreatedBy'] = hrmrfRCreatedBy;
    data['hrmrfR_UpdatedBy'] = hrmrfRUpdatedBy;
    data['hrmrfR_ManagerFlag'] = hrmrfRManagerFlag;
    data['hrmrfR_HRFlag'] = hrmrfRHRFlag;
    data['userid'] = userid;
    data['ismmclT_Id'] = ismmclTId;
    data['ismmclT_ClientName'] = ismmclTClientName;
    data['hrmE_Id'] = hrmEId;
    data['hrmcoN_Id'] = hrmcoNId;
    data['hrmcoN_State'] = hrmcoNState;
    data['hrmcoN_PINCode'] = hrmcoNPINCode;
    data['hrmcoN_ActiveFlg'] = hrmcoNActiveFlg;
    data['hrmeT_Id'] = hrmeTId;
    data['roleId'] = roleId;
    data['returnval'] = returnval;
    return data;
  }
}
