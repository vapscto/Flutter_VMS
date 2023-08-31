import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/attendance_shortage_api.dart';
import 'package:m_skool_flutter/apis/fee_reminder_api.dart';
import 'package:m_skool_flutter/controller/dashboard_controller.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/notice/screen/notice_home.dart';
import 'package:m_skool_flutter/screens/home_page_drawer.dart';
import 'package:m_skool_flutter/screens/notification.dart';
import 'package:m_skool_flutter/student/attendance/screens/home_page.dart';
import 'package:m_skool_flutter/student/certificates/screens/cert_home.dart';
import 'package:m_skool_flutter/student/classwork/screen/classwork_home_screen.dart';
import 'package:m_skool_flutter/student/coe/screen/coe_home.dart';
import 'package:m_skool_flutter/student/exam/screen/exam_home.dart';
import 'package:m_skool_flutter/student/fees/screens/fee_analysis_screen.dart';
import 'package:m_skool_flutter/student/fees/screens/fee_receipt_home.dart';
import 'package:m_skool_flutter/student/fees/screens/online_payment_screen.dart';
import 'package:m_skool_flutter/student/fees/tabs/pay_online_tab.dart';
import 'package:m_skool_flutter/student/homework/screen/home_work_screen.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/student/interaction/screen/interaction_home.dart';
import 'package:m_skool_flutter/student/library/screen/library_home.dart';
import 'package:m_skool_flutter/student/timetable/screens/time_table_home.dart';
import 'package:m_skool_flutter/tabs/profile_tab.dart';
import 'package:m_skool_flutter/widget/card_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/dashbaord_fee_widget.dart';
import 'package:m_skool_flutter/widget/dashboard_attendance.dart';
import 'package:m_skool_flutter/widget/dashboard_timetable_widget.dart';
import 'package:m_skool_flutter/widget/home_screen_carasouel.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const Home(
      {Key? key,
      required this.loginSuccessModel,
      required this.mskoolController})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RxInt pageNumber = 0.obs;
  RxString keyWord = "".obs;
  //TextEditingController textEditingController = TextEditingController();
  DashboardController dashboardController = Get.put(DashboardController());
  ScrollController scrollController = ScrollController();
  RxList<LoginValues> values = RxList<LoginValues>();
  final HwCwNbController hwCwNbController = Get.put(HwCwNbController());

  RxList<Map<String, dynamic>> homeViewPage = RxList<Map<String, dynamic>>();
  final PageController pageController = PageController();
  @override
  void initState() {
    version(widget.loginSuccessModel, widget.mskoolController);

    dashboardController.studentDashBoardDetails(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        amstId: widget.loginSuccessModel.amsTId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        asmcLId: widget.loginSuccessModel.asmcLId!,
        asmSId: widget.loginSuccessModel.asmSId!);
    FeeReminderApi.instance.showFeeReminder(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      asmclId: widget.loginSuccessModel.asmcLId!,
      asmsId: widget.loginSuccessModel.asmSId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      context: context,
      loginSuccessModel: widget.loginSuccessModel,
      mskoolController: widget.mskoolController,
    );
    AttendanceShortageApi.instance.getShortage(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        amstId: widget.loginSuccessModel.amsTId!,
        percentage: 0,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        context: context);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    scrollController.dispose();
    //textEditingController.dispose();
    Get.delete<HwCwNbController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      homeViewPage.clear();
      homeViewPage.add({
        "title": const Text("Dashboard"),
        "color": const Color(0xFF9900F0),
        "navTitle": const Text(
          "Home",
        ),
        "page": HomeTab(
          loginSuccessModel: widget.loginSuccessModel,
          mskoolController: widget.mskoolController,
          hwCwNbController: hwCwNbController,
        ),
        "icon": Image.asset(
          'assets/images/floatingicon.png',
          height: 30,
          color:
              (pageNumber.value == 0) ? const Color(0xFF9900F0) : Colors.grey,
        ),
      });
      homeViewPage.add({
        "title": const Text("Interaction"),
        "color": const Color(0xFFFF008C),
        "navTitle": const Text(
          "Interaction",
        ),
        "page": InteractionHomeScreen(
          loginSuccessModel: widget.loginSuccessModel,
          mskoolController: widget.mskoolController,
          showAppBar: false,
        ),
        "icon": Image.asset(
          'assets/images/tabinteraction.png',
          height: 30,
          color:
              (pageNumber.value == 1) ? const Color(0xFFFF008C) : Colors.grey,
        ),
      });
      homeViewPage.add({
        "title": const Text("Pay Online"),
        "color": const Color(0xFFFFA901),
        "navTitle": const Text(
          "Pay Online",
        ),
        "page": PayOnlineTab(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController),
        //  CoeHome(
        //   loginSuccessModel: widget.loginSuccessModel,
        //   mskoolController: widget.mskoolController,
        //   pageController: pageController,
        //   showAppBar: false,
        // ),
        "icon": Image.asset(
          'assets/images/payonlinetabicon.png',
          height: 30,
          color:
              (pageNumber.value == 2) ? const Color(0xFFFFA901) : Colors.grey,
        ),
      });
      homeViewPage.add({
        "title": const Text("Profile"),
        "color": const Color(0xFF3D9292),
        "navTitle": const Text(
          "Profile",
        ),
        "page": ProfileTab(
          loginSuccessModel: widget.loginSuccessModel,
          mskoolController: widget.mskoolController,
          pageController: pageController,
        ),
        "icon": Image.asset(
          'assets/images/tabprofile.png',
          height: 30,
          color:
              (pageNumber.value == 3) ? const Color(0xFF3D9292) : Colors.grey,
        ),
      });
      return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/svg/menu.svg'),
            onPressed: () {
              _scaffold.currentState!.openDrawer();
            },
          ),
          title: homeViewPage.elementAt(pageNumber.value)["title"]!,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return NotificationScreen(
                        // appBarTitle: "Notice",
                        loginSuccessModel: widget.loginSuccessModel,
                        mskoolController: widget.mskoolController,
                        openFor: 'student', hwCwNbController: hwCwNbController,
                      );
                      // hwCwNbController: hwCwNbController);
                    },
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/svg/bell.svg',
              ),
            ),
            const SizedBox(
              width: 6.0,
            ),
          ],
        ),
        drawer: HomePageDrawer(
          loginSuccessModel: widget.loginSuccessModel,
          hwCwNbController: hwCwNbController,
          mskoolController: widget.mskoolController,
        ),
        body: PageView.builder(
          controller: pageController,
          itemBuilder: (_, index) {
            logger.d(homeViewPage.length);
            return homeViewPage.elementAt(index)["page"]!;
          },
          itemCount: homeViewPage.length,
          onPageChanged: (e) {
            pageNumber.value = e;
          },
        ),
        bottomNavigationBar: Obx(() {
          return SalomonBottomBar(
            selectedColorOpacity: 0.2,
            unselectedItemColor: Colors.grey,
            // selectedItemColor: Colors.white,
            // itemShape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            currentIndex: pageNumber.value,
            onTap: (i) {
              pageController.animateToPage(i,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn);
              pageNumber.value = i;
            },
            items: [
              ...List.generate(homeViewPage.length, (index) {
                return SalomonBottomBarItem(
                    icon: homeViewPage.elementAt(index)["icon"]!,
                    title: homeViewPage.elementAt(index)["navTitle"]!,
                    selectedColor: homeViewPage.elementAt(index)["color"]!);
              })
            ],
          );
        }),
      );
    });
  }
}

