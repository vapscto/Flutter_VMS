import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/hw_cw_subject_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_topic_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_sub_list_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/widget/verify_topic_dd.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class VerifySubjectDD extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccesModel;
  final HwCwController verifyController;
  final bool forHw;
  const VerifySubjectDD(
      {super.key,
      required this.mskoolController,
      required this.loginSuccesModel,
      required this.verifyController,
      required this.forHw});

  @override
  State<VerifySubjectDD> createState() => _VerifySubjectDDState();
}

class _VerifySubjectDDState extends State<VerifySubjectDD> {
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  DateTime startDT = DateTime.now();
  DateTime endDT = DateTime.now();
  @override
  Widget build(BuildContext context) {
    logger.d(widget.verifyController.cwSubjectList.length);
    return Column(
      children: [
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(
          child: DropdownButtonFormField(
              value: widget.forHw
                  ? widget.verifyController.selectedSubject.value
                  : widget.verifyController.selectedCwSub.value,
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
                    color: const Color(0xFFF0EBFF),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/HINDI.png",
                        height: 24.0,
                        color: const Color(0xFF7757D9),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Subject ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                color: Color(0xFF7757D9),
                                fontSize: 20.0,
                              ),
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
              items: !widget.forHw
                  ? widget.verifyController.cwSubjectList
                      .map((e) =>
                          DropdownMenuItem<VerifyCwSubjectListModelValues>(
                              value: e,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8, left: 5),
                                child: Text(e.iSMSSubjectName ?? "N/a"),
                              )))
                      .toList()
                  : widget.verifyController.subjects
                      .map((e) => DropdownMenuItem<HwCwSubjectListModelValues>(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, left: 5),
                            child: Text(e.ismSSubjectName ?? "N/a"),
                          )))
                      .toList(),
              onChanged: (e) async {
                if (widget.forHw) {
                  widget.verifyController
                      .updateSelectedSubject(e as HwCwSubjectListModelValues);
                  await loadAgain();
                  return;
                }
                widget.verifyController.updateSelectedCwSubject(
                    e as VerifyCwSubjectListModelValues);
                await loadAgain();
              }),
        ),
        const SizedBox(
          height: 32.0,
        ),
        VerifyTopicDD(
          forHw: widget.forHw,
          loginSuccesModel: widget.loginSuccesModel,
          mskoolController: widget.mskoolController,
          verifyController: widget.verifyController,
        ),
      ],
    );
  }

  Future<void> loadAgain() async {
    if (widget.verifyController.isErrorOccuredLoadingSection.value ||
        (widget.verifyController.cwSubjectList.isEmpty &&
            widget.verifyController.subjects.isEmpty)) {
      return;
    }

    if (widget.forHw) {
      await GetVerifyTopicApi.instance.getTopicForHw(
          asmayId: widget.verifyController.selectedSession.value.asmaYId!,
          asmclId: widget.verifyController.selectedClass.value.asmcLId!,
          miId: widget.loginSuccesModel.mIID!,
          asmsId: widget.verifyController.verifySelectedSection.value.asmSId!,
          ismsId: widget.verifyController.selectedSubject.value.ismSId!,
          loginId: widget.loginSuccesModel.userId!,
          controller: widget.verifyController,
          base: baseUrlFromInsCode(
            "portal",
            widget.mskoolController,
          ));
      // return;
    } else {
      await GetVerifyTopicApi.instance.getTopicForCw(
          asmayId: widget.verifyController.selectedSession.value.asmaYId!,
          asmclId: widget.verifyController.selectedClass.value.asmcLId!,
          miId: widget.loginSuccesModel.mIID!,
          asmsId: widget.verifyController.verifySelectedSection.value.asmSId!,
          ismsId: widget.verifyController.selectedCwSub.value.iSMSId!,
          loginId: widget.loginSuccesModel.userId!,
          controller: widget.verifyController,
          base: baseUrlFromInsCode(
            "portal",
            widget.mskoolController,
          ));
    }
  }
}
