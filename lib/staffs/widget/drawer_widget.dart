import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/forgotpassword/screens/forgot_password_screen.dart';
import 'package:m_skool_flutter/forgotpassword/screens/reset_password.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/theme_switcher.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/attendance_entry_home.dart';
import 'package:m_skool_flutter/staffs/coe/screens/coe_home.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/screen/hw_cw_home.dart';
import 'package:m_skool_flutter/staffs/interaction/screen/interaction_home.dart';
import 'package:m_skool_flutter/staffs/marks_entry/screen/marks_entry_home.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/screen/notice_board_staff_home.dart';
import 'package:m_skool_flutter/staffs/online_leave/screen/online_leave_home.dart';
import 'package:m_skool_flutter/staffs/punch_report/screens/punch_report_home.dart';
import 'package:m_skool_flutter/staffs/salary_details/screen/salary_det_home.dart';
import 'package:m_skool_flutter/staffs/salary_slip/screen/salary_slip_home.dart';
import 'package:m_skool_flutter/staffs/staff_tt/screens/staff_tt_home.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/screen/student_attendance_staff_home.dart';
import 'package:m_skool_flutter/staffs/student_birthday/screens/bday_home.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/screen/verify_hw_cw_home.dart';
import 'package:m_skool_flutter/staffs/view_notice/screens/view_notice_home_screen.dart';
import 'package:m_skool_flutter/widget/logout_confirmation.dart';

class StaffDashboardDrawer extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffDashboardDrawer(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaffDrawerHeader(loginSuccessModel: loginSuccessModel),
        Expanded(
          child: SingleChildScrollView(
            child: loginSuccessModel.staffmobileappprivileges != null &&
                    loginSuccessModel.staffmobileappprivileges!.values != null
                ? Column(
                    children: [
                      ...List.generate(
                        loginSuccessModel
                            .staffmobileappprivileges!.values!.length,
                        (index) => ListTile(
                          onTap: () {
                            logger.d(loginSuccessModel
                                .staffmobileappprivileges!.values!
                                .elementAt(index)
                                .pagename);
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
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
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Student Attendance Staff") {
                              Get.to(() => StudentAttendanceStaffHome(
                                    loginSuccessModel: loginSuccessModel,
                                    mskoolController: mskoolController,
                                  ));
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Mark Entry") {
                              Get.to(
                                () => MarksEntryHome(
                                  loginSuccessModel: loginSuccessModel,
                                  mskoolController: mskoolController,
                                ),
                              );
                            }

                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Salary Details") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
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
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Salary Slip") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return SalarySlipHome(
                                  loginSuccessModel: loginSuccessModel,
                                  mskoolController: mskoolController,
                                );
                              }));
                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Staff Birth Day Report") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return StudentBdayHome(
                                  loginSuccessModel: loginSuccessModel,
                                  mskoolController: mskoolController,
                                );
                              }));
                              return;
                            }

                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Online Leave Apply") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return OnlineLeaveApply(
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

                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
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
                              Get.to(() => NoticeBoardStaffHome(
                                    loginSuccessModel: loginSuccessModel,
                                    mskoolController: mskoolController,
                                    title: 'Notice Board',
                                  ));
                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "View Notice") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ViewNoticeHome(
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
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "Punch Report") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
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

                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "Verify Homework") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return VerifyHwCwHome(
                                      loginSuccessModel: loginSuccessModel,
                                      mskoolController: mskoolController,
                                      title: loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename!,
                                      forHw: true,
                                    );
                                  },
                                ),
                              );
                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "Verify Classwork") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return VerifyHwCwHome(
                                      loginSuccessModel: loginSuccessModel,
                                      mskoolController: mskoolController,
                                      title: loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename!,
                                      forHw: false,
                                    );
                                  },
                                ),
                              );
                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "Classwork") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return HwCwHome(
                                      loginSuccessModel: loginSuccessModel,
                                      mskoolController: mskoolController,
                                      title: loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename!,
                                      forHw: false,
                                    );
                                  },
                                ),
                              );
                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "Homework") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return HwCwHome(
                                      loginSuccessModel: loginSuccessModel,
                                      mskoolController: mskoolController,
                                      title: loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename!,
                                      forHw: true,
                                    );
                                  },
                                ),
                              );
                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
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
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "Time Table") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return StaffTTHome(
                                      loginSuccessModel: loginSuccessModel,
                                      mskoolController: mskoolController,
                                      title: loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename!,
                                      //forHw: true,
                                    );
                                  },
                                ),
                              );
                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename! ==
                                "COE") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return StaffCoeHome(
                                      loginSuccessModel: loginSuccessModel,
                                      mskoolController: mskoolController,
                                      title: loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename!,
                                      //forHw: true,
                                    );
                                  },
                                ),
                              );
                              return;
                            }
                          },
                          leading: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              // radius: 18,
                              backgroundImage: AssetImage(
                                getStaffDashboardIcon(
                                    "${loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          title: Text(
                              "${loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"),
                        ),
                      ),
                      ListTile(
                        title: const Text("Change Password"),
                        leading: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            // radius: 18,
                            backgroundImage: AssetImage(
                              "assets/images/ChangePassword.png",
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(() => ResetPassword(
                                mskoolController: mskoolController,
                                loginSuccessModel: loginSuccessModel,
                              ));
                        },
                      ),
                      ListTile(
                        title: const Text("Forgot Password"),
                        leading: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            // radius: 18,
                            backgroundImage: AssetImage(
                              "assets/images/ForgotPassword.png",
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(() => ForgotPasswordScreen(
                                mskoolController: mskoolController,
                                forExpire: false,
                              ));
                        },
                      ),
                      ListTile(
                        title: const Text("Select Theme"),
                        leading: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            // radius: 18,
                            backgroundImage: AssetImage(
                              "assets/images/theme.png",
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const ThemeSwitcher();
                          }));
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: SizedBox(
                            width: 180,
                            height: 40,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: const Color(0xFFFFDFD6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                                onPressed: () {
                                  Get.dialog(const LogoutConfirmationPopup());
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Color(0xffF24E1E),
                                ),
                                label: Text(
                                  "Log Out",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(
                                        const TextStyle(
                                          color: Color(0xffF24E1E),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                )),
                          )),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
      ],
    );
  }
}

