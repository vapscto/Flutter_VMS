import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_get_work.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/hw_cw_view_work_item.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class HwCwViewWork extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final bool forHw;
  final HwCwController hwController;
  final HwCwNbController filteration;
  // final RxBool showFilter;
  const HwCwViewWork({
    super.key,
    required this.mskoolController,
    required this.loginSuccessModel,
    required this.forHw,
    required this.hwController,
    required this.filteration,
  });

  @override
  State<HwCwViewWork> createState() => _HwCwViewWorkState();
}

class _HwCwViewWorkState extends State<HwCwViewWork> {
  int color = -1;

  @override
  void initState() {
    GetHomeWorks.instance.getHomeWorks(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      hrmeId: widget.loginSuccessModel.empcode!,
      userId: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      loginId: widget.loginSuccessModel.userId!,
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
      controller: widget.hwController,
      forHw: widget.forHw,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.hwController.isErrorOccuredWhileLoadingWork.value
          ? Center(
              child: Center(
              child: ErrWidget(err: {
                "errorTitle": "An Error Occured",
                "errorMsg": widget.hwController.viewWorkLoadingStatus.value
              }),
            ))
          : widget.hwController.isWorkLoading.value
              ? const Center(
                  child: AnimatedProgressWidget(
                      title: "Loading Assigned Work's",
                      desc:
                          "Please wait while we load your assigned work.. your view will be visible here.",
                      animationPath: "assets/json/default.json"),
                )
              : widget.forHw
                  ? widget.hwController.homeWorks.isEmpty
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "No Assigned Work's",
                            desc:
                                "There are no assigned work available right now, try with adding some work.",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16.0),
                          itemBuilder: (_, index) {
                            color += 1;
                            if (color % 6 == 0) {
                              color = 0;
                            }
                            return HwCwViewWorkItem(
                              miId: widget.loginSuccessModel.mIID!,
                              color: color,
                              forHw: widget.forHw,
                              homeWork: widget.hwController.homeWorks
                                  .elementAt(index),
                              mskoolController: widget.mskoolController,
                              func: () {
                                if (widget.hwController.filterCount.value ==
                                    0) {
                                  GetHomeWorks.instance.getHomeWorks(
                                    miId: widget.loginSuccessModel.mIID!,
                                    asmayId: widget.loginSuccessModel.asmaYId!,
                                    hrmeId: widget.loginSuccessModel.empcode!,
                                    userId: widget.loginSuccessModel.userId!,
                                    ivrmrtId: widget.loginSuccessModel.roleId!,
                                    loginId: widget.loginSuccessModel.userId!,
                                    base: baseUrlFromInsCode(
                                      "portal",
                                      widget.mskoolController,
                                    ),
                                    controller: widget.hwController,
                                    forHw: widget.forHw,
                                  );
                                } else {
                                  GetHomeWorks.instance.getFilteredHwCw(
                                      miId: widget.loginSuccessModel.mIID!,
                                      asmayId:
                                          widget.loginSuccessModel.asmaYId!,
                                      hrmeId: widget.loginSuccessModel.empcode!,
                                      startDate: widget.filteration.dtList.first
                                          .toLocal()
                                          .toString(),
                                      endDate: widget.filteration.dtList.last
                                          .toLocal()
                                          .toString(),
                                      base: baseUrlFromInsCode(
                                        "portal",
                                        widget.mskoolController,
                                      ),
                                      controller: widget.hwController,
                                      forHw: widget.forHw);
                                }
                              },
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 16.0,
                            );
                          },
                          itemCount: widget.hwController.homeWorks.length)
                  : widget.hwController.classWorks.isEmpty
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "No Assigned Work's",
                            desc:
                                "There are no assigned work available right now, try with adding some work.",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16.0),
                          itemBuilder: (_, index) {
                            color += 1;
                            if (color % 6 == 0) {
                              color = 0;
                            }
                            return HwCwViewWorkItem(
                              color: color,
                              forHw: widget.forHw,
                              classwork: widget.hwController.classWorks
                                  .elementAt(index),
                              mskoolController: widget.mskoolController,
                              miId: widget.loginSuccessModel.mIID!,
                              func: () {
                                if (widget.hwController.filterCount.value ==
                                    0) {
                                  GetHomeWorks.instance.getHomeWorks(
                                    miId: widget.loginSuccessModel.mIID!,
                                    asmayId: widget.loginSuccessModel.asmaYId!,
                                    hrmeId: widget.loginSuccessModel.empcode!,
                                    userId: widget.loginSuccessModel.userId!,
                                    ivrmrtId: widget.loginSuccessModel.roleId!,
                                    loginId: widget.loginSuccessModel.userId!,
                                    base: baseUrlFromInsCode(
                                      "portal",
                                      widget.mskoolController,
                                    ),
                                    controller: widget.hwController,
                                    forHw: widget.forHw,
                                  );
                                } else {
                                  GetHomeWorks.instance.getFilteredHwCw(
                                      miId: widget.loginSuccessModel.mIID!,
                                      asmayId:
                                          widget.loginSuccessModel.asmaYId!,
                                      hrmeId: widget.loginSuccessModel.empcode!,
                                      startDate: widget.filteration.dtList.first
                                          .toLocal()
                                          .toString(),
                                      endDate: widget.filteration.dtList.last
                                          .toLocal()
                                          .toString(),
                                      base: baseUrlFromInsCode(
                                        "portal",
                                        widget.mskoolController,
                                      ),
                                      controller: widget.hwController,
                                      forHw: widget.forHw);
                                }
                              },
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 16.0,
                            );
                          },
                          itemCount: widget.hwController.classWorks.length,
                        );
    });

    // return widget.forHw
    //     ? FutureBuilder<List<HomeWorkViewWorkValues>>(
    //         future: homework,
    //         builder: (_, snapshot) {
    //           if (snapshot.hasData) {
    //             if (snapshot.data!.isEmpty) {
    //               return const Center(
    //                 child: AnimatedProgressWidget(
    //                   title: "No Assigned Work's",
    //                   desc:
    //                       "There are no assigned work available right now, try with adding some work.",
    //                   animationPath: "assets/json/nodata.json",
    //                   animatorHeight: 250,
    //                 ),
    //               );
    //             }
    //             return ListView.separated(
    //                 itemBuilder: (_, index) {
    //                   color += 1;
    //                   if (color % 6 == 0) {
    //                     color = 0;
    //                   }
    //                   return ElevatedButton(
    //                       onPressed: () {

    //                       },
    //                       child: const Text("CC"));
    //                 },
    //                 separatorBuilder: (_, index) {
    //                   return const SizedBox(
    //                     height: 16.0,
    //                   );
    //                 },
    //                 itemCount: snapshot.data!.length);
    //           }

    //           if (snapshot.hasError) {
    //             return Center(
    //               child: ErrWidget(err: snapshot.error as Map<String, dynamic>),
    //             );
    //           }
    //           return const Center(
    //             child: AnimatedProgressWidget(
    //                 title: "Loading Assigned Work's",
    //                 desc:
    //                     "Please wait while we load your assigned work.. your view will be visible here.",
    //                 animationPath: "assets/json/default.json"),
    //           );
    //         })
    //     : FutureBuilder<List<ClassWorkViewWorkValues>>(builder: (_, snapshot) {
    //         if (snapshot.hasData) {
    //           if (snapshot.data!.isEmpty) {
    //             return const Center(
    //               child: AnimatedProgressWidget(
    //                 title: "No Assigned Work's",
    //                 desc:
    //                     "There are no assigned work available right now, try with adding some work.",
    //                 animationPath: "assets/json/nodata.json",
    //                 animatorHeight: 250,
    //               ),
    //             );
    //           }
    //           return ListView.separated(
    //               itemBuilder: (_, index) {
    //                 color += 1;
    //                 if (color % 6 == 0) {
    //                   color = 0;
    //                 }
    //                 return const SizedBox();
    //               },
    //               separatorBuilder: (_, index) {
    //                 return const SizedBox(
    //                   height: 16.0,
    //                 );
    //               },
    //               itemCount: snapshot.data!.length);
    //         }

    //         if (snapshot.hasError) {
    //           return Center(
    //             child: ErrWidget(err: snapshot.error as Map<String, dynamic>),
    //           );
    //         }
    //         return const Center(
    //           child: AnimatedProgressWidget(
    //               title: "Loading Assigned Work's",
    //               desc:
    //                   "Please wait while we load your assigned work.. your view will be visible here.",
    //               animationPath: "assets/json/default.json"),
    //         );
    //       });
    // return ListView.separated(
    //   padding: const EdgeInsets.all(16.0),
    //   itemBuilder: (_, index) {
    //     color += 1;
    //     if (color % 6 == 0) {
    //       color = 0;
    //     }

    //     return HwCwViewWorkItem(color: color);
    //   },
    //   separatorBuilder: (_, index) {
    //     return const SizedBox(
    //       height: 16.0,
    //     );
    //   },
    //   itemCount: 7,
    // );
  }
}
