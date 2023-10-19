import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/sales_report/model/sale_list_model.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';

class SalesListAPI {
  SalesListAPI.init();
  static final SalesListAPI instance = SalesListAPI.init();
  salesListApi(
      {required String base,
      required SalesController salesController,
      required String flag,
      required String fromDate,
      required String toDate,
      required int miId,
      required int userId,
      required List hrmdIdList,
      required List hrmeIdList,
      required List designationId}) async {
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
        "hrmD_IdList": hrmdIdList,
        "hrmE_IdList": hrmeIdList,
        "hrmdes_IdList": designationId
      }
              // data: {
              //   "MI_Id": miId,
              //   "flag": flag,
              //   "User_Id": userId,
              //   "fromdate": fromDate,
              //   "todate": toDate,
              //   "hrmdes_IdList": [
              //     15,
              //     23,
              //     25,
              //     26,
              //     31,
              //     183,
              //     333,
              //     440,
              //     448,
              //     450,
              //     470,
              //     513,
              //     514,
              //     520,
              //     522,
              //     523,
              //     538
              //   ],
              //   "hrmD_IdList": [231],
              //   "hrmE_IdList": [
              //     1452,
              //     1748,
              //     1780,
              //     1840,
              //     1843,
              //     1845,
              //     1847,
              //     1849,
              //     1864,
              //     1865,
              //     1866,
              //     1873,
              //     1874,
              //     1882,
              //     1889,
              //     1932,
              //     1953,
              //     1955,
              //     1957,
              //     1977
              //   ]
              // }
              );
      logger.i({
        "MI_Id": miId,
        "flag": flag,
        "User_Id": userId,
        "fromdate": fromDate,
        "todate": toDate,
        "hrmD_IdList": hrmdIdList,
        "hrmE_IdList": hrmeIdList,
        "hrmdes_IdList": designationId
      });
      if (response.statusCode == 200) {
        SalesEmployeeListModel salesListModel = SalesEmployeeListModel.fromJson(
            response.data['leadcommentsreport']);
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