class StaffDrawerHeader extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  const StaffDrawerHeader({super.key, required this.loginSuccessModel});

  @override
  State<StaffDrawerHeader> createState() => _StaffDrawerHeaderState();
}

class _StaffDrawerHeaderState extends State<StaffDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16.0, (MediaQuery.of(context).padding.top + 32.0), 16.0, 30.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40)),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() {
          //   return
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.0,
            backgroundImage: (widget.loginSuccessModel.userImagePath == null ||
                    widget.loginSuccessModel.userImagePath!.isEmpty)
                ? null
                : NetworkImage(widget.loginSuccessModel.userImagePath!),
            child: (widget.loginSuccessModel.userImagePath == null ||
                    widget.loginSuccessModel.userImagePath!.isEmpty)
                ?
                // ?
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 36.0,
                    ),
                  )
                : null,
            // : Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Image.network(
            //       widget.loginSuccessModel.userImagePath!,
            //       fit: BoxFit.fill,
            //     ),
            //   ),
          ),
          // }),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(() {
                // return
                Text(
                  widget.loginSuccessModel.studname ?? "N/A",
                  style: Theme.of(context).textTheme.labelLarge!.merge(
                        const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                ),
                // }),
                const SizedBox(
                  height: 6.0,
                ),
                // EmailWidget(userProfileController: controller),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  children: [
                    Text(
                      // controller.profileData.elementAt(0).mobileNo ??
                      widget.loginSuccessModel.hrmEEmployeeCode ?? "N/A",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                            const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: IconButton(
                //       onPressed: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (_) {
                //           return const ThemeSwitcher();
                //         }));
                //       },
                //       icon: Image.asset("assets/images/theme.png")),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
