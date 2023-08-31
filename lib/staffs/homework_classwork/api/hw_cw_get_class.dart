import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_classes_model.dart';

class HwCwGetClassApi {
  HwCwGetClassApi.init();
  static final HwCwGetClassApi instance = HwCwGetClassApi.init();

  Future<void> getHwCwClasses({
    required int miId,
    required int loginId,
    required int asmayId,
    required int ivrmrtId,
    required String base,
    required int hrmeId,
    required HwCwController hwCwController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String apiUrl = base + URLS.getHwClass;
      if (hwCwController.isErrorOccuredLoadingClass.value) {
        hwCwController.updateIsErrorOccuredLoadingClass(false);
      }
      hwCwController.updateLoadingStatus(
          "We are in process to loading class's for selected Academic Year");
      hwCwController.updateIsClassLoading(true);

      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "Login_Id": loginId,
        "ASMAY_Id": asmayId,
        "IVRMRT_Id": ivrmrtId,
        "HRME_Id": hrmeId,
      });

      if (response.data['classlist'] == null) {
        hwCwController.updateIsClassLoading(false);
        hwCwController.updateErrorStatus(
            "No Classes are present in record, Please contact your technical team for assistance");
        hwCwController.updateIsErrorOccuredLoadingClass(true);

        return;
      }
      final HwCwClassesListModel classes =
          HwCwClassesListModel.fromJson(response.data['classlist']);
      if (classes.values!.isNotEmpty) {
        hwCwController.updateSelectedClass(classes.values!.first);
      }
      hwCwController.updateClasses(classes.values!);
      hwCwController.updateIsClassLoading(false);
    } on DioError catch (e) {
      hwCwController.updateIsClassLoading(false);
      hwCwController.updateErrorStatus(e.message);
      hwCwController.updateIsErrorOccuredLoadingClass(true);
      logger.e(e.message);
      return;
    } on Exception catch (e) {
      logger.e(e.toString());
      hwCwController.updateIsClassLoading(false);
      hwCwController.updateErrorStatus(
          "An Internal error Occured, while trying to create a view for you. you can try again later");
      hwCwController.updateIsErrorOccuredLoadingAcademicYear(true);
      return;
    }
  }
}
