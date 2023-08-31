class GetFeeDetails {
  String? type;
  List<GetFeeDetailsValues>? values;

  GetFeeDetails({this.type, this.values});

  GetFeeDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetFeeDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetFeeDetailsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetFeeDetailsValues {
  String? type;
  int? receivable;
  int? concession;
  int? collectionamount;
  int? adjusted;
  int? balance;
  String? acdYear;

  GetFeeDetailsValues(
      {this.type,
      this.receivable,
      this.concession,
      this.collectionamount,
      this.adjusted,
      this.balance,
      this.acdYear});

  GetFeeDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    receivable = json['Receivable'];
    concession = json['Concession'];
    collectionamount = json['Collectionamount'];
    adjusted = json['Adjusted'];
    balance = json['Balance'];
    acdYear = json['acdYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['Receivable'] = receivable;
    data['Concession'] = concession;
    data['Collectionamount'] = collectionamount;
    data['Adjusted'] = adjusted;
    data['Balance'] = balance;
    data['acdYear'] = acdYear;
    return data;
  }
}

class GetTermFeeDetails {
  String? type;
  List<GetTermFeeDetailsValues>? values;

  GetTermFeeDetails({this.type, this.values});

  GetTermFeeDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetTermFeeDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetTermFeeDetailsValues.fromJson(v));
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

class GetTermFeeDetailsValues {
  String? type;
  int? aMSTId;
  int? fMTId;
  String? fMTName;
  int? balanceAmount;

  GetTermFeeDetailsValues(
      {this.type, this.aMSTId, this.fMTId, this.fMTName, this.balanceAmount});

  GetTermFeeDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aMSTId = json['AMST_Id'];
    fMTId = json['FMT_Id'];
    fMTName = json['FMT_Name'];
    balanceAmount = json['BalanceAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['AMST_Id'] = aMSTId;
    data['FMT_Id'] = fMTId;
    data['FMT_Name'] = fMTName;
    data['BalanceAmount'] = balanceAmount;
    return data;
  }
}
