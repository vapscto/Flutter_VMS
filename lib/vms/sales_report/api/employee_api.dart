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
          }
          // data: {
          //   "MI_Id": 17,
          //   "hrmdes_IdList": [
          //     4,
          //     5,
          //     7,
          //     8,
          //     9,
          //     10,
          //     12,
          //     13,
          //     14,
          //     15,
          //     16,
          //     17,
          //     18,
          //     19,
          //     21,
          //     22,
          //     23,
          //     25,
          //     26,
          //     27,
          //     28,
          //     29,
          //     31,
          //     32,
          //     183,
          //     325,
          //     333,
          //     339,
          //     342,
          //     344,
          //     351,
          //     361,
          //     365,
          //     367,
          //     368,
          //     405,
          //     414,
          //     416,
          //     432,
          //     440,
          //     445,
          //     447,
          //     448,
          //     449,
          //     450,
          //     451,
          //     452,
          //     453,
          //     467,
          //     470,
          //     489,
          //     513,
          //     514,
          //     520,
          //     522,
          //     523,
          //     524,
          //     536,
          //     538,
          //     546,
          //     558,
          //     567,
          //     569,
          //     571,
          //     575,
          //     576,
          //     580,
          //     581,
          //     584,
          //     586,
          //     587,
          //     588,
          //     589,
          //     590,
          //     593,
          //     594
          //   ],
          //   "hrmD_IdList": [
          //     3,
          //     4,
          //     5,
          //     6,
          //     7,
          //     8,
          //     9,
          //     13,
          //     175,
          //     180,
          //     186,
          //     198,
          //     216,
          //     217,
          //     218,
          //     227,
          //     231,
          //     241,
          //     253,
          //     304,
          //     306,
          //     307,
          //     315,
          //     322,
          //     324
          //   ]
          // }
          );
      // logger.i({
      //   "MI_Id": miId,
      //   "hrmD_IdList": hrndIdList,
      //   "hrmdes_IdList": hrmdesIdList
      // });
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
