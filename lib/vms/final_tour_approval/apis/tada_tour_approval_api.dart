import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/controller/final_tada_tour_approval.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tada_tour_approval_lists.dart';
 
Future<void> getFinalAdavncedViewList(
    {required String base,
    required int userId,
    required TadaTourApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getFinalAdavncedViewApi;
  logger.w(apiUrl);
 controller.showFinalTadaTourApprovalList.value = true;
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {"userId": userId});
    FinalTadaTourApproval finalTadaTourApproval =  FinalTadaTourApproval.fromJson(response.data['getadvancetada']); 
    controller.finaltadaTourApprovalList.addAll(finalTadaTourApproval.values!);
    if(response.data['getadvancetada'] !=null){
      logger.d(response.data['getadvancetada']);
      controller.showFinalTadaTourApprovalList.value =false;
    }
  } on DioError catch (e) {
    logger.e(e.message);
controller.showFinalTadaTourApprovalList.value = true;    
  } on Exception catch (e) {
    logger.e(e.toString());
controller.showFinalTadaTourApprovalList.value = true;    
  }
}
