import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/homework/api/home_work_api.dart';
import 'package:m_skool_flutter/student/homework/api/update_hw_seen.dart';
import 'package:m_skool_flutter/student/homework/screen/hwcw_detail_screen.dart';
import 'package:m_skool_flutter/student/homework/widget/hw_cw_item.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class FiltredHw extends StatefulWidget {
  final HwCwNbController hwCwNbController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const FiltredHw(
      {super.key,
      required this.hwCwNbController,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<FiltredHw> createState() => _FiltredHwState();
}

class _FiltredHwState extends State<FiltredHw> {
  int color = -1;

  @override
  void initState() {
    getHw();
    super.initState();
  }

  Future<void> getHw() async {
    await GetHomeWorkApi.instance.getHomeAssignment(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        amstId: widget.loginSuccessModel.amsTId!,
        startDate: widget.hwCwNbController.dtList.first.toLocal().toString(),
        endDate: widget.hwCwNbController.dtList.last.toLocal().toString(),
        baseUrl: baseUrlFromInsCode("portal", widget.mskoolController),
        hwCwNbController: widget.hwCwNbController);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.hwCwNbController.isHomeWorkLoading.value
          ? Column(
              children: [
                SizedBox(
                  height: Get.height * 0.25,
                ),
                const AnimatedProgressWidget(
                    animationPath: "assets/json/hwanim.json",
                    title: "Loading Filter Homework",
                    desc:
                        "We are getting your homework, please wait while we do it for you"),
              ],
            )
          : widget.hwCwNbController.homeWorkList.isEmpty
              ? const AnimatedProgressWidget(
                  title: "No Homework Found",
                  desc:
                      "Hurray! We couldn't find any homework for this particular date, So enjoy",
                  animationPath: "assets/json/nodata.json",
                  animatorHeight: 250,
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
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
                                    topic: widget.hwCwNbController.homeWorkList
                                            .elementAt(index)
                                            .ihWTopic ??
                                        "N/a",
                                    ihcId: widget.hwCwNbController.homeWorkList
                                            .elementAt(index)
                                            .ihWId ??
                                        0,
                                    content: widget
                                            .hwCwNbController.homeWorkList
                                            .elementAt(index)
                                            .ihWAssignment ??
                                        "N/A",
                                    assignment: "",
                                    date: widget.hwCwNbController.homeWorkList
                                            .elementAt(index)
                                            .ihWDate ??
                                        "N/A",
                                    subject: widget
                                            .hwCwNbController.homeWorkList
                                            .elementAt(index)
                                            .ismSSubjectName ??
                                        "N/a",
                                    attachmentUrl: "",
                                    attachmentType: widget
                                                .hwCwNbController.homeWorkList
                                                .elementAt(index)
                                                .ihWFilePath ==
                                            null
                                        ? null
                                        : widget.hwCwNbController.homeWorkList
                                                .elementAt(index)
                                                .ihWFilePath!
                                                .endsWith(".pdf")
                                            ? "PDF"
                                            : "OTHERS",
                                    attachmentName: widget
                                            .hwCwNbController.homeWorkList
                                            .elementAt(index)
                                            .ihWFilePath ??
                                        "N/a",
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                    screenType: 'homework',
                                  );
                                })).then((value) {
                                  if (value == null) {}
                                  if (widget.hwCwNbController.homeWorkList
                                          .elementAt(index)
                                          .iHWUPLViewedFlg ==
                                      1) {
                                    return;
                                  }
                                  getHw();
                                });

                                if (widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .iHWUPLViewedFlg ==
                                    1) {
                                  return;
                                }

                                UpdateHwSeenApi.instance.markAsSeen(
                                    amstId: widget.loginSuccessModel.amsTId!,
                                    miId: widget.loginSuccessModel.mIID!,
                                    asmayId: widget.loginSuccessModel.asmaYId!,
                                    userId: widget.loginSuccessModel.userId!,
                                    roleId: widget.loginSuccessModel.roleId!,
                                    flag: "Homework",
                                    ihwId: widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWId!,
                                    asmclId: widget
                                        .hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .asmcLId!,
                                    asmsId: widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .asmSId!,
                                    base: baseUrlFromInsCode(
                                        "portal", widget.mskoolController));
                              },
                              child: HwCwItem(
                                  isRead: widget.hwCwNbController.homeWorkList
                                              .elementAt(index)
                                              .iHWUPLViewedFlg ==
                                          1
                                      ? true
                                      : false,
                                  sub: widget.hwCwNbController.homeWorkList
                                          .elementAt(index)
                                          .ismSSubjectName ??
                                      "N/a",
                                  topic: widget.hwCwNbController.homeWorkList
                                          .elementAt(index)
                                          .ihWAssignment ??
                                      "N/A",
                                  color: noticeColor.elementAt(color),
                                  verified: widget.hwCwNbController.homeWorkList
                                          .elementAt(index)
                                          .ihwupLMarks ??
                                      0),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 16.0,
                            );
                          },
                          itemCount:
                              widget.hwCwNbController.homeWorkList.length),
                    ],
                  ),
                );
    });
  }
}
