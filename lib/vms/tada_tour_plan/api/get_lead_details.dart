import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/controller/lead_controller.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/model/lead_details.dart';

Future<bool> feacthLeadClient(
    {required String base,
    required int userId,
    required int miId,
    required LeadController controller}) async {
  final Dio ins = getGlobalDio();
  String apiUrl =
      base + URLS.getLeads; //"https://vmsstaging.vapssmartecampus.com:40015/"
  logger.d(apiUrl);
  controller.updateLoading(true);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": 17, "UserId": 60795}
        // {"MI_Id": miId, "UserId": userId}
        );
    LeadCilent leadClientList =
        LeadCilent.fromJson(response.data['getloadarray']);
    controller.getLeadList.addAll(leadClientList.values!);
    controller.updateLoading(false);
    return true;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
    return false;
  }
}
