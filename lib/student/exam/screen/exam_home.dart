import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/exam/controller/exam_controller.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import '../tabs/exam_wise_tab.dart';
import '../tabs/subject_wise_tab.dart';

class ExamHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ExamHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<ExamHome> createState() => _ExamHomeState();
}

class _ExamHomeState extends State<ExamHome> with TickerProviderStateMixin {
  TabController? tabController;
  final PageController pageController = PageController();
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      pageController.animateToPage(tabController!.index,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn);
    });
    pageController.addListener(() {
      selectedTab = tabController!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      ExamWiseTab(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
      SubjectWiseTab(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
    ];
    debugPrint("Build");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 30,
          title: Text("Exam".tr),
          leading: const CustomGoBackButton(),
        ),
        body: Column(
          children: [
            CustomTabBar(
              tabs: const [
                CustomTab(
                  name: "Exam wise",
                  asset: "assets/svg/exam_ic.svg",
                ),
                CustomTab(
                  name: "Subject wise",
                  asset: "assets/svg/exam_ic.svg",
                )
              ],
              tabController: tabController!,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: Get.height,
                child: PageView.builder(
                    onPageChanged: (newPage) {
                      tabController!.animateTo(newPage);
                      
                    },
                    controller: pageController,
                    itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages.elementAt(index);
                    }),
              ),
            ),
          ],
        ),
        floatingActionButton: const HomeFab(),
      ),
    );
  }
}
