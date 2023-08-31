class BirthdayModel {
  String? type;
  List<BirthdayModelValues>? values;

  BirthdayModel({this.type, this.values});

  BirthdayModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <BirthdayModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(BirthdayModelValues.fromJson(v));
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

class BirthdayModelValues {
  String? type;
  String? aMSTFirstName;
  String? aMSTDOB;
  String? aMSTPhotoname;

  BirthdayModelValues(
      {this.type, this.aMSTFirstName, this.aMSTDOB, this.aMSTPhotoname});

  BirthdayModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aMSTFirstName = json['AMST_FirstName'];
    aMSTDOB = json['AMST_DOB'];
    aMSTPhotoname = json['AMST_Photoname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['AMST_FirstName'] = aMSTFirstName;
    data['AMST_DOB'] = aMSTDOB;
    data['AMST_Photoname'] = aMSTPhotoname;
    return data;
  }
}
