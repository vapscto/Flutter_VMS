import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/fees/tabs/fee_analysis_tab.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class FeeAnalysisScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final String title;
  final MskoolController mskoolController;
  const FeeAnalysisScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.title,
  });

  @override
  State<FeeAnalysisScreen> createState() => _FeeAnalysisScreenState();
}

class _FeeAnalysisScreenState extends State<FeeAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        leading: const CustomGoBackButton(),
        leadingWidth: 30,
        title: Text(widget.title),
      ),
      body: FeeAnalysisTab(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
      floatingActionButton: const HomeFab(),
    );
  }
}
