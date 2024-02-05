import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/hc_doc_model.dart';

Future<HCDocModel?> getDocxApi({
  required int miId,
  required int hcupID,
  required String base,
}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getdocxApi;
  logger.e(apiUrl);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "HWHCHUP_Id": hcupID});
    logger.d(apiUrl);
    HCDocModel hcDocModel =
        HCDocModel.fromJson(response.data['getviewfilesdetails']);
    return hcDocModel;
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e);
  }
  return null;
}
