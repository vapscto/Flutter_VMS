import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/demo_response_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/status_demo.dart';

Future<void> featchDemoResponse(
    {required String base,
    required int ismsledm,
    required int ismsle,
    required int miId,
    required TourLeadController controller}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getTourDemoResponseApi;

  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
         data: {"ISMSLEDM_Id": ismsledm, "ISMSLE_Id": ismsle, "MI_Id": miId});
    DemoResponseModel demoResponseModel =
        DemoResponseModel.fromJson(response.data['demo_response_details']);
    controller.listDemoRespose.addAll(demoResponseModel.values!);
    StatusDemoModel statusDemoModel =
        StatusDemoModel.fromJson(response.data['status_demo_master']);
    controller.listDemoStatus.addAll(statusDemoModel.values!);
    for (int i = 0; i < demoResponseModel.values!.length; i++) {
      controller.demoRemarkEdt.add(TextEditingController(text: ""));
      controller.demoNegotiateList.add(false);
      controller.checkBoxList.add(false);
      controller.demoCancelList.add(false);
      controller.demoMouList.add(false);
      controller.demoNegotiate.add(TextEditingController(text: ""));
      controller.demoDropDown.add("");
    }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
