import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/cheque_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/otp_response.dart';

Future<bool> otpCheck({
  required String base,
  required int userId,
  required int mi_id,
   required int otp,
required ChequeController controller,
}) async {
  final Dio ins = getGlobalDio();
    String apiUrl = base+URLS.OtpCheck;
 
  logger.w(apiUrl);
  logger.i( {
          "MI_Id": mi_id,
          "UserId": userId,
          "EMAILOTP": otp
          });
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
           "MI_Id": mi_id,
          "UserId": userId,
          "EMAILOTP": otp
          });
   if (response.statusCode == 200) {
   // Map<String, dynamic> data = json.decode(response.data);
    OtpResponse otpResponse = OtpResponse.fromJson(response.data);
    controller.otpResponseList.add( otpResponse);
   }else {
    logger.d('Error: ${response.statusCode}');
  }
      // controller.otpResponseList.add(response.data);
      // logger.d(controller.otpResponseList.first);
     return  true ;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());

    return false;
  }
}

 