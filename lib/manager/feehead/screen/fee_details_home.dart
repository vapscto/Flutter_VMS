import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/feehead/controller/fee_head_details_controller.dart';
import 'package:m_skool_flutter/manager/feehead/tabs/fee_details.dart';
import 'package:m_skool_flutter/manager/feehead/tabs/fill_fee_details.dart';
// import 'package:m_skool_flutter/manager/overall_fee/controller/overall_classwise_related_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class FeeDetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const FeeDetailsScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required});

  @override
  State<FeeDetailsScreen> createState() => _FeeDetailsScreenState();
}

class _FeeDetailsScreenState extends State<FeeDetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController? nitin;
  @override
  void initState() {
    nitin = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Fee Details").getAppBar(),
      floatingActionButton: const HomeFab(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: nitin!,
              tabs: const [
                CustomTab(
                    name: "Fee Group Details",
                    asset: "assets/svg/calendar.svg"),
                CustomTab(
                    name: " Fee Head Details",
                    asset: "assets/svg/calendar.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: nitin!,
              children: [
                FeeFillWiseTap(
                  loginSuccessModel: widget.loginSuccessModel,
                  controller: widget.mskoolController,
                ),
                FeeHeadWiseTab(
                  loginSuccessModel: widget.loginSuccessModel,
                  controller: widget.mskoolController,
                )
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
