import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/coe/api/staff_coe_api.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

import '../controller/coe_data_handler.dart';

class CoeSelectors extends StatelessWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const CoeSelectors({
    Key? key,
    required this.coeDataHandler,
    required this.mskoolController,
    required this.loginSuccessModel,
  }) : super(key: key);

  final CoeDataHandler coeDataHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: DropdownButtonFormField<ViewNoticeSessionModelValues>(
            value: coeDataHandler.sessions.first,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16.0),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                decoration: BoxDecoration(
                    color: const Color(0xFFDFFBFE),
                    borderRadius: BorderRadius.circular(24.0)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/cap.png",
                      height: 28.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "Academic Year",
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                          const TextStyle(
                              fontSize: 20, color: Color(0xFF28B6C8))),
                    ),
                  ],
                ),
              ),
            ),
            icon: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
              ),
            ),
            iconSize: 30,
            items: List.generate(
              coeDataHandler.sessions.length,
              (index) => DropdownMenuItem<ViewNoticeSessionModelValues>(
                value: coeDataHandler.sessions.elementAt(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                  child: Text(
                    coeDataHandler.sessions.elementAt(index).asmaYYear!,
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            letterSpacing: 0.3)),
                  ),
                ),
              ),
            ),
            onChanged: (s) async {
              // selectedValue = s;
              // asmayId.value = s!.asmaYId!;
              // setState(() {});
              // handler.updateSelectedInDropDown(s!);
              // handler.asmayId.value = s.asmaYId!;
              // logger.d(s.asmaYId);
              // reloadEvent();

              coeDataHandler.updateSelectedAcademicYear(s!);
              await loadOnChange();
            },
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(
          child: DropdownButtonFormField<Map<String, dynamic>>(
            value: fullMonthsWithIndex.elementAt(DateTime.now().month - 1),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16.0),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEA),
                    borderRadius: BorderRadius.circular(24.0)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/calendar.png",
                      color: const Color(0xFFFF6F67),
                      height: 22.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "Select Month",
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                          const TextStyle(
                              fontSize: 20, color: Color(0xFFFF6F67))),
                    ),
                  ],
                ),
              ),
            ),
            icon: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
              ),
            ),
            iconSize: 30,
            items: List.generate(
              fullMonths.length,
              (index) => DropdownMenuItem<Map<String, dynamic>>(
                value: fullMonthsWithIndex.elementAt(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                  child: Text(
                    fullMonths.elementAt(index),
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            letterSpacing: 0.3)),
                  ),
                ),
              ),
            ),
            onChanged: (s) async {
              // selectedValue = s;
              // asmayId.value = s!.asmaYId!;
              // setState(() {});
              // handler.updateSelectedInDropDown(s!);
              // handler.asmayId.value = s.asmaYId!;
              // logger.d(s.asmaYId);
              // reloadEvent();
              coeDataHandler.updateSelectedMonth(s!['day']);
              await loadOnChange();
            },
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        // ListView.separated(itemBuilder: (_,index){return CoeItem(values: values, color: color)}, separatorBuilder: (_,index){
        //   return SizedBox(height: 16.0,);
        // }, itemCount: 5)
      ],
    );
  }

  Future<void> loadOnChange() async {
    await StaffCoeApi.instance.getCoeList(
      miId: loginSuccessModel.mIID!,
      asmayId: coeDataHandler.selectedAcademicYear.value.asmaYId!,
      base: baseUrlFromInsCode("coe", mskoolController),
      month: coeDataHandler.selectedMonth.value,
      asmclId: loginSuccessModel.asmcLId!,
      coeDataHandler: coeDataHandler,
    );
  }
}
