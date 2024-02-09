import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<int> approveApi({
  required String base,
  required int userId,
  required int miId,
  required List<Map<String, dynamic>> detailsList,
  required int otp,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.submitCheck;
  // "https://vmsstaging.vapssmartecampus.com:40015/api/CheckBookEntryApprovalFacade/Getdata/";

  logger.d(apiUrl);

  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
          "UserId": userId,
          "MI_Id": miId,
          "Apprval": detailsList,
          "VPAYVOUAUT_OTP": otp
        });
    logger.d({"Apprval": detailsList, "VPAYVOUAUT_OTP": otp});
    return response.statusCode!;
  } on DioError catch (e) {
    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());

    return 0;
  }
}
