import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/api/staff_dashboard_api.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/attendance_entry_home.dart';
import 'package:m_skool_flutter/staffs/controller/dashboard_controller.dart';
import 'package:m_skool_flutter/staffs/punch_report/screens/punch_report_home.dart';
import 'package:m_skool_flutter/staffs/salary_details/screen/salary_det_home.dart';
import 'package:m_skool_flutter/staffs/salary_slip/screen/salary_slip_home.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/screen/student_attendance_staff_home.dart';
import 'package:m_skool_flutter/staffs/student_birthday/screens/bday_home.dart';
import 'package:m_skool_flutter/staffs/widget/staff_dashboard_container.dart';
import 'package:m_skool_flutter/vms/interaction/screen/interaction_home.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key? key,
    required this.mskoolController,
    required this.dashboardController,
    required this.loginSuccessModel,
  }) : super(key: key);

  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final StaffDashboardController dashboardController;

  @override
  build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await StaffDashboardApi.instance.loadDashboard(
            miId: loginSuccessModel.mIID!,
            userId: loginSuccessModel.userId!,
            base: baseUrlFromInsCode("portal", mskoolController),
            controller: dashboardController);
        logger.d(dashboardController.dashboardLop.length);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StaffDashboardContainer(
              controller: dashboardController,
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
            ),

            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount:
                  loginSuccessModel.staffmobileappprivileges!.values!.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    logger.d(loginSuccessModel.staffmobileappprivileges!.values!
                        .elementAt(index)
                        .pagename);
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Attendance Entry") {
                      Get.to(
                        // () => const MonthWiseAttendanceEntryHomeScreen(),
                        () => AttendanceEntryHomeScreen(
                          loginSuccessModel: loginSuccessModel,
                          mskoolController: mskoolController,
                        ),
                        // () => const DayWiseAttendanceEntryHome(),
                      );
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Student Attendance Staff") {
                      Get.to(() => StudentAttendanceStaffHome(
                            loginSuccessModel: loginSuccessModel,
                            mskoolController: mskoolController,
                          ));
                    }
                    // if (loginSuccessModel.staffmobileappprivileges!.values!
                    //         .elementAt(index)
                    //         .pagename ==
                    //     "Mark Entry") {
                    //   Get.to(
                    //     () => MarksEntryHome(
                    //       loginSuccessModel: loginSuccessModel,
                    //       mskoolController: mskoolController,
                    //     ),
                    //   );
                    // }

                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Salary Details") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return
                            // SalarySlipHome(
                            //   loginSuccessModel: loginSuccessModel,
                            //   mskoolController: mskoolController,
                            // );
                            SalaryDetails(
                          loginSuccessModel: loginSuccessModel,
                          mskoolController: mskoolController,
                        );
                      }));
                      return;
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Salary Slip") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SalarySlipHome(
                          loginSuccessModel: loginSuccessModel,
                          mskoolController: mskoolController,
                        );
                        //     SalaryDetails(
                        //   loginSuccessModel: loginSuccessModel,
                        //   mskoolController: mskoolController,
                        // );
                      }));
                      return;
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Student Birth Day Report") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return StudentBdayHome(
                          loginSuccessModel: loginSuccessModel,
                          mskoolController: mskoolController,
                        );
                      }));
                      return;
                    }

                    // if (loginSuccessModel.staffmobileappprivileges!.values!
                    //         .elementAt(index)
                    //         .pagename ==
                    //     "Online Leave Apply") {
                    //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //     return OnlineLeaveApply(
                    //       loginSuccessModel: loginSuccessModel,
                    //       mskoolController: mskoolController,
                    //       title: loginSuccessModel
                    //           .staffmobileappprivileges!.values!
                    //           .elementAt(index)
                    //           .pagename!,
                    //     );
                    //   }));
                    //   return;
                    // }

                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Notice Board") {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) {
                      //   return ViewNoticeHome(
                      //     loginSuccessModel: loginSuccessModel,
                      //     mskoolController: mskoolController,
                      //     title: loginSuccessModel
                      //         .staffmobileappprivileges!.values!
                      //         .elementAt(index)
                      //         .pagename!,
                      //   );
                      // }));

                      // Notice Board Staff
                      // Get.to(() => NoticeBoardStaffHome(
                      //       loginSuccessModel: loginSuccessModel,
                      //       mskoolController: mskoolController,
                      //       title: loginSuccessModel
                      //           .staffmobileappprivileges!.values!
                      //           .elementAt(index)
                      //           .pagename!,
                      //     ));
                      return;
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "View Notice") {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) {
                      //   return ViewNoticeHome(
                      //     loginSuccessModel: loginSuccessModel,
                      //     mskoolController: mskoolController,
                      //     title: loginSuccessModel
                      //         .staffmobileappprivileges!.values!
                      //         .elementAt(index)
                      //         .pagename!,
                      //   );
                      // }));
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Punch Report") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return PunchReport(
                          loginSuccessModel: loginSuccessModel,
                          mskoolController: mskoolController,
                          title: loginSuccessModel
                              .staffmobileappprivileges!.values!
                              .elementAt(index)
                              .pagename!,
                        );
                      }));
                      return;
                    }

                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Verify Homework") {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) {
                      //       return VerifyHwCwHome(
                      //         loginSuccessModel: loginSuccessModel,
                      //         mskoolController: mskoolController,
                      //         title: loginSuccessModel
                      //             .staffmobileappprivileges!.values!
                      //             .elementAt(index)
                      //             .pagename!,
                      //         forHw: true,
                      //       );
                      //     },
                      //   ),
                      // );
                      return;
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Verify Classwork") {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) {
                      //       return VerifyHwCwHome(
                      //         loginSuccessModel: loginSuccessModel,
                      //         mskoolController: mskoolController,
                      //         title: loginSuccessModel
                      //             .staffmobileappprivileges!.values!
                      //             .elementAt(index)
                      //             .pagename!,
                      //         forHw: false,
                      //       );
                      //     },
                      //   ),
                      // );
                      return;
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Classwork") {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) {
                      //       return HwCwHome(
                      //         loginSuccessModel: loginSuccessModel,
                      //         mskoolController: mskoolController,
                      //         title: loginSuccessModel
                      //             .staffmobileappprivileges!.values!
                      //             .elementAt(index)
                      //             .pagename!,
                      //         forHw: false,
                      //       );
                      //     },
                      //   ),
                      // );
                      return;
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Homework") {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) {
                      //       return HwCwHome(
                      //         loginSuccessModel: loginSuccessModel,
                      //         mskoolController: mskoolController,
                      //         title: loginSuccessModel
                      //             .staffmobileappprivileges!.values!
                      //             .elementAt(index)
                      //             .pagename!,
                      //         forHw: true,
                      //       );
                      //     },
                      //   ),
                      // );
                      return;
                    }
                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Interaction") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return InteractionHome(
                              loginSuccessModel: loginSuccessModel,
                              mskoolController: mskoolController,
                            );
                          },
                        ),
                      );
                      return;
                    }

                    if (loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "COE") {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) {
                      //       return StaffCoeHome(
                      //         loginSuccessModel: loginSuccessModel,
                      //         mskoolController: mskoolController,
                      //         title: loginSuccessModel
                      //             .staffmobileappprivileges!.values!
                      //             .elementAt(index)
                      //             .pagename!,
                      //         //forHw: true,
                      //       );
                      //     },
                      //   ),
                      // );
                      return;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              getStaffDashboardIcon(
                                  "${loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"),
                              height: 60,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                              //maxLines: 1,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(fontSize: 13.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount:
            //       loginSuccessModel.staffmobileappprivileges!.values!.length,
            //   itemBuilder: (_, index) {
            //     return ListTile(
            //       onTap: () {},
            //       title: Text(
            //           loginSuccessModel.staffmobileappprivileges!.values!
            //           .elementAt(index)
            //           .pagename!),
            //     );
            //   },
            // ),
            const SizedBox(
              height: 24.0,
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            //   child: SizedBox(
            //     width: 180,
            //     height: 40,
            //     child: CustomElevatedButton(
            //         isGradient: false,
            //         boxShadow: const BoxShadow(),
            //         color: const Color(0xFFFFDFD6),
            //         child: Row(mainAxisSize: MainAxisSize.min, children: const [
            //           Icon(
            //             Icons.logout,
            //             color: Color(0xffF24E1E),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Log Out",
            //             style: TextStyle(
            //                 color: Color(0xffF24E1E),
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w600),
            //           )
            //         ]),
            //         onPressed: () {
            //           Get.dialog(const LogoutConfirmationPopup());
            //         }),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
