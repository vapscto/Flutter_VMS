import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/staff_birthday/controller/bday_controller.dart';
import 'package:m_skool_flutter/manager/staff_birthday/model/staff_bday_model.dart';


class StudentBdayReportApi {
  StudentBdayReportApi.init();
  static final StudentBdayReportApi instance = StudentBdayReportApi.init();
  getBday({
    required int miId,
    required String fromDate,
    required String toDate,
    required int all1,
    required String flag,
    required String month,
    required String base,
    required int type,
    required BdayController bdayController,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getStaffBday;
    if (bdayController.isErrorOccured.value) {
      bdayController.updateIsErrorOccured(false);
    }

    bdayController.updateIsLoadingBday(true);
    try {
      logger.d({
        "MI_ID": miId,
        "Fromdate": fromDate,
        "Todate": toDate,
        "all1": all1,
        "flag": "S",
        "months": month,
      });
      logger.d(api);

      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_ID": miId,
          "Fromdate": fromDate,
          "Todate": toDate,
          "all1": type,
          "flag": "S",
          "months": month,
        },
      );

      if (response.data['staffDetails'] == null) {
        bdayController.updateIsErrorOccured(true);
        bdayController.updateIsLoadingBday(false);
        bdayController.updateErrorMap({
          "errorTitle": "No Data Present",
          "errorMsg":
              "Sorry! but we are unable to get the data from the server, because the data is not available , you can try again later"
        });
        return;
      }

      final StaffBirthdayreportmodel staffBdayModel =
          StaffBirthdayreportmodel.fromJson(response.data['staffDetails']);

      bdayController.updateStudentBdayList(staffBdayModel.values!);
      bdayController.updateIsLoadingBday(false);

      //return Future.value(studentBdayModel.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      bdayController.updateIsErrorOccured(true);
      bdayController.updateIsLoadingBday(false);
      bdayController.updateErrorMap({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "Server Error Occured, you can try again later..",
      });
    }
  }

  Future<List<Values>> getMonthWiseBday(
      {required int miId,
      required String fromDate,
      required String toDate,
      required int all1,
      required String flag,
      required String month,
      required String base,
      required int type}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getStaffBday;

    logger.d({
      "MI_ID": miId,
      "Fromdate": fromDate,
      "Todate": toDate,
      "all1": type,
      "flag": "S",
      "months": month,
    });
    logger.d(api);

    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_ID": miId,
          "Fromdate": fromDate,
          "Todate": toDate,
          "all1": type,
          "flag": "S",
          "months": month,
        },
      );
      logger.d(api);
      if (response.data['staffDetails'] == null) {
        return Future.error({
          "errorTitle": "No Data Present",
          "errorMsg":
              "Sorry! but we are unable to get the data from the server, because the data is not available , you can try again later"
        });
      }

      final StaffBirthdayreportmodel staffBdayModel =
          StaffBirthdayreportmodel.fromJson(response.data['staffDetails']);

      return Future.value(staffBdayModel.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "Server Error Occured, you can try again later..",
      });
    }
  }
}
