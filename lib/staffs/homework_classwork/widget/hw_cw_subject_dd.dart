import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/assignment_details.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class HwCwSujectDD extends StatelessWidget {
  final HwCwController hwCwController;
  final bool forHw;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const HwCwSujectDD(
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
        CustomContainer(
          child: DropdownButtonFormField(
              value: hwCwController.selectedSubject.value,
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
              items: hwCwController.subjects
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 5),
                        child: Text(e.ismSSubjectName ?? "N/a"),
                      )))
                  .toList(),
              onChanged: (e) {
                hwCwController.updateSelectedSubject(e!);
              }),
        ),
        AssignmentDetails(
          hwCwController: hwCwController,
          forHw: forHw,
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        )
      ],
    );
  }
}
