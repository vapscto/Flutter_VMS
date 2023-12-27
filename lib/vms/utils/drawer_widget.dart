import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/forgotpassword/screens/forgot_password_screen.dart';
import 'package:m_skool_flutter/manager/overall_fee/screen/overall_fee_home.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/screen/notice_board_staff_home.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/screen/leave_list_home.dart';
import 'package:m_skool_flutter/widget/logout_confirmation.dart';

import '../../forgotpassword/screens/reset_password.dart';
import '../../screens/theme_switcher.dart';

class ManagerDashboardDrawer extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ManagerDashboardDrawer(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaffDrawerHeader(loginSuccessModel: loginSuccessModel),
        Expanded(
          child: loginSuccessModel.staffmobileappprivileges == null
              ? const SizedBox()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        loginSuccessModel
                            .staffmobileappprivileges!.values!.length,
                        (index) => ListTile(
                          onTap: () {
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Student Birth Day Report") {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (_) {
                              //   return ManagerStudentDetails(
                              //     loginSuccessModel: loginSuccessModel,
                              //     mskoolController: mskoolController,
                              //     title: loginSuccessModel
                              //         .staffmobileappprivileges!.values!
                              //         .elementAt(index)
                              //         .pagename!,
                              //   );
                              // }));

                              return;
                            }
                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Leave Approval Staff") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ListLeaveHomeScreen(
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
                            // if (loginSuccessModel
                            //         .staffmobileappprivileges!.values!
                            //         .elementAt(index)
                            //         .pagename ==
                            //     'Notice Board Staff') {
                            //   Get.to(() => NoticeBoardStaffHome(
                            //         loginSuccessModel: loginSuccessModel,
                            //         mskoolController: mskoolController,
                            //         title: loginSuccessModel
                            //             .staffmobileappprivileges!.values!
                            //             .elementAt(index)
                            //             .pagename!,
                            //       ));
                            // }

                            if (loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename ==
                                "Overall Fee") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return OverallFeeHome(
                                      loginSuccessModel: loginSuccessModel,
                                      mskoolController: mskoolController,
                                      title: loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename!,
                                    );
                                  },
                                ),
                              );

                              return;
                            }
                            // if (loginSuccessModel
                            //         .staffmobileappprivileges!.values!
                            //         .elementAt(index)
                            //         .pagename ==
                            //     "COE Report") {
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (_) {
                            //     return ManagerCoeHome(
                            //       loginSuccessModel: loginSuccessModel,
                            //       mskoolController: mskoolController,
                            //       title: loginSuccessModel
                            //           .staffmobileappprivileges!.values!
                            //           .elementAt(index)
                            //           .pagename!,
                            //       formDashboard: true,
                            //     );
                            //   }));

                            //   return;
                            // }
                          },
                          leading: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              // radius: 18,
                              backgroundImage: AssetImage(
                                getManagerDashboardIconByName(
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
                  ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.loginSuccessModel.roleforlogin!.toLowerCase() ==
                                "student"
                            ? Column(
                                children: [
                                  Text(
                                    widget.loginSuccessModel.userId.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        // Text(
                        //   widget.loginSuccessModel.empcode.toString(),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: Theme.of(context).textTheme.labelSmall!.merge(
                        //         const TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        // ),
                      ],
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
                // IconButton(onPressed: (){}, icon: Icon(Icons.setting))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
