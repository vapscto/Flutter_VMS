import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/sales_report/model/department_model.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';

class DepartmentAPI {
  DepartmentAPI.init();
  static final DepartmentAPI instance = DepartmentAPI.init();
  departmentAPI(
      {required String base,
      required int miId,
      required int hrmdId,
      required SalesController salesController}) async {
    var dio = Dio();

    var url2 = base + URLS.department;
    logger.i(url2);
    try {
      if (salesController.isErrorLoading.value) {
        salesController.error(false);
      }
      salesController.departmentLoading(true);
      var response = await dio.post(url2,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "HRMD_Id": hrmdId});
      if (response.statusCode == 200) {
        DepartmentListModel departmentListModel =
            DepartmentListModel.fromJson(response.data['departmentdropdown']);
        salesController.getDepartment(departmentListModel.values!);
        salesController.departmentLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.d(e.toString());
    }
  }
}
