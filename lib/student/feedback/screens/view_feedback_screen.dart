import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';

import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/feedback/api/get_feedback_api.dart';
import 'package:m_skool_flutter/student/feedback/model/get_feed_model.dart';
import 'package:m_skool_flutter/student/feedback/widget/feedback_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ViewFeedBackScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ViewFeedBackScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<ViewFeedBackScreen> createState() => _ViewFeedBackScreenState();
}

class _ViewFeedBackScreenState extends State<ViewFeedBackScreen> {
  int color = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "View Feedback").getAppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder<FeedBacksModel>(
            future: GetFeedBackApi.instance.getStuFeedBack(
              miId: widget.loginSuccessModel.mIID!,
              asmayId: widget.loginSuccessModel.asmaYId!,
              amstId: widget.loginSuccessModel.amsTId!,
              base: baseUrlFromInsCode("portal", widget.mskoolController),
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: Image.asset("assets/images/feedbackBanner.png"),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (_, index) {
                        color += 1;
                        if (index % 6 == 0) {
                          color = 0;
                        }
                        if (color > 6) {
                          color = 0;
                        }

                        return FeedBackItem(
                            color: noticeColor.elementAt(color),
                            feedBacks: snapshot.data!.values!.elementAt(index));
                      },
                      separatorBuilder: (_, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                      itemCount: snapshot.data!.values!.length,
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return ErrWidget(err: snapshot.error as Map<String, dynamic>);
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.25,
                  ),
                  const AnimatedProgressWidget(
                    title: "Getting your feedback's",
                    desc: "Just a moment, we are there to get your feedback's",
                    animationPath: "assets/json/feedback.json",
                  ),
                ],
              );
            }),
      ),
    );
  }
}