class HomeTab extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController hwCwNbController;

  const HomeTab({
    Key? key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.hwCwNbController,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DashboardController dashboardController = Get.find<DashboardController>();
  final ValueNotifier<int> carouselNotifier = ValueNotifier<int>(0);
  List<String> icons = [
    // "attendance",
    "compose",
    "exam_icon",
    "fee",
    "information",
    // "library",
    // "timetable"
  ];

  //ExamListValues? selectedOption;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await dashboardController.studentDashBoardDetails(
            miId: widget.loginSuccessModel.mIID!,
            asmayId: widget.loginSuccessModel.asmaYId!,
            amstId: widget.loginSuccessModel.amsTId!,
            base: baseUrlFromInsCode("portal", widget.mskoolController),
            asmcLId: widget.loginSuccessModel.asmcLId!,
            asmSId: widget.loginSuccessModel.asmSId!);
      },
      child: Obx(() {
        //logger.d("Reload in thr");
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DashboardProfile(loginSuccessModel: widget.loginSuccessModel),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        logger.d("Reload in CalList & Bday");
                        return dashboardController.calList.isNotEmpty ||
                                dashboardController.birthday.isNotEmpty
                            ? HomePageCarasouel(
                                // coeList: dashboardController.calList.value,
                                coeList: const [],
                                bdayList: dashboardController.birthday.value,
                                loginSuccessModel: widget.loginSuccessModel,
                                mskoolController: widget.mskoolController,
                              )
                            : const SizedBox();
                      }),

                      const SizedBox(
                        height: 20.0,
                      ),
                      // const DashBoardExamChart(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (dashboardController.attendance.isNotEmpty)
                              ? Expanded(
                                  flex: 1,
                                  child: CardWidget(
                                    padding: const EdgeInsets.all(0),
                                    children: [
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       "Attendance",
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .titleSmall!
                                      //           .copyWith(
                                      //             fontWeight: FontWeight.w600,
                                      //           ),
                                      //     ),
                                      //     InkWell(
                                      //       onTap: () {
                                      //         Get.to(() => AttendanceHomeScreen(
                                      //             loginSuccessModel:
                                      //                 widget.loginSuccessModel,
                                      //             mskoolController:
                                      //                 widget.mskoolController));
                                      //       },
                                      //       child: Text(
                                      //         "Know more",
                                      //         style: Theme.of(context)
                                      //             .textTheme
                                      //             .labelMedium!
                                      //             .copyWith(
                                      //                 decoration: TextDecoration
                                      //                     .underline,
                                      //                 fontSize: 14),
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),

                                      SizedBox(
                                        height: 36,
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => AttendanceHomeScreen(
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Attendance",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                const Icon(Icons
                                                    .chevron_right_rounded),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // trailing
                                      ),
                                      SizedBox(
                                        height: Get.width * 0.4329,
                                        child: DashBoardAttendance(
                                          attendanceValue: dashboardController
                                                  .attendance
                                                  .first
                                                  .values!
                                                  .first
                                                  .score ??
                                              0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            width: 12.0,
                          ),
                          (dashboardController.feeList.isNotEmpty)
                              ? Expanded(
                                  flex: 1,
                                  child: DashboardFeeGraph(
                                    feeDet: dashboardController
                                        .feeList.first.values!,
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      (dashboardController.timeTableList.isNotEmpty)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: DashboardTimetable(
                                timeTableList: dashboardController
                                    .timeTableList.first.values!,
                                loginSuccessModel: widget.loginSuccessModel,
                                mskoolController: widget.mskoolController,
                              ),
                            )
                          : Container(),
                      // const SizedBox(
                      //   height: 6.0,
                      // ),
                      (dashboardController.examList.isNotEmpty)
                          ? CustomContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ExamHome(
                                          loginSuccessModel:
                                              widget.loginSuccessModel,
                                          mskoolController:
                                              widget.mskoolController));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Exam",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          const Icon(
                                              Icons.chevron_right_rounded),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Transform.translate(
                                  //   offset: const Offset(0, -4.0),
                                  //   child: Obx(() {
                                  //     return dashboardController
                                  //             .examList.first.values!.isEmpty
                                  //         ? const SizedBox()
                                  //         : Padding(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     horizontal: 8.0),
                                  //             child: DropdownButton<
                                  //                 ExamListNewValues>(
                                  //               value: dashboardController
                                  //                   .selectedOption.value,
                                  //               isDense: true,
                                  //               underline: const SizedBox(),
                                  //               isExpanded: false,
                                  //               icon: Icon(
                                  //                 Icons.keyboard_arrow_down,
                                  //                 color: Theme.of(context)
                                  //                     .textTheme
                                  //                     .titleMedium!
                                  //                     .color,
                                  //               ),
                                  //               style: const TextStyle(
                                  //                   fontSize: 14.0,
                                  //                   color: Colors.black),
                                  //               items: List.generate(
                                  //                   dashboardController.examList
                                  //                       .first.values!.length,
                                  //                   (index) => DropdownMenuItem(
                                  //                       value:
                                  //                           dashboardController
                                  //                               .examList
                                  //                               .first
                                  //                               .values!
                                  //                               .elementAt(
                                  //                                   index),
                                  //                       child: Text(
                                  //                           dashboardController
                                  //                                   .examList
                                  //                                   .first
                                  //                                   .values!
                                  //                                   .elementAt(
                                  //                                       index)
                                  //                                   .eMEExamName ??
                                  //                               "N/a"))),
                                  //               onChanged: (value) async {
                                  //                 dashboardController
                                  //                     .selectedOption
                                  //                     .value = value!;
                                  //                 await DashboardExamApi.instance.loadExamData(
                                  //                     miId: widget
                                  //                         .loginSuccessModel
                                  //                         .mIID!,
                                  //                     asmayId: widget
                                  //                         .loginSuccessModel
                                  //                         .asmaYId!,
                                  //                     asmclId: widget
                                  //                         .loginSuccessModel
                                  //                         .asmcLId!,
                                  //                     asmsId: widget
                                  //                         .loginSuccessModel
                                  //                         .asmSId!,
                                  //                     amstId: widget
                                  //                         .loginSuccessModel
                                  //                         .amsTId!,
                                  //                     emeId: dashboardController
                                  //                         .selectedOption
                                  //                         .value
                                  //                         .eMEId!,
                                  //                     base: baseUrlFromInsCode(
                                  //                         "portal",
                                  //                         widget
                                  //                             .mskoolController),
                                  //                     dashboardController:
                                  //                         dashboardController);
                                  //               },
                                  //             ),
                                  //           );
                                  //   }),
                                  // ),
                                  // const SizedBox(
                                  //   height: 12.0,
                                  // ),
                                  // Obx(() {
                                  //   //logger.d("Updating here");
                                  //   return DashboardLineChart(
                                  //     selectedExam: dashboardController
                                  //         .selectedOption.value,
                                  //     loginSuccessModel:
                                  //         widget.loginSuccessModel,
                                  //     mskoolController: widget.mskoolController,
                                  //     dashboardController: dashboardController,
                                  //   );
                                  // }),
                                  // const SizedBox(
                                  //   height: 12.0,
                                  // ),
                                ],
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Dashboard",
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              const TextStyle(fontSize: 20.0),
                            ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: GridView.count(
                          // alignment: WrapAlignment.spaceBetween,
                          // spacing: 3,
                          // crossAxisAlignment: WrapCrossAlignment.center,
                          // mainAxisSpacing: 10,
                          childAspectRatio: 0.9,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          children: List.generate(
                              widget.loginSuccessModel.staffmobileappprivileges!
                                  .values!.length,
                              (i) => InkWell(
                                    onTap: () {
                                      switch (widget
                                          .loginSuccessModel
                                          .staffmobileappprivileges!
                                          .values![i]
                                          .pagename) {
                                        case "Attendance":
                                          Get.to(() => AttendanceHomeScreen(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController));
                                          break;
                                        case "Fee Details":
                                          // Get.to(() => FeeHomeScreen(
                                          //     loginSuccessModel:
                                          //         widget.loginSuccessModel,
                                          //     mskoolController:
                                          //         widget.mskoolController));
                                          break;
                                        case "Fee Payment":
                                          Get.to(
                                            () => OnlinePaymentScreen(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                              title:
                                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}",
                                            ),
                                          );
                                          break;
                                        case "Fee Analysis":
                                          Get.to(
                                            () => FeeAnalysisScreen(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                              title:
                                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}",
                                            ),
                                          );
                                          break;
                                        case "Classwork":
                                          Get.to(() => ClassWorkHomeScreen(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                              // hwCwNbController:
                                              //     widget.hwCwNbController,
                                              title:
                                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}"));
                                          break;
                                        case "Homework":
                                          Get.to(
                                            () => HomeWorkScreen(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                              // hwCwNbController:
                                              //     widget.hwCwNbController,
                                              title:
                                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}",
                                            ),
                                          );
                                          break;
                                        case "COE":
                                          Get.to(() => CoeHome(
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                                // hwCwNbController:
                                                //     widget.hwCwNbController,
                                                // title:
                                                //     "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}"
                                              ));
                                          break;
                                        case "Notice Board":
                                          Get.to(
                                            () => NoticeHome(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                              hwCwNbController:
                                                  widget.hwCwNbController,
                                              appBarTitle:
                                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}",
                                            ),
                                          );
                                          break;
                                        case "Library":
                                          String base = baseUrlFromInsCode(
                                              "portal",
                                              widget.mskoolController);
                                          Get.to(
                                            () => LibraryHome(
                                              miId: widget
                                                  .loginSuccessModel.mIID!,
                                              asmayId: widget
                                                  .loginSuccessModel.asmaYId!,
                                              asmtId: widget
                                                  .loginSuccessModel.amsTId!,
                                              base: base,
                                              title:
                                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}",
                                            ),
                                          );
                                          break;
                                        case "Syllabus":
                                          break;
                                        case "Exam":
                                          Get.to(() => ExamHome(
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                              ));
                                          break;
                                        case "Interaction":
                                          Get.to(() => InteractionHomeScreen(
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                              ));
                                          break;
                                        case "Certificate":
                                          Get.to(() => CertificateHomeScreen(
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                              ));
                                          break;
                                        case "Time Table":
                                          Get.to(() => TimeTableHome(
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                              ));
                                          break;
                                        case "Fee Receipt":
                                          Get.to(
                                            () => FeeReceiptHome(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                              title:
                                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}",
                                            ),
                                          );
                                          break;
                                        default:
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SizedBox(
                                        width: 80,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                getDashBoardIconByName(
                                                    "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}"),
                                                height: 60,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${widget.loginSuccessModel.staffmobileappprivileges!.values![i].pagename}",
                                                //maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(const TextStyle(
                                                        fontSize: 13.0)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class BtmNavItem extends StatelessWidget {
  final bool selected;
  final String title;
  final String img;
  final Function() func;
  const BtmNavItem({
    Key? key,
    required this.selected,
    required this.title,
    required this.img,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Column(
        children: [
          SvgPicture.asset(
            img,
            color: selected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade700,
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(title),
        ],
      ),
      onPressed: func,
    );
  }
}
