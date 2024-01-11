import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/state_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
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
  TadaApplyDataController tadaApplyDataController =
      Get.put(TadaApplyDataController());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    newController = tabController;
    getStateList();
    super.initState();
  }

  getStateList() async {
    tadaApplyDataController.stateLoading(true);
    tadaApplyDataController.cityListValues.clear();
    await StateListAPI.instance.tadastateList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        tadaApplyController: tadaApplyDataController);
    tadaApplyDataController.stateLoading(false);
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
                  tadaApplyDataController: tadaApplyDataController,
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
