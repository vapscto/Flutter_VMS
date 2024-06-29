import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_controller/gate_pass_controller.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_widgets/gate_pass.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_widgets/gate_pass_list.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class StaffGatePass extends StatefulWidget {
  final String title;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const StaffGatePass(
      {super.key,
      required this.title,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<StaffGatePass> createState() => _StaffGatePassState();
}

class _StaffGatePassState extends State<StaffGatePass>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  GatePassController controller = Get.put(GatePassController());
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
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(name: "Gate Pass", asset: "assets/svg/bell.svg"),
                CustomTab(name: "Gate Pass List", asset: "assets/svg/bell.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                GatePassScreen(
                  controller: controller,
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                ),
                GatePassListScreen(
                  controller: controller,
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
