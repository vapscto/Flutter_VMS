import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/staff_list_model.dart';

Future<void> checkAuthorizationLeave(
    {required int miId,
    required String base,
    required int userId,
    required int hrmlId,
    required OpetionLeaveController opetionLeaveController}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.leaveAuthorization;
  logger.d(api);

  logger.d({
    "MI_Id": miId,
    "UserId": userId,
    "HRML_Id": hrmlId,
  });

  try {
    // controller.updateisLoadingOnloadEmployee(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": userId,
      "HRML_Id": hrmlId,
    });

    opetionLeaveController.particularLeaveAuthorization =
        response.data["authorizationmessage"];

    /// **  Staff LIST Previlege  **  ///

    if (response.data['staff_List'] == null) {
      opetionLeaveController.updateErrorLoadingOnloadEmployee(true);
      // return 0;
    } else if (response.data['staff_List'] != null) {
      opetionLeaveController.updateErrorLoadingOnloadEmployee(false);
      opetionLeaveController.updateisLoadingOnloadEmployee(false);
      StaffPrevilegeListModel employeeListResponse =
          StaffPrevilegeListModel.fromJson(response.data['staff_List']);
      opetionLeaveController.employeeList.addAll(employeeListResponse.values!);
    }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
