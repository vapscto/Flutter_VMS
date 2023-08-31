import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_filter_model.dart';

class ViewNoticeFilterApi {
  ViewNoticeFilterApi.init();
  static final ViewNoticeFilterApi instance = ViewNoticeFilterApi.init();

  getFilteredNotice({
    required String base,
    required int hrme,
    required int asmayId,
    required int miId,
    required String start,
    required String end,
    required ViewNoticeDataController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.filterViewNotice;
    logger.d(api);
    if (controller.isErrorOccuredWhileLoadingFilteration.value) {
      controller.isErrorOccuredWhileLoadingFilteration.value = false;
    }
    controller.isFilterationLoading.value = true;
    try {
      logger.d({
        "HRME_Id": hrme,
        "ASMAY_Id": asmayId,
        "MI_Id": miId,
        "INTB_StartDate": start,
        "INTB_EndDate": end
      });
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "HRME_Id": hrme,
        "ASMAY_Id": asmayId,
        "MI_Id": miId,
        "INTB_StartDate": start,
        "INTB_EndDate": end
      });

      if (response.data['noticelist'] == null) {
        Fluttertoast.showToast(
            msg: "NoticeList array is not present, we can't show you data",
            toastLength: Toast.LENGTH_LONG);
        controller.addNoticeToFilter([]);
        controller.isFilterationLoading.value = false;

        return;
      }
      final ViewNoticeFilterModel filterMode =
          ViewNoticeFilterModel.fromJson(response.data['noticelist']);

      controller.addNoticeToFilter(filterMode.values!);
      controller.isFilterationLoading.value = false;
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);

      controller.isErrorOccuredWhileLoadingFilteration.value = true;

      controller.isFilterationLoading.value = false;
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.isErrorOccuredWhileLoadingFilteration.value = true;

      controller.isFilterationLoading.value = false;
    }
  }
}
