import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/fees/tabs/fee_analysis_tab.dart';
import 'package:m_skool_flutter/student/fees/tabs/fee_receipt_tab.dart';
import 'package:m_skool_flutter/student/fees/tabs/pay_online_tab.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';

class FeeHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const FeeHomeScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<FeeHomeScreen> createState() => _FeeHomeScreenState();
}

class _FeeHomeScreenState extends State<FeeHomeScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          leading: const CustomGoBackButton(),
          leadingWidth: 30,
          title: Text("Fee".tr),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  color: Colors.white,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedTab == 0
                            ? SvgPicture.asset(
                                'assets/svg/feeanalysis_icon.svg')
                            : const SizedBox(),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "Fee Analysis",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.1,
                                    color: selectedTab != 0
                                        ? Colors.white
                                        : Colors.black),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedTab == 1
                            ? SvgPicture.asset('assets/svg/feereceipt_icon.svg')
                            : const SizedBox(),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "Fee Receipt",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.1,
                                    color: selectedTab != 1
                                        ? Colors.white
                                        : Colors.black),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedTab == 2
                            ? SvgPicture.asset('assets/svg/payonline_icon.svg')
                            : const SizedBox(),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Pay Online",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.1,
                                    color: selectedTab != 2
                                        ? Colors.white
                                        : Colors.black),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FeeAnalysisTab(
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            FeeReceiptTab(
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            PayOnlineTab(
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
          ],
        ),
      ),
    );
  }
}
