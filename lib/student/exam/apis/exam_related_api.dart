import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';

import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/exam/model/markoverview_model.dart';
import 'package:m_skool_flutter/student/exam/model/subject_list_model.dart';
import 'package:m_skool_flutter/student/exam/model/subjectoverview_model.dart';

import '../model/academic_year_model.dart';
import '../model/exam_list_model.dart';

var dio = Dio();
Future<AcademicYearModel?> getExamAcademicYear({
  required int miID,
  required int amstID,
  required String base,
}) async {
  var url = base + URLS.getExamAcademicYear;
  logger.d(url);
  logger.d({
    "MI_Id": miID,
    "AMST_Id": amstID,
  });
  try {
    var response = await dio.post(url,
        options: Options(
          headers: getSession(),
        ),
        data: {
          "MI_Id": miID,
          "AMST_Id": amstID,
        });

    if (response.statusCode == 200) {
      AcademicYearModel academicYearModel =
          AcademicYearModel.fromJson(response.data);

      return academicYearModel;
    }
    return null;
  } on Exception catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<ExamListModel?> getExamList({
  required int miID,
  required int amstID,
  required int asmayID,
  required String base,
}) async {
  var url = base + URLS.getExamdetail;
  try {
    var response = await dio.post(url,
        options: Options(
          headers: getSession(),
        ),
        data: {
          "mI_ID": miID,
          "ASMAY_Id": asmayID,
          "AMST_Id": amstID,
        });

    if (response.statusCode == 200) {
      ExamListModel examListModel = ExamListModel.fromJson(response.data);
      return examListModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<SubjectListModel?> getSubjectList({
  required int miID,
  required int amstID,
  required int asmayID,
  required String base,
}) async {
  var url = base + URLS.getSubjectDetail;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miID,
        "ASMAY_Id": asmayID,
        "AMST_Id": amstID,
        "Type": "SWAE",
      },
    );
    if (response.statusCode == 200) {
      SubjectListModel subjectListModel =
          SubjectListModel.fromJson(response.data);

      return subjectListModel;
    } else {
      return null;
    }
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<MarkOverviewModel?> getMarkOverviewList({
  required int miID,
  required int asmayID,
  required int asmtID,
  required int emeID,
  required String base,
}) async {
  var url = base + URLS.getMarksOverview;

  logger.d(url);
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miID,
        "ASMAY_Id": asmayID,
        "AMST_Id": asmtID,
        "EME_Id": emeID,
        "Type": "EWAS"
      },
    );
    if (response.statusCode == 200) {
      MarkOverviewModel markOverviewModel =
          MarkOverviewModel.fromJson(response.data);
      return markOverviewModel;
    } else {
      return null;
    }
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<SubjectOverviewModel?> getSubjectOverviewList({
  required int miID,
  required int asmayID,
  required int asmtID,
  required int ismsID,
  required String base,
}) async {
  var url = base + URLS.getMarksOverview;
  logger.d(url);
  logger.d({
    "MI_Id": miID,
    "ASMAY_Id": asmayID,
    "AMST_Id": asmtID,
    "ISMS_Id": ismsID,
    "Type": "SWAE"
  });
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miID,
        "ASMAY_Id": asmayID,
        "AMST_Id": asmtID,
        "ISMS_Id": ismsID,
        "Type": "SWAE"
      },
    );
    if (response.statusCode == 200) {
      SubjectOverviewModel subjectOverviewModel =
          SubjectOverviewModel.fromJson(response.data);
      return subjectOverviewModel;
    } else {
      return null;
    }
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
