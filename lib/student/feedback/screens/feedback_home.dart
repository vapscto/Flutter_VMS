import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/feedback/api/save_feedback_api.dart';
import 'package:m_skool_flutter/student/feedback/screens/view_feedback_screen.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/pgr_widget.dart';
import 'package:m_skool_flutter/widget/success_widget.dart';

class FeedBackHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const FeedBackHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<FeedBackHome> createState() => _FeedBackHomeState();
}

class _FeedBackHomeState extends State<FeedBackHome> {
  final TextEditingController feedBackCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: Text("Feedback".tr),
        leading: const CustomGoBackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return ViewFeedBackScreen(
                        loginSuccessModel: widget.loginSuccessModel,
                        mskoolController: widget.mskoolController,
                      );
                    },
                  ),
                );
              },
              child: Text(
                "View Feedback",
                style: Theme.of(context).textTheme.labelSmall!.merge(
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Please Complete This Form To Report The Feedback And Issue To ${widget.mskoolController.universalInsCodeModel!.value.institutioNNAME}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              const TextStyle(
                                // color: Color(0xFF35658F),
                                fontSize: 16.0,
                              ),
                            ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Suggestions for Improvement",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                // color: Color(0xFF35658F),
                                letterSpacing: 0.3,
                                fontSize: 16.0,
                              ),
                            ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          boxShadow: CustomThemeData.getShadow(),
                          borderRadius: BorderRadius.circular(12.0),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: TextField(
                          maxLines: 8,
                          controller: feedBackCtrl,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                                const TextStyle(
                                    letterSpacing: 0.3, fontSize: 16.0),
                              ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Feedback'.tr,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 36.0,
            ),
            MSkollBtn(
              title: "Submit",
              size: Size(Get.width * 0.5, 50),
              onPress: () {
                if (feedBackCtrl.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please provide your feedback before submitting.");
                  return;
                }
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: FutureBuilder<bool>(
                        future: SaveFeedBackApi.instance.getSaveFeedBack(
                          miId: widget.loginSuccessModel.mIID!,
                          asmayId: widget.loginSuccessModel.asmaYId!,
                          amstId: widget.loginSuccessModel.amsTId!,
                          feedBack: feedBackCtrl.text,
                          baseUrl: baseUrlFromInsCode(
                            "portal",
                            widget.mskoolController,
                          ),
                        ),
                        builder: (_, snapshot) {
                          if (snapshot.hasData && snapshot.data!) {
                            return SuccessWidget(
                              title: "Thanks for your Feedback",
                              message:
                                  "Your feedback matters most of us, we will see this soon",
                              onPressed: () {
                                Navigator.pop(context);
                                feedBackCtrl.text = "";
                              },
                            );
                          }
                          if (snapshot.hasError) {
                            return ErrWidget(
                                err: snapshot.error as Map<String, dynamic>);
                          }
                          return const ProgressWidget();
                        },
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 36.00,
            ),
            LottieBuilder.asset("assets/json/feed.json"),
          ],
        ),
      ),
    );
  }
}
