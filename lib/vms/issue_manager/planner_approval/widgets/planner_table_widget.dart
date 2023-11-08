class AllPlannerTable {
  bool flag;
  String taskNo;
  String taskName;
  String taskType;
  String clint;
  String category;
  String periodicity;
  String plannedDate;
  String createdBy;
  String date;
  String effort;
  String duration;
  String remarks;
  int ismtpltaId;
  int ismtcrId;
  String status;
  int ptsCount;
  String startDate;
  String endDate;

  AllPlannerTable(
      this.flag,
      this.taskNo,
      this.taskName,
      this.taskType,
      this.clint,
      this.category,
      this.periodicity,
      this.plannedDate,
      this.date,
      this.effort,
      this.remarks,
      this.ismtpltaId,
      this.createdBy,
      this.duration,
      this.ismtcrId,
      this.status,
      this.ptsCount,
      this.startDate,
      this.endDate);
}
