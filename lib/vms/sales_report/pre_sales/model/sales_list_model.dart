class PreSalesListModel {
  String? type;
  List<PreSalesListModelValues>? values;

  PreSalesListModel({this.type, this.values});

  PreSalesListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PreSalesListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PreSalesListModelValues.fromJson(v));
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

class PreSalesListModelValues {
  String? type;
  String? ismslELeadName;
  String? ismslELeadCode;
  String? ismsmsTStatusName;
  int? ismsmsTId;
  String? ismsledMContactPerson;
  bool? ismsledMActiveFlag;
  int? ismsledMStatusFlg;
  int? ismsledMId;
  int? ismslEId;
  String? ismsledMDemoDate;
  int? ismslEContactNo;
  String? ismslEEmailId;
  String? ismsledMDemoType;
  int? ismsledMDemoScheduledBy;
  String? employeename;

  PreSalesListModelValues(
      {this.type,
      this.ismslELeadName,
      this.ismslELeadCode,
      this.ismsmsTStatusName,
      this.ismsmsTId,
      this.ismsledMContactPerson,
      this.ismsledMActiveFlag,
      this.ismsledMStatusFlg,
      this.ismsledMId,
      this.ismslEId,
      this.ismsledMDemoDate,
      this.ismslEContactNo,
      this.ismslEEmailId,
      this.ismsledMDemoType,
      this.ismsledMDemoScheduledBy,
      this.employeename});

  PreSalesListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    ismslELeadName = json['ismslE_LeadName'];
    ismslELeadCode = json['ismslE_LeadCode'];
    ismsmsTStatusName = json['ismsmsT_StatusName'];
    ismsmsTId = json['ismsmsT_Id'];
    ismsledMContactPerson = json['ismsledM_ContactPerson'];
    ismsledMActiveFlag = json['ismsledM_ActiveFlag'];
    ismsledMStatusFlg = json['ismsledM_Status_Flg'];
    ismsledMId = json['ismsledM_Id'];
    ismslEId = json['ismslE_Id'];
    ismsledMDemoDate = json['ismsledM_DemoDate'];
    ismslEContactNo = json['ismslE_ContactNo'];
    ismslEEmailId = json['ismslE_EmailId'];
    ismsledMDemoType = json['ismsledM_DemoType'];
    ismsledMDemoScheduledBy = json['ismsledM_DemoScheduledBy'];
    employeename = json['employeename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ismslE_LeadName'] = ismslELeadName;
    data['ismslE_LeadCode'] = ismslELeadCode;
    data['ismsmsT_StatusName'] = ismsmsTStatusName;
    data['ismsmsT_Id'] = ismsmsTId;
    data['ismsledM_ContactPerson'] = ismsledMContactPerson;
    data['ismsledM_ActiveFlag'] = ismsledMActiveFlag;
    data['ismsledM_Status_Flg'] = ismsledMStatusFlg;
    data['ismsledM_Id'] = ismsledMId;
    data['ismslE_Id'] = ismslEId;
    data['ismsledM_DemoDate'] = ismsledMDemoDate;
    data['ismslE_ContactNo'] = ismslEContactNo;
    data['ismslE_EmailId'] = ismslEEmailId;
    data['ismsledM_DemoType'] = ismsledMDemoType;
    data['ismsledM_DemoScheduledBy'] = ismsledMDemoScheduledBy;
    data['employeename'] = employeename;
    return data;
  }
}
