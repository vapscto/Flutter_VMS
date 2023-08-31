import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/coe/api/get_coe_events.dart';
import 'package:m_skool_flutter/manager/coe/controller/manager_coe_handler.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_academic_data_model.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_month_data.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ManagerCoeSelector extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ManagerCoeHandler coeDataHandler;
  const ManagerCoeSelector(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.coeDataHandler});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: DropdownButtonFormField<CoeAcademicDataModelValues>(
            value: coeDataHandler.academic.first,
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
              coeDataHandler.academic.length,
              (index) => DropdownMenuItem<CoeAcademicDataModelValues>(
                value: coeDataHandler.academic.elementAt(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                  child: Text(
                    coeDataHandler.academic.elementAt(index).hrmlYLeaveYear!,
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
              loadOnChange();
            },
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(
          child: DropdownButtonFormField<CoeMonthDataModelValues>(
            value: coeDataHandler.selectedMonth.value,
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
              coeDataHandler.months.length,
              (index) => DropdownMenuItem<CoeMonthDataModelValues>(
                value: coeDataHandler.months.elementAt(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                  child: Text(
                    coeDataHandler.months.elementAt(index).monthname!,
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
              coeDataHandler.updateSelectedMonth(s!);
              loadOnMonthChange();
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

  Future<void> loadOnMonthChange() async {
    await GetCoeEventsForManagerApi.instance.getEvents(
      base: baseUrlFromInsCode("coe", mskoolController),
      miId: loginSuccessModel.mIID!,
      month: coeDataHandler.selectedMonth.value.monthid.toString(),
      asmayId: coeDataHandler.selectedYear.value.hrmlYId!,
      type: 1,
      asmsclId: "0",
      handler: coeDataHandler,
    );
  }

  Future<void> loadOnChange() async {
    // await CoeGetAcademicAndMonthApi.instance.getAcademics(
    //   base: baseUrlFromInsCode("coe", mskoolController),
    //   handler: coeDataHandler,
    //   miId: loginSuccessModel.mIID!,
    // );
    // if (coeDataHandler.isErrorOccuredWhileLoadingAcademic.value &&
    //     (coeDataHandler.academic.isEmpty || coeDataHandler.months.isEmpty)) {
    //   return;
    // }

    await GetCoeEventsForManagerApi.instance.getEvents(
      base: baseUrlFromInsCode("coe", mskoolController),
      miId: loginSuccessModel.mIID!,
      month: coeDataHandler.selectedMonth.value.monthid.toString(),
      asmayId: coeDataHandler.selectedYear.value.hrmlYId!,
      type: loginSuccessModel.roleforlogin!.toLowerCase() == "staff"
          ? 1
          : loginSuccessModel.roleforlogin!.toLowerCase() == "student"
              ? 2
              : 3,
      asmsclId: loginSuccessModel.asmcLId != null
          ? "${loginSuccessModel.asmcLId}"
          : "0",
      handler: coeDataHandler,
    );
  }
}
