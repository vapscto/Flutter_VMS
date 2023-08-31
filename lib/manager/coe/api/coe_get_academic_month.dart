import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/coe/controller/manager_coe_handler.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_academic_data_model.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_month_data.dart';

class CoeGetAcademicAndMonthApi {
  CoeGetAcademicAndMonthApi.init();
  static final CoeGetAcademicAndMonthApi instance =
      CoeGetAcademicAndMonthApi.init();

  getAcademics({
    required String base,
    required ManagerCoeHandler handler,
    required int miId,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = "$base${URLS.getCoeAcaForManager}$miId";
    logger.d(api);
    if (handler.isErrorOccuredWhileLoadingAcademic.value) {
      handler.updateIsErrorOccuredWhileLoadingAcademic(false);
    }
    handler.updateIsLoadingYear(true);
    handler.updateStatus("We are loading academic year and month for you");
    try {
      final Response response =
          await ins.get(api, options: Options(headers: getSession()));

      if (response.data['fillyear'] == null) {
        handler.updateIsErrorOccuredWhileLoadingAcademic(true);
        handler.updateStatus(
            "There is no academic year available in database, ask them to add some");

        handler.updateIsLoadingYear(false);
        return;
      }

      if (response.data['fillmonth'] == null) {
        handler.updateIsErrorOccuredWhileLoadingAcademic(true);
        handler.updateStatus(
            "There is no academic month available in database, ask them to add some");

        handler.updateIsLoadingYear(false);
        return;
      }

      final CoeAcademicDataModel academicDataModel =
          CoeAcademicDataModel.fromJson(response.data['fillyear']);

      final CoeMonthDataModel month =
          CoeMonthDataModel.fromJson(response.data['fillmonth']);

      if (academicDataModel.values!.isNotEmpty) {
        handler.updateSelectedAcademicYear(academicDataModel.values!.first);
      }

      if (month.values!.isNotEmpty) {
        handler.updateSelectedMonth(month.values!.first);
      }

      handler.updateAcademics(academicDataModel.values!);
      handler.updateMonths(month.values!);

      handler.updateIsLoadingYear(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      handler.updateStatus(e.message);
      handler.updateIsLoadingYear(false);
      handler.updateIsErrorOccuredWhileLoadingAcademic(true);
    } on Exception catch (e) {
      logger.e(e.toString());
      handler.updateStatus(
          "An internal error occured while trying to create a view for you");

      handler.updateIsLoadingYear(false);
      handler.updateIsErrorOccuredWhileLoadingAcademic(true);
    }
  }
}
