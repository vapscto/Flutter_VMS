class InteractionListModel {
  String? type;
  List<InteractionListModelValues>? values;

  InteractionListModel({this.type, this.values});

  InteractionListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <InteractionListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(InteractionListModelValues.fromJson(v));
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

class InteractionListModelValues {
  String? type;
  int? iSMINTRId;
  String? iSMINTRInteractionId;
  int? iSMINTRComposedByHRMEId;
  String? iSMINTRGroupOrIndFlg;
  String? iSMINTRSubject;
  String? iSMINTRDateTime;
  String? iSMINTRInteraction;
  String? messageflg;
  int? iSMINTRDToId;
  String? employeename;
  String? sender;
  String? receiver;

  InteractionListModelValues(
      {this.type,
      this.iSMINTRId,
      this.iSMINTRInteractionId,
      this.iSMINTRComposedByHRMEId,
      this.iSMINTRGroupOrIndFlg,
      this.iSMINTRSubject,
      this.iSMINTRDateTime,
      this.iSMINTRInteraction,
      this.messageflg,
      this.iSMINTRDToId,
      this.employeename,
      this.sender,
      this.receiver});

  InteractionListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMINTRId = json['ISMINTR_Id'];
    iSMINTRInteractionId = json['ISMINTR_InteractionId'] ?? '';
    iSMINTRComposedByHRMEId = json['ISMINTR_ComposedByHRME_Id'];
    iSMINTRGroupOrIndFlg = json['ISMINTR_GroupOrIndFlg'];
    iSMINTRSubject = json['ISMINTR_Subject'];
    iSMINTRDateTime = json['ISMINTR_DateTime'];
    iSMINTRInteraction = json['ISMINTR_Interaction'];
    messageflg = json['messageflg'];
    iSMINTRDToId = json['ISMINTRD_ToId'];
    employeename = json['employeename'];
    sender = json['Sender'];
    receiver = json['Receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMINTR_Id'] = iSMINTRId;
    data['ISMINTR_InteractionId'] = iSMINTRInteractionId;
    data['ISMINTR_ComposedByHRME_Id'] = iSMINTRComposedByHRMEId;
    data['ISMINTR_GroupOrIndFlg'] = iSMINTRGroupOrIndFlg;
    data['ISMINTR_Subject'] = iSMINTRSubject;
    data['ISMINTR_DateTime'] = iSMINTRDateTime;
    data['ISMINTR_Interaction'] = iSMINTRInteraction;
    data['messageflg'] = messageflg;
    data['ISMINTRD_ToId'] = iSMINTRDToId;
    data['employeename'] = employeename;
    data['Sender'] = sender;
    data['Receiver'] = receiver;
    return data;
  }
}
