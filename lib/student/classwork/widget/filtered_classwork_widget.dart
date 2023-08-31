import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/classwork/api/get_filtered_classwork.dart';
import 'package:m_skool_flutter/student/classwork/api/update_seen_classwork_api.dart';
import 'package:m_skool_flutter/student/homework/screen/hwcw_detail_screen.dart';
import 'package:m_skool_flutter/student/homework/widget/hw_cw_item.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class FilteredClassWork extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController hwCwNbController;
  const FilteredClassWork(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.hwCwNbController});

  @override
  State<FilteredClassWork> createState() => _FilteredClassWorkState();
}

class _FilteredClassWorkState extends State<FilteredClassWork> {
  int color = -1;

  @override
  void initState() {
    getAssignment();
    super.initState();
  }

  Future<void> getAssignment() async {
    await GetFilteredClasswork.instance.getFilteredClassWork(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      startDate: widget.hwCwNbController.dtList.first.toLocal().toString(),
      endDate: widget.hwCwNbController.dtList.last.toLocal().toString(),
      hwCwNbController: widget.hwCwNbController,
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
    );

    logger.d(widget.hwCwNbController.classWorkList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        return widget.hwCwNbController.errorHappendWhileLoadingClsWrk.value
            ? Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.25,
                  ),
                  const ErrWidget(err: {
                    "errTitle": "Unexpected Error Occured",
                    "errMsg":
                        "Something went wrong either I'am unable to connect to server or data array is not present...ask your tech team to solve this issue"
                  }),
                ],
              )
            : widget.hwCwNbController.isClassWorkDataLoading.value
                ? Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.25,
                      ),
                      const AnimatedProgressWidget(
                        title: "Loading Filtered Assignments",
                        desc:
                            "We are filtering your classwork form whiteboard, it will be shown here",
                        animationPath: "assets/json/classwork.json",
                      ),
                    ],
                  )
                : widget.hwCwNbController.classWorkList.isEmpty
                    ? const AnimatedProgressWidget(
                        title: "No Classwork Found",
                        desc:
                            "We couldn't find any classwork for these filtration",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getFormatedDate(widget.hwCwNbController.dtList.first.toLocal())} - ${getFormatedDate(widget.hwCwNbController.dtList.last.toLocal())}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                widget.hwCwNbController.classWorkList.length,
                            itemBuilder: (_, index) {
                              color += 1;
                              if (index % 6 == 0) {
                                color = 0;
                              }
                              if (color > 6) {
                                color = 0;
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return HwCwDetailScreen(
                                      subject: widget
                                          .hwCwNbController.classWorkList
                                          .elementAt(index)
                                          .ismSSubjectName!,
                                      topic: widget
                                          .hwCwNbController.classWorkList
                                          .elementAt(index)
                                          .icWTopic!,
                                      assignment: widget.hwCwNbController
                                                  .classWorkList
                                                  .elementAt(index)
                                                  .icWAssignment ==
                                              null
                                          ? "N/A"
                                          : widget
                                              .hwCwNbController.classWorkList
                                              .elementAt(index)
                                              .icWAssignment!,
                                      date: widget
                                          .hwCwNbController.classWorkList
                                          .elementAt(index)
                                          .icWFromDate!,
                                      ihcId: widget
                                          .hwCwNbController.classWorkList
                                          .elementAt(index)
                                          .icWId!,
                                      content: widget
                                          .hwCwNbController.classWorkList
                                          .elementAt(index)
                                          .icWContent!,
                                      loginSuccessModel:
                                          widget.loginSuccessModel,
                                      mskoolController: widget.mskoolController,
                                      screenType: 'classwork',
                                    );
                                  })).then((value) {
                                    if (widget.hwCwNbController.classWorkList
                                            .elementAt(index)
                                            .iCWUPLViewedFlg ==
                                        1) {
                                      return;
                                    }
                                    getAssignment();
                                  });

                                  if (widget.hwCwNbController.classWorkList
                                          .elementAt(index)
                                          .iCWUPLViewedFlg ==
                                      1) {
                                    return;
                                  }
                                  UpdateClassworkSeenApi.instance.updateSeen(
                                      amstId: widget.loginSuccessModel.amsTId!,
                                      miId: widget.loginSuccessModel.mIID!,
                                      asmayId:
                                          widget.loginSuccessModel.asmaYId!,
                                      userId: widget.loginSuccessModel.userId!,
                                      roleId: widget.loginSuccessModel.roleId!,
                                      icwId: widget
                                          .hwCwNbController.classWorkList
                                          .elementAt(index)
                                          .icWId!,
                                      asmclId:
                                          widget.loginSuccessModel.asmcLId!,
                                      asmsId: widget.loginSuccessModel.asmSId!,
                                      base: baseUrlFromInsCode(
                                          "portal", widget.mskoolController));
                                },
                                child: HwCwItem(
                                    isRead: widget
                                                .hwCwNbController.classWorkList
                                                .elementAt(index)
                                                .iCWUPLViewedFlg ==
                                            1
                                        ? true
                                        : false,
                                    sub: widget.hwCwNbController.classWorkList
                                        .elementAt(index)
                                        .ismSSubjectName!,
                                    topic: widget.hwCwNbController.classWorkList
                                        .elementAt(index)
                                        .icWContent!,
                                    color: noticeColor.elementAt(color),
                                    verified: widget
                                                .hwCwNbController.classWorkList
                                                .elementAt(index)
                                                .icwupLMarks ==
                                            null
                                        ? 0
                                        : widget.hwCwNbController.classWorkList
                                            .elementAt(index)
                                            .icwupLMarks!
                                            .toInt()),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 16.0,
                              );
                            },
                          ),
                        ],
                      );
      }),
    );
  }
}
