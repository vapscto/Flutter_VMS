class DemoResponseModel {
  String? type;
  List<DemoResponseModelValues>? values;

  DemoResponseModel({this.type, this.values});

  DemoResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DemoResponseModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DemoResponseModelValues.fromJson(v));
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

class DemoResponseModelValues {
  String? type;
  String? ismsmpRProductName;
  int? ismsmpRId;
  String? ismsledmpRDiscussionPoints;
  int? ismsledMId;
  int? ismslEId;

  DemoResponseModelValues(
      {this.type,
      this.ismsmpRProductName,
      this.ismsmpRId,
      this.ismsledmpRDiscussionPoints,
      this.ismsledMId,
      this.ismslEId});

  DemoResponseModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    ismsmpRProductName = json['ismsmpR_ProductName'];
    ismsmpRId = json['ismsmpR_Id'];
    ismsledmpRDiscussionPoints = json['ismsledmpR_DiscussionPoints'];
    ismsledMId = json['ismsledM_Id'];
    ismslEId = json['ismslE_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ismsmpR_ProductName'] = ismsmpRProductName;
    data['ismsmpR_Id'] = ismsmpRId;
    data['ismsledmpR_DiscussionPoints'] = ismsledmpRDiscussionPoints;
    data['ismsledM_Id'] = ismsledMId;
    data['ismslE_Id'] = ismslEId;
    return data;
  }
}
