import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/demo_response_details.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/view_lead_demo.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/view_lead_demo_product_details.dart';

Future<void> featchViewDemoRespose(
    {required String base,
    required int ismsledm,
    required int ismsleId,
    required int miId,
    required TourLeadController controller}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getLeadDemoResponse;
  logger.i(apiUrl);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
          "viewall": 1,
          "ISMSLEDM_Id": ismsledm,
          "ISMSLE_Id": ismsleId,
          "MI_Id": miId
        });
    logger.e({
      "viewall": 1,
      "ISMSLEDM_Id": ismsledm,
      "ISMSLE_Id": ismsleId,
      "MI_Id": miId
    });
    logger.e(response);
    ViewLeadDemo viewDemoDetails =
        ViewLeadDemo.fromJson(response.data['view_lead_demo']);
    controller.viewDemoResopnseList.addAll(viewDemoDetails.values!);
    ViewLeadDemoProductResponse viewDemoProductResponse =
        ViewLeadDemoProductResponse.fromJson(response.data['product_dd_s']);
    controller.viewDemoPRoductList.addAll(viewDemoProductResponse.values!);
    DemoResponseDetails viewDemResponseDetails =
        DemoResponseDetails.fromJson(response.data['demo_response_details']);
    controller.viewDemoResponseDetailsList
        .addAll(viewDemResponseDetails.values!);
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
