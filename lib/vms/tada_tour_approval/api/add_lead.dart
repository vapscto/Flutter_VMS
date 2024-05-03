import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/clientLead_model.dart';
 

Future<void> getLead(
    {required String base,
    required int userId,
    required int hrmeId,
    required int catId,
    required int miID,
    required TadaTourController tadaTourController}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getLeadsClients;
  logger.w(apiUrl);

  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
    "MI_Id": miID,
    "IMRC_CategoryId":catId,
    "HRME_Id": hrmeId,
    "userId": userId
    });
    // logger.e({
    // "MI_Id": miID,
    // "IMRC_CategoryId":catId,
    // "HRME_Id": hrmeId,
    // "userId": userId
    // });
    if( tadaTourController.leadList.isNotEmpty || tadaTourController.checkBoxList.isNotEmpty){
      tadaTourController.leadList.clear();
      tadaTourController.checkBoxList.clear();
    }
   LeadsModel clientLead = LeadsModel.fromJson(response.data['leadList']);
   tadaTourController.leadList.addAll(clientLead.values!);
   for(int i =0;i<clientLead.values!.length;i++){
    tadaTourController.checkBoxList.add(false);
   }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
