import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_section.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_subject.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_classes_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/hw_cw_section_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class HwCwClassDD extends StatelessWidget {
  final bool forHw;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const HwCwClassDD({
    Key? key,
    required this.hwCwController,
    required this.forHw,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  final HwCwController hwCwController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(
          child: DropdownButtonFormField<HwCwClassesListModelValues>(
              value: hwCwController.selectedClass.value,
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
                    color: const Color(0xFFFFEBEA),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/class_.svg",
                        height: 24.0,
                        color: const Color(0xFFFF6F67),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Class ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  fontSize: 20.0, color: Color(0xFFFF6F67)),
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
              items: hwCwController.classes
                  .map((e) => DropdownMenuItem<HwCwClassesListModelValues>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 5),
                        child: Text(e.asmcLClassName ?? "N/a"),
                      )))
                  .toList(),
              onChanged: (e) async {
                hwCwController.updateSelectedClass(e!);
                await loadAgain();
              }),
        ),
        Obx(() {
          return hwCwController.isErrorOccuredLoadingSection.value
              ? ErrWidget(err: {
                  "errorTitle": "An Unexpected Error Occurred",
                  "errorMsg": hwCwController.errorStatus.value
                })
              : hwCwController.isSectionLoading.value
                  ? Center(
                      child: AnimatedProgressWidget(
                        title: "Loading Available Section's",
                        desc: hwCwController.loadingStatus.value,
                        animationPath: "assets/json/hwanim.json",
                      ),
                    )
                  : hwCwController.sections.isEmpty
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "No Section Available",
                            desc:
                                "Sorry but there are no section available, try changing academic year",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : HwCwSectionDD(
                          hwCwController: hwCwController,
                          forHw: forHw,
                          loginSuccessModel: loginSuccessModel,
                          mskoolController: mskoolController,
                        );
        })
      ],
    );
  }

  Future<void> loadAgain() async {
    await HwCwGetSection.instance.getSections(
        miId: loginSuccessModel.mIID!,
        ivrmrtId: loginSuccessModel.roleId!,
        hrmeId: loginSuccessModel.empcode!,
        asmayId: hwCwController.selectedSession.value.asmaYId!,
        userId: loginSuccessModel.userId!,
        loginId: loginSuccessModel.userId!,
        asmclId: hwCwController.selectedClass.value.asmcLId!,
        base: baseUrlFromInsCode("portal", mskoolController),
        hwCwController: hwCwController,
        fromVerifyCat: false);
    if (hwCwController.isErrorOccuredLoadingSection.value ||
        hwCwController.sections.isEmpty) {
      return;
    }

    await HwCwGetSubjectsApi.instance.getSubjects(
      miId: loginSuccessModel.mIID!,
      hrmeId: loginSuccessModel.empcode!,
      asmayId: hwCwController.selectedSession.value.asmaYId!,
      asmclId: hwCwController.selectedClass.value.asmcLId!,
      sections: [
        {"ASMS_Id": hwCwController.selectedSection.first.asmSId!}
      ],
      ivrmrtId: loginSuccessModel.roleId!,
      loginId: loginSuccessModel.userId!,
      base: baseUrlFromInsCode("portal", mskoolController),
      hwCwController: hwCwController,
    );
  }
}
