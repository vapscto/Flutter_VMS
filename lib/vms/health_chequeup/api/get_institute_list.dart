import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/health_chequeup/controlers/health_controler.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/client_model_list.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/get_data_model.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/hc_emp_list.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/institute_model.dart';
 
Future<void> getDetailsHC({
     required int miId,
     required int userId,
     required String base,
     required HealthCheckUpController controller
  }) async {
    controller.updateLoadPage(true);
    final Dio ins = getGlobalDio();
    final String apiUrl =  base + URLS.hcClassList;
    logger.e(apiUrl);
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
          "OnLoadOrOnChange": "OnLoad",
          "MI_Id": miId,
          "UserId": userId,
    });
     logger.d(apiUrl);
     InstituteListModel instituteListModel = InstituteListModel.fromJson(response.data['getuserinstitution']);
     ClientListModel clientListModel = ClientListModel.fromJson(response.data['getclientlist']);
     GetHCEmpListModel getHCEmpListModel = GetHCEmpListModel.fromJson(response.data['getemployeedetails']);
     GetHCDataModel getHCDataModel = GetHCDataModel.fromJson(response.data['getloaddata']);
     if(instituteListModel.values!.isNotEmpty){
      controller.updateLoadPage(false);
     }
     controller.getInstituteList.addAll(instituteListModel.values!);
     controller.getClientList.addAll(clientListModel.values!);
     controller.getEmpList.addAll(getHCEmpListModel.values!);
     controller.getHCData.addAll(getHCDataModel.values!);
     } on DioError catch (e) {
     logger.e(e.message); 
      controller.updateLoadPage(true);
    } on Exception catch (e) {
     logger.e(e);
      controller.updateLoadPage(true);
    }
  }