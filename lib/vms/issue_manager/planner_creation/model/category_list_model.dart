class Category {
  String ismmtcaT_Id;
  String ismmtcaT_TaskCategoryName;
  double ismmtcaT_TaskPercentage;

  Category(this.ismmtcaT_Id, this.ismmtcaT_TaskCategoryName,
      this.ismmtcaT_TaskPercentage);
}

class Effort {
  String ISMMTCAT_Id;
  double ISMTCRASTO_EffortInHrs;

  Effort(this.ISMMTCAT_Id, this.ISMTCRASTO_EffortInHrs);
}

class ResultCategory {
  String? CATNAME;
  double? RP;
  double? CWP;
  double? CRE;
  double? CCE;
  String? effhrcat;
  String? effmicat;
  String? effhrcatCCE;
  String? effmicatCCE;
  String? effhrcatfin;
  String? effmicatfin;

  ResultCategory({
    this.CATNAME,
    this.RP,
    this.CWP,
    this.CRE,
    this.CCE,
    this.effhrcat,
    this.effmicat,
    this.effhrcatCCE,
    this.effmicatCCE,
    this.effhrcatfin,
    this.effmicatfin,
  });
}
