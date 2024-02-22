import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/vms/utils/birthday_slider.dart';
import 'package:m_skool_flutter/vms/utils/periodicity_widget.dart';

class DashboardTab extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ProfileController profileController;
  const DashboardTab(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.profileController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Obx(() {
            return profileController.birthdayList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: BirthDaySlider(profileController: profileController),
                  )
                : const SizedBox();
          }),
          Obx(() {
            return (profileController.periodicityList.isEmpty)
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Issues Details",
                          style: Get.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        PeriodicityWidget(
                          controller: profileController,
                          loginSuccessModel: loginSuccessModel,
                          mskoolController: mskoolController,
                        ),
                      ],
                    ),
                  );
          }),
          loginSuccessModel.staffmobileappprivileges == null ||
                  loginSuccessModel.staffmobileappprivileges!.values!.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: loginSuccessModel
                          .staffmobileappprivileges!.values!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (_, index) {
                        return SizedBox(
                          // width: 100,
                          // height: 100,
                          child: InkWell(
                            onTap: () {
                              openMappedPages(
                                loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename!,
                                loginSuccessModel,
                                mskoolController,
                                context,
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    getDashboardIcon(
                                      loginSuccessModel
                                              .staffmobileappprivileges!.values!
                                              .elementAt(index)
                                              .pagename ??
                                          "N/a",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                (loginSuccessModel
                                            .staffmobileappprivileges!.values!
                                            .elementAt(index)
                                            .pagename ==
                                        'TADA Advance Approval')
                                    ? const Text(
                                        'TADA Ad. Approval',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      )
                                    : Text(
                                        loginSuccessModel
                                                .staffmobileappprivileges!
                                                .values!
                                                .elementAt(index)
                                                .pagename ??
                                            "N/a",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),

                                // )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
