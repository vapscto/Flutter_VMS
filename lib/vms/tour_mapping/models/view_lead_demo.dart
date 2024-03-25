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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['employeename'] = this.employeename;
    data['hrmE_Id'] = this.hrmEId;
    data['ismslE_LeadName'] = this.ismslELeadName;
    data['ismslE_LeadCode'] = this.ismslELeadCode;
    data['ismsledM_ContactPerson'] = this.ismsledMContactPerson;
    data['ismslE_ContactNo'] = this.ismslEContactNo;
    data['ismsledM_DemoAddress'] = this.ismsledMDemoAddress;
    data['ismsledM_Remarks'] = this.ismsledMRemarks;
    return data;
  }
}
