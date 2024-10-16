import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/attendance_shortage_api.dart';
import 'package:m_skool_flutter/apis/fee_reminder_api.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/home_page_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/tabs/dashboard.dart';
import 'package:m_skool_flutter/vms/profile_tab/screens/profile_home_screen.dart';
import 'package:m_skool_flutter/vms/punch_report/screens/punch_report_home.dart';
import 'package:m_skool_flutter/vms/task%20creation/screens/taskCreationHome.dart';
import 'package:m_skool_flutter/vms/utils/common_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CommonHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const CommonHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<CommonHomeScreen> createState() => _CommonHomeScreenState();
}

class _CommonHomeScreenState extends State<CommonHomeScreen> {
  final List<HomePageModel> homePage = [];
  final PageController pageController = PageController();
  final RxInt selectedPage = RxInt(0);
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  void initState() {
    version(widget.loginSuccessModel, widget.mskoolController);

    if (widget.loginSuccessModel.roleforlogin!.toLowerCase() == "student") {
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
    }

    homePage.addAll(
      [
        HomePageModel(
          title: "Dashboard",
          icon: 'assets/images/floatingicon.png',
          page: DashboardTab(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
            // hwcwNbController: hwCwNbController,
          ),
          selectedColor: const Color(0xFF9900F0),
        ),
        HomePageModel(
          title: "Task Creation",
          icon: 'assets/images/tabinteraction.png',
          page: TaskCreationHome(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
            // showAppBar: false,
          ),
          selectedColor: const Color(0xFFFF008C),
        ),
        HomePageModel(
          title: "Punch Report",
          icon: 'assets/images/calendar.png',
          page: PunchReport(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
            title: 'Punch Report',
            // showAppBar: false,
          ),
          selectedColor: const Color(0xFFFFA901),
        ),
        HomePageModel(
          title: "Profile",
          icon: 'assets/images/tabprofile.png',
          page: ProfileHomeScreen(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
          ),
          selectedColor: const Color(0xFF3D9292),
        ),
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: (selectedPage.value == 0)
          ? AppBar(
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset('assets/svg/menu.svg'),
                onPressed: () {
                  _scaffold.currentState!.openDrawer();
                },
              ),
              title: Obx(() {
                return Text(homePage.elementAt(selectedPage.value).title);
              }),
              actions: [
                IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) {
                    //       return NotificationScreen(
                    //         // appBarTitle: "Notice",
                    //         loginSuccessModel: widget.loginSuccessModel,
                    //         mskoolController: widget.mskoolController,
                    //         openFor: widget.loginSuccessModel.roleforlogin!
                    //             .toLowerCase(),
                    //         hwCwNbController: hwCwNbController,
                    //       );
                    //       // hwCwNbController: hwCwNbController);
                    //     },
                    //   ),
                    // );
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/bell.svg',
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
              ],
            )
          : null,
      drawer: Drawer(
        child: CommonDrawer(
          loginSuccessModel: widget.loginSuccessModel,
          // hwCwNbController: hwCwNbController,
          mskoolController: widget.mskoolController,
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: homePage.length,
        itemBuilder: (_, index) {
          return homePage.elementAt(index).page;
        },
        onPageChanged: (v) {
          setState(() {
            selectedPage.value = v;
          });
        },
      ),
      bottomNavigationBar: Material(
        elevation: 10.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Obx(() {
          return SalomonBottomBar(
            currentIndex: selectedPage.value,
            items: [
              ...List.generate(
                  homePage.length,
                  (index) => SalomonBottomBarItem(
                      unselectedColor: const Color(0xFFC0C0C0),
                      selectedColor: homePage.elementAt(index).selectedColor,
                      icon: Image.asset(
                        homePage.elementAt(index).icon,
                        height: homePage.elementAt(index).size ?? 30,
                        color: selectedPage.value == index
                            ? homePage.elementAt(index).selectedColor
                            : const Color(0xFFC0C0C0),
                      ),
                      title: Text(
                        homePage.elementAt(index).title,
                        overflow: TextOverflow.fade,
                      )))
            ],
            onTap: (v) {
              selectedPage.value = v;
              pageController.animateToPage(v,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn);
            },
          );
        }),
      ),
    );
  }
}

class StaffProfileTab extends StatelessWidget {
  const StaffProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
