import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/tabs/approved_indent_details.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/tabs/approval_indent_screen.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class PCApprovalHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const PCApprovalHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PCApprovalHome> createState() => _PCApprovalHomeState();
}

class _PCApprovalHomeState extends State<PCApprovalHome> with SingleTickerProviderStateMixin {
  // final PettyCashApprovalController Controller =
  //     Get.put<PettyCashApprovalController>(PettyCashApprovalController());

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    Get.delete<PettyCashApprovalController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: const HomeFab(),
      appBar: CustomAppBar(title: "Petty Cash Approval").getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(
                    name: "Approval", asset: "assets/svg/calendar.svg"),
                CustomTab(name: "Approved Details", asset: "assets/svg/calendar.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                PcIndentApprovalScreen(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                ),
                PcApprovedHome(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
