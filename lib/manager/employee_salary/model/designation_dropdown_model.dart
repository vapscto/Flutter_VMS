class DesignationDropdownModel {
  String? type;
  List<DesignationDropdownValues>? values;

  DesignationDropdownModel({this.type, this.values});

  DesignationDropdownModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DesignationDropdownValues>[];
      json['\$values'].forEach((v) {
        values!.add(DesignationDropdownValues.fromJson(v));
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

class DesignationDropdownValues {
  num? hreSId;
  num? mIId;
  num? hrmEId;
  String? hrmdeSDesignationName;
  num? hrmdeSId;
  num? roleId;
  num? lopAmount;
  num? hrCId;
  bool? hrCAsPerEmpFlag;
  num? hrCRetirementYrs;
  num? hrCSalaryFromDay;
  num? hrCSalaryToDay;

  DesignationDropdownValues(
      {this.hreSId,
      this.mIId,
      this.hrmEId,
      this.hrmdeSDesignationName,
      this.hrmdeSId,
      this.roleId,
      this.lopAmount,
      this.hrCId,
      this.hrCAsPerEmpFlag,
      this.hrCRetirementYrs,
      this.hrCSalaryFromDay,
      this.hrCSalaryToDay});

  DesignationDropdownValues.fromJson(Map<String, dynamic> json) {
    hreSId = json['hreS_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    hrmdeSDesignationName = json['hrmdeS_DesignationName'];
    hrmdeSId = json['hrmdeS_Id'];
    roleId = json['roleId'];
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
    data['hrmdeS_DesignationName'] = hrmdeSDesignationName;
    data['hrmdeS_Id'] = hrmdeSId;
    data['roleId'] = roleId;
    data['lopAmount'] = lopAmount;
    data['hrC_Id'] = hrCId;
    data['hrC_AsPerEmpFlag'] = hrCAsPerEmpFlag;
    data['hrC_RetirementYrs'] = hrCRetirementYrs;
    data['hrC_SalaryFromDay'] = hrCSalaryFromDay;
    data['hrC_SalaryToDay'] = hrCSalaryToDay;
    return data;
  }
}
