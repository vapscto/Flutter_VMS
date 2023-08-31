import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/manager/feedemo/controller/fee_demo_controller.dart';
import 'package:m_skool_flutter/manager/feedemo/model/fee_demo_year_model.dart';
import '../../../main.dart';

class GetFeeDemoInitialDataApi {
  GetFeeDemoInitialDataApi.init();

  static final GetFeeDemoInitialDataApi instance =
      GetFeeDemoInitialDataApi.init();

  getYearList({
    required int miId,
    required int asmayId,
    required String base,
    required FeeDemoController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.feeDemoInitialData;
    logger.d(api);
    if (controller.isErrorOccuredWhileLoadingAcademicYear.value) {
      controller.updateIsErrorOcuuredWhileLoadingAcademicYear(false);
    }
    controller.updateIsLoadingAcademicYear(true);
    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId});
           logger.d( {"MI_Id": miId});

      if (response.data['yearlist'] == null) {
        controller.updateIsErrorOcuuredWhileLoadingAcademicYear(true);
        controller.updateIsLoadingAcademicYear(false);
        return;
      }

      final FeeDemoAcademicYear academicYear =
          FeeDemoAcademicYear.fromJson(response.data['yearlist']);

      controller.updateAcademicYear(academicYear.values!);
      controller.selectedAcademicYear = academicYear.values!.first;
      controller.updateIsLoadingAcademicYear(false);
      controller.updateIsErrorOcuuredWhileLoadingAcademicYear(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOcuuredWhileLoadingAcademicYear(true);
      controller.updateIsLoadingAcademicYear(false);
    }
  }
}
