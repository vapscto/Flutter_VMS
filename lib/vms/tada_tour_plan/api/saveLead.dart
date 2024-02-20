import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<String?> saveLeadClient(
    {required String base,
    required int userId,
    required int miId,
    required int ierId,
    required String ierRemark,
    required String lat,
    required String longitude,
    required String demostatus}) async {
  final Dio ins = getGlobalDio();
  String apiUrl =
       base + URLS.saveLeads;
  logger.d(apiUrl);

  logger.w({
    "IER_ID": ierId, // IERCLE_Id
    "UserId": userId,
    "IER_Remarks": ierRemark,
    "ILRR_Lat": lat,
    "ILRR_Long": longitude,
    "ISMSLEDM_DemoExecuted": demostatus
  });
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IER_ID": ierId, // IERCLE_Id
      "UserId": userId,
      "IER_Remarks": ierRemark,
      "ILRR_Lat": lat,
      "ILRR_Long": longitude,
      "ISMSLEDM_DemoExecuted": demostatus
    }
            //    {
            //   "IER_ID":ierId,
            //   "UserId": userId,
            //   "IER_Remarks": ierRemark,
            //   "VMSATGPSL_LATLONGValue": latLong,
            //   "ISMSLEDM_DemoExecuted": demostatus
            //  }

            );
    logger.e(response.data["message"]);
    if (response.statusCode == 200) {
      return response.data["message"];
    }
    return null;
  } on DioError catch (e) {
    logger.e(e.message);
    return null;
  } on Exception catch (e) {
    logger.e(e.toString());
    return null;
  }
}
