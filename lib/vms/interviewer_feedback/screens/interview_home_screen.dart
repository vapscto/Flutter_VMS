import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/api/interview_feedback_api.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/controller/interview_feedback_controller.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/screens/update_interview_status.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class InterviewerHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const InterviewerHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<InterviewerHomeScreen> createState() => _InterviewerHomeScreenState();
}

class _InterviewerHomeScreenState extends State<InterviewerHomeScreen> {
  InterviewFeedbackController controller =
      Get.put(InterviewFeedbackController());
  _getData() async {
    controller.listLoading(true);
    await InterviewFeedbackAPI.i.onload(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: controller,
        body: {"UserId": widget.loginSuccessModel.userId});
    controller.listLoading(false);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  int bgColor = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Candidate Interview Feedback')
            .getAppBar(),
        body: Obx(() {
          return (controller.isListLoading.value)
              ? const AnimatedProgressWidget(
                  animationPath: "assets/json/default.json",
                  title: "Loading",
                  desc: "We are under process to get your details from server.")
              : (controller.interviewList.isEmpty)
                  ? const AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'Data is not available',
                      desc: "Interview candidate is not available  ",
                      animatorHeight: 250,
                    )
                  : ListView.separated(
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 16, horizontal: 16),
                      itemBuilder: (context, index) {
                        bgColor += 1;
                        if (bgColor % 6 == 0) {
                          bgColor = 0;
                        }
                        var value = controller.interviewList.elementAt(index);
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: lighterColor.elementAt(bgColor),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(1, 2.1),
                                    blurRadius: 0,
                                    spreadRadius: 0,
                                    color: Colors.black12)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.hrcDFullName!,
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'InterView Type: ',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text:
                                              '${value.hrcisCInterviewRounds}',
                                          style: Get.textTheme.titleSmall)
                                    ])),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'InterView Date: ',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: dateFormat(DateTime.parse(
                                              value.hrcisCInterviewDateTime!)),
                                          style: Get.textTheme.titleSmall)
                                    ])),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'InterView Status: ',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: '${value.hrcisCStatus}',
                                          style: Get.textTheme.titleSmall)
                                    ])),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                UpdatedInterviewStatus(
                                                  controller: controller,
                                                  mskoolController:
                                                      widget.mskoolController,
                                                  loginSuccessModel:
                                                      widget.loginSuccessModel,
                                                  values: controller
                                                      .interviewList[index],
                                                )));
                                  },
                                  child: Chip(
                                      backgroundColor: noticeColor[bgColor],
                                      label: Text(
                                        "Feedback",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: controller.interviewList.length);
        }));
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }
}
