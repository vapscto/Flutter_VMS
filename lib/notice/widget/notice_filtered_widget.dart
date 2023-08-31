import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/notice/api/get_datewise_notices.dart';
import 'package:m_skool_flutter/notice/screen/notice_detail_screen.dart';
import 'package:m_skool_flutter/notice/screen/notice_home.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class NoticeFilteredWidget extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController hwCwNbController;
  const NoticeFilteredWidget(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.hwCwNbController});

  @override
  State<NoticeFilteredWidget> createState() => _NoticeFilteredWidgetState();
}

class _NoticeFilteredWidgetState extends State<NoticeFilteredWidget> {
  int color = -1;
  List<Color> usedColor = [];

  @override
  void initState() {
    getNotices();
    super.initState();
  }

  Future<void> getNotices() async {
    await GetDateWiseNotice.instance.getNotices(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      startDate: widget.hwCwNbController.dtList.first.toLocal().toString(),
      endDate: widget.hwCwNbController.dtList.last.toLocal().toString(),
      nbController: widget.hwCwNbController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.hwCwNbController.isErrorHappendWhileLoadingNotice.value
          ? const Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": "We are unable to load noticeboard",
                },
              ),
            )
          : widget.hwCwNbController.isNoticeDataLoading.value
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.25,
                    ),
                    const AnimatedProgressWidget(
                      title: "Loading Fitered Data",
                      desc: "Please wait while we load new data for you",
                      animationPath: "assets/json/Noticeboard.json",
                    ),
                  ],
                )
              : widget.hwCwNbController.noticeList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Notice Found",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Text(
                              "We couldn't find any notice for these filtration")
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.hwCwNbController.noticeList.length,
                      itemBuilder: (_, index) {
                        color += 1;
                        if (index % 6 == 0) {
                          color = 0;
                        }
                        if (color > 6) {
                          color = 0;
                        }

                        usedColor.add(noticeColor.elementAt(color));
                        return widget.hwCwNbController.noticeList
                                    .elementAt(index)
                                    .ntBTTSylabusFlg!
                                    .trim()
                                    .toLowerCase() ==
                                "tt"
                            ? TTNoticeItem(
                                color: color,
                                values: widget.hwCwNbController.noticeList
                                    .elementAt(index))
                            : InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return NoticeDetailScreen(
                                      color: noticeColor.elementAt(color),
                                      value: widget.hwCwNbController.noticeList
                                          .elementAt(index),
                                      base: baseUrlFromInsCode(
                                          "portal", widget.mskoolController),
                                      isFiltring: true,
                                      forSyllabus: widget
                                                  .hwCwNbController.noticeList
                                                  .elementAt(index)
                                                  .ntBTTSylabusFlg!
                                                  .trim()
                                                  .toLowerCase() ==
                                              "s"
                                          ? true
                                          : false,
                                    );
                                  }));
                                },
                                child: NoticeItem(
                                    color: color,
                                    values: widget.hwCwNbController.noticeList
                                        .elementAt(index)),
                              );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                    );
    });
  }
}
