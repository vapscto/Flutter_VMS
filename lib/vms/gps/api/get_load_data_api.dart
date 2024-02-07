import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
// import 'package:m_skool_flutter/vms/gps/constants/client_name_const.dart';
import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/gps/model/clients_model.dart';
import 'package:m_skool_flutter/vms/gps/model/sales_list_model.dart';

Future<bool> feacthGpsClient({
  required String base,
  required int userId,
  required int miId,
  required GetEmpDetailsController controller,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.gpsFeacth;
  logger.d(apiUrl);
  controller.updategpsLoading(true);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "UserId": userId});
    logger.i({"MI_Id": miId, "UserId": userId});
    logger.e(apiUrl);
    if (response.statusCode == 200) {
      // Map<String, dynamic> jsonData = jsonDecode(jsonString);
      // GetGpsClientDetails getGpsClientDetails =
      //     GetGpsClientDetails.fromJson(jsonData['clientlist']);
      GetGpsClientDetails clientDetailsList =
          GetGpsClientDetails.fromJson(response.data['clientlist']);
      controller.gpsClientList.addAll(clientDetailsList.values!);
      // GetGpsEmployeeDetails employeeDetails =
      //     GetGpsEmployeeDetails.fromJson(response.data['employee_name']);
      // controller.gpsEmpList.addAll(employeeDetails.values!);
      //
      // Map<String, dynamic> jsonData1 = jsonDecode(leadString);
      // GetGpsSalesDetails salesDetails =
      //     GetGpsSalesDetails.fromJson(jsonData1['saleslist']);
      GetGpsSalesDetails salesDetails =
          GetGpsSalesDetails.fromJson(response.data['saleslist']);
      controller.gpsSalesList.addAll(salesDetails.values!);
      controller.updategpsLoading(false);
    }

    return true;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
    return false;
  }
}
