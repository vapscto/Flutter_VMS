import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/employee_model.dart';

getemployeeManagaementApi({
  required String base,
  required int miId,
  required int userId,
  required VisitorManagementsController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.visitormanagementapi;
  if (controller.isErrorOccuredassigned.value) {}

  logger.d(api);
  try {
    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {"mI_Id": miId, "UserId": userId});
    if (response.data['emplist'] != null) {
      EmployeelistModel pValues =
          EmployeelistModel.fromJson(response.data['emplist']);
      controller.getrequestGetemployeeList.addAll(pValues.values!);
    }
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredempoyee(true);
    controller.updateIsLoadingemployee(false);
  }
}
