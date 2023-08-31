import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_subject.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/check_box_container.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/hw_cw_subject_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class HwCwSectionDD extends StatelessWidget {
  final HwCwController hwCwController;
  final bool forHw;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const HwCwSectionDD(
      {super.key,
      required this.hwCwController,
      required this.forHw,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32.0,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              constraints:
                  const BoxConstraints(minHeight: 20.0, maxHeight: 180),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 4,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: RawScrollbar(
                thumbColor: const Color(0xFF1E38FC),
                trackColor: const Color.fromRGBO(223, 239, 253, 1),
                trackRadius: const Radius.circular(10),
                trackVisibility: true,
                radius: const Radius.circular(10),
                thickness: 14,
                child: ListView.builder(
                  itemCount: hwCwController.sections.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 30,
                      child: CheckBoxContainer(
                        sectionName: hwCwController.sections
                                .elementAt(index)
                                .asmCSectionName ??
                            "N/a",
                        func: (b) {
                          if (b) {
                            hwCwController.updateSelectedSection(
                                hwCwController.sections.elementAt(index));
                          } else {
                            hwCwController.selectedSection.remove(
                                hwCwController.sections.elementAt(index));
                          }

                          loadAgain();
                        },
                        isChecked: RxBool(hwCwController.selectedSection
                            .contains(
                                hwCwController.sections.elementAt(index))),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: -20,
              left: 14,
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: const BoxDecoration(
                  color: Color(0xFFDBFDF5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/section_.svg",
                      fit: BoxFit.cover,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Section',
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Color(0xFF47BA9E),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // CustomContainer(
        //   child: DropdownButtonFormField<HwCwSectionListModelValue>(
        //       value: hwCwController.selectedSection.value,
        //       style: Theme.of(context).textTheme.titleSmall!.merge(
        //             const TextStyle(fontSize: 16.0),
        //           ),
        //       decoration: InputDecoration(
        //         focusedBorder: const OutlineInputBorder(
        //           borderSide: BorderSide(
        //             color: Colors.transparent,
        //           ),
        //         ),
        //         enabledBorder: const OutlineInputBorder(
        //           borderSide: BorderSide(
        //             color: Colors.transparent,
        //           ),
        //         ),
        //         label: Container(
        //           decoration: BoxDecoration(
        //             color: const Color(0xFFDBFDF5),
        //             borderRadius: BorderRadius.circular(24.0),
        //           ),
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: 12.0, vertical: 6.0),
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               SvgPicture.asset(
        //                 "assets/svg/section_.svg",
        //                 height: 24.0,
        //                 color: const Color(0xFF47BA9E),
        //               ),
        //               const SizedBox(
        //                 width: 6.0,
        //               ),
        //               Text(
        //                 " Section ",
        //                 style: Theme.of(context).textTheme.labelMedium!.merge(
        //                       const TextStyle(
        //                           //backgroundColor: Color(0xFFDFFBFE),
        //                           fontSize: 20.0,
        //                           color: Color(0xFF47BA9E)),
        //                     ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         border: const OutlineInputBorder(),
        //       ),
        //       icon: const Padding(
        //         padding: EdgeInsets.only(top: 4.5),
        //         child: Icon(
        //           Icons.keyboard_arrow_down_outlined,
        //           size: 30,
        //         ),
        //       ),
        //       items: hwCwController.sections
        //           .map((e) => DropdownMenuItem<HwCwSectionListModelValue>(
        //               value: e,
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 8, left: 5),
        //                 child: Text("${e.asmCSectionName}"),
        //               )))
        //           .toList(),
        //       onChanged: (e) {
        //         hwCwController.updateSelectedSection(e!);
        //         loadAgain();
        //       }),
        // ),
        Obx(() {
          return hwCwController.isErrorOccuredLoadingSection.value
              ? ErrWidget(err: {
                  "errorTitle": "An Unexpected Error Occurred",
                  "errorMsg": hwCwController.errorStatus.value
                })
              : hwCwController.isSubjectLoading.value
                  ? Center(
                      child: AnimatedProgressWidget(
                        title: "Loading Available Subject's",
                        desc: hwCwController.loadingStatus.value,
                        animationPath: "assets/json/hwanim.json",
                      ),
                    )
                  : hwCwController.subjects.isEmpty
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "No Subject's Available",
                            desc:
                                "Sorry but there are no subject available, try changing values",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : HwCwSujectDD(
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
    List<Map<String, dynamic>> map = [];
    for (var element in hwCwController.selectedSection) {
      map.add({
        "ASMS_Id": element.asmSId,
      });
    }

    await HwCwGetSubjectsApi.instance.getSubjects(
      miId: loginSuccessModel.mIID!,
      hrmeId: loginSuccessModel.empcode!,
      asmayId: hwCwController.selectedSession.value.asmaYId!,
      asmclId: hwCwController.selectedClass.value.asmcLId!,
      sections: map,
      ivrmrtId: loginSuccessModel.roleId!,
      loginId: loginSuccessModel.userId!,
      base: baseUrlFromInsCode("portal", mskoolController),
      hwCwController: hwCwController,
    );
  }
}
