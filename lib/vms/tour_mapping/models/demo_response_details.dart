class DemoResponseDetails {
  String? type;
  List<DemoResponseDetailsValues>? values;

  DemoResponseDetails({this.type, this.values});

  DemoResponseDetails.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <DemoResponseDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(  DemoResponseDetailsValues.fromJson(v));
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

class DemoResponseDetailsValues {
  String? type;
  String? ismsmpRProductName;
  int? ismsmpRId;
  String? ismsledmpRDiscussionPoints;
  int? ismsledMId;
  String? ismsledmpRRemarks;
  int? ismsmsTId;
  String? ismsmsTStatusName;

  DemoResponseDetailsValues(
      {this.type,
      this.ismsmpRProductName,
      this.ismsmpRId,
      this.ismsledmpRDiscussionPoints,
      this.ismsledMId,
      this.ismsledmpRRemarks,
      this.ismsmsTId,
      this.ismsmsTStatusName});

  DemoResponseDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    ismsmpRProductName = json['ismsmpR_ProductName'];
    ismsmpRId = json['ismsmpR_Id'];
    ismsledmpRDiscussionPoints = json['ismsledmpR_DiscussionPoints'];
    ismsledMId = json['ismsledM_Id'];
    ismsledmpRRemarks = json['ismsledmpR_Remarks'];
    ismsmsTId = json['ismsmsT_Id'];
    ismsmsTStatusName = json['ismsmsT_StatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['ismsmpR_ProductName'] = this.ismsmpRProductName;
    data['ismsmpR_Id'] = this.ismsmpRId;
    data['ismsledmpR_DiscussionPoints'] = this.ismsledmpRDiscussionPoints;
    data['ismsledM_Id'] = this.ismsledMId;
    data['ismsledmpR_Remarks'] = this.ismsledmpRRemarks;
    data['ismsmsT_Id'] = this.ismsmsTId;
    data['ismsmsT_StatusName'] = this.ismsmsTStatusName;
    return data;
  }
}
