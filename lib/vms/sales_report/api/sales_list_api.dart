import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/sales_report/model/sale_list_model.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';

class SalesListAPI {
  SalesListAPI.init();
  static final SalesListAPI instance = SalesListAPI.init();
  salesListApi({
    required String base,
    required SalesController salesController,
    required String flag,
    required String fromDate,
    required String toDate,
    required int miId,
    required int userId,
    required List<Map<String, dynamic>> leadIdList,
    required List hrmdIdList,
    required List hrmeIdList,
  }) async {
    var dio = Dio();
    var url = base + URLS.salesList;
    try {
      salesController.listLoading(true);
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "flag": flag,
        "User_Id": userId,
        "fromdate": fromDate,
        "todate": toDate,
        "leaddatalist": leadIdList,
        "hrmD_IdList": hrmdIdList,
        "hrmE_IdList": hrmeIdList
      });
      logger.i({
        "MI_Id": miId,
        "flag": flag,
        "User_Id": userId,
        "fromdate": fromDate,
        "todate": toDate,
        "leaddatalist": leadIdList,
        "hrmD_IdList": hrmdIdList,
        "hrmE_IdList": hrmeIdList
      });
      if (response.statusCode == 200) {
        SalesListModel salesListModel =
            SalesListModel.fromJson(response.data['leadcommentsreport']);
        salesController.salesList(salesListModel.values!);
        salesController.listLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
