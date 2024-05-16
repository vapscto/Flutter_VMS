import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/controller/final_tada_tour_approval.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tour_plan_details.dart';
 
Future<void> getFinalAdavncedPlanerDetails(
    {required String base,
    required int userId,
    required int ierId,
    required TadaTourApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getTadaTourPlanerDetails;
  logger.w(apiUrl);
   try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {
              "UserId":userId,
              "IER_ID":ierId});
  FinalTourPlanDetails finalTourPlanDetails = FinalTourPlanDetails.fromJson(response.data['tourPlanDetails']);
  controller.finalPalnerDetails.addAll(finalTourPlanDetails.values!);
  } on DioError catch (e) {
    logger.e(e.message);
   } on Exception catch (e) {
    logger.e(e.toString());
   }
}
