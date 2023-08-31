import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_subject.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_section_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_topic_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/verify_cw_subject_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/widget/verify_subject_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class VerifySectionDD extends StatelessWidget {
  final HwCwController verifyController;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final bool forHw;
  const VerifySectionDD(
      {super.key,
      required this.verifyController,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.forHw});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(
          child: DropdownButtonFormField<HwCwSectionListModelValue>(
              value: verifyController.sections.first,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBFDF5),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/section_.svg",
                        height: 24.0,
                        color: const Color(0xFF47BA9E),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Section ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  //backgroundColor: Color(0xFFDFFBFE),
                                  fontSize: 20.0,
                                  color: Color(0xFF47BA9E)),
                            ),
                      ),
                    ],
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              icon: const Padding(
                padding: EdgeInsets.only(top: 4.5),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
              ),
              items: verifyController.sections
                  .map((e) => DropdownMenuItem<HwCwSectionListModelValue>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 5),
                        child: Text(e.asmCSectionName ?? "N/a"),
                      )))
                  .toList(),
              onChanged: (e) {
                verifyController.updateVerifySelectedSection(e!);
                loadAgain();
              }),
        ),
        Obx(() {
          return verifyController.isErrorOccuredLoadingSection.value
              ? ErrWidget(err: {
                  "errorTitle": "An Unexpected Error Occurred",
                  "errorMsg": verifyController.errorStatus.value
                })
              : verifyController.isSubjectLoading.value
                  ? Center(
                      child: AnimatedProgressWidget(
                        title: "Loading Available Subject's",
                        desc: verifyController.loadingStatus.value,
                        animationPath: "assets/json/hwanim.json",
                      ),
                    )
                  : verifyController.subjects.isEmpty &&
                          verifyController.cwSubjectList.isEmpty
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "No Subject's Available",
                            desc:
                                "Sorry but there are no subject available, try changing values",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : VerifySubjectDD(
                          mskoolController: mskoolController,
                          loginSuccesModel: loginSuccessModel,
                          verifyController: verifyController,
                          forHw: forHw,
                        );
        })
      ],
    );
  }

  Future<void> loadAgain() async {
    if (forHw) {
      await HwCwGetSubjectsApi.instance.getSubjects(
        miId: loginSuccessModel.mIID!,
        hrmeId: loginSuccessModel.empcode!,
        asmayId: verifyController.selectedSession.value.asmaYId!,
        asmclId: verifyController.selectedClass.value.asmcLId!,
        sections: [
          {"ASMS_Id": verifyController.verifySelectedSection.value.asmSId!}
        ],
        ivrmrtId: loginSuccessModel.roleId!,
        loginId: loginSuccessModel.userId!,
        base: baseUrlFromInsCode("portal", mskoolController),
        hwCwController: verifyController,
      );
      // return;
    } else {
      await VerifyCwSubjectListApi.instance.getCwSubjects(
          miId: loginSuccessModel.mIID!,
          hrme: loginSuccessModel.empcode!,
          loginId: loginSuccessModel.userId!,
          userId: loginSuccessModel.userId!,
          ivrmrtId: loginSuccessModel.roleId!,
          asmayId: verifyController.selectedSession.value.asmaYId!,
          asmscld: verifyController.selectedClass.value.asmcLId!,
          asmsId: verifyController.verifySelectedSection.value.asmSId!,
          base: baseUrlFromInsCode("portal", mskoolController),
          hwCwController: verifyController);
    }

    if (verifyController.isErrorOccuredLoadingSection.value ||
        (verifyController.cwSubjectList.isEmpty &&
            verifyController.subjects.isEmpty)) {
      return;
    }

    if (forHw) {
      await GetVerifyTopicApi.instance.getTopicForHw(
          asmayId: verifyController.selectedSession.value.asmaYId!,
          asmclId: verifyController.selectedClass.value.asmcLId!,
          miId: loginSuccessModel.mIID!,
          asmsId: verifyController.verifySelectedSection.value.asmSId!,
          ismsId: verifyController.selectedSubject.value.ismSId!,
          loginId: loginSuccessModel.userId!,
          controller: verifyController,
          base: baseUrlFromInsCode(
            "portal",
            mskoolController,
          ));
      // return;
    } else {
      await GetVerifyTopicApi.instance.getTopicForCw(
          asmayId: verifyController.selectedSession.value.asmaYId!,
          asmclId: verifyController.selectedClass.value.asmcLId!,
          miId: loginSuccessModel.mIID!,
          asmsId: verifyController.verifySelectedSection.value.asmSId!,
          ismsId: verifyController.selectedCwSub.value.iSMSId!,
          loginId: loginSuccessModel.userId!,
          controller: verifyController,
          base: baseUrlFromInsCode(
            "portal",
            mskoolController,
          ));
    }
  }
}
