import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/all_rating_emp_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/all_rating_month.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/rating_data_list_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/rating_year_model.dart';

class EmpRatingController extends GetxController {
  RxBool isEmpLoading = RxBool(false);
  RxBool isRatingLoading = RxBool(false);
  void empLoad(bool l) {
    isEmpLoading.value = l;
  }

  void rating(bool l) {
    isRatingLoading.value = l;
  }

  RxList<RatingEmpModelValues> employeeList = <RatingEmpModelValues>[].obs;
  RxList<RatingMonthModelValues> monthList = <RatingMonthModelValues>[].obs;
  RxList<RatingYearModelValues> yearList = <RatingYearModelValues>[].obs;
  RxList<RatingDataListModelValues> ratingDataList =
      <RatingDataListModelValues>[].obs;
  List<RatingDataListModelValues> employeename = [];
  List<RatingDataListModelValues> employeeId = [];
  List<RatingDataListModelValues> tempList = [];
  void getRating(List<RatingDataListModelValues> ratingData) {
    if (ratingDataList.isNotEmpty) {
      ratingDataList.clear();
      tempList.clear();
      employeename.clear();
      employeeId.clear();
    }
    ratingDataList.addAll(ratingData);
    getData();
  }

  // void processDeviationReport() {
  //   if (ratingDataList.isNotEmpty) {
  //     for (var dev in ratingDataList) {
  //       if (employeeId.isEmpty) {
  //         employeeId.add(dev);
  //       } else {
  //         dynamic count = 0;
  //         for (var emp in employeeId) {
  //           if (emp.hRMEId == dev.hRMEId) {
  //             count += 1;
  //           }
  //         }
  //         if (count == 0) {
  //           employeeId.add(dev);
  //         }
  //       }
  //     }

  //     for (var ddd in employeeId) {
  //       overallAvg = 0;
  //       for (var dd in ratingDataList) {
  //         if (dd.hRMEId == ddd.hRMEId) {
  //           dynamic qnCount = 0;
  //           if (dd.january != null && dd.january >= -2) qnCount += 1;
  //           if (dd.february != null && dd.february >= -2) qnCount += 1;
  //           if (dd.march != null && dd.march >= -2) qnCount += 1;
  //           if (dd.april != null && dd.april >= -2) qnCount += 1;
  //           if (dd.may != null && dd.may >= -2) qnCount += 1;
  //           if (dd.june != null && dd.june >= -2) qnCount += 1;
  //           if (dd.july != null && dd.july >= -2) qnCount += 1;
  //           if (dd.august != null && dd.august >= -2) qnCount += 1;
  //           if (dd.september != null && dd.september >= -2) qnCount += 1;
  //           if (dd.october != null && dd.october >= -2) qnCount += 1;
  //           if (dd.november != null && dd.november >= -2) qnCount += 1;
  //           if (dd.december != null && dd.december >= -2) qnCount += 1;
  //           if (qnCount > 0) {
  //             double rr = (dd.totalRating / qnCount);
  //             if (rr >= -2) {
  //               dd.totalRating = rr.toStringAsFixed(2);
  //             } else {
  //               dd.totalRating = 0.toStringAsFixed(2);
  //             }
  //             overallAvg += double.parse(dd.totalRating);
  //             tempList.add(dd);
  //             // tempList.add(RatingDataListModelValues(overallAvg: overallAvg));
  //           }
  //         }
  //       }
  //       if (tempList.isNotEmpty) {
  //         totalAverage = (overallAvg / tempList.length).toStringAsFixed(2);
  //         // tempList.add(RatingDataListModelValues(totalAverage: totalAverage));
  //       }
  //     }
  //   }
  //   logger.i(employeeId.toList());
  //   logger.e(tempList.toList());
  //   logger.v(totalAverage);
  // }

