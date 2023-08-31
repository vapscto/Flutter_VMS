import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/time_table/controller/time_table_controller.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_time_table_stafflist_model.dart';

class GetStaffListInitialDataApi {
  GetStaffListInitialDataApi.init();

  static final GetStaffListInitialDataApi instance =
      GetStaffListInitialDataApi.init();

  getStaffList(
      {required int miId,
      required int asmayId,
      required String base,
      required ManagerTimeTableController controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.staffListInitialDataApi;
    logger.d(api);
    if (controller.isErrorOccuredWhileLoadingStaffList.value) {
      controller.updateIsErrorOccuredWhileLoadingStaffList(false);
    }

    controller.updateIsLoadingStaffList(true);

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
      });
      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
      });
      if (response.data['stafflist'] == null) {
        controller.updateIsErrorOccuredWhileLoadingStaffList(true);
        controller.updateIsLoadingStaffList(false);
        return;
      }

      final ManagerTimeTableStaffList staffList =
          ManagerTimeTableStaffList.fromJson(response.data['stafflist']);

      if (staffList.values!.isNotEmpty) {
        controller.selectedStaffList = staffList.values!.first;
      }

      controller.updatestaffList(staffList.values!);
      controller.updateIsLoadingStaffList(false);
      controller.updateIsErrorOccuredWhileLoadingStaffList(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingStaffList(true);
      controller.updateIsLoadingStaffList(false);
    }
  }
}
