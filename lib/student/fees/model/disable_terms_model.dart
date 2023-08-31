class DisableTermsModel {
  String? type;
  List<DisableTermsModelValues>? values;

  DisableTermsModel({this.type, this.values});

  DisableTermsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DisableTermsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DisableTermsModelValues.fromJson(v));
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

class DisableTermsModelValues {
  String? type;
  int? fMGGId;
  int? fmtId;
  int? paid;
  int? pending;
  int? payable;
  String? fMTName;
  int? fMTOrder;

  DisableTermsModelValues(
      {this.type,
      this.fMGGId,
      this.fmtId,
      this.paid,
      this.pending,
      this.payable,
      this.fMTName,
      this.fMTOrder});

  DisableTermsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    fMGGId = json['FMGG_Id'];
    fmtId = json['fmt_id'];
    paid = json['paid'];
    pending = json['pending'];
    payable = json['payable'];
    fMTName = json['FMT_Name'];
    fMTOrder = json['FMT_Order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['FMGG_Id'] = fMGGId;
    data['fmt_id'] = fmtId;
    data['paid'] = paid;
    data['pending'] = pending;
    data['payable'] = payable;
    data['FMT_Name'] = fMTName;
    data['FMT_Order'] = fMTOrder;
    return data;
  }
}
