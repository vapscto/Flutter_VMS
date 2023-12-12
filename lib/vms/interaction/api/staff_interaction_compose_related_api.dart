import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/interaction/controller/staff_interaction_compose_related_controller.dart';
import 'package:m_skool_flutter/vms/interaction/model/interaction_staff_list_mode.dart';

var dio = Dio();

Future<bool> submitComposeStaff({
  required Map data,
  required String base,
}) async {
  var url = base + URLS.interactionSave;
  logger.d(data);
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    logger.d(e.toString());
    return false;
  }
}

Future<bool> submitComposeIndivisual({
  required Map data,
  required String base,
}) async {
  var url = base + URLS.interactionSave;
  logger.d(data);
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    logger.d(e.toString());
    return false;
  }
}

class InteractionStaffListAPI {
  InteractionStaffListAPI.init();
  static final InteractionStaffListAPI instance =
      InteractionStaffListAPI.init();
  getStaffList(
      {required String base,
      required StaffInteractionComposeController
          staffInteractionComposeController,
      required int miId,
      required int asmayId,
      required int userId,
      required int irmrtId,
      required String flag}) async {
    var dio = Dio();
    var api = base + URLS.staffList;
    try {
      staffInteractionComposeController.dataLoading(true);
      var response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "Role_flag": flag,
        "IVRMRT_Id": irmrtId
      });
      if (response.statusCode == 200) {
        InteractionStaffListModel interactionStaffListModel =
            InteractionStaffListModel.fromJson(response.data['get_toEmplist']);
        staffInteractionComposeController
            .getStaffList(interactionStaffListModel.values!);
        staffInteractionComposeController.dataLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
