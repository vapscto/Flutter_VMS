import 'package:dio/dio.dart';
import 'package:m_skool_flutter/Principal/toperWise/controller/examwise_toper_home_controller.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/academic_year_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/exam_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/section_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/subject_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/top_class_model.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<void> featchAcademic(
    {required int miId,
    required base,
    required ExamWiseToperController controller}) async {
  final String api = base + URLS.toperWiseSearch;

  final Dio ins = getGlobalDio();
  logger.d(base);
  logger.d(api);
  logger.d({
    "MI_ID": miId,
  });

  if (controller.isErrorOccuredWhileLoadingAcademic.value) {
    controller.updateIsErrorOccuredWhileLoadingAcademic(false);
  }
  controller.updateIsLoadingAcademicYear(true);
  controller.updateIsLoadingCategory(true);
  try {
    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
    });
    logger.d(response.data["acdlist"]);
    if (response.data["acdlist"] == null) {
      controller.updateIsErrorOccuredWhileLoadingAcademic(true);
      controller.updateIsLoadingAcademicYear(false);
      return;
    }

    final AcademicListModel selectedyear =
        AcademicListModel.fromJson(response.data['acdlist']);
    // logger.d(selectedAcademic.values!);
    final TopClassListModel selectedClass =
        TopClassListModel.fromJson(response.data['ctlist']);
    final TopSectonListModel selectSection =
        TopSectonListModel.fromJson(response.data['seclist']);

    final TopExamListModel selectExam =
        TopExamListModel.fromJson(response.data['examlist']);
    final TopSubjectListModel selectSubject =
        TopSubjectListModel.fromJson(response.data['sublist']);
    logger.d(selectedyear.values!);
    if (selectedClass.values!.isNotEmpty) {
      controller.selectedClass = selectedClass.values?.first;
    }
    if (selectedyear.values!.isNotEmpty) {
      controller.selectedAcademicYear = selectedyear.values?.first;
    }
    if (selectSection.values!.isNotEmpty) {
      controller.selectedSection = selectSection.values?.first;
    }
    if (selectExam.values!.isNotEmpty) {
      controller.selectedExam = selectExam.values?.first;
    }
    if (selectSubject.values!.isNotEmpty) {
      controller.selectedExamSubject = selectSubject.values?.first;
    }
    controller.updateSection(selectSection.values!);
    controller.updateAcademic(selectedyear.values!);
    controller.updateClass(selectedClass.values!);
    controller.updateExam(selectExam.values!);
    controller.subjectTop.addAll(selectSubject.values!);
   controller.updateSubject(selectSubject.values!);
    controller.updateIsErrorOccuredWhileLoadingAcademic(false);
    controller.updateIsLoadingAcademicYear(false);
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredWhileLoadingAcademic(true);
    controller.updateIsLoadingAcademicYear(false);
  }
}
