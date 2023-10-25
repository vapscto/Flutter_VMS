import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/tabs/particular_requisition.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/tabs/requisition_details.dart';
import 'package:m_skool_flutter/vms/widgets/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class PCRequisitionHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PCRequisitionHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<PCRequisitionHome> createState() => _PCRequisitionHomeState();
}

class _PCRequisitionHomeState extends State<PCRequisitionHome>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    // Get.delete<PettyCashApprovalController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Petty Cash Requisition").getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(
                    name: "Requisition", asset: "assets/svg/calendar.svg"),
                CustomTab(
                    name: "Requisition Details",
                    asset: "assets/svg/calendar.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                PcRequisitionScreen(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                ),
                PcRequisitionDetailsScreen(
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
