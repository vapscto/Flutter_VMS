import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/exam_graph_model.dart';

class DashboardExamApi {
  DashboardExamApi.init();
  static final DashboardExamApi instance = DashboardExamApi.init();

  Future<List<ExamGraphListValues>> loadExamData(
      {required int miId,
      required int asmayId,
      required int asmclId,
      required int asmsId,
      required int amstId,
      required int emeId,
      required String base,
      required DynamicAnalyticsController dashboardController}) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = base + URLS.examGraph;
      if (dashboardController.isLoadingGraphData.value) {
        dashboardController.updateIsLoadingGraphData(true);
      }
      if (dashboardController.examGraphVal.isNotEmpty) {
        dashboardController.examGraphVal.clear();
      }
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "ASMAY_Id": asmayId,
          "ASMCL_Id": asmclId,
          "ASMS_Id": asmsId,
          "AMST_Id": amstId,
          "EME_Id": emeId
        },
      );

      final ExamGraphList examGraphList =
          ExamGraphList.fromJson(response.data['examgraphList']);

      dashboardController.updateExamGraph(examGraphList.values!);

      return Future.value(examGraphList.values);
    } catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorMsg": "Unable to connect to server",
        "errorTitle":
            "Sorry! but we are unable to connect to server, or server returned an error",
      });
    }
  }
}
