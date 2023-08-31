import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_class.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_section.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_subject.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_year.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/hw_cw_academic_dd.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_topic_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/verify_cw_subject_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/widget/verify_class_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class VerifyHwCwHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  final bool forHw;
  const VerifyHwCwHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title,
      required this.forHw});

  @override
  State<VerifyHwCwHome> createState() => _VerifyHwCwHomeState();
}

class _VerifyHwCwHomeState extends State<VerifyHwCwHome> {
  final HwCwController verifyController = Get.put(HwCwController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadVHw();
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HwCwController>();
    super.dispose();
  }

  Future<void> loadVHw() async {
    // logger.d("Reached");

    await HwCwGetAcademicYear.instance.getAcademicYear(
      miId: widget.loginSuccessModel.mIID!,
      userId: widget.loginSuccessModel.userId!,
      loginId: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      hrmeId: widget.loginSuccessModel.empcode!,
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
      hwCwController: verifyController,
    );
    if (verifyController.isErrorOccuredLoadingAcademicYear.value ||
        verifyController.session.isEmpty) {
      return;
    }

    await HwCwGetClassApi.instance.getHwCwClasses(
      miId: widget.loginSuccessModel.mIID!,
      loginId: widget.loginSuccessModel.userId!,
      asmayId: verifyController.selectedSession.value.asmaYId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      hrmeId: widget.loginSuccessModel.empcode!,
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
      hwCwController: verifyController,
    );

    if (verifyController.isErrorOccuredLoadingClass.value ||
        verifyController.classes.isEmpty) {
      return;
    }

    await HwCwGetSection.instance.getSections(
        miId: widget.loginSuccessModel.mIID!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        hrmeId: widget.loginSuccessModel.empcode!,
        asmayId: verifyController.selectedSession.value.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        loginId: widget.loginSuccessModel.userId!,
        asmclId: verifyController.selectedClass.value.asmcLId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        hwCwController: verifyController,
        fromVerifyCat: true);
    if (verifyController.isErrorOccuredLoadingSection.value ||
        verifyController.sections.isEmpty) {
      return;
    }

    if (widget.forHw) {
      await HwCwGetSubjectsApi.instance.getSubjects(
        miId: widget.loginSuccessModel.mIID!,
        hrmeId: widget.loginSuccessModel.empcode!,
        asmayId: verifyController.selectedSession.value.asmaYId!,
        asmclId: verifyController.selectedClass.value.asmcLId!,
        sections: [
          {"ASMS_Id": verifyController.verifySelectedSection.value.asmSId!}
        ],
        ivrmrtId: widget.loginSuccessModel.roleId!,
        loginId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        hwCwController: verifyController,
      );
    } else {
      await VerifyCwSubjectListApi.instance.getCwSubjects(
          miId: widget.loginSuccessModel.mIID!,
          hrme: widget.loginSuccessModel.empcode!,
          loginId: widget.loginSuccessModel.userId!,
          userId: widget.loginSuccessModel.userId!,
          ivrmrtId: widget.loginSuccessModel.roleId!,
          asmayId: verifyController.selectedSession.value.asmaYId!,
          asmscld: verifyController.selectedClass.value.asmcLId!,
          asmsId: verifyController.verifySelectedSection.value.asmSId!,
          base: baseUrlFromInsCode("portal", widget.mskoolController),
          hwCwController: verifyController);
    }

    if (verifyController.isErrorOccuredLoadingSection.value ||
        (verifyController.cwSubjectList.isEmpty &&
            verifyController.subjects.isEmpty)) {
      return;
    }

    if (widget.forHw) {
      await GetVerifyTopicApi.instance.getTopicForHw(
          asmayId: verifyController.selectedSession.value.asmaYId!,
          asmclId: verifyController.selectedClass.value.asmcLId!,
          miId: widget.loginSuccessModel.mIID!,
          asmsId: verifyController.verifySelectedSection.value.asmSId!,
          ismsId: verifyController.selectedSubject.value.ismSId!,
          loginId: widget.loginSuccessModel.userId!,
          controller: verifyController,
          base: baseUrlFromInsCode(
            "portal",
            widget.mskoolController,
          ));
      // return;
    } else {
      await GetVerifyTopicApi.instance.getTopicForCw(
          asmayId: verifyController.selectedSession.value.asmaYId!,
          asmclId: verifyController.selectedClass.value.asmcLId!,
          miId: widget.loginSuccessModel.mIID!,
          asmsId: verifyController.verifySelectedSection.value.asmSId!,
          ismsId: verifyController.selectedCwSub.value.iSMSId!,
          loginId: widget.loginSuccessModel.userId!,
          controller: verifyController,
          base: baseUrlFromInsCode(
            "portal",
            widget.mskoolController,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.title).getAppBar(),
        floatingActionButton: const HomeFab(),
        body: Obx(() {
          return verifyController.isErrorOccuredLoadingAcademicYear.value
              ? Center(
                  child: ErrWidget(err: {
                    "errorTitle": "Error Occured Loading Academic's",
                    "errorMsg": verifyController.errorStatus.value
                  }),
                )
              : verifyController.isAcademicYearLoading.value
                  ? Center(
                      child: AnimatedProgressWidget(
                        title: "Loading Academic's",
                        desc: verifyController.loadingStatus.value,
                        animationPath: "assets/json/default.json",
                      ),
                    )
                  : verifyController.session.isEmpty
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "No Academic's Found",
                            desc:
                                "There are no academic session present in record.",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16.0,
                              ),
                              HwCwAcademicYearDD(
                                hwCwController: verifyController,
                                loginSuccessModel: widget.loginSuccessModel,
                                mskoolController: widget.mskoolController,
                                forHw: widget.forHw,
                                forVerify: widget.forHw == true ? false : true,
                              ),
                              Obx(() {
                                return verifyController.isClassLoading.value
                                    ? Center(
                                        child: AnimatedProgressWidget(
                                          title: "Loading Available Classes",
                                          desc: verifyController
                                              .loadingStatus.value,
                                          animationPath:
                                              "assets/json/hwanim.json",
                                        ),
                                      )
                                    : verifyController
                                            .isErrorOccuredLoadingClass.value
                                        ? ErrWidget(err: {
                                            "errorTitle":
                                                "Unexpected Error Occured",
                                            "errorMsg": verifyController
                                                .errorStatus.value
                                          })
                                        : verifyController.classes.isEmpty
                                            ? const Center(
                                                child: AnimatedProgressWidget(
                                                  title: "No Classes Available",
                                                  desc:
                                                      "Sorry but there are no classes available, try changing academic year",
                                                  animationPath:
                                                      "assets/json/nodata.json",
                                                  animatorHeight: 250,
                                                ),
                                              )
                                            : VerifyClassDD(
                                                verifyController:
                                                    verifyController,
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                                forHw: widget.forHw,
                                              );
                              }),
                            ],
                          ),
                        );
        }));
  }
}