  void getData() {
    if (ratingDataList.isNotEmpty) {
      // ignore: unused_local_variable
      String employee = ratingDataList[0].empName!;
      for (var i in ratingDataList) {
        if (employeename.isEmpty) {
          employeename.add(
              RatingDataListModelValues(empName: i.empName, hRMEId: i.hRMEId));
        } else if (employeename.isNotEmpty) {
          var intcount = 0;
          for (var j in employeename) {
            if (j.hRMEId == i.hRMEId) {
              intcount += 1;
            }
          }
          if (intcount == 0) {
            employeename.add(RatingDataListModelValues(
                empName: i.empName, hRMEId: i.hRMEId));
          }
        }
      }
      for (var k in ratingDataList) {
        if (employeeId.isEmpty) {
          employeeId.add(RatingDataListModelValues(
              hRMEId: k.hRMEId,
              rATMQERatingQuestions: k.rATMQERatingQuestions,
              // RATMT_Id: k.RATMT_Id,
              rATMQEId: k.rATMQEId,
              empName: k.empName,
              // RATMT_RatingTypeName: k.RATMT_RatingTypeName,
              totalAverage: k.totalAverage));
        } else if (employeeId.isNotEmpty) {
          int intCount = 0;
          for (var l in employeeId) {
            if (l.hRMEId == k.hRMEId) {
              intCount += 1;
            }
          }
          if (intCount == 0) {
            employeeId.add(RatingDataListModelValues(
                hRMEId: k.hRMEId,
                rATMQERatingQuestions: k.rATMQERatingQuestions,
                // RATMT_Id: k.RATMT_Id,
                rATMQEId: k.rATMQEId,
                empName: k.empName,
                // RATMT_RatingTypeName: k.RATMT_RatingTypeName,
                totalAverage: k.totalAverage));
          }
        }
      }
      //
      for (var i in employeeId) {
        for (var j in ratingDataList) {
          if (i.hRMEId == j.hRMEId) {
            dynamic qnCount = 0;
            if (i.january != null && j.january >= -2) {
              qnCount += 1;
            }
            if (i.february != null && j.february >= -2) {
              qnCount += 1;
            }
            if (i.march != null && j.march >= -2) {
              qnCount += 1;
            }
            if (i.april != null && j.april >= -2) {
              qnCount += 1;
            }
            if (i.may != null && j.may >= -2) {
              qnCount += 1;
            }
            if (i.june != null && j.june >= -2) {
              qnCount += 1;
            }
            if (i.july != null && j.july >= -2) {
              qnCount += 1;
            }
            if (i.august != null && j.august >= -2) {
              qnCount += 1;
            }
            if (i.september != null && j.september >= -2) {
              qnCount += 1;
            }
            if (i.october != null && j.october >= -2) {
              qnCount += 1;
            }
            if (i.november != null && j.november >= -2) {
              qnCount += 1;
            }
            if (i.december != null && j.december >= -2) {
              qnCount += 1;
            }
            if (qnCount > 0) {
              double rr = (j.totalRating / qnCount);
              if (rr >= -2) {
                j.totalRating = rr;
              } else {
                j.totalRating = 0;
              }
              overallAvg += double.parse(j.totalRating);
              j.overallAvg = overallAvg;
            }
            tempList.add(j);
          }
        }
        i.totalAverage = (overallAvg / tempList.length);
      }
    }
  }

  dynamic totalAverage;
  double overallAvg = 0;
  //
  RxList<bool> checkBox = <bool>[].obs;
  RxList<RatingEmpModelValues> selectedEmployeeList =
      <RatingEmpModelValues>[].obs;
  void addToSelectedEmployee(RatingEmpModelValues sele) {
    selectedEmployeeList.add(sele);
  }

  void removeFromSelectedEmployee(RatingEmpModelValues sele) {
    selectedEmployeeList.remove(sele);
  }

  //
  RxList<RatingMonthModelValues> selectedMonthList =
      <RatingMonthModelValues>[].obs;
  void addToSelectedMonth(RatingMonthModelValues sele) {
    selectedMonthList.add(sele);
  }

  void removeFromSelectedMonth(RatingMonthModelValues sele) {
    selectedMonthList.remove(sele);
  }

  //
  RxList<RatingYearModelValues> selectedYearList =
      <RatingYearModelValues>[].obs;
  void addToSelectedYear(RatingYearModelValues sele) {
    selectedYearList.add(sele);
  }

  void removeFromSelectedYear(RatingYearModelValues sele) {
    selectedYearList.remove(sele);
  }
}

class Employee {
  dynamic slNo;
  String? empName;
  dynamic overallAverage;
  dynamic questions;
  dynamic january;
  dynamic february;
  dynamic march;
  dynamic april;
  dynamic may;
  dynamic june;
  dynamic july;
  dynamic august;
  dynamic september;
  dynamic october;
  dynamic november;
  dynamic december;
  String? totalAverage;

  Employee({
    this.slNo,
    this.empName,
    this.overallAverage,
    this.questions,
    this.january,
    this.february,
    this.march,
    this.april,
    this.may,
    this.june,
    this.july,
    this.august,
    this.september,
    this.october,
    this.november,
    this.december,
    this.totalAverage,
  });
}
