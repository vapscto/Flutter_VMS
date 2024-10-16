class ParticularsPcRequestModel {
  String? type;
  List<ParticularsPcRequestModelValues>? values;

  ParticularsPcRequestModel({this.type, this.values});

  ParticularsPcRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ParticularsPcRequestModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ParticularsPcRequestModelValues.fromJson(v));
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

class ParticularsPcRequestModelValues {
  int? pcmparTId;
  int? mIId;
  String? pcmparTParticularName;
  String? pcmparTParticularDesc;
  bool? pcmparTActiveFlg;
  String? pcmparTCreatedDate;
  String? pcmparTUpdatedDate;
  int? pcmparTCreatedBy;
  int? pcmparTUpdatedBy;

  ParticularsPcRequestModelValues(
      {this.pcmparTId,
      this.mIId,
      this.pcmparTParticularName,
      this.pcmparTParticularDesc,
      this.pcmparTActiveFlg,
      this.pcmparTCreatedDate,
      this.pcmparTUpdatedDate,
      this.pcmparTCreatedBy,
      this.pcmparTUpdatedBy});

  ParticularsPcRequestModelValues.fromJson(Map<String, dynamic> json) {
    pcmparTId = json['pcmparT_Id'];
    mIId = json['mI_Id'];
    pcmparTParticularName = json['pcmparT_ParticularName'];
    pcmparTParticularDesc = json['pcmparT_ParticularDesc'];
    pcmparTActiveFlg = json['pcmparT_ActiveFlg'];
    pcmparTCreatedDate = json['pcmparT_CreatedDate'];
    pcmparTUpdatedDate = json['pcmparT_UpdatedDate'];
    pcmparTCreatedBy = json['pcmparT_CreatedBy'];
    pcmparTUpdatedBy = json['pcmparT_UpdatedBy'];
  }

  get isNotEmpty => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pcmparT_Id'] = this.pcmparTId;
    data['mI_Id'] = this.mIId;
    data['pcmparT_ParticularName'] = this.pcmparTParticularName;
    data['pcmparT_ParticularDesc'] = this.pcmparTParticularDesc;
    data['pcmparT_ActiveFlg'] = this.pcmparTActiveFlg;
    data['pcmparT_CreatedDate'] = this.pcmparTCreatedDate;
    data['pcmparT_UpdatedDate'] = this.pcmparTUpdatedDate;
    data['pcmparT_CreatedBy'] = this.pcmparTCreatedBy;
    data['pcmparT_UpdatedBy'] = this.pcmparTUpdatedBy;
    return data;
  }
}
