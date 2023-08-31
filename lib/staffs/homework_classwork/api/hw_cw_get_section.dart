import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_section_model.dart';

class HwCwGetSection {
  HwCwGetSection.init();
  static final HwCwGetSection instance = HwCwGetSection.init();

  Future<void> getSections({
    required int miId,
    required int ivrmrtId,
    required int asmayId,
    required int userId,
    required int loginId,
    required int asmclId,
    required String base,
    required int hrmeId,
    required HwCwController hwCwController,
    required bool fromVerifyCat,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String apiUrl = base + URLS.getSection;

      if (hwCwController.isErrorOccuredLoadingSection.value) {
        hwCwController.updateIsErrorOccuredLoadingSection(true);
      }
      hwCwController.updateLoadingStatus(
          "We are in process to loading section's for selected Academic Year, and class");
      hwCwController.updateIsSectionLoading(true);

      // logger.d({
      //   "MI_Id": miId,
      //   "Login_Id": loginId,
      //   "UserId": userId,
      //   "ivrmrT_Id": ivrmrtId,
      //   "ASMAY_Id": asmayId,
      //   "ASMCL_Id": asmclId,
      //   "IVRMRT_Id": ivrmrtId,
      // });
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "Login_Id": loginId,
        "UserId": userId,
        "ivrmrT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "IVRMRT_Id": ivrmrtId,
        "HRME_Id": 28,
      });

      if (response.data['sectionlist'] == null) {
        hwCwController.updateIsSectionLoading(false);
        hwCwController.updateErrorStatus(
            "No Section were found for selected Classes, Try with another class or contact your technical team for assistance");
        hwCwController.updateIsErrorOccuredLoadingSection(true);

        return;
      }
      final HwCwSectionListModel sectionListModel =
          HwCwSectionListModel.fromJson(response.data['sectionlist']);
      //logger.d("message 420");
      if (fromVerifyCat == true) {
        logger.d("message");
        logger.d(sectionListModel.values!.first.toJson());
        hwCwController
            .updateVerifySelectedSection(sectionListModel.values!.first);
      } else {
        if (hwCwController.selectedSection.isNotEmpty) {
          hwCwController.selectedSection.clear();
        }
        if (sectionListModel.values!.isNotEmpty) {
          hwCwController.updateSelectedSection(sectionListModel.values!.first);
        }
      }

      hwCwController.updateSections(sectionListModel.values!);
      hwCwController.updateIsSectionLoading(false);
    } on DioError catch (e) {
      hwCwController.updateIsSectionLoading(false);
      hwCwController.updateErrorStatus(e.message);
      hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
      logger.e(e.message);
      return;
    } on Exception catch (e) {
      logger.e(e.toString());
      hwCwController.updateIsSectionLoading(false);
      hwCwController.updateErrorStatus(
          "An Internal error Occured, while trying to create a view for you. you can try again later");
      hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
      return;
    }
  }
}
