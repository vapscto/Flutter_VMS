import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/controller/final_tada_tour_approval.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tada_adavance.dart';
 
Future<void> getFinalAdavncedViewDetails(
    {required String base,
    required int userId,
    required int vtadaaId,
    required int vtadaaaaId,
    required int miID,
    required TadaTourApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getViewAdancedFinal;
    try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {
     "UserId":userId,
    "VTADAA_Id":vtadaaId,
    "MI_Id":miID,
    "VTADAAAAA_Id":vtadaaaaId});
     FinalViewAdvancDetails finalViewAdvancDetail = FinalViewAdvancDetails.fromJson(response.data['veiwdetails']);
    controller.finalViewAdvance.addAll(finalViewAdvancDetail.values!);
    controller.etPaidAmount.value.text =  finalViewAdvancDetail.values!.first.paidAmount.toString();
    // logger.w(response.data['timeArray']['\$values'][0]['vtadaA_TotalSactionedAmount']);
    controller.etSnactionedAmount.value.text = response.data['timeArray']['\$values'][0]['vtadaA_TotalSactionedAmount'].toString();
     } on DioError catch (e) {
    logger.e(e.message);
   } on Exception catch (e) {
    logger.e(e.toString());
   }
}
     