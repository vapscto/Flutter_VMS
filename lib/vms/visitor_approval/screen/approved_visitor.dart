import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ApproveVisitorsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ApproveVisitorsScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<ApproveVisitorsScreen> createState() => _ApproveVisitorsScreenState();
}

class _ApproveVisitorsScreenState extends State<ApproveVisitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Approve Visitors").getAppBar(),
    );
  }
}
