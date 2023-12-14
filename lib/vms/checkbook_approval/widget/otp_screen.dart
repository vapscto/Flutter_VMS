import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';

import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/forgotpassword/controller/opt_sent_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';

import 'package:m_skool_flutter/vms/checkbook_approval/controller/cheque_controller.dart';

import 'package:pinput/pinput.dart';

class OTpScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ChequeController chequeController;
  final int? cmpnymiId;
  OTpScreen(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.chequeController,
      super.key,
      required this.cmpnymiId});

  @override
  State<OTpScreen> createState() => _OTpScreenState();
}

class _OTpScreenState extends State<OTpScreen> {
  final ChequeController _chequeController = Get.put(ChequeController());
  final OtpSentStatusController otpSentStatusController =
      Get.put(OtpSentStatusController());
  final TextEditingController entredOtp = TextEditingController();

  Timer? timer;
  // int seconds = 59;
  @override
  void initState() {
    
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (otpSentStatusController.remainingTime.value == 0) {
        otpSentStatusController.updateDisableResendBtn(false);
      } else {
        otpSentStatusController.remainingTime.value -= 1;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<OtpSentStatusController>();
    entredOtp.dispose();
    widget.chequeController.otpResponseList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verification Code",
            style: Theme.of(context).textTheme.titleMedium!.merge(
                  const TextStyle(fontSize: 20.0),
                ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "We’ve send the verification code on  email.",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Pinput(
            length: 6,
            controller: entredOtp,
            defaultPinTheme: PinTheme(
              //padding: const EdgeInsets.all(16.0),
              width: 56,
              height: 56,
              textStyle: Theme.of(context).textTheme.titleMedium!,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: CustomThemeData.getShadow(),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Obx(() {
                return Text(
                    timeFormat(otpSentStatusController.remainingTime.value),
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                            // decoration: TextDecoration.underline,
                            color: Color(0xFFFF828A)),
                      ),
                );
              }),
            ],
          ),
          SizedBox(
            height: Get.height * 0.1,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    minimumSize: Size(Get.width * 0.4, 50)),
                onPressed: () async {
                  if (entredOtp.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please provide otp to continue");
                    return;
                  }

                  if (entredOtp.text ==
                      widget.chequeController.otpResponseList.first.emailotp) {
                    Fluttertoast.showToast(msg: "Otp Verified Successfully");
                    _chequeController.updateBtns(true);
                    Get.back();
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "You are entering wrong otp, we didn't sent this otp, check and try again");
                  }
                },
                child: Text(
                  "Continue",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(color: Colors.white, fontSize: 18.0)),
                )),
          ),
        ],
      ),
    ));
  }
  String timeFormat(int v){
    otpSentStatusController.minutes.value = v ~/ 60;
  otpSentStatusController. remainingSeconds.value = v % 60;
      return '${otpSentStatusController.minutes.value}:${otpSentStatusController.remainingSeconds.toString().padLeft(2, '0')}';

  }
  
}
