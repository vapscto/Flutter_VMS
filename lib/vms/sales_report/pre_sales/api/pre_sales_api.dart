import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/controller/pre_sales_controller.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/sales_list_model.dart';

class PreSalesAPI {
  PreSalesAPI.init();
  static final PreSalesAPI instance = PreSalesAPI.init();
  preSalesList(
      {required String base,
      required int userId,
      required int miId,
      required PreSalesController preSalesController}) async {
    var dio = Dio();
    var api =
        "https://vmsstaging.vapssmartecampus.com:40019/${URLS.preSalesList}";
    try {
      preSalesController.salesLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": 17, "USER_Id": 60948});
      if (response.statusCode == 200) {
        PreSalesListModel preSalesListModel =
            PreSalesListModel.fromJson(response.data['demo_list']);
        preSalesController.getData(preSalesListModel.values!);
        preSalesController.salesLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
