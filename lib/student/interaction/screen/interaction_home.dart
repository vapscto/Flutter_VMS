import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/screen/composetab.dart';
import 'package:m_skool_flutter/student/interaction/screen/inbox_tab.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
// import 'package:m_skool_flutter/interaction/screen/all_tab.dart';
import '../controller/compose_tab_controller.dart';
import '../widget/custom_tab_bar.dart';

class InteractionHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final bool showAppBar;
  final String? role;
  final int? hrmeId;
  final bool animateToInbox;
  const InteractionHomeScreen({
    required this.loginSuccessModel,
    required this.mskoolController,
    super.key,
    this.showAppBar = true,
    this.role = 'ClassTeacher',
    this.hrmeId,
    this.animateToInbox = false,
  });

  @override
  State<InteractionHomeScreen> createState() => _InteractionHomeScreenState();
}

class _InteractionHomeScreenState extends State<InteractionHomeScreen>
    with SingleTickerProviderStateMixin {
  final ComposeController composeController = Get.put(ComposeController());
  late TabController _tabController;

  void loadingInteraction() async {
    composeController.isInteractionloading(true);
    await Future.delayed(const Duration(seconds: 2));
    composeController.isInteractionloading(false);
  }

  @override
  void initState() {
    _tabController = TabController(
        initialIndex: 0,
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 300));
    loadingInteraction();
    super.initState();
  }

  List<CustomTab> tabs = const [
    CustomTab(name: "Compose", asset: "assets/svg/edit.svg"),
    CustomTab(name: "Inbox", asset: "assets/svg/inbox.svg"),
    // CustomTab(name: "All", asset: "layersall.svg"),
    // CustomTab(name: "Unread", asset: "assets/svg/unread.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.showAppBar)
          ? AppBar(
              elevation: 0,
              leadingWidth: 30,
              title: Text("interaction".tr),
              leading: const CustomGoBackButton(),
            )
          : null,
      body: Obx(
        () => composeController.isInteractionLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                  title: "Loading Interaction",
                  desc: "Please wait while we generate a view for you..",
                  animationPath: "assets/json/interaction.json",
                ),
              )
            : Column(
                children: [
                  CustomTabBar(
                    tabs: tabs,
                    tabController: _tabController,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ComposeTabScreen(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          tabController: _tabController,
                          role: widget.role!,
                          hrmeId: widget.hrmeId,
                          animateToInbox: widget.animateToInbox,
                        ),
                        InboxTabScreen(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                        ),
                        // AllTabScreen(),
                        // UnReadTabScreen(
                        //   loginSuccessModel: widget.loginSuccessModel,
                        //   mskoolController: widget.mskoolController,
                        // )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
