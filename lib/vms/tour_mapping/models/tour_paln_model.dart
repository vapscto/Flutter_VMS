class TourPlanModel {
  String? type;
  List<TourPlanModelValues>? values;

  TourPlanModel({this.type, this.values});

  TourPlanModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TourPlanModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new TourPlanModelValues.fromJson(v));
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

class TourPlanModelValues {
  String? type;
  int? hRMEId;
  int? iERID;
  String? iERPlanName;
  int? vTADAAAId;
  // String? vTADAAId;

  TourPlanModelValues(
      {this.type,
      this.hRMEId,
      this.iERID,
      this.iERPlanName,
      this.vTADAAAId,
      //this.vTADAAId
      });

  TourPlanModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    iERID = json['IER_ID'];
    iERPlanName = json['IER_PlanName'];
    vTADAAAId = json['VTADAAA_Id'];
   // vTADAAId = json['VTADAA_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['HRME_Id'] = this.hRMEId;
    data['IER_ID'] = this.iERID;
    data['IER_PlanName'] = this.iERPlanName;
    data['VTADAAA_Id'] = this.vTADAAAId;
   // data['VTADAA_Id'] = this.vTADAAId;
    return data;
  }
}
