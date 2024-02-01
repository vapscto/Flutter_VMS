import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/home_page_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/notification.dart';
import 'package:m_skool_flutter/tabs/dashboard.dart';
import 'package:m_skool_flutter/vms/api/institute_api.dart';
import 'package:m_skool_flutter/vms/coe/coe_home.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';
import 'package:m_skool_flutter/vms/profile/api/profile_api.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/vms/profile/screens/profile_screen.dart';
import 'package:m_skool_flutter/vms/punch_report/api/punch_api.dart';
import 'package:m_skool_flutter/vms/punch_report/controller/punch_filter_controller.dart';
import 'package:m_skool_flutter/vms/punch_report/screens/punch_report_home.dart';
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
  final ProfileController profileController = Get.put(ProfileController());
  final PunchFilterController punchFilterController =
      Get.put(PunchFilterController());
  final VmsTransationController vmsTransationController =
      Get.put(VmsTransationController());
  _getPunch() async {
    punchFilterController.punchLoading(true);
    await PunchApi.instance.pcReports(
        body: {
          "UserId": widget.loginSuccessModel.userId,
          "MI_Id": widget.loginSuccessModel.mIID,
          "IVRMRT_Id": widget.loginSuccessModel.roleId!,
          "ASMAY_Id": widget.loginSuccessModel.asmaYId
        },
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        controller: punchFilterController);
    punchFilterController.punchLoading(false);
  }

  _getProfile() async {
    profileController.profileLoading(true);
    await ProfileAPI.instance.profileData(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        profileController: profileController,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        roleId: widget.loginSuccessModel.roleId!);
    profileController.profileLoading(false);
  }

  _getInstitute() async {
    vmsTransationController.instituteLoading(true);
    await await InstituteListAPI.instance.instituteList(
        base: baseUrlFromInsCode("login", widget.mskoolController),
        controller: vmsTransationController,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        roleId: widget.loginSuccessModel.roleId!);
    vmsTransationController.instituteLoading(false);
  }

  @override
  void initState() {
    version(widget.loginSuccessModel, widget.mskoolController);
    _getPunch();
    _getProfile();
    _getInstitute();
    homePage.addAll(
      [
        HomePageModel(
          title: "Dashboard",
          icon: 'assets/images/floatingicon.png',
          page: DashboardTab(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
            // controller: controller,
            profileController: profileController,
          ),
          selectedColor: const Color(0xFF9900F0),
        ),
        HomePageModel(
            title: "Punch Report",
            icon: 'assets/images/calendar.png',
            page: PunchReport(
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
              title: 'Punch Report',
              previousScreen: '1',
            ),
            selectedColor: const Color(0xFFFFA901),
            size: 24.0),
        HomePageModel(
            title: "COE",
            icon: 'assets/images/event.png',
            page: CoeHomeScreen(
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
              // title: 'COE',
              // previousScreen: '1',
              profileController: profileController,
            ),
            selectedColor: const Color.fromRGBO(247, 80, 80, 1),
            size: 24.0),
        HomePageModel(
          title: "Profile",
          icon: 'assets/images/tabprofile.png',
          page: MyProfileScreen(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
            profileController: profileController,
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

  Future<bool> _onWillPop() async {
    if (pageController.page! > 0) {
      pageController.animateTo(pageController.page! - 1,
          duration: const Duration(microseconds: 100),
          curve: Curves.fastLinearToSlowEaseIn);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Color.fromARGB(255, 255, 83, 77)
    //         //color set to purple or set your own color
    //         ));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return NotificationScreen(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              openFor: widget.loginSuccessModel.roleforlogin!
                                  .toLowerCase(),
                            );
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
              )
            : null,
        drawer: Drawer(
          child: CommonDrawer(
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
            profileController: profileController,
            vmsTransationController: vmsTransationController,
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
                        title: Text(homePage.elementAt(index).title)))
              ],
              onTap: (v) {
                selectedPage.value = v;
                pageController.animateToPage(v,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.fastLinearToSlowEaseIn);
              },
            );
          }),
        ),
      ),
    );
  }
}
