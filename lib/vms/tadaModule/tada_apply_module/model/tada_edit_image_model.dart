class EditUploadImageModel {
  String? type;
  List<EditUploadImageModelValues>? values;

  EditUploadImageModel({this.type, this.values});

  EditUploadImageModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EditUploadImageModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(EditUploadImageModelValues.fromJson(v));
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

class EditUploadImageModelValues {
  int? id;
  int? vtadaaFId;
  int? vtadaAId;
  String? vtadaaFFileName;
  String? vtadaaFFilePath;
  bool? vtadaaFApprovedFlg;
  String? vtadaaFRemarks;
  String? vtadaaFStatusFlg;
  bool? vtadaaFActiveFlag;

  EditUploadImageModelValues(
      {this.id,
      this.vtadaaFId,
      this.vtadaAId,
      this.vtadaaFFileName,
      this.vtadaaFFilePath,
      this.vtadaaFApprovedFlg,
      this.vtadaaFRemarks,
      this.vtadaaFStatusFlg,
      this.vtadaaFActiveFlag});

  EditUploadImageModelValues.fromJson(Map<String, dynamic> json) {
    vtadaaFId = json['vtadaaF_Id'];
    vtadaAId = json['vtadaA_Id'];
    vtadaaFFileName = json['vtadaaF_FileName'];
    vtadaaFFilePath = json['vtadaaF_FilePath'];
    vtadaaFApprovedFlg = json['vtadaaF_ApprovedFlg'];
    vtadaaFRemarks = json['vtadaaF_Remarks'];
    vtadaaFStatusFlg = json['vtadaaF_StatusFlg'];
    vtadaaFActiveFlag = json['vtadaaF_ActiveFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vtadaaF_Id'] = vtadaaFId;
    data['vtadaA_Id'] = vtadaAId;
    data['vtadaaF_FileName'] = vtadaaFFileName;
    data['vtadaaF_FilePath'] = vtadaaFFilePath;
    data['vtadaaF_ApprovedFlg'] = vtadaaFApprovedFlg;
    data['vtadaaF_Remarks'] = vtadaaFRemarks;
    data['vtadaaF_StatusFlg'] = vtadaaFStatusFlg;
    data['vtadaaF_ActiveFlag'] = vtadaaFActiveFlag;
    return data;
  }
}
