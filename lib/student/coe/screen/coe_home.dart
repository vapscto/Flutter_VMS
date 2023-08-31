import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/coe/apis/get_academic_year_api.dart';
import 'package:m_skool_flutter/student/coe/apis/get_event_api.dart';
import 'package:m_skool_flutter/student/coe/controller/coe_data_handler.dart';
import 'package:m_skool_flutter/student/coe/models/academic_year_model.dart';
import 'package:m_skool_flutter/student/coe/widget/coe_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class CoeHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final bool showAppBar;
  final MskoolController mskoolController;
  final PageController? pageController;
  const CoeHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      this.pageController,
      this.showAppBar = true});

  @override
  State<CoeHome> createState() => _CoeHomeState();
}

class _CoeHomeState extends State<CoeHome> {
  Map<String, dynamic> selectedMonth =
      fullMonthsWithIndex[DateTime.now().month - 1];
  RxInt month = RxInt(DateTime.now().month);
  RxInt asmayId = RxInt(0);

  AttyearlistValues? selectedValue;
  //final DateTime selected = DateTime.now();
  final CoeDataHandler handler = Get.put(CoeDataHandler());

  int color = -1;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    await GetAcademicYearApi.instance.getAcademicYear(
      miId: widget.loginSuccessModel.mIID!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      handler: handler,
    );
    await GetEventsApi.instance.getCoeData(
      miId: widget.loginSuccessModel.mIID!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      month: month.value,
      asmayId: handler.asmayId.value,
      asmclID: int.parse(widget.loginSuccessModel.clsnme!),
      coeDataHandler: handler,
      roleForLogin: widget.loginSuccessModel.roleforlogin!,
    );
  }

  Future<void> reloadEvent() async {
    handler.showEventLoading(true);
    await GetEventsApi.instance.getCoeData(
        miId: widget.loginSuccessModel.mIID!,
        amstId: widget.loginSuccessModel.amsTId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        month: month.value,
        asmayId: handler.asmayId.value,
        asmclID: int.parse(widget.loginSuccessModel.clsnme!),
        coeDataHandler: handler,
        roleForLogin: widget.loginSuccessModel.roleforlogin!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: (widget.showAppBar)
          ? AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.white,
                  size: 34,
                ),
                onPressed: () {
                  if (widget.pageController != null) {
                    widget.pageController!.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn);
                  } else {
                    Get.back();
                  }
                },
              ),
              leadingWidth: 30,
              title: Text("COE".tr),
            )
          : null,
      body: SafeArea(
        child: Obx(() {
          return handler.showAllLoadingProgress.value
              ? const Center(
                  child: AnimatedProgressWidget(
                      title: "Getting Academic Year and events",
                      desc:
                          "We are loading academic data and event... Please wait ",
                      animationPath: "assets/json/COE.json"),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      Obx(() {
                        return handler.academicYearList.isEmpty
                            ? const SizedBox()
                            : CustomContainer(
                                child:
                                    DropdownButtonFormField<AttyearlistValues>(
                                  value: handler.selectedInDorpDown.value,
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
                                          horizontal: 16.0, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFDFFBFE),
                                          borderRadius:
                                              BorderRadius.circular(24.0)),
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
                                            "Academic Year".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF28B6C8))),
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
                                    handler.academicYearList.length,
                                    (index) =>
                                        DropdownMenuItem<AttyearlistValues>(
                                      value: handler.academicYearList
                                          .elementAt(index),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, left: 8, right: 8),
                                        child: Text(
                                          handler.academicYearList
                                                  .elementAt(index)
                                                  .asmaYYear ??
                                              "N/a",
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
                                  onChanged: (s) {
                                    // selectedValue = s;
                                    // asmayId.value = s!.asmaYId!;
                                    // setState(() {});
                                    handler.updateSelectedInDropDown(s!);
                                    handler.asmayId.value = s.asmaYId!;
                                    logger.d(s.asmaYId);
                                    reloadEvent();
                                  },
                                ),
                              );
                      }),
                      const SizedBox(
                        height: 36.0,
                      ),
                      CustomContainer(
                        child: DropdownButtonFormField<Map<String, dynamic>>(
                          value: selectedMonth,
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
                                    "Select Month".tr,
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
                            fullMonthsWithIndex.length,
                            (index) => DropdownMenuItem<Map<String, dynamic>>(
                              value: fullMonthsWithIndex.elementAt(index),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 8, right: 8),
                                child: Text(
                                  fullMonthsWithIndex.elementAt(index)['month'],
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
                          onChanged: (s) {
                            selectedMonth = s!;
                            month.value = s['day'];
                            reloadEvent();
                            //setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Obx(() {
                        return handler.showEventLoading.value
                            ? const AnimatedProgressWidget(
                                title: "Your events are comming.",
                                desc:
                                    "All your event will appear here for a particular academic year. you can use dropdown to see different events.",
                                animationPath: "assets/json/COE.json")
                            : handler.coeReport.isEmpty
                                ? const AnimatedProgressWidget(
                                    animatorHeight: 250,
                                    title: "No event found",
                                    desc:
                                        "We coudn't find any event with selected month/academic year, you can use dropdown to see different events.",
                                    animationPath: "assets/json/nodata.json")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Result",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        reverse: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          color += 1;
                                          if (index % 6 == 0) {
                                            color = 0;
                                          }
                                          if (color > 6) {
                                            color = 0;
                                          }
                                          return CoeItem(
                                              color:
                                                  noticeColor.elementAt(color),
                                              values: handler.coeReport
                                                  .elementAt(index));
                                        },
                                        separatorBuilder: (_, index) {
                                          return const SizedBox(height: 16.0);
                                        },
                                        itemCount: handler.coeReport.length,
                                      ),
                                    ],
                                  );
                      })
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
