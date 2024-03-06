class PlannerFileUpload {
  String? filename;
  String? filepath;
  String? refno;
  int? iSMMTCATCLId;
  String? checklistname;
  String? comments;
  int? iSMTCRId;
  PlannerFileUpload(this.filename, this.filepath, this.refno, this.iSMMTCATCLId,
      this.checklistname, this.comments, this.iSMTCRId);
  PlannerFileUpload.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    filepath = json['filepath'];
    refno = json['refno'];
    iSMMTCATCLId = json['ISMMTCATCL_Id'];
    checklistname = json['checklistname'];
    comments = json['comments'] ?? '';
    iSMTCRId = json['ISMTCR_Id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['filepath'] = filepath;
    data['refno'] = refno;
    data['ISMMTCATCL_Id'] = iSMMTCATCLId;
    data['checklistname'] = checklistname;
    data['comments'] = comments;
    data['ISMTCR_Id'] = iSMTCRId;
    return data;
  }
}
