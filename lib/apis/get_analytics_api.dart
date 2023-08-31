import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_fee_details.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_fee_model.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_leaves_details.dart';
import 'package:m_skool_flutter/manager/model/manager_dashboard_preadmission.dart';
import 'package:m_skool_flutter/manager/staff_leave_approval/screen/staff_leave_approval_home.dart';
import 'package:m_skool_flutter/model/exam_list.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/model/staff_analytics_privilages.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_leave_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_lop_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_punch_report_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_tt_model.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class GetAnalyticsApi {
  GetAnalyticsApi.init();
  static final GetAnalyticsApi instance = GetAnalyticsApi.init();

  getData({
    required DynamicAnalyticsController controller,
    required LoginSuccessModel loginSuccessModel,
    required MskoolController mskoolController,
    required String base,
    required BuildContext context,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = base + URLS.dynamicAnalytics;
      // logger.d({
      //   "RoleType": loginSuccessModel.roleforlogin,
      //   "MI_Id": loginSuccessModel.mIID,
      //   "AMST_Id": loginSuccessModel.amsTId ?? 0,
      //   "ASMCL_Id": loginSuccessModel.asmcLId ?? 0,
      //   "ASMS_Id": loginSuccessModel.asmSId ?? 0,
      //   "ASMAY_Id": loginSuccessModel.asmaYId ?? 0,
      //   "UserId": loginSuccessModel.userId ?? 0,
      // });
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "RoleType": loginSuccessModel.roleforlogin,
          "MI_Id": loginSuccessModel.mIID,
          "AMST_Id": loginSuccessModel.amsTId ?? 0,
          "ASMCL_Id": loginSuccessModel.asmcLId ?? 0,
          "ASMS_Id": loginSuccessModel.asmSId ?? 0,
          "ASMAY_Id": loginSuccessModel.asmaYId ?? 0,
          "UserId": loginSuccessModel.userId ?? 0,
        },
      );

      logger.d(response.data);

      final StaffAnalyticsPrivilages privilages =
          loginSuccessModel.staffAnalyticsPrivilages!;

      for (var element in privilages.values!) {
        logger.d(element.pagename);
        if (element.pagename == "leaveDetails") {
          if (response.data['leaveDetails'] != null) {
            controller.updateDashboardLeaves(
                DashboardLeaveModel.fromJson(response.data['leaveDetails'])
                    .values!);
          }
          continue;
        }
        if (element.pagename == "lopDetails") {
          if (response.data['lopDetails'] != null) {
            controller.updateDashboardLop(
                DashboardLopModel.fromJson(response.data['lopDetails'])
                    .values!);
          }
          continue;
        }

        if (element.pagename == "punchDetails") {
          if (response.data['punchDetails'] != null) {
            controller.updateDashboardPunch(DashboardPunchReportModel.fromJson(
                    response.data['punchDetails'])
                .values!);
          }
          continue;
        }
        if (element.pagename == "calList") {
          if (response.data['calList'] != null) {
            controller.updateDashboardCoe(
                DashboardCoeDataModel.fromJson(response.data['calList'])
                    .values!);
          }
          continue;
        }
        if (element.pagename == "timeTableDetails") {
          if (response.data['timeTableDetails'] != null) {
            controller.updateDashboardTT(StaffDashboardTimetableModel.fromJson(
                    response.data['timeTableDetails'])
                .values!);
          }
          continue;
        }

        // if (element.pagename == "managerDashboardCOE") {
        //   if (response.data['managerDashboardCOE'] != null) {
        //     final DashboardCoeDataModel coe = DashboardCoeDataModel.fromJson(
        //         response.data['managerDashboardCOE']);
        //     controller.updateDashboardCoe(coe.values!);
        //   }
        // }
        if (element.pagename!.toLowerCase() == "managerdashboardleavedetails") {
          if (response.data['managerDashboardLeaveDetails'] != null) {
            final ManagerDashboardLeaveDetails leaves =
                ManagerDashboardLeaveDetails.fromJson(
                    response.data['managerDashboardLeaveDetails']);
            controller.updateDashboardLeave(leaves.values!);
          }
          continue;
        }
        if (element.pagename!.toLowerCase() == "managerdashboardfeesdetails") {
          if (response.data['managerDashboardFeesDetails'] != null) {
            final ManagerDashboardFeeDetails feeDetails =
                ManagerDashboardFeeDetails.fromJson(
                    response.data['managerDashboardFeesDetails']);

            controller.updateDashboardFeeDetails(feeDetails.values!);
          }
          continue;
        }
        if (element.pagename!.toLowerCase() ==
            "managerdashboardpreadmissiondetails") {
          if (response.data['managerDashboardPreadmissionDetails'] != null) {
            final ManagerDashboardPreadmissionDetails preadmissionDetails =
                ManagerDashboardPreadmissionDetails.fromJson(
                    response.data['managerDashboardPreadmissionDetails']);
            controller.updateDashboardPreAdmission(preadmissionDetails.values!);
          }
          continue;
        }
        if (element.pagename!.toLowerCase() == "managerdashfeetotal") {
          if (response.data['managerdashFeetotal'] != null) {
            final DashboardFeeModel fee = DashboardFeeModel.fromJson(
                response.data['managerdashFeetotal']);
            controller.updateDashboardFees(fee.values!);
          }
          continue;
        }

        if (element.pagename == "birthdayList") {
          if (response.data['birthdayList'] != null) {
            final BirthdayList bDay =
                BirthdayList.fromJson(response.data['birthdayList']);
            controller.updateBirthday(bDay.values!);
          }
          continue;
        }
        if (element.pagename == "attendanceList") {
          if (response.data['attendanceList'] != null) {
            final AttendanceList attendance =
                AttendanceList.fromJson(response.data['attendanceList']);
            controller.updateAttendance(attendance.values!);
          }
          continue;
        }
        if (element.pagename == "feesList") {
          if (response.data['feesList'] != null) {
            final FeesList fee = FeesList.fromJson(response.data['feesList']);
            controller.updateFeeList(fee.values!);
          }
          continue;
        }
        if (element.pagename == "timeTableList") {
          if (response.data['timeTableList'] != null) {
            final TimeTableList tt =
                TimeTableList.fromJson(response.data['timeTableList']);
            controller.updateStudentTT(tt.values!);
          }
          continue;
        }
        if (element.pagename == "examList") {
          if (response.data['examList'] != null) {
            final ExamListNew exam =
                ExamListNew.fromJson(response.data['examList']);
            controller.selectedOption.value = exam.values!.first;
            controller.updateExamList(exam.values!);
          }
          continue;
        }
      }

      if (response.data['leavecount'] != null &&
          response.data['leavecount'] as int > 0) {
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
      logger.d(e.message);
    } on Exception catch (e) {
      logger.d(e.toString());
    }
  }
}
