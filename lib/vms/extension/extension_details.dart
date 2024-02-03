import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/extension/controller/extension_controller.dart';
import 'package:m_skool_flutter/vms/extension/widgets/dr_ext_tab.dart';
import 'package:m_skool_flutter/vms/extension/widgets/planner_ext_tab.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ExtensionDetails extends StatefulWidget {
  final ExtensionController controller;

  const ExtensionDetails({
    super.key,
    required this.controller,
  });

  @override
  State<ExtensionDetails> createState() => _ExtensionDetailsState();
}

class _ExtensionDetailsState extends State<ExtensionDetails>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PlannerCreationController plannerCreationController =
      Get.put(PlannerCreationController());

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Extension Details").getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(name: "Planner", asset: "assets/svg/bell.svg"),
                CustomTab(name: "Daily Report", asset: "assets/svg/bell.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                PlannerExtensionTab(
                  controller: widget.controller,
                ),
                DrExtensionTab(
                  controller: widget.controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
