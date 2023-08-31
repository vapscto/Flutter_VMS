import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/controller/manager_dashboard_controller.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_fee_details.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_fee_model.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_leaves_details.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_preadmission.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

import '../staff_leave_approval/screen/staff_leave_approval_home.dart';

class ManagerDashboardApi {
  ManagerDashboardApi.init();
  static final ManagerDashboardApi instance = ManagerDashboardApi.init();

  getDashboardData({
    required int miId,
    required int asmayId,
    required String base,
    required BuildContext context,
    required int userId,
    required int hrmeId,
    required LoginSuccessModel loginSuccessModel,
    required MskoolController mskoolController,
    required ManagerDashboardController dashboardController,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.managerDashboard;

    logger.d(api);
    logger.d({
      "MI_Id": miId,
      "ASMAY_Id": asmayId,
      "UserId": userId,
      "HRME_Id": hrmeId
    });
    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "ASMAY_Id": asmayId,
            "UserId": userId,
            "HRME_Id": hrmeId
          });

      if (response.data['managerDashboardCOE'] != null) {
        final DashboardCoeDataModel coe = DashboardCoeDataModel.fromJson(
            response.data['managerDashboardCOE']);
        dashboardController.updateDashboardCoe(coe.values!);
      }
      if (response.data['managerDashboardLeaveDetails'] != null) {
        final ManagerDashboardLeaveDetails leaves =
            ManagerDashboardLeaveDetails.fromJson(
                response.data['managerDashboardLeaveDetails']);
        dashboardController.updateDashboardLeave(leaves.values!);
      }
      if (response.data['managerDashboardFeesDetails'] != null) {
        final ManagerDashboardFeeDetails feeDetails =
            ManagerDashboardFeeDetails.fromJson(
                response.data['managerDashboardFeesDetails']);

        dashboardController.updateDashboardFeeDetails(feeDetails.values!);
      }
      if (response.data['managerDashboardPreadmissionDetails'] != null) {
        final ManagerDashboardPreadmissionDetails preadmissionDetails =
            ManagerDashboardPreadmissionDetails.fromJson(
                response.data['managerDashboardPreadmissionDetails']);
        dashboardController
            .updateDashboardPreAdmission(preadmissionDetails.values!);
      }
      if (response.data['managerdashFeetotal'] != null) {
        final DashboardFeeModel fee =
            DashboardFeeModel.fromJson(response.data['managerdashFeetotal']);
        dashboardController.updateDashboardFees(fee.values!);
      }

      if (response.data['leavecount'] as int > 0) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                insetPadding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pending Leaves",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/images/leave.png",
                        height: 70,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        "${response.data['leavecount']} Memebers Applied for Leave Approval",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      MSkollBtn(
                          title: "Proceed",
                          onPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return StaffLeaveApproval(
                                loginSuccessModel: loginSuccessModel,
                                mskoolController: mskoolController,
                                title: 'Leave Approval',
                              );
                            }));
                          }),
                      const SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    } on DioError catch (e) {
      logger.e(e.stackTrace);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
