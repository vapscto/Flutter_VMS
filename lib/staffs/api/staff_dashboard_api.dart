import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/controller/dashboard_controller.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_leave_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_lop_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_punch_report_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_tt_model.dart';

class StaffDashboardApi {
  StaffDashboardApi.init();
  static final StaffDashboardApi instance = StaffDashboardApi.init();

  loadDashboard(
      {required int miId,
      required int userId,
      required String base,
      required StaffDashboardController controller}) async {
    final String apiUrl = base + URLS.staffDashboard;
    final Dio ins = getGlobalDio();

    try {
      if (controller.isErrorOccured.value) {
        controller.updateIsErrorOccured(false);
      }

      controller.updateIsLoading(true);

      final Response response = await ins.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {"MI_Id": miId, "UserId": userId},
      );
      if (response.data['leaveDetails'] != null) {
        controller.updateDashboardLeaves(
            DashboardLeaveModel.fromJson(response.data['leaveDetails'])
                .values!);
      }

      if (response.data['lopDetails'] != null) {
        controller.updateDashboardLop(
            DashboardLopModel.fromJson(response.data['lopDetails']).values!);
      }

      if (response.data['punchDetails'] != null) {
        controller.updateDashboardPunch(
            DashboardPunchReportModel.fromJson(response.data['punchDetails'])
                .values!);
      }

      if (response.data['calList'] != null) {
        controller.updateDashboardCoe(
            DashboardCoeDataModel.fromJson(response.data['calList']).values!);
      }

      if (response.data['timeTableDetails'] != null) {
        controller.updateDashboardTT(StaffDashboardTimetableModel.fromJson(
                response.data['timeTableDetails'])
            .values!);
      }
    } on DioError catch (e) {
      logger.d(e.message);
    } on Exception catch (e) {
      logger.d(e.toString());
    }
  }
}
