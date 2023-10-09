import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/dashboard_exam_api.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/exam_list.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/widget/punch_lop_analytics.dart';
import 'package:m_skool_flutter/staffs/widget/staff_home_leave.dart';
import 'package:m_skool_flutter/staffs/widget/staff_home_tt.dart';
import 'package:m_skool_flutter/student/attendance/screens/home_page.dart';
import 'package:m_skool_flutter/student/exam/screen/exam_home.dart';
import 'package:m_skool_flutter/widget/card_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/dashbaord_fee_widget.dart';
import 'package:m_skool_flutter/widget/dashboard_attendance.dart';
import 'package:m_skool_flutter/widget/dashboard_line_chart.dart';
import 'package:m_skool_flutter/widget/dashboard_timetable_widget.dart';
import 'package:m_skool_flutter/widget/home_screen_carasouel.dart';

class DynamicAnalytics extends StatelessWidget {
  final DynamicAnalyticsController dashboardController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const DynamicAnalytics(
      {super.key,
      required this.dashboardController,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StudentAnalytics(
            dashboardController: dashboardController,
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController),
        StaffAnalytics(
          dashboardController: dashboardController,
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ),
        // ManagerDashboardContainer(
        //     dashboardController: dashboardController,
        //     loginSuccessModel: loginSuccessModel,
        //     mskoolController: mskoolController)
      ],
    );
  }
}

class StudentAnalytics extends StatelessWidget {
  const StudentAnalytics({
    super.key,
    required this.dashboardController,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  final DynamicAnalyticsController dashboardController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return dashboardController.dashboardCoe.isNotEmpty ||
                  dashboardController.birthday.isNotEmpty
              ? Column(
                  children: [
                    HomePageCarasouel(
                      coeList: dashboardController.dashboardCoe,
                      bdayList: dashboardController.birthday,
                      loginSuccessModel: loginSuccessModel,
                      mskoolController: mskoolController,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                )
              : const SizedBox();
        }),
        Obx(() {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (dashboardController.attendance.isNotEmpty)
                      ? Expanded(
                          flex: 1,
                          child: CardWidget(
                            padding: const EdgeInsets.all(0),
                            children: [
                              SizedBox(
                                height: 36,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => AttendanceHomeScreen(
                                        loginSuccessModel: loginSuccessModel,
                                        mskoolController: mskoolController));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Attendance",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const Icon(Icons.chevron_right_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                                // trailing
                              ),
                              SizedBox(
                                height: Get.width * 0.4329,
                                child: DashBoardAttendance(
                                  attendanceValue: dashboardController
                                          .attendance.first.score ??
                                      0,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    width: 12.0,
                  ),
                  (dashboardController.feeList.isNotEmpty)
                      ? Expanded(
                          flex: 1,
                          child: DashboardFeeGraph(
                            feeDet: dashboardController.feeList,
                            loginSuccessModel: loginSuccessModel,
                            mskoolController: mskoolController,
                          ),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          );
        }),
        Obx(() {
          return (dashboardController.timeTableList.isNotEmpty)
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: DashboardTimetable(
                        timeTableList: dashboardController.timeTableList,
                        loginSuccessModel: loginSuccessModel,
                        mskoolController: mskoolController,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                )
              : Container();
        }),
        Obx(() {
          return (dashboardController.examList.isNotEmpty)
              ? Column(
                  children: [
                    CustomContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 6.0,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ExamHome(
                                  loginSuccessModel: loginSuccessModel,
                                  mskoolController: mskoolController));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Exam",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const Icon(Icons.chevron_right_rounded),
                                ],
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -4.0),
                            child: Obx(() {
                              return dashboardController.examList.isEmpty
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: DropdownButton<ExamListNewValues>(
                                        value: dashboardController
                                            .selectedOption.value,
                                        isDense: true,
                                        underline: const SizedBox(),
                                        isExpanded: false,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color,
                                        ),
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black),
                                        items: List.generate(
                                            dashboardController.examList.length,
                                            (index) => DropdownMenuItem(
                                                value: dashboardController
                                                    .examList
                                                    .elementAt(index),
                                                child: Text(dashboardController
                                                        .examList
                                                        .elementAt(index)
                                                        .eMEExamName ??
                                                    "N/a"))),
                                        onChanged: (value) async {
                                          // dashboardController
                                          //     .selectedOption.value = value!;
                                          // await DashboardExamApi.instance
                                          //     .loadExamData(
                                          //         miId: loginSuccessModel.mIID!,
                                          //         asmayId: loginSuccessModel
                                          //             .asmaYId!,
                                          //         asmclId: loginSuccessModel
                                          //             .asmcLId!,
                                          //         asmsId:
                                          //             loginSuccessModel.asmSId!,
                                          //         amstId:
                                          //             loginSuccessModel.amsTId!,
                                          //         emeId: dashboardController
                                          //             .selectedOption
                                          //             .value
                                          //             .eMEId!,
                                          //         base: baseUrlFromInsCode(
                                          //             "portal",
                                          //             mskoolController),
                                          //         dashboardController:
                                          //             dashboardController);
                                        },
                                      ),
                                    );
                            }),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Obx(() {
                            //logger.d("Updating here");
                            return DashboardLineChart(
                              selectedExam:
                                  dashboardController.selectedOption.value,
                              loginSuccessModel: loginSuccessModel,
                              mskoolController: mskoolController,
                              dashboardController: dashboardController,
                            );
                          }),
                          const SizedBox(
                            height: 12.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                  ],
                )
              : Container();
        }),
      ],
    );
  }
}

class StaffAnalytics extends StatelessWidget {
  const StaffAnalytics(
      {super.key,
      required this.dashboardController,
      required this.loginSuccessModel,
      required this.mskoolController});
  final DynamicAnalyticsController dashboardController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return dashboardController.dashboardLop.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    PunchLopAnalytics(
                      controller: dashboardController,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                );
        }),
        Obx(() {
          return dashboardController.dashboardLeaves.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    StaffHomeLeave(
                      controller: dashboardController,
                      loginSuccessModel: loginSuccessModel,
                      mskoolController: mskoolController,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                );
        }),
        Obx(() {
          return dashboardController.dashboardTT.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    StaffHomeTT(
                      controller: dashboardController,
                      loginSuccessModel: loginSuccessModel,
                      mskoolController: mskoolController,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                );
        })
      ],
    );
  }
}
