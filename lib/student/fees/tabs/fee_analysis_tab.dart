import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/fees/controller/fee_related_controller.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'headwise_analysis_tab.dart';
import 'overallAnalysis_tab.dart';

class FeeAnalysisTab extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const FeeAnalysisTab({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<FeeAnalysisTab> createState() => _FeeAnalysisTabState();
}

class _FeeAnalysisTabState extends State<FeeAnalysisTab>
    with TickerProviderStateMixin {
  final feeController = Get.put(FeeController());
  TabController? tabController;
  final PageController pageController = PageController();
  RxInt currentPage = RxInt(0);

  List<Widget> pages = const [
    OverallAnalysisTab(),
    HeadwiseAnalysisTab(),
  ];

  Future<void> getOverallData() async {
    feeController.isloading(true);
    await feeController
        .getFeeAnalysisData(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode('portal', widget.mskoolController),
    )
        .then((value) {
      debugPrint(value.toString());
    });
    feeController.isloading(false);
  }

  @override
  void initState() {
    getOverallData();

    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      pageController.animateToPage(tabController!.index,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn);
    });
    pageController.addListener(() {
      currentPage.value = tabController!.index;
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    pageController.dispose();

    Get.delete<TabController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabBar(
          tabs: const [
            CustomTab(
              name: "Overall Analysis",
              asset: "assets/svg/fee_analysis.svg",
            ),
            CustomTab(
              name: "Headwise Analysis",
              asset: "assets/svg/fee_analysis.svg",
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
    );
  }
}
