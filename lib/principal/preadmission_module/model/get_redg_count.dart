
class GetCountData {
  String? type;
  List<GetCountDataValues>? values;

  GetCountData({this.type, this.values});

  GetCountData.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetCountDataValues>[];
      json['\$values'].forEach((v) {
        values!.add( GetCountDataValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetCountDataValues {
  String? type;
  int? reg;
  int? notapplicationform;
  int? applicationform;
  int? payment;
  int? transferstu;
  int? notpayment;

  GetCountDataValues(
      {this.type,
      this.reg,
      this.notapplicationform,
      this.applicationform,
      this.payment,
      this.transferstu,
      this.notpayment});

  GetCountDataValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    reg = json['reg'];
    notapplicationform = json['notapplicationform'];
    applicationform = json['applicationform'];
    payment = json['payment'];
    transferstu = json['transferstu'];
    notpayment = json['notpayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['$type'] = type;
    data['reg'] = reg;
    data['notapplicationform'] = notapplicationform;
    data['applicationform'] = applicationform;
    data['payment'] = payment;
    data['transferstu'] = transferstu;
    data['notpayment'] = notpayment;
    return data;
  }
}







