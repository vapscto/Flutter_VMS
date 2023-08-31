import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/api/view_notice_circular.dart';
import 'package:m_skool_flutter/staffs/view_notice/api/view_notice_get_session.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/widget/academic_year_dd.dart';
import 'package:m_skool_flutter/staffs/view_notice/widget/circular_notice_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class TTScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ViewNoticeDataController dataController;
  const TTScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.dataController});

  @override
  State<TTScreen> createState() => _TTScreenState();
}

class _TTScreenState extends State<TTScreen> {
  // final ViewNoticeDataController dataController =
  //     Get.put(ViewNoticeDataController());
  @override
  void initState() {
    loadCircularNT();
    super.initState();
  }

  @override
  void dispose() {
    // Get.delete<ViewNoticeDataController>();
    super.dispose();
  }

  Future<void> loadCircularNT() async {
    await ViewNoticeGetSession.instance.getViewNoticeSession(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      flag: "tt",
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      dataController: widget.dataController,
    );
    if (widget.dataController.isErrorOccuredWhileLoadingCircular.value) {
      return;
    }
    await ViewCircularNoticeApi.instance.getCircularNotice(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        asmayId: widget.dataController.selectedSession.value.asmaYId!,
        flag: "tt",
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        dataController: widget.dataController);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.dataController.isErrorOccuredWhileLoadingCircular.value
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ErrWidget(err: {
                    "errorTitle": "An error Occured",
                    "errorMsg":
                        "Sorry but while loading Academic year, we encountered an error."
                  }),
                ],
              ),
            )
          : widget.dataController.isCircularPageLoading.value
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: Get.height * 0.2,
                      ),
                      const AnimatedProgressWidget(
                          title: "Loading Academic Year",
                          desc:
                              "We are loading Academic year to get circular.. Your content will be visisble here.",
                          animationPath: "assets/json/Noticeboard.json"),
                    ],
                  ),
                )
              : widget.dataController.circularSession.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Academic Year Found",
                        desc:
                            "Unfortunately, we couldn't find any academic year, Please contact to your technical team to solve this issue",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : Column(
                      children: [
                        AcademicYearDD(
                          dataController: widget.dataController,
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          message: "tt",
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CircularNoticeWidget(
                          datController: widget.dataController,
                          moduleName: 'timetable',
                          base: baseUrlFromInsCode(
                              "portal", widget.mskoolController),
                        ),
                      ],
                    );
    });
  }
}
