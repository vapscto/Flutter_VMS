import 'package:flutter/material.dart';
import 'package:m_skool_flutter/apis/get_analytics_api.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/dynamic_analytics.dart';

class DashboardTab extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final DynamicAnalyticsController controller;
  const DashboardTab(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await GetAnalyticsApi.instance.getData(
            controller: controller,
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            base: baseUrlFromInsCode("portal", mskoolController),
            context: context);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DynamicAnalytics(
              dashboardController: controller,
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
            ),
            loginSuccessModel.staffmobileappprivileges == null ||
                    loginSuccessModel.staffmobileappprivileges!.values!.isEmpty
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      loginSuccessModel.roleforlogin!.toLowerCase() == "manager"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  "Quick Search",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomContainer(
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (_) {
                                            //   return ManagerStudentDetails(
                                            //     loginSuccessModel:
                                            //         loginSuccessModel,
                                            //     mskoolController:
                                            //         mskoolController,
                                            //     title: 'Student Details',
                                            //   );
                                            // }));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: const Color(0xFFFAEFFE)),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/stu_d.png",
                                                  width: 36.0,
                                                ),
                                                const SizedBox(
                                                  width: 12.0,
                                                ),
                                                const Expanded(
                                                    child: Text("Student"))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                    Expanded(
                                      child: CustomContainer(
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (_) {
                                            //   return EmployeeDetailsHomeScreen(
                                            //     loginSuccessModel:
                                            //         loginSuccessModel,
                                            //     mskoolController:
                                            //         mskoolController,
                                            //   );
                                            // }));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: const Color(0xFFECF8FF)),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/emp_d.png",
                                                  width: 36.0,
                                                ),
                                                const SizedBox(
                                                  width: 12.0,
                                                ),
                                                const Expanded(
                                                    child: Text("Staff"))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                              ],
                            )
                          : const SizedBox(),
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
                                                .staffmobileappprivileges!
                                                .values!
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
      ),
    );
  }
}
