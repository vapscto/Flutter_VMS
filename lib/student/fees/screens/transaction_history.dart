import 'package:flutter/material.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/fees/apis/get_transaction_history.dart';
import 'package:m_skool_flutter/student/fees/model/transaction_his_model.dart';
import 'package:m_skool_flutter/student/fees/widgets/trans_his_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class TransactionHistory extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const TransactionHistory(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Transaction History").getAppBar(),
        body: FutureBuilder<List<TransDetailHisModelValues>>(
          future: GetTransactionHistory.instance.getHistory(
              miId: loginSuccessModel.mIID!,
              asmayId: loginSuccessModel.asmaYId!,
              amstId: loginSuccessModel.amsTId!,
              fmotGateWayType: "Razorpay",
              base: baseUrlFromInsCode("portal", mskoolController)),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (_, index) {
                    return TransHisItem(
                      value: snapshot.data!.elementAt(index),
                      loginSuccessMode: loginSuccessModel,
                      mskoolController: mskoolController,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                  itemCount: snapshot.data!.length);
            }
            if (snapshot.hasError) {
              return ErrWidget(err: snapshot.error as Map<String, dynamic>);
            }
            return const AnimatedProgressWidget(
              title: "Loading Transaction's",
              desc:
                  "We are loading your previous transaction's.... Please wait",
              animationPath: "assets/json/fee.json",
            );
          },
        ));
  }
}
