import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/vms/utils/drawer_widget.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/theme_switcher.dart';
import 'package:m_skool_flutter/vms/utils/institute_change.dart';
import 'package:m_skool_flutter/widget/logout_confirmation.dart';

import '../../forgotpassword/screens/reset_password.dart';

class CommonDrawer extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ProfileController profileController;
  final VmsTransationController vmsTransationController;
  const CommonDrawer({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.profileController,
    required this.vmsTransationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaffDrawerHeader(
          loginSuccessModel: loginSuccessModel,
          profileController: profileController,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                loginSuccessModel.staffmobileappprivileges != null &&
                        loginSuccessModel
                            .staffmobileappprivileges!.values!.isNotEmpty
                    ? Column(
                        children: [
                          ...List.generate(
                            loginSuccessModel
                                .staffmobileappprivileges!.values!.length,
                            (index) => ListTile(
                              onTap: () {
                                openMappedPages(
                                  loginSuccessModel
                                          .staffmobileappprivileges!.values!
                                          .elementAt(index)
                                          .pagename ??
                                      "N/a",
                                  loginSuccessModel,
                                  mskoolController,
                                  context,
                                );
                              },
                              leading: Image.asset(
                                getDashboardIcon(loginSuccessModel
                                        .staffmobileappprivileges!.values!
                                        .elementAt(index)
                                        .pagename ??
                                    "N/a"),
                                width: 40,
                                height: 40,
                              ),
                              title: Text(loginSuccessModel
                                      .staffmobileappprivileges!.values!
                                      .elementAt(index)
                                      .pagename ??
                                  "N/a"),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                (loginSuccessModel.roleforlogin == "ADMIN")
                    ? const SizedBox()
                    : ListTile(
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
                // (loginSuccessModel.roleforlogin == "ADMIN")
                //     ? const SizedBox()
                //     : ListTile(
                //         title: const Text("Forgot Password"),
                //         leading: Container(
                //           decoration: const BoxDecoration(
                //             shape: BoxShape.circle,
                //           ),
                //           child: const CircleAvatar(
                //             // radius: 18,
                //             backgroundImage: AssetImage(
                //               "assets/images/ForgotPassword.png",
                //             ),
                //             backgroundColor: Colors.white,
                //           ),
                //         ),
                //         onTap: () {
                //           Navigator.pop(context);
                //           Get.to(() => ForgotPasswordScreen(
                //                 mskoolController: mskoolController,
                //                 forExpire: false,
                //               ));
                //         },
                //       ),
                (loginSuccessModel.roleforlogin == "ADMIN")
                    ? ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.amber[50]),
                          child: const CircleAvatar(
                            // radius: 18,
                            backgroundImage: AssetImage(
                              "assets/images/change.png",
                            ),
                            backgroundColor: Color.fromARGB(255, 253, 253, 253),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          instituteChange(context, vmsTransationController,
                              loginSuccessModel, mskoolController);
                        },
                        title: const Text('Select Company'),
                      )
                    : const SizedBox(),
                ListTile(
                  title: const Text("Select Theme"),
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/theme.png",
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const ThemeSwitcher();
                    }));
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    latestVersion,
                    style: Get.textTheme.titleSmall,
                  ),
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
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
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
