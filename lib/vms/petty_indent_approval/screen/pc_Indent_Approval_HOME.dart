import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/tabs/indent_approval.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/tabs/indent_approved_details.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class PcIndentApprovalHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const PcIndentApprovalHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PcIndentApprovalHome> createState() => _PcIndentApprovalHomeState();
}

class _PcIndentApprovalHomeState extends State<PcIndentApprovalHome> with SingleTickerProviderStateMixin {
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
    Get.delete<PettyIndentApprovalController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: const HomeFab(),
      appBar: CustomAppBar(title: "Cash Indent Approval").getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(
                    name: "Indent Approval", asset: "assets/svg/fee_analysis.svg"),
                CustomTab(name: "Indent Details", asset: "assets/svg/fee_analysis.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                IndentApproval(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                ),
                IndentApprovedDetails(
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
