class SearchResultModel {
  String? type;
  List<SearchResultModelValues>? values;

  SearchResultModel({this.type, this.values});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    type = json['\\$type'];
    if (json['\$values'] != null) {
      values = <SearchResultModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SearchResultModelValues.fromJson(v));
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

class SearchResultModelValues {
  String? type;
  String? amsTRegistrationNo;
  String? amsTFirstName;
  String? amsTDate;
  String? amsTDOB;
  String? amsTSex;
  String? amsTMotherName;
  String? amsTFatherName;
  String? amsTEmailId;
  int? amsTMobileNo;
  dynamic amsTStuBankAccNo;
  int? amsTAadharNo;
  String? amsTAdmNo;
  dynamic amsTBirthCertNO;
  String? amsTBloodGroup;
  int? amsTFatherAadharNo;
  String? amsTFatherBankAccNo;
  String? asmcLClassName;
  String? asmCSectionName;
  String? aMSTPhotoname;
  String? addressd1;
  int? aMSTId;

  SearchResultModelValues(
      {this.type,
      this.amsTRegistrationNo,
      this.amsTFirstName,
      this.amsTDate,
      this.amsTDOB,
      this.amsTSex,
      this.amsTMotherName,
      this.amsTFatherName,
      this.amsTEmailId,
      this.amsTMobileNo,
      this.amsTStuBankAccNo,
      this.amsTAadharNo,
      this.amsTAdmNo,
      this.amsTBirthCertNO,
      this.amsTBloodGroup,
      this.amsTFatherAadharNo,
      this.amsTFatherBankAccNo,
      this.asmcLClassName,
      this.asmCSectionName,
      this.aMSTPhotoname,
      this.addressd1,
      this.aMSTId});

  SearchResultModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    amsTRegistrationNo = json['amsT_RegistrationNo'];
    amsTFirstName = json['amsT_FirstName'];
    amsTDate = json['amsT_Date'];
    amsTDOB = json['amsT_DOB'];
    amsTSex = json['amsT_Sex'];
    amsTMotherName = json['amsT_MotherName'];
    amsTFatherName = json['amsT_FatherName'];
    amsTEmailId = json['amsT_emailId'];
    amsTMobileNo = json['amsT_MobileNo'];
    amsTStuBankAccNo = json['amsT_StuBankAccNo'];
    amsTAadharNo = json['amsT_AadharNo'];
    amsTAdmNo = json['amsT_AdmNo'];
    amsTBirthCertNO = json['amsT_BirthCertNO'];
    amsTBloodGroup = json['amsT_BloodGroup'];
    amsTFatherAadharNo = json['amsT_FatherAadharNo'];
    amsTFatherBankAccNo = json['amsT_FatherBankAccNo'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    aMSTPhotoname = json['AMST_Photoname'];
    addressd1 = json['addressd1'];
    aMSTId = json['AMST_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['amsT_RegistrationNo'] = amsTRegistrationNo;
    data['amsT_FirstName'] = amsTFirstName;
    data['amsT_Date'] = amsTDate;
    data['amsT_DOB'] = amsTDOB;
    data['amsT_Sex'] = amsTSex;
    data['amsT_MotherName'] = amsTMotherName;
    data['amsT_FatherName'] = amsTFatherName;
    data['amsT_emailId'] = amsTEmailId;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['amsT_StuBankAccNo'] = amsTStuBankAccNo;
    data['amsT_AadharNo'] = amsTAadharNo;
    data['amsT_AdmNo'] = amsTAdmNo;
    data['amsT_BirthCertNO'] = amsTBirthCertNO;
    data['amsT_BloodGroup'] = amsTBloodGroup;
    data['amsT_FatherAadharNo'] = amsTFatherAadharNo;
    data['amsT_FatherBankAccNo'] = amsTFatherBankAccNo;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmC_SectionName'] = asmCSectionName;
    data['AMST_Photoname'] = aMSTPhotoname;
    data['addressd1'] = addressd1;
    data['AMST_Id'] = aMSTId;
    return data;
  }
}
