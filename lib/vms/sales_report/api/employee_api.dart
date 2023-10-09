import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/sales_report/model/employee_model.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';

class EmployeeListAPI {
  EmployeeListAPI.init();
  static final EmployeeListAPI instance = EmployeeListAPI.init();
  employeeListAPI(
      {required String base,
      required int miId,
      required List<int> hrndIdList,
      required List<int> hrmdesIdList,
      required SalesController salesController}) async {
    var dio = Dio();
    var url = base + URLS.employeeList;
    try {
      salesController.employeeLoading(true);
      var response = await dio.post(url,
          // options: Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "hrmD_IdList": hrndIdList,
            "hrmdes_IdList": hrmdesIdList
          });
      logger.i({
        "MI_Id": miId,
        "hrmD_IdList": hrndIdList,
        "hrmdes_IdList": hrmdesIdList
      });
      logger.i(response.data['employeedropdown']);
      if (response.statusCode == 200) {
        EmployeeListModel designationListModel =
            EmployeeListModel.fromJson(response.data['employeedropdown']);
        salesController.getEmployee(designationListModel.values!);
        salesController.employeeLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.d(e.toString());
    }
  }
}
