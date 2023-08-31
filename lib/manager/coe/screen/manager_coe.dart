import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/coe/api/coe_get_academic_month.dart';
import 'package:m_skool_flutter/manager/coe/api/get_coe_events.dart';
import 'package:m_skool_flutter/manager/coe/controller/manager_coe_handler.dart';
import 'package:m_skool_flutter/manager/coe/widget/coe_manager_selector.dart';
import 'package:m_skool_flutter/manager/coe/widget/manager_coe_item.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class ManagerCoeHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  final bool formDashboard;
  const ManagerCoeHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title,
      required this.formDashboard});

  @override
  State<ManagerCoeHome> createState() => _ManagerCoeHomeState();
}

class _ManagerCoeHomeState extends State<ManagerCoeHome> {
  final ManagerCoeHandler coeDataHandler = Get.put(ManagerCoeHandler());
  int color = -1;

  @override
  void initState() {
    loadCoe();
    super.initState();
  }

  loadCoe() async {
    await CoeGetAcademicAndMonthApi.instance.getAcademics(
      base: baseUrlFromInsCode("coe", widget.mskoolController),
      handler: coeDataHandler,
      miId: widget.loginSuccessModel.mIID!,
    );

    if (coeDataHandler.isErrorOccuredWhileLoadingAcademic.value &&
        (coeDataHandler.academic.isEmpty || coeDataHandler.months.isEmpty)) {
      return;
    }

    await GetCoeEventsForManagerApi.instance.getEvents(
      base: baseUrlFromInsCode("coe", widget.mskoolController),
      miId: widget.loginSuccessModel.mIID!,
      month: coeDataHandler.selectedMonth.value.monthid.toString(),
      asmayId: coeDataHandler.selectedYear.value.hrmlYId!,
      type: widget.loginSuccessModel.roleforlogin!.toLowerCase() == "staff"
          ? 1
          : widget.loginSuccessModel.roleforlogin!.toLowerCase() == "student"
              ? 2
              : 3,
      asmsclId: widget.loginSuccessModel.asmcLId != null
          ? "${widget.loginSuccessModel.asmcLId}"
          : "0",
      handler: coeDataHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.formDashboard
          ? const CustomAppBar(title: "Coe").getAppBar()
          : null,
      floatingActionButton: widget.formDashboard ? const HomeFab() : null,
      body: Obx(() {
        return coeDataHandler.isErrorOccuredWhileLoadingAcademic.value
            ? Center(
                child: ErrWidget(err: {
                  "errorTitle": "An Error Occured",
                  "errorMsg": coeDataHandler.status.value,
                }),
              )
            : coeDataHandler.isLoadingYear.value
                ? AnimatedProgressWidget(
                    title: "Loading Coe Academic Session's",
                    desc: coeDataHandler.status.value,
                    animationPath: "assets/json/COE.json")
                : Obx(() {
                    return coeDataHandler.academic.isEmpty
                        ? const Center(
                            child: AnimatedProgressWidget(
                              animationPath: "assets/json/nodata.json",
                              title: "No Session Found",
                              desc:
                                  "We couldn't find any academic year session, so we couldn't able to show any COE",
                            ),
                          )
                        : SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16.0,
                                ),
                                ManagerCoeSelector(
                                  coeDataHandler: coeDataHandler,
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                ),
                                Obx(() {
                                  return coeDataHandler
                                          .isErrorOccuredWhileLoadingCoe.value
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.1,
                                            ),
                                            ErrWidget(err: {
                                              "errorTitle": "Sorry! For this.",
                                              "errorMsg":
                                                  coeDataHandler.status.value,
                                            }),
                                          ],
                                        )
                                      : coeDataHandler.isLoadingCoe.value
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.1,
                                                ),
                                                const AnimatedProgressWidget(
                                                    title:
                                                        "Your events are comming.",
                                                    desc:
                                                        "All your event will appear here for a particular academic year. you can use dropdown to see different events.",
                                                    animationPath:
                                                        "assets/json/COE.json"),
                                              ],
                                            )
                                          : coeDataHandler.coeEvent.isEmpty
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.1,
                                                    ),
                                                    const AnimatedProgressWidget(
                                                      animationPath:
                                                          "assets/json/nodata.json",
                                                      animatorHeight: 250,
                                                      title: "No Coe Found",
                                                      desc:
                                                          "We couldn't find any coe with academic session and selected month .. Try with changing these values",
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Result",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (_, index) {
                                                        color += 1;
                                                        if (color % 6 == 0) {
                                                          color = 0;
                                                        }
                                                        return ManagerCoeItem(
                                                          values: coeDataHandler
                                                              .coeEvent
                                                              .elementAt(index),
                                                          color: noticeColor
                                                              .elementAt(color),
                                                        );
                                                      },
                                                      itemCount: coeDataHandler
                                                          .coeEvent.length,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return const SizedBox(
                                                          height: 16.0,
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                })
                              ],
                            ),
                          );
                  });
      }),
    );
  }
}
