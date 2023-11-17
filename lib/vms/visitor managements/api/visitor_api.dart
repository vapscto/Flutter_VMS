import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/insituional_model.dart';

getVisitorManagaementApi({
  required String base,
  required int miId,
  required int userId,
  required VisitorManagementsController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.visitormanagementapi;
  logger.d(api);
  try {
    controller.updateIsLoadingVisitor(true);
    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {"mI_Id": miId, "UserId": userId});

    if (response.data['institutionlist'] != null) {
      controller.updateIsLoadingVisitor(false);
      InstitutionlistModel pValues =
          InstitutionlistModel.fromJson(response.data['institutionlist']);
      controller.getData(pValues.values!);
      controller.updateIsLoadingVisitor(false);
    }
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
