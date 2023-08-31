import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_board_api.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/view_notice_card.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ViewNoticeTabScreen extends StatefulWidget {
  final NoticeBoardController nbController;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const ViewNoticeTabScreen(
      {super.key,
      required this.nbController,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<ViewNoticeTabScreen> createState() => _ViewNoticeTabScreenState();
}

class _ViewNoticeTabScreenState extends State<ViewNoticeTabScreen> {
  int color = -1;

  @override
  void initState() {
    StaffNoticeBoardApi.instance.getAllNotices(
        miId: widget.loginSuccessModel.mIID!,
        hrme: widget.loginSuccessModel.empcode!,
        userId: widget.loginSuccessModel.userId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        noticeBoardController: widget.nbController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.nbController.isErrorOccuredWhileLoadingWork.value
          ? Center(
              child: Center(
              child: ErrWidget(err: {
                "errorTitle": "An Error Occured",
                "errorMsg": widget.nbController.viewWorkLoadingStatus.value
              }),
            ))
          : widget.nbController.isWorkLoading.value
              ? const Center(
                  child: AnimatedProgressWidget(
                      title: "Loading Assigned Work's",
                      desc:
                          "Please wait while we load your assigned work.. your view will be visible here.",
                      animationPath: "assets/json/default.json"),
                )
              : widget.nbController.viewNoticeList.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Notice Found",
                        desc: "There are no notice's available right now.",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (_, index) {
                        color += 1;
                        if (color % 6 == 0) {
                          color = 0;
                        }
                        //
                        return ViewNoticeCard(
                          color: color,
                          values: widget.nbController.viewNoticeList
                              .elementAt(index),
                          base: baseUrlFromInsCode(
                              "portal", widget.mskoolController),
                          func: () {
                            StaffNoticeBoardApi.instance.getAllNotices(
                                miId: widget.loginSuccessModel.mIID!,
                                hrme: widget.loginSuccessModel.empcode!,
                                userId: widget.loginSuccessModel.userId!,
                                ivrmrtId: widget.loginSuccessModel.roleId!,
                                asmayId: widget.loginSuccessModel.asmaYId!,
                                base: baseUrlFromInsCode(
                                    "portal", widget.mskoolController),
                                noticeBoardController: widget.nbController);
                          },
                          miId: widget.loginSuccessModel.mIID!,
                          asmayId: widget.loginSuccessModel.asmaYId!,
                          ivrmrtId: widget.loginSuccessModel.roleId!,
                          userId: widget.loginSuccessModel.userId!,
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                      itemCount: widget.nbController.viewNoticeList.length);
    });
    // return ListView.separated(
    //   padding: const EdgeInsets.all(16.0),
    //   itemBuilder: (_, index) {
    //     color += 1;
    //     if (color % 6 == 0) {
    //       color = 0;
    //     }

    //     return ViewNoticeCard(color: color);
    //   },
    //   separatorBuilder: (_, index) {
    //     return const SizedBox(
    //       height: 16.0,
    //     );
    //   },
    //   itemCount: 1,
    // );
  }
}
