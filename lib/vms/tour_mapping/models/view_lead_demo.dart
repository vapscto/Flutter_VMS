class ViewLeadDemo {
  String? type;
  List<ViewLeadDemoValues>? values;

  ViewLeadDemo({this.type, this.values});

  ViewLeadDemo.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ViewLeadDemoValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewLeadDemoValues.fromJson(v));
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

class ViewLeadDemoValues {
  String? type;
  String? employeename;
  int? hrmEId;
  String? ismslELeadName;
  String? ismslELeadCode;
  String? ismsledMContactPerson;
  int? ismslEContactNo;
  String? ismsledMDemoAddress;
  String? ismsledMRemarks;

  ViewLeadDemoValues(
      {this.type,
      this.employeename,
      this.hrmEId,
      this.ismslELeadName,
      this.ismslELeadCode,
      this.ismsledMContactPerson,
      this.ismslEContactNo,
      this.ismsledMDemoAddress,
      this.ismsledMRemarks});

  ViewLeadDemoValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    employeename = json['employeename'];
    hrmEId = json['hrmE_Id'];
    ismslELeadName = json['ismslE_LeadName'];
    ismslELeadCode = json['ismslE_LeadCode'];
    ismsledMContactPerson = json['ismsledM_ContactPerson'];
    ismslEContactNo = json['ismslE_ContactNo'];
    ismsledMDemoAddress = json['ismsledM_DemoAddress'];
    ismsledMRemarks = json['ismsledM_Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['employeename'] = employeename;
    data['hrmE_Id'] = hrmEId;
    data['ismslE_LeadName'] = ismslELeadName;
    data['ismslE_LeadCode'] = ismslELeadCode;
    data['ismsledM_ContactPerson'] = ismsledMContactPerson;
    data['ismslE_ContactNo'] = ismslEContactNo;
    data['ismsledM_DemoAddress'] = ismsledMDemoAddress;
    data['ismsledM_Remarks'] = ismsledMRemarks;
    return data;
  }
}
