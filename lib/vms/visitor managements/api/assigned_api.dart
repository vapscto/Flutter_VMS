
// ignore_for_file: unused_local_variable

import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';

import 'package:m_skool_flutter/vms/visitor%20managements/model/gridoption_model.dart';

 

  getAssignedManagaementApi({
    required String base,
    required int miId,
    required int userId,
    required VisitorManagementsController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.gridoptionapi;
 const String api2 = "https://vmsstaging.vapssmartecampus.com:40020/api/AddVisitorsFacade/getVisitorAssignDetails/";

    if (controller.isErrorOccuredassigned.value) {
     }

     
    logger.d(api2);
    logger.i("nitin");
    try {
      final Response response =
          await ins.post(api2, options: Options(headers: getSession()), data: {
              "mI_Id": 24, "UserId": 60415 ,  "VMMV_Id": 20841
      });

logger.e({
              "mI_Id": 24, "UserId": 60415 , "VMMV_Id": 20841
      });
      logger.i(response.data['gridoptions']);

      if (response.data['gridoptions']!= null) {
        
        GridOptionslistModel pValues =
            GridOptionslistModel.fromJson(response.data['gridoptions']);
        controller.getrequestGetgridoptionList.addAll(pValues.values!);
  /////////////////////////////////////////////////////////////////////////////////////// 
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredassigned(true);
      controller.updateIsLoadingassigned(false);
    }
  }
 
