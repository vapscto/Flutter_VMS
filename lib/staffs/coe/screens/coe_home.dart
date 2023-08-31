import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/coe/api/coe_get_session_api.dart';
import 'package:m_skool_flutter/staffs/coe/api/staff_coe_api.dart';
import 'package:m_skool_flutter/staffs/coe/controller/coe_data_handler.dart';
import 'package:m_skool_flutter/staffs/coe/widget/coe_selector.dart';
import 'package:m_skool_flutter/staffs/coe/widget/staff_coe_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class StaffCoeHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  final bool? showAppBar;
  const StaffCoeHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title,
      this.showAppBar});

  @override
  State<StaffCoeHome> createState() => _StaffCoeHomeState();
}

class _StaffCoeHomeState extends State<StaffCoeHome> {
  // final List<String> session = ["2022", "2021", "2020", "2019"];

  final CoeDataHandler coeDataHandler = Get.put(CoeDataHandler());

  int color = -1;

  Future<void> loadCoeScreen() async {
    await CoeAcademicSession.instance.getViewNoticeSession(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      flag: "O",
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
      handler: coeDataHandler,
    );
    logger.d(baseUrlFromInsCode("coe", widget.mskoolController));
    if (coeDataHandler.isErrorOccured.value) {
      return;
    }
    await StaffCoeApi.instance.getCoeList(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: coeDataHandler.selectedAcademicYear.value.asmaYId!,
      base: baseUrlFromInsCode("coe", widget.mskoolController),
      month: DateTime.now().month,
      asmclId: widget.loginSuccessModel.asmcLId!,
      coeDataHandler: coeDataHandler,
    );
  }

  @override
  void initState() {
    loadCoeScreen();

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CoeDataHandler>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar == null
          ? const CustomAppBar(title: "Coe").getAppBar()
          : null,
      floatingActionButton: widget.showAppBar != null ? null : const HomeFab(),
      body: Obx(() {
        return coeDataHandler.isErrorOccured.value
            ? const Center(
                child: ErrWidget(err: {
                  "errorTitle": "An Error Occured",
                  "errorMsg":
                      "While Loading the coe, we encountered an error, or server returned an error"
                }),
              )
            : coeDataHandler.isWholePageLoading.value
                ? AnimatedProgressWidget(
                    title: "Loading Coe Academic Session's",
                    desc: coeDataHandler.coeLoadingStatus.value,
                    animationPath: "assets/json/COE.json")
                : Obx(() {
                    return coeDataHandler.sessions.isEmpty
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
                                CoeSelectors(
                                  coeDataHandler: coeDataHandler,
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                ),
                                Obx(() {
                                  return coeDataHandler
                                          .errorOccuredWhileLoadingCoe.value
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.1,
                                            ),
                                            const ErrWidget(err: {
                                              "errorTitle": "Sorry! For this.",
                                              "errorMsg":
                                                  "While loading the coe for selected academic year and month, we encountered an error"
                                            }),
                                          ],
                                        )
                                      : coeDataHandler.isCoeLoading.value
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
                                          : coeDataHandler.coeLists.isEmpty
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
                                                    const SizedBox(
                                                      height: 16.0,
                                                    ),
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (_, index) {
                                                        color += 1;
                                                        if (index % 6 == 0) {
                                                          color = 0;
                                                        }
                                                        return StaffCoeItem(
                                                          values: coeDataHandler
                                                              .coeLists
                                                              .elementAt(index),
                                                          color: noticeColor
                                                              .elementAt(color),
                                                        );
                                                      },
                                                      itemCount: coeDataHandler
                                                          .coeLists.length,
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
