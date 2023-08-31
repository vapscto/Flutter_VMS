import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/principal/preadmission_module/controller/show_year_list_controller.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_class_data.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_redg_count.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_year_data.dart';


class ShowYearAPI {
  ShowYearAPI.init();
  static final ShowYearAPI instance = ShowYearAPI.init();

  showYearList(
      {required String url,
      required int miId,
      required ShowYearListController controller}) async {
    final String base = url + URLS.principalYearList;
    final ins = Dio();
    try {
      if (controller.isErrorOccured.value) {
        controller.updateIsErrorOccured(false);
      }

      controller.updateIsLoading(true);
      final Response response = await ins.post(
        base,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId},
      );
      logger.d(response.data);
      logger.d(base);
      if (response.data['fillyear'] != null) {
        YearGetData yearGetData =
            YearGetData.fromJson(response.data['fillyear']);
        controller.getYearListData(yearGetData.values!);
      }
      if (response.data['fillclass'] != null) {
        ClassGetData classGetData =
            ClassGetData.fromJson(response.data['fillclass']);

        controller.getClassData(classGetData.values!);
      }
      if (response.data['totalcountDetails'] != null) {
        GetCountData getCountData =
            GetCountData.fromJson(response.data['totalcountDetails']);
        controller.getRegdCount(getCountData.values!);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
