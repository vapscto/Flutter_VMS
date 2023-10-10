import 'package:dio/dio.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/gps/model/clients_model.dart';
import 'package:m_skool_flutter/vms/gps/model/gps_emp.dart';
import 'package:m_skool_flutter/vms/gps/model/sales_list_model.dart';

Future<bool>  feacthGpsClient({
  required String base,
  required int userId,
  required int miId,
  required GetEmpDetailsController  controller,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.gpsFeacth;
  logger.d(apiUrl);
controller.updategpsLoading(true);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "UserId": userId});
        GetGpsClientDetails clientDetailsList = GetGpsClientDetails.fromJson( response.data['clientlist']);
        controller.gpsClientList.addAll(clientDetailsList.values!);
        GetGpsEmployeeDetails employeeDetails = GetGpsEmployeeDetails.fromJson( response.data['employee_name']);
        controller.gpsEmpList.addAll(employeeDetails.values!);
        GetGpsSalesDetails salesDetails =GetGpsSalesDetails.fromJson(response.data['saleslist']);
        controller.gpsSalesList.addAll(salesDetails.values!);

controller.updategpsLoading(false);
  return true;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    return false;
  }
}
