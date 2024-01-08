import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/tada_apply.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/tada_balance_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class TadaApplyHomeScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final int previousScreen;
  const TadaApplyHomeScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.previousScreen});

  @override
  State<TadaApplyHomeScreen> createState() => _TadaApplyHomeScreenState();
}

class _TadaApplyHomeScreenState extends State<TadaApplyHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    newController = tabController;
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
      appBar: const CustomAppBar(
        title: "TA-DA Apply",
      ).getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(name: "Apply", asset: "assets/svg/calendar_icon.svg"),
                CustomTab(
                    name: "Balance Apply",
                    asset: "assets/svg/calendar_icon.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                TadaApplyWidget(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  previousScreen: widget.previousScreen,
                ),
                TadaBalanceWidget(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  tabController: tabController!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
