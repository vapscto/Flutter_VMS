import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/exam/apis/exam_related_api.dart';
import 'package:m_skool_flutter/student/exam/model/markoverview_model.dart';
import 'package:m_skool_flutter/student/exam/model/subjectoverview_model.dart';

import '../model/academic_year_model.dart';
import '../model/exam_list_model.dart';
import '../model/subject_list_model.dart';

class ExamController extends GetxController {
  RxList<AcademicYearValues> academicYearList = <AcademicYearValues>[].obs;
  RxList<ExamListValue> examList = <ExamListValue>[].obs;
  RxList<SubjectListValue> subjectList = <SubjectListValue>[].obs;
  RxList<ExamWiseReportListValue> examwiseMarkOverview =
      <ExamWiseReportListValue>[].obs;
  RxList<SubjectWiseReportListValue> subjectwiseMarkOverview =
      <SubjectWiseReportListValue>[].obs;

  List<Color> chipColor = const [
    Color.fromRGBO(255, 211, 211, 1),
    Color.fromRGBO(202, 230, 255, 1),
    Color.fromRGBO(219, 195, 254, 1),
    Color.fromRGBO(172, 239, 233, 1),
////////////
    Color.fromRGBO(255, 211, 211, 1),
    Color.fromRGBO(202, 230, 255, 1),
    Color.fromRGBO(219, 195, 254, 1),
    Color.fromRGBO(172, 239, 233, 1),
    /////
    ///
    Color.fromRGBO(255, 211, 211, 1),
    Color.fromRGBO(202, 230, 255, 1),
    Color.fromRGBO(219, 195, 254, 1),
    Color.fromRGBO(172, 239, 233, 1),
  ];
  List<Color> containerColor = const [
    Color.fromRGBO(255, 232, 231, 0.4),
    Color.fromRGBO(211, 239, 255, 0.4),
    Color.fromRGBO(238, 232, 255, 0.4),
    Color.fromRGBO(202, 244, 244, 0.4),
////////
    Color.fromRGBO(255, 232, 231, 0.4),
    Color.fromRGBO(211, 239, 255, 0.4),
    Color.fromRGBO(238, 232, 255, 0.4),
    Color.fromRGBO(202, 244, 244, 0.4),
    ///////
    Color.fromRGBO(255, 232, 231, 0.4),
    Color.fromRGBO(211, 239, 255, 0.4),
    Color.fromRGBO(238, 232, 255, 0.4),
    Color.fromRGBO(202, 244, 244, 0.4),
  ];
  List<Color> gradeColor = const [
    Color.fromRGBO(15, 141, 133, 1),
    Color.fromRGBO(234, 142, 5, 1),
    Color.fromRGBO(236, 22, 240, 1),
    Colors.redAccent,
/////
    Color.fromRGBO(15, 141, 133, 1),
    Color.fromRGBO(234, 142, 5, 1),
    Color.fromRGBO(236, 22, 240, 1),
    Colors.redAccent,
    ////
    Color.fromRGBO(15, 141, 133, 1),
    Color.fromRGBO(234, 142, 5, 1),
    Color.fromRGBO(236, 22, 240, 1),
    Colors.redAccent,
  ];

  AcademicYearValues? selectedYear;
  ExamListValue? selectedExam;

  RxBool isLoading = RxBool(false);
  RxBool isSubjectWiseLoading = RxBool(false);
  RxBool isDataListLoading = RxBool(false);
  RxBool issubjectdata = RxBool(false);

  void isloading(bool loading) {
    isLoading.value = loading;
  }

  void issubjectData(bool loading) {
    issubjectdata.value = loading;
  }

  void issubjectwiseloading(bool loading) {
    isSubjectWiseLoading.value = loading;
  }

  void isDataListloading(bool loading) {
    isDataListLoading.value = loading;
  }

  Future<bool> getAcademicYearData({
    required int miID,
    required int amstID,
    required String base,
  }) async {
    AcademicYearModel? academicYearModel =
        await getExamAcademicYear(miID: miID, amstID: amstID, base: base);

    academicYearList.clear();
    examList.clear();
    examwiseMarkOverview.clear();

    try {
      if (academicYearModel!.studetiallist != null ||
          academicYearModel.studetiallist!.values != null) {
        for (var i = 0;
            i < academicYearModel.studetiallist!.values!.length;
            i++) {
          academicYearList
              .add(academicYearModel.studetiallist!.values!.elementAt(i));
        }
        selectedYear = academicYearModel.studetiallist!.values!.first;
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Unable to get data..');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getExamListData({
    required int miID,
    required int amstID,
    required int asmayID,
    required String base,
  }) async {
    ExamListModel? examListModel = await getExamList(
        miID: miID, amstID: amstID, asmayID: asmayID, base: base);

    try {
      if (examListModel!.examlist != null ||
          examListModel.examlist!.values != null) {
        for (var i = 0; i < examListModel.examlist!.values!.length; i++) {
          examList.add(examListModel.examlist!.values!.elementAt(i));
        }
        selectedExam = examListModel.examlist!.values!.first;
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Unable to get data..');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSubjectListData({
    required int miID,
    required int amstID,
    required int asmayID,
    required String base,
  }) async {
    SubjectListModel? subjectListModel = await getSubjectList(
        miID: miID, amstID: amstID, asmayID: asmayID, base: base);
    try {
      if (subjectListModel!.subjectlist != null ||
          subjectListModel.subjectlist!.values != null) {
        for (var i = 0; i < subjectListModel.subjectlist!.values!.length; i++) {
          subjectList.add(subjectListModel.subjectlist!.values!.elementAt(i));
        }
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Unable to get data..');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getMarkOverviewData({
    required int miID,
    required int asmayID,
    required int asmtID,
    required int emeID,
    required String base,
  }) async {
    MarkOverviewModel? markOverviewModel = await getMarkOverviewList(
        miID: miID, asmayID: asmayID, asmtID: asmtID, emeID: emeID, base: base);

    try {
      if (markOverviewModel!.examReportList != null ||
          markOverviewModel.examReportList!.values != null) {
        for (int i = 0;
            i < markOverviewModel.examReportList!.values!.length;
            i++) {
          examwiseMarkOverview
              .add(markOverviewModel.examReportList!.values!.elementAt(i));
        }
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Unable to get data..');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSubjectWiseOverviewData({
    required int miID,
    required int asmayID,
    required int asmtID,
    required int ismsID,
    required String base,
  }) async {
    SubjectOverviewModel? subjectOverviewModel = await getSubjectOverviewList(
        miID: miID,
        asmayID: asmayID,
        asmtID: asmtID,
        ismsID: ismsID,
        base: base);

    try {
      if (subjectOverviewModel!.examReportList != null ||
          subjectOverviewModel.examReportList!.values != null) {
        for (int i = 0;
            i < subjectOverviewModel.examReportList!.values!.length;
            i++) {
          subjectwiseMarkOverview
              .add(subjectOverviewModel.examReportList!.values!.elementAt(i));
        }
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Unable to get data..');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
