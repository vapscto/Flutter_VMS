import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/api/dashboard_api.dart';
import 'package:m_skool_flutter/manager/coe/screen/manager_coe.dart';
import 'package:m_skool_flutter/manager/controller/manager_dashboard_controller.dart';
import 'package:m_skool_flutter/manager/employee_details/screens/employee_details_home_screen.dart';
import 'package:m_skool_flutter/manager/overall_fee/screen/overall_fee_home.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/screen/notice_board_staff_home.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ManagerDashboard extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ManagerDashboard(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  final ManagerDashboardController dashboardController =
      Get.put(ManagerDashboardController());
  @override
  void initState() {
    ManagerDashboardApi.instance.getDashboardData(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        dashboardController: dashboardController,
        context: context,
        hrmeId: widget.loginSuccessModel.empcode!,
        userId: widget.loginSuccessModel.userId!,
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ManagerDashboardApi.instance.getDashboardData(
          miId: widget.loginSuccessModel.mIID!,
          asmayId: widget.loginSuccessModel.asmaYId!,
          base: baseUrlFromInsCode("portal", widget.mskoolController),
          dashboardController: dashboardController,
          context: context,
          hrmeId: widget.loginSuccessModel.empcode!,
          userId: widget.loginSuccessModel.userId!,
          loginSuccessModel: widget.loginSuccessModel,
          mskoolController: widget.mskoolController,
        );
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ManagerDashboardContainer(
          //   dashboardController: dashboardController,
          //   loginSuccessModel: widget.loginSuccessModel,
          //   mskoolController: widget.mskoolController,
          // ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "Quick Search",
            style: Theme.of(context).textTheme.titleSmall!.merge(
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
                      // Navigator.push(context, MaterialPageRoute(builder: (_) {
                      //   return ManagerStudentDetails(
                      //     loginSuccessModel: widget.loginSuccessModel,
                      //     mskoolController: widget.mskoolController,
                      //     title: 'Student Details',
                      //   );
                      // }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
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
                          const Expanded(child: Text("Student"))
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return EmployeeDetailsHomeScreen(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
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
                          const Expanded(child: Text("Staff"))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          widget.loginSuccessModel.staffmobileappprivileges != null
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // logger.d(widget
                        //     .loginSuccessModel.staffmobileappprivileges!.values!
                        //     .elementAt(index)
                        //     .pagename);

                        if (widget.loginSuccessModel.staffmobileappprivileges!
                                .values!
                                .elementAt(index)
                                .pagename ==
                            "Student") {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) {
                          //   return ManagerStudentDetails(
                          //     loginSuccessModel: widget.loginSuccessModel,
                          //     mskoolController: widget.mskoolController,
                          //     title: widget.loginSuccessModel
                          //         .staffmobileappprivileges!.values!
                          //         .elementAt(index)
                          //         .pagename!,
                          //   );
                          // }));

                          return;
                        }

                        if (widget.loginSuccessModel.staffmobileappprivileges!
                                .values!
                                .elementAt(index)
                                .pagename ==
                            "Employee Details") {
                          Get.to(
                            () => EmployeeDetailsHomeScreen(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                            ),
                          );
                          return;
                        }
                        if (widget.loginSuccessModel.staffmobileappprivileges!
                                .values!
                                .elementAt(index)
                                .pagename ==
                            'Notice Board') {
                          Get.to(() => NoticeBoardStaffHome(
                                loginSuccessModel: widget.loginSuccessModel,
                                mskoolController: widget.mskoolController,
                                title: widget.loginSuccessModel
                                    .staffmobileappprivileges!.values!
                                    .elementAt(index)
                                    .pagename!,
                              ));
                        }

                        if (widget.loginSuccessModel.staffmobileappprivileges!
                                .values!
                                .elementAt(index)
                                .pagename ==
                            "Overall Fee") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return OverallFeeHome(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                  title: widget.loginSuccessModel
                                      .staffmobileappprivileges!.values!
                                      .elementAt(index)
                                      .pagename!,
                                );
                              },
                            ),
                          );

                          return;
                        }
                        if (widget.loginSuccessModel.staffmobileappprivileges!
                                .values!
                                .elementAt(index)
                                .pagename ==
                            "COE Report") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ManagerCoeHome(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              title: widget.loginSuccessModel
                                  .staffmobileappprivileges!.values!
                                  .elementAt(index)
                                  .pagename!,
                              formDashboard: true,
                            );
                          }));

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
                                  getManagerDashboardIconByName(
                                      "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"),
                                  height: 60,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                                  //maxLines: 1,
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
                  itemCount: widget.loginSuccessModel.staffmobileappprivileges!
                      .values!.length,
                )
              : const AnimatedProgressWidget(
                  title: "No Category Available",
                  desc: "",
                  animationPath: "assets/json/nodata.json",
                  animatorHeight: 250,
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
        ]),
      ),
    );
  }
}
