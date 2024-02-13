import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class NocApproval extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const NocApproval(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<NocApproval> createState() => _NocApprovalState();
}

class _NocApprovalState extends State<NocApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'NOC Approval').getAppBar(),
      body: ListView(
        children: [],
      ),
    );
  }
}
