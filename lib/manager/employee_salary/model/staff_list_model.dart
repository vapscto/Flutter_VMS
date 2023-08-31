class StaffListModel {
  String? type;
  List<StaffListValues>? values;

  StaffListModel({this.type, this.values});

  StaffListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffListValues>[];
      json['\$values'].forEach((v) {
        values!.add(StaffListValues.fromJson(v));
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

class StaffListValues {
  num? hreSId;
  num? mIId;
  num? hrmEId;
  num? roleId;
  String? hrmEEmployeeLastName;
  String? hrmEEmployeeMiddleName;
  String? hrmEEmployeeFirstName;
  num? lopAmount;
  num? hrCId;
  bool? hrCAsPerEmpFlag;
  num? hrCRetirementYrs;
  num? hrCSalaryFromDay;
  num? hrCSalaryToDay;

  StaffListValues(
      {this.hreSId,
      this.mIId,
      this.hrmEId,
      this.roleId,
      this.hrmEEmployeeLastName,
      this.hrmEEmployeeMiddleName,
      this.hrmEEmployeeFirstName,
      this.lopAmount,
      this.hrCId,
      this.hrCAsPerEmpFlag,
      this.hrCRetirementYrs,
      this.hrCSalaryFromDay,
      this.hrCSalaryToDay});

  StaffListValues.fromJson(Map<String, dynamic> json) {
    hreSId = json['hreS_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    roleId = json['roleId'];
    hrmEEmployeeLastName = json['hrmE_EmployeeLastName'];
    hrmEEmployeeMiddleName = json['hrmE_EmployeeMiddleName'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    lopAmount = json['lopAmount'];
    hrCId = json['hrC_Id'];
    hrCAsPerEmpFlag = json['hrC_AsPerEmpFlag'];
    hrCRetirementYrs = json['hrC_RetirementYrs'];
    hrCSalaryFromDay = json['hrC_SalaryFromDay'];
    hrCSalaryToDay = json['hrC_SalaryToDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hreS_Id'] = hreSId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['roleId'] = roleId;
    data['hrmE_EmployeeLastName'] = hrmEEmployeeLastName;
    data['hrmE_EmployeeMiddleName'] = hrmEEmployeeMiddleName;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['lopAmount'] = lopAmount;
    data['hrC_Id'] = hrCId;
    data['hrC_AsPerEmpFlag'] = hrCAsPerEmpFlag;
    data['hrC_RetirementYrs'] = hrCRetirementYrs;
    data['hrC_SalaryFromDay'] = hrCSalaryFromDay;
    data['hrC_SalaryToDay'] = hrCSalaryToDay;
    return data;
  }
}
