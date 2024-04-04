class DemoResponseDetails {
  String? type;
  List<DemoResponseDetailsValues>? values;

  DemoResponseDetails({this.type, this.values});

  DemoResponseDetails.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <DemoResponseDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(DemoResponseDetailsValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ismsmpR_ProductName'] = ismsmpRProductName;
    data['ismsmpR_Id'] = ismsmpRId;
    data['ismsledmpR_DiscussionPoints'] = ismsledmpRDiscussionPoints;
    data['ismsledM_Id'] = ismsledMId;
    data['ismsledmpR_Remarks'] = ismsledmpRRemarks;
    data['ismsmsT_Id'] = ismsmsTId;
    data['ismsmsT_StatusName'] = ismsmsTStatusName;
    return data;
  }
}
