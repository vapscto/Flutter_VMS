import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/api/view_notice_circular.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class AcademicYearDD extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ViewNoticeDataController dataController;
  final String message;
  const AcademicYearDD({
    Key? key,
    required this.dataController,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomContainer(
        child: DropdownButtonFormField<ViewNoticeSessionModelValues>(
            value: dataController.circularSession.first,
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
                  color: const Color(0xFFDFFBFE),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/cap.png",
                      height: 24.0,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      " Academic Year ",
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                            const TextStyle(
                                backgroundColor: Color(0xFFDFFBFE),
                                fontSize: 20.0,
                                color: Color(0xFF28B6C8)),
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
            items: dataController.circularSession
                .map((e) => DropdownMenuItem<ViewNoticeSessionModelValues>(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 5),
                      child: Text(e.asmaYYear!),
                    )))
                .toList(),
            onChanged: (e) async {
              dataController.updateSelectedSession(e!);
              await ViewCircularNoticeApi.instance.getCircularNotice(
                  miId: loginSuccessModel.mIID!,
                  userId: loginSuccessModel.userId!,
                  asmayId: dataController.selectedSession.value.asmaYId!,
                  flag: message,
                  base: baseUrlFromInsCode("portal", mskoolController),
                  dataController: dataController);
            }),
      ),
    );
  }
}
