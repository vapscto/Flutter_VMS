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

  logger.d(api);

  try {
    controller.updateIsLoadingVisit(true);

    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {"mI_Id": miId, "UserId": userId});

    logger.e({"mI_Id": miId, "UserId": userId}); //60415
    logger.i(response.data['visitorlist']);

    if (response.data['visitorlist'] != null) {
      controller.updateIsErrorOccuredVisit(true);

      VisitorlistModel pValues =
          VisitorlistModel.fromJson(response.data['visitorlist']);
      controller.getvisitor(pValues.values!);
    }
    controller.updateIsLoadingVisit(false);
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredVisit(true);
    controller.updateIsLoadingVisit(false);
  }
}
