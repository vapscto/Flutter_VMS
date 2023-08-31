import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/fees/tabs/fee_receipt_tab.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class FeeReceiptHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const FeeReceiptHome(
      {super.key,
      required this.title,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<FeeReceiptHome> createState() => _FeeReceiptHomeState();
}

class _FeeReceiptHomeState extends State<FeeReceiptHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.title).getAppBar(),
        body: FeeReceiptTab(
          loginSuccessModel: widget.loginSuccessModel,
          mskoolController: widget.mskoolController,
        ));
  }
}
