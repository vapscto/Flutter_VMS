import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_fee_details.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_fee_model.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_leaves_details.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_preadmission.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';

class ManagerDashboardController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isErrorOccured = RxBool(false);

  void updateIsLoading(bool b) {
    isLoading.value = b;
  }

  void updateIsErrorOccured(bool b) {
    isErrorOccured.value = b;
  }

  RxList<ManagerDashboardFeeDetailsValues> feeDetails = RxList();

  void updateDashboardFeeDetails(List<ManagerDashboardFeeDetailsValues> fee) {
    if (feeDetails.isNotEmpty) {
      feeDetails.clear();
    }
    feeDetails.addAll(fee);
  }

  RxList<ManagerDashboardLeaveDetailsValues> dashboardLeave = RxList();

  void updateDashboardLeave(List<ManagerDashboardLeaveDetailsValues> leave) {
    if (dashboardLeave.isNotEmpty) {
      dashboardLeave.clear();
    }
    dashboardLeave.addAll(leave);
  }

  RxList<ManagerDashboardPreadmissionDetailsValues> preAdmission = RxList();

  void updateDashboardPreAdmission(
      List<ManagerDashboardPreadmissionDetailsValues> prAd) {
    if (preAdmission.isNotEmpty) {
      preAdmission.clear();
    }
    preAdmission.addAll(prAd);
  }

  RxList<DashboardFeeModelValues> fee = RxList();

  void updateDashboardFees(List<DashboardFeeModelValues> punch) {
    if (fee.isNotEmpty) {
      fee.clear();
    }
    fee.addAll(punch);
  }

  RxList<DashboardCoeDataModelValues> dashboardCoe = RxList();

  void updateDashboardCoe(List<DashboardCoeDataModelValues> coe) {
    if (dashboardCoe.isNotEmpty) {
      dashboardCoe.clear();
    }
    dashboardCoe.addAll(coe);
    // }
  }
}
