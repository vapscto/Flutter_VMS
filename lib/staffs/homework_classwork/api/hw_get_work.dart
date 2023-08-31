import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/classwork_view_work_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/homework_view_work_model.dart';

class GetHomeWorks {
  GetHomeWorks.init();
  static final GetHomeWorks instance = GetHomeWorks.init();

  getHomeWorks({
    required int miId,
    required int asmayId,
    required int hrmeId,
    required int userId,
    required int ivrmrtId,
    required int loginId,
    required String base,
    required HwCwController controller,
    required bool forHw,
  }) async {
    final String api = forHw ? base + URLS.getHwYear : base + URLS.getCwYear;
    final Dio ins = getGlobalDio();
    if (controller.isErrorOccuredWhileLoadingWork.value) {
      controller.updateIsErrorOccuredWhileLoadingWork(false);
    }
    controller.updateViewWorkLoadingStatus(
        "Please wait while we are loading your assigned work");
    controller.updateIsWorkLoading(true);
    try {
      Map<String, dynamic> data = forHw
          ? {
              "MI_Id": miId,
              "HRME_Id": hrmeId,
              "userId": userId,
              "login_Id": loginId,
              "IVRMRT_Id": ivrmrtId,
              "ASMAY_Id": asmayId,
            }
          : {
              "MI_Id": miId,
              "userId": userId,
              "login_Id": loginId,
              "IVRMRT_Id": ivrmrtId,
              "ASMAY_Id": asmayId,
            };
      final Response response = await ins.post(api,
          options: Options(headers: getSession()), data: data);

      if (response.data['classwork'] == null) {
        controller.updateViewWorkLoadingStatus(
            "The data is unavailable at this moment, try again after some time");
        controller.updateIsErrorOccuredWhileLoadingWork(true);
        controller.updateIsWorkLoading(false);

        // return Future.error({
        //   "errorTitle": "No Classwork Present",
        //   "errorMsg":
        //       "The data is unavailable at this moment, try again after some time",
        // });
      }
      if (forHw) {
        controller.updateHomeWorks(
            HomeWorkViewWork.fromJson(response.data['classwork']).values!);
      } else {
        controller.updateClassWorks(
            ClassWorkViewWork.fromJson(response.data['classwork']).values!);
      }
      controller.updateIsWorkLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      controller.updateViewWorkLoadingStatus(e.message);
      controller.updateIsErrorOccuredWhileLoadingWork(true);
      controller.updateIsWorkLoading(false);
      return Future.error({
        "errorTitle": "Error Occured while connecting to server",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateViewWorkLoadingStatus(
          "An internal error occured while trying to create your view");
      controller.updateIsErrorOccuredWhileLoadingWork(true);
      controller.updateIsWorkLoading(false);
      return Future.error({
        "errorTitle": "Unexpected error Occured",
        "errorMsg":
            "An internal error occured while trying to create your view",
      });
    }
  }

  getFilteredHwCw({
    required int miId,
    required int asmayId,
    required int hrmeId,
    required String startDate,
    required String endDate,
    required String base,
    required HwCwController controller,
    required bool forHw,
  }) async {
    final String api =
        forHw ? base + URLS.getFilteredHw : base + URLS.getFilteredCw;
    final Dio ins = getGlobalDio();
    if (controller.isErrorOccuredWhileLoadingWork.value) {
      controller.updateIsErrorOccuredWhileLoadingWork(false);
    }
    controller.updateFilterCount(controller.filterCount.value + 1);
    controller.updateViewWorkLoadingStatus(
        "Please wait while we are loading your filtered work");
    controller.updateIsWorkLoading(true);
    try {
      Map<String, dynamic> data = forHw
          ? {
              "MI_Id": miId,
              "HRME_Id": hrmeId,
              "ASMAY_Id": asmayId,
              "INTB_StartDate": startDate,
              "INTB_EndDate": endDate
            }
          : {
              "MI_Id": miId,
              "HRME_Id": hrmeId,
              "ASMAY_Id": asmayId,
              "INTB_StartDate": startDate,
              "INTB_EndDate": endDate
            };

      logger.d({
        "MI_Id": miId,
        "HRME_Id": hrmeId,
        "ASMAY_Id": asmayId,
        "INTB_StartDate": startDate,
        "INTB_EndDate": endDate
      });
      logger.d(api);
      final Response response = await ins.post(api,
          options: Options(headers: getSession()), data: data);

      if (response.data['homeworklist'] == null &&
          response.data['assignmentlist'] == null) {
        controller.updateViewWorkLoadingStatus(
            "The data is unavailable at this moment, try again after some time");
        controller.updateIsErrorOccuredWhileLoadingWork(true);
        controller.updateIsWorkLoading(false);

        // return Future.error({
        //   "errorTitle": "No Classwork Present",
        //   "errorMsg":
        //       "The data is unavailable at this moment, try again after some time",
        // });
      }
      if (forHw) {
        controller.updateHomeWorks(
            HomeWorkViewWork.fromJson(response.data['homeworklist']).values!);
      } else {
        controller.updateClassWorks(
            ClassWorkViewWork.fromJson(response.data['assignmentlist'])
                .values!);
      }
      controller.updateIsWorkLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      controller.updateViewWorkLoadingStatus(e.message);
      controller.updateIsErrorOccuredWhileLoadingWork(true);
      controller.updateIsWorkLoading(false);
      return Future.error({
        "errorTitle": "Error Occured while connecting to server",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateViewWorkLoadingStatus(
          "An internal error occured while trying to create your view");
      controller.updateIsErrorOccuredWhileLoadingWork(true);
      controller.updateIsWorkLoading(false);
      return Future.error({
        "errorTitle": "Unexpected error Occured",
        "errorMsg":
            "An internal error occured while trying to create your view",
      });
    }
  }
}
