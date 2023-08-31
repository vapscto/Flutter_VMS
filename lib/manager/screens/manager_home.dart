import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/coe/screen/manager_coe.dart';
import 'package:m_skool_flutter/manager/tabs/manager_dashboard.dart';
import 'package:m_skool_flutter/manager/widget/drawer_widget.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/notification.dart';
import 'package:m_skool_flutter/staffs/tabs/staff_profile_tab.dart';
import 'package:m_skool_flutter/staffs/interaction/screen/interaction_home.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ManagerHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ManagerHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  final PageController controller = PageController(initialPage: 0);
  final RxList<Widget> homeList = <Widget>[].obs;

  @override
  void initState() {
    version(widget.loginSuccessModel, widget.mskoolController);

    homeList.add(
      ManagerDashboard(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
    );
    homeList.add(
      InteractionHome(
        // Same ui and api for staff and manager
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
        showAppBar: false,
      ),
    );

    homeList.add(ManagerCoeHome(
        formDashboard: false,
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
        title: "Coe"));
    homeList.add(StaffProfileTab(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController));
    super.initState();
  }

  RxInt index = RxInt(0);
  @override
  Widget build(BuildContext context) {
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
                          openFor: 'manager',
                        );
                        // hwCwNbController: hwCwNbController);
                      },
                    ),
                  );
                },
                icon: SvgPicture.asset('assets/svg/bell.svg'))
          ],
          title: Obx(() {
            return Text(index.value == 0
                ? "Dashboard"
                : index.value == 1
                    ? "Interaction"
                    : index.value == 2
                        ? "COE"
                        : "Profile");
          })),
      drawer: Drawer(
        child: ManagerDashboardDrawer(
          loginSuccessModel: widget.loginSuccessModel,
          mskoolController: widget.mskoolController,
        ),
      ),
      body: PageView.builder(
        controller: controller,
        itemBuilder: (_, index) {
          return homeList.elementAt(index);
        },
        itemCount: homeList.length,
        onPageChanged: (v) {
          index.value = v;
        },
      ),
      bottomNavigationBar: Material(
        elevation: 10.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Obx(() {
          return SalomonBottomBar(
            currentIndex: index.value,
            items: [
              SalomonBottomBarItem(
                  unselectedColor: const Color(0xFFC0C0C0),
                  selectedColor: const Color(0xFF9900F0),
                  icon: Image.asset(
                    'assets/images/floatingicon.png',
                    height: 30,
                    color: (index.value == 0)
                        ? const Color(0xFF9900F0)
                        : Colors.grey,
                  ),
                  title: const Text("Home")),
              SalomonBottomBarItem(
                  unselectedColor: const Color(0xFFC0C0C0),
                  selectedColor: const Color(0xFFFF008C),
                  icon: Image.asset(
                    'assets/images/tabinteraction.png',
                    height: 30,
                    color: (index.value == 1)
                        ? const Color(0xFFFF008C)
                        : Colors.grey,
                  ),
                  title: const Text("Interaction")),
              SalomonBottomBarItem(
                  unselectedColor: const Color(0xFFC0C0C0),
                  selectedColor: const Color(0xFFFFA901),
                  icon: Image.asset(
                    'assets/images/calendar.png',
                    height: 24,
                    color: (index.value == 2)
                        ? const Color(0xFFFFA901)
                        : Colors.grey,
                  ),
                  title: const Text("COE")),
              SalomonBottomBarItem(
                  unselectedColor: const Color(0xFFC0C0C0),
                  selectedColor: const Color(0xFF3D9292),
                  icon: Image.asset(
                    'assets/images/tabprofile.png',
                    height: 30,
                    color: (index.value == 3)
                        ? const Color(0xFF3D9292)
                        : Colors.grey,
                  ),
                  title: const Text("Profile")),
            ],
            onTap: (v) {
              index.value = v;
              controller.animateToPage(v,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn);
            },
          );
        }),
      ),
    );
  }
}
