import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/visitor_model.dart';

getVisitManagaementApi({
  required String base,
  required int miId,
  required int userId,
  required VisitorManagementsController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.visitormanagementapi;
  const String api2 =
      "https://vmsstaging.vapssmartecampus.com:40020/api/AddVisitorsFacade/getAssignDetails/";

  if (controller.isErrorOccuredVisit.value) {
    controller.updateIsErrorOccuredVisit(false);
  }

  controller.updateIsLoadingVisit(true);

  logger.d(api);

  try {
    final Response response = await ins.post(api2,
        options: Options(headers: getSession()),
        data: {"mI_Id": 24, "UserId": 60415});

    logger.e({"mI_Id": 24, "UserId": 60415});
    logger.i(response.data['visitorlist']);

    if (response.data['visitorlist'] != null) {
      controller.updateIsErrorOccuredVisit(true);
      controller.updateIsLoadingVisit(false);
      VisitorlistModel pValues =
          VisitorlistModel.fromJson(response.data['visitorlist']);
      controller.getvisitor(pValues.values!);

      ///////////////////////////////////////////////////////////////////////////////////////
    }

    controller.updateIsLoadingVisit(false);
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredVisit(true);
    controller.updateIsLoadingVisit(false);
  }
}
