import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
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
          options: Options(headers: getSession()),
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
      logger.i(url);
      if (response.statusCode == 200) {
        EmployeeListModel employeeListModel =
            EmployeeListModel.fromJson(response.data['employeedropdown']);
        salesController.getEmployee(employeeListModel.values!);
        logger.i(response.statusCode);
        salesController.employeeLoading(false);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } on DioError catch (e) {
      logger.d(e.message);
    } on Exception catch (e) {
      logger.d(e.toString());
    }
  }
}
