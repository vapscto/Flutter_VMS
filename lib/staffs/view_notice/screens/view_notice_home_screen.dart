import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/screens/circula_screen.dart';
import 'package:m_skool_flutter/staffs/view_notice/screens/syllabus_screen.dart';
import 'package:m_skool_flutter/staffs/view_notice/screens/tt_screen.dart';
import 'package:m_skool_flutter/staffs/view_notice/widget/filter_controller_widget.dart';
import 'package:m_skool_flutter/staffs/view_notice/widget/filtered_notice.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

import '../widget/filter_notice_by_type.dart';

class ViewNoticeHome extends StatefulWidget {
  final String title;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ViewNoticeHome({
    super.key,
    required this.title,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<ViewNoticeHome> createState() => _ViewNoticeHomeState();
}

class _ViewNoticeHomeState extends State<ViewNoticeHome> {
  final ScrollController scrollController = ScrollController();
  RxBool showFilter = RxBool(false);
  RxString noticeType = RxString("circular");
  final HwCwNbController hwCwNbController = Get.put(HwCwNbController());
  final ViewNoticeDataController viewNoticeDataController =
      Get.put(ViewNoticeDataController());
  int color = -1;
  final List<Color> usedBgColor = [];
  final List<Color> usedChipColor = [];

  @override
  void dispose() {
    Get.delete<HwCwNbController>();
    Get.delete<ViewNoticeDataController>();

    usedBgColor.clear();
    usedChipColor.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        action: [
          IconButton(
            onPressed: () {
              if (scrollController.offset > 0 && showFilter.value) {
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn);
                return;
              }

              if (showFilter.value) {
                showFilter.value = false;
              } else {
                showFilter.value = true;
              }

              // setState(() {});

              scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastOutSlowIn);
            },
            icon: SvgPicture.asset('assets/svg/filter.svg'),
          ),
        ],
      ).getAppBar(),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Obx(() {
              return showFilter.value == false
                  ? const SizedBox()
                  : FilterControllerWidget(
                      hwCwNbController: hwCwNbController,
                      showFilter: showFilter,
                      forHwCw: false,
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      datController: viewNoticeDataController,
                    );
            }),
            const SizedBox(
              height: 12.0,
            ),
            Obx(() {
              return hwCwNbController.filter.value == 0
                  ? NoticeFilterByType(noticeType: noticeType)
                  : const SizedBox();
            }),
            const SizedBox(
              height: 20.0,
            ),
            Obx(() {
              return hwCwNbController.filter.value > 0
                  ? FilteredNotice(
                      base:
                          baseUrlFromInsCode("portal", widget.mskoolController),
                      datController: viewNoticeDataController,
                      asmayId: widget.loginSuccessModel.asmaYId!,
                      endDt: hwCwNbController.dtList.first.toLocal().toString(),
                      hrmeId: widget.loginSuccessModel.empcode!,
                      miId: widget.loginSuccessModel.mIID!,
                      startDt:
                          hwCwNbController.dtList.last.toLocal().toString())
                  : noticeType.value == "circular"
                      ? CirculaNotice(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          dataController: viewNoticeDataController,
                          message: 'o',
                        )
                      : noticeType.value == "syllabus"
                          ? SyllabusScreen(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              dataController: viewNoticeDataController,
                              // dataController: viewNoticeDataController,
                              // message: 's',
                            )
                          : TTScreen(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              dataController: viewNoticeDataController,
                            );
            }),
          ],
        ),
      ),
      floatingActionButton: const HomeFab(),
    );
  }

  filter() {}
}
