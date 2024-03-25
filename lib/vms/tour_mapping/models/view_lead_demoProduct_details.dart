class ViewLeadDemoProductResponse {
  String? type;
  List<ViewLeadDemoProductResponseValues>? values;

  ViewLeadDemoProductResponse({this.type, this.values});

  ViewLeadDemoProductResponse.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ViewLeadDemoProductResponseValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ViewLeadDemoProductResponseValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['ismsmpR_ProductName'] = this.ismsmpRProductName;
    data['ismsmpR_Id'] = this.ismsmpRId;
    data['ismsledmpR_DiscussionPoints'] = this.ismsledmpRDiscussionPoints;
    data['ismsledmpR_ActiveFlag'] = this.ismsledmpRActiveFlag;
    return data;
  }
}
