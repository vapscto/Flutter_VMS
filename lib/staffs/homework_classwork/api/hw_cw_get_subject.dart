import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_subject_model.dart';

class HwCwGetSubjectsApi {
  HwCwGetSubjectsApi.init();
  static final HwCwGetSubjectsApi instance = HwCwGetSubjectsApi.init();

  Future<void> getSubjects({
    required int miId,
    required int asmayId,
    required int asmclId,
    required List<Map<String, dynamic>> sections,
    required int ivrmrtId,
    required int loginId,
    required String base,
    required int hrmeId,
    required HwCwController hwCwController,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.getSubjects;
    if (hwCwController.isErrorOccuredLoadingSubject.value) {
      hwCwController.updateIsErrorOccuredLoadingSubject(false);
    }
    hwCwController.updateLoadingStatus(
        "We are in process to loading subject's for selected Academic Year, Class and section");
    hwCwController.updateIsSubjectLoading(true);
    logger.d({
      "MI_Id": miId,
      "Login_Id": loginId,
      "ASMAY_Id": asmayId,
      "ASMCL_Id": asmclId,
      "hm_section_list": sections,
      "IVRMRT_Id": ivrmrtId,
      "HRME_Id": hrmeId,
    });
    try {
      final Response response = await ins.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "Login_Id": loginId,
          "ASMAY_Id": asmayId,
          "ASMCL_Id": asmclId,
          "hm_section_list": sections,
          "IVRMRT_Id": ivrmrtId,
          "HRME_Id": hrmeId,
        },
      );
      if (response.data['subjectlist'] == null) {
        hwCwController.updateIsSectionLoading(false);
        hwCwController.updateIsErrorOccuredLoadingSubject(true);
        hwCwController.updateErrorStatus(
            "No Subject are present in record, try changing class, section or academic year, or do contact your technical team for assistance");
        return;
      }
      final HwCwSubjectListModel subjectListModel =
          HwCwSubjectListModel.fromJson(response.data['subjectlist']);
      if (subjectListModel.values!.isNotEmpty) {
        hwCwController.updateSelectedSubject(subjectListModel.values!.first);
      }
      hwCwController.updateSubjects(subjectListModel.values!);
      hwCwController.updateIsSubjectLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      hwCwController.updateIsSubjectLoading(false);
      hwCwController.updateErrorStatus(e.message);
      hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
      return;
    } on Exception catch (e) {
      logger.e(e.toString());
      hwCwController.updateIsSubjectLoading(false);
      hwCwController.updateErrorStatus(
          "An Internal error Occured, while trying to create a view for you. you can try again later");
      hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
      return;
    }
  }
}
