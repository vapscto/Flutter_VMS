import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/api/staff_daily_tt.dart';
import 'package:m_skool_flutter/staffs/staff_tt/controller/staff_tt_controller.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/daily_tt_days_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/pdf/daily_pdf_generator.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class StaffDailyTT extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final StaffTTController ttController;
  final String? day;
  const StaffDailyTT({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.ttController,
    this.day,
  });

  @override
  State<StaffDailyTT> createState() => _StaffDailyTTState();
}

class _StaffDailyTTState extends State<StaffDailyTT> {
  @override
  void initState() {
    // if (widget.day != null) {
    //   widget.ttController.updateSelectedDayForDailyTT(
    //       widget.ttController.dailyTTDays.firstWhere(
    //     (element) => element.ttmDDayName == widget.day,
    //   ));
    // }
    loadApis();
    super.initState();
  }

  loadApis() async {
    await StaffDailyTTApi.instance.getDays(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        controller: widget.ttController,
        day: widget.day);

    await StaffDailyTTApi.instance.getDailyTT(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        controller: widget.ttController,
        ttMiID: widget.ttController.selectedDayForDailyTT.value.ttmDId!);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      logger.d("Loading again");
      return widget.ttController.isErrorOccuredWhileLoadingPage.value
          ? Center(
              child: ErrWidget(err: {
                "errorTitle": "Unexpected Error Occured",
                "errorMsg": widget.ttController.errorOccuredAt.value
              }),
            )
          : Obx(() {
              return widget.ttController.isWholePageLoading.value
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "Loading Daily Timetable",
                        desc: "Please wait. while we load the data for you.",
                        animationPath: "assets/json/default.json",
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 32.0,
                          ),
                          CustomContainer(
                            child:
                                DropdownButtonFormField<DailyTTDaysModelValues>(
                              value: widget
                                  .ttController.selectedDayForDailyTT.value,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFEBEA),
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
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
                                        "Select Day",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFFFF6F67))),
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
                                widget.ttController.dailyTTDays.length,
                                (index) =>
                                    DropdownMenuItem<DailyTTDaysModelValues>(
                                  value: widget.ttController.dailyTTDays
                                      .elementAt(index),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 8, right: 8),
                                    child: Text(
                                      "${widget.ttController.dailyTTDays.elementAt(index).ttmDDayName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
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

                                widget.ttController
                                    .updateSelectedDayForDailyTT(s!);
                                await StaffDailyTTApi.instance.getDailyTT(
                                    miId: widget.loginSuccessModel.mIID!,
                                    asmayId: widget.loginSuccessModel.asmaYId!,
                                    userId: widget.loginSuccessModel.userId!,
                                    base: baseUrlFromInsCode(
                                        "portal", widget.mskoolController),
                                    controller: widget.ttController,
                                    ttMiID: widget.ttController
                                        .selectedDayForDailyTT.value.ttmDId!);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Obx(() {
                            return widget.ttController.isErrorOccuredAtLoadingTT
                                    .value
                                ? ErrWidget(
                                    err: {
                                      "errorTitle":
                                          "An Unexpected Error Occured",
                                      "errorMsg": widget
                                          .ttController.errorOccuredAt.value
                                    },
                                  )
                                : widget.ttController.isTTLoading.value
                                    ? AnimatedProgressWidget(
                                        title:
                                            "Loading ${widget.ttController.selectedDayForDailyTT.value.ttmDDayName} Timetable",
                                        desc:
                                            "Don't Worry, your classes wont't miss, We will provide you timetable",
                                        animationPath:
                                            "assets/json/default.json",
                                      )
                                    : widget.ttController.dailyTT.isEmpty
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.1,
                                              ),
                                              AnimatedProgressWidget(
                                                title: "No Timetable Found",
                                                desc:
                                                    "We couldn't find any timetable for ${widget.ttController.selectedDayForDailyTT.value.ttmDDayName}",
                                                animationPath:
                                                    "assets/json/nodata.json",
                                                animatorHeight: 250,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (_, index) {
                                                    return Material(
                                                      child: ListTile(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0)),
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        tileColor:
                                                            timetablePeriodColor
                                                                .elementAt(
                                                                    index)
                                                                .withOpacity(
                                                                    0.15),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 16.0),
                                                          child: Text(
                                                            "Class : ${widget.ttController.dailyTT.elementAt(index).asmcLClassName} | Time : ${widget.ttController.dailyTT.elementAt(index).ttmdpTStartTime} | Subject : ${widget.ttController.dailyTT.elementAt(index).ismSSubjectName}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .merge(const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    height:
                                                                        1.5)),
                                                          ),
                                                        ),
                                                        leading: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            color:
                                                                timetablePeriodColor
                                                                    .elementAt(
                                                                        index),
                                                          ),
                                                          child: Text(
                                                            "P${widget.ttController.dailyTT.elementAt(index).period}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .merge(
                                                                  const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder: (_, index) {
                                                    return const SizedBox(
                                                      height: 6.0,
                                                    );
                                                  },
                                                  itemCount: widget.ttController
                                                      .dailyTT.length),
                                              const SizedBox(
                                                height: 48.0,
                                              ),
                                              MSkollBtn(
                                                  title: "Generate Pdf",
                                                  onPress: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: const [
                                                              AnimatedProgressWidget(
                                                                  title:
                                                                      "Generating Pdf",
                                                                  desc:
                                                                      "Please wait while we generate pdf for you",
                                                                  animationPath:
                                                                      "assets/json/default.json")
                                                            ],
                                                          );
                                                        });
                                                    await TTPdfGenerator
                                                        .instance
                                                        .generateDailyTT(widget
                                                            .ttController
                                                            .dailyTT);

                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          );
                          }),
                        ],
                      ),
                    );
            });
    });
  }
}
