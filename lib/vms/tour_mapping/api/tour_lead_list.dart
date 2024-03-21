import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/tour_plan_List.dart';

Future<void> featchTourNameLeadList(
    {required String base,
      required int iredId,
    required TourLeadController controller}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getTourLeadList;
  controller.tourLeadListLoading.value = true;
 try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {"IER_ID": iredId});
   TourPlanListModel tourLeadNameList = TourPlanListModel.fromJson(response.data['getloadarray']);    
   controller.listTourListName.addAll(tourLeadNameList.values!);
  controller.tourLeadListLoading.value = false;
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
