import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/tour_paln_model.dart';

Future<void> featchTourName(
    {required String base,
    required int userId,
    required TourLeadController controller}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getTourName;
  controller.tourLeadNameLoading.value = true;
// logger.i(apiUrl);
 try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {"UserId": userId});
      //  logger.w(response.data['tourPlanDetails']);
   TourPlanModel tourName = TourPlanModel.fromJson(response.data['tourPlanDetails']);    
   controller.listLeadName.addAll(tourName.values!);
   controller.tourLeadNameLoading.value = false;
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
