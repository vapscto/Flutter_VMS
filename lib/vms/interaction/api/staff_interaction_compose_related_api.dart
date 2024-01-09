import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/interaction/controller/staff_interaction_compose_related_controller.dart';
import 'package:m_skool_flutter/vms/interaction/model/interaction_list_model.dart';
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

class InteractionListAPI {
  InteractionListAPI.init();
  static final InteractionListAPI instance = InteractionListAPI.init();
  getInteractionList(
      {required String base,
      required StaffInteractionComposeController
          staffInteractionComposeController,
      required int miId,
      required int asmayId,
      required int userId,
      required int irmrtId,
      required String flag,
      required int ismintrId}) async {
    var dio = Dio();
    var api = base + URLS.interactionAllList;

    logger.d(api);

    logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "Role_flag": flag,
        "IVRMRT_Id": irmrtId,
        "ISMINTR_Id": ismintrId
      });
      
    try {
      staffInteractionComposeController.isgetdetailloading(true);
      var response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "Role_flag": flag,
        "IVRMRT_Id": irmrtId,
        "ISMINTR_Id": ismintrId
      });
      if (response.statusCode == 200) {
        InteractionListModel interactionStaffListModel =
            InteractionListModel.fromJson(response.data['get_messageDetail']);
        staffInteractionComposeController
            .getInteractionList(interactionStaffListModel.values!);
        staffInteractionComposeController.isgetdetailloading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}

Future<bool> sendVMSMessage({
  required int miId,
  required int asmayId,
  required String message,
  required int ismintId,
  required int userId,
  required int roleId,
  required String base,
}) async {
  var url = base + URLS.vmsInteractionSave;
  logger.d(url);
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "Role_flag": "S",
        "IVRMRT_Id": roleId,
        "ISMINTR_Id": 233,
        "ISMINTRD_ToId": 1861,
        "ISMINTRD_Interaction": message,
        "arrayreply": [
          {"ISMINTRD_ToId": 1915}
        ],
      },
    );
    if (response.statusCode == 200) {
      logger.d('true');
      return true;
    }
    logger.d('false');
    return false;
  } catch (e) {
    logger.e(e.toString());
    return false;
  }
}
