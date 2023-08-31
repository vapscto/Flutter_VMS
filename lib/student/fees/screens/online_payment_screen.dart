import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/fees/tabs/pay_online_tab.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class OnlinePaymentScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final String title;
  final MskoolController mskoolController;
  const OnlinePaymentScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<OnlinePaymentScreen> createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: PayOnlineTab(
          loginSuccessModel: widget.loginSuccessModel,
          mskoolController: widget.mskoolController),
    );
  }
}
