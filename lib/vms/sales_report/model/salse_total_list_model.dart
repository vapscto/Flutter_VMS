class SalseTotalListModel {
  String? type;
  List<SalseTotalListModelValues>? values;

  SalseTotalListModel({this.type, this.values});

  SalseTotalListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SalseTotalListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SalseTotalListModelValues.fromJson(v));
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

class SalseTotalListModelValues {
  String? type;
  int? hRMEId;
  String? empName;
  int? demoGiven;
  int? notGivenDemo;
  int? totalLeads;
  int? cOLD;
  int? hOT;
  int? wARM;
  String? fromdate;
  String? todate;
  String? empFlg;

  SalseTotalListModelValues(
      {this.type,
      this.hRMEId,
      this.empName,
      this.demoGiven,
      this.notGivenDemo,
      this.totalLeads,
      this.cOLD,
      this.hOT,
      this.wARM,
      this.fromdate,
      this.todate,
      this.empFlg});

  SalseTotalListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    empName = json['Emp_Name'];
    demoGiven = json['Demo_Given'];
    notGivenDemo = json['Not_Given_Demo'];
    totalLeads = json['Total_Leads'];
    cOLD = json['COLD'];
    hOT = json['HOT'];
    wARM = json['WARM'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    empFlg = json['emp_flg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['Emp_Name'] = empName;
    data['Demo_Given'] = demoGiven;
    data['Not_Given_Demo'] = notGivenDemo;
    data['Total_Leads'] = totalLeads;
    data['COLD'] = cOLD;
    data['HOT'] = hOT;
    data['WARM'] = wARM;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['emp_flg'] = empFlg;
    return data;
  }
}
