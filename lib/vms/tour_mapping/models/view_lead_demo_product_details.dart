class ViewLeadDemoProductResponse {
  String? type;
  List<ViewLeadDemoProductResponseValues>? values;

  ViewLeadDemoProductResponse({this.type, this.values});

  ViewLeadDemoProductResponse.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ViewLeadDemoProductResponseValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewLeadDemoProductResponseValues.fromJson(v));
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

class ViewLeadDemoProductResponseValues {
  String? type;
  String? ismsmpRProductName;
  int? ismsmpRId;
  String? ismsledmpRDiscussionPoints;
  bool? ismsledmpRActiveFlag;

  ViewLeadDemoProductResponseValues(
      {this.type,
      this.ismsmpRProductName,
      this.ismsmpRId,
      this.ismsledmpRDiscussionPoints,
      this.ismsledmpRActiveFlag});

  ViewLeadDemoProductResponseValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    ismsmpRProductName = json['ismsmpR_ProductName'];
    ismsmpRId = json['ismsmpR_Id'];
    ismsledmpRDiscussionPoints = json['ismsledmpR_DiscussionPoints'];
    ismsledmpRActiveFlag = json['ismsledmpR_ActiveFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ismsmpR_ProductName'] = ismsmpRProductName;
    data['ismsmpR_Id'] = ismsmpRId;
    data['ismsledmpR_DiscussionPoints'] = ismsledmpRDiscussionPoints;
    data['ismsledmpR_ActiveFlag'] = ismsledmpRActiveFlag;
    return data;
  }
}
