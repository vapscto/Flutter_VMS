import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_sub_list_model.dart';

class VerifyCwSubjectListApi {
  VerifyCwSubjectListApi.init();
  static final VerifyCwSubjectListApi instance = VerifyCwSubjectListApi.init();

  getCwSubjects(
      {required int miId,
      required int hrme,
      required int loginId,
      required int userId,
      required int ivrmrtId,
      required int asmayId,
      required int asmscld,
      required int asmsId,
      required String base,
      required HwCwController hwCwController}) async {
    final apiUrl = base + URLS.verifySub;
    final Dio ins = getGlobalDio();
    if (hwCwController.isErrorOccuredLoadingSubject.value) {
      hwCwController.updateIsErrorOccuredLoadingSubject(false);
    }
    hwCwController.updateLoadingStatus(
        "We are in process to loading subject's for selected Academic Year, Class and section");
    hwCwController.updateIsSubjectLoading(true);
    try {
      logger.d({
        "MI_Id": miId,
        "HRME_Id": hrme,
        "Login_Id": loginId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "Role_flag": "Staff",
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmscld,
        "ASMS_Id": asmsId
      });
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "HRME_Id": hrme,
        "Login_Id": loginId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "Role_flag": "Staff",
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmscld,
        "ASMS_Id": asmsId
      });
      if (response.data['getsubject_list'] == null) {
        hwCwController.updateIsSectionLoading(false);
        hwCwController.updateIsErrorOccuredLoadingSubject(true);
        hwCwController.updateErrorStatus(
            "No Subject are present in record, try changing class, section or academic year, or do contact your technical team for assistance");
        return;
      }
      final VerifyCwSubjectListModel verifyCwSubjectListModel =
          VerifyCwSubjectListModel.fromJson(response.data['getsubject_list']);

      if (verifyCwSubjectListModel.values!.isNotEmpty) {
        hwCwController
            .updateSelectedCwSubject(verifyCwSubjectListModel.values!.first);
      }
      hwCwController.updateCwSubjectList(verifyCwSubjectListModel.values!);
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
