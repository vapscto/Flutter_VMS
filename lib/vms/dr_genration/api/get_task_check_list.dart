import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/category_check_list_model.dart';
 
Future<CategoryCheckListModel?> getCategoryChecklistDetails({
  required String base,
  required int ismctrId,
  required int ismmcatId,
  required PlannerDetails controller
}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getTaskCheckList;
  logger.e(apiUrl);
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
    "ISMMTCAT_Id": ismmcatId,
    "ISMTCR_Id": ismctrId
    });
    logger.e({
     
    });
    CategoryCheckListModel checkListModel =  CategoryCheckListModel.fromJson(response.data['gettaskcategorychecklist']);
    
    return checkListModel;
  } on DioError catch (e) {
    logger.e(e.message);
    return null;
  } on Exception catch (e) {
    logger.e(e.toString());
    return null;
  }
}
