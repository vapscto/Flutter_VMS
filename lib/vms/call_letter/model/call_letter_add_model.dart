class CallLetterModel {
  int? callLetterNo;
  String? candidateName;
  String? address;
  String? positionName;
  String? candidateEmail;
  String? companyName;
  String? jobSite;
  String? jobLocation;
  String? jobPostDate;
  String? interviewDate;
  String? interviewTime;
  String? officeMailId;
  String? officePhoneNo;
  CallLetterModel(
      {this.callLetterNo,
      this.candidateName,
      this.address,
      this.positionName,
      this.candidateEmail,
      this.companyName,
      this.jobSite,
      this.jobLocation,
      this.jobPostDate,
      this.interviewDate,
      this.interviewTime,
      this.officeMailId,
      this.officePhoneNo});
  CallLetterModel.fromJson(Map<String, dynamic> json) {
    callLetterNo = json['callLetterNo'];
    candidateName = json['candidateName'];
    address = json['address'];
    positionName = json['positionName'];
    candidateEmail = json['candidateEmail'];
    companyName = json['companyName'];
    jobSite = json['jobSite'];
    jobLocation = json['jobLocation'];
    jobPostDate = json['jobPostDate'];
    interviewDate = json['interviewDate'];
    interviewTime = json['interviewTime'];
    officeMailId = json['officeMailId'];
    officePhoneNo = json['officePhoneNo'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['callLetterNo'] = callLetterNo;
    data['candidateName'] = candidateName;
    data['address'] = address;
    data['positionName'] = positionName;
    data['candidateEmail'] = candidateEmail;
    data['companyName'] = companyName;
    data['jobSite'] = jobSite;
    data['jobLocation'] = jobLocation;
    data['jobPostDate'] = jobPostDate;
    data['interviewDate'] = interviewDate;
    data['interviewTime'] = interviewTime;
    data['officeMailId'] = officeMailId;
    data['officePhoneNo'] = officePhoneNo;
    return data;
  }
}
