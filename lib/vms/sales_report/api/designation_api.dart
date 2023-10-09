import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/sales_report/model/designation_model.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';

class DesignationAPI {
  DesignationAPI.init();
  static final DesignationAPI instance = DesignationAPI.init();
  designationAPI(
      {required String base,
      required int miId,
      required List<int> hrndIdList,
      required SalesController salesController}) async {
    var dio = Dio();
    var url =
        base+URLS.designation;
    try {
      salesController.designationLoading(true);
      var response = await dio.post(url,
          // options: Options(headers: getSession()),
          data: {"MI_Id": miId, "hrmD_IdList": hrndIdList});
      if (response.statusCode == 200) {
        DesignationListModel designationListModel =
            DesignationListModel.fromJson(response.data['designationdropdown']);
        salesController.getDesignation(designationListModel.values!);
        salesController.designationLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.d(e.toString());
    }
  }
}
