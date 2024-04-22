import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/api/candidate_api.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/controller/candidate_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class CandidateHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const CandidateHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});
  @override
  // ignore: library_private_types_in_public_api
  _CandidateHomeState createState() => _CandidateHomeState();
}

class _CandidateHomeState extends State<CandidateHome> {
  CandidateController controller = Get.put(CandidateController());

  @override
  void initState() {
    _onload();
    super.initState();
  }

  _onload() async {
    controller.updateIsLoadingRequest(true);
    await CandidateListApi.instance.getCandidateListApi(
      base: baseUrlFromInsCode('recruitement', widget.mskoolController),
      userId: widget.loginSuccessModel.userId!,
      controller: controller,
      miId: widget.loginSuccessModel.mIID!,
    );
    controller.updateIsLoadingRequest(false);
  }

  int bgColor = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            const CustomAppBar(title: 'Interview Schedule List').getAppBar(),
        body: Obx(() {
          return (controller.isLoadingRequest.value)
              ? const AnimatedProgressWidget(
                  animationPath: "assets/json/default.json",
                  title: "Loading",
                  desc: "We are under process to get your details from server.")
              : (controller.getcandiateList.isEmpty)
                  ? const AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'Data is Loading',
                      desc: "Interview candidate list is not available  ",
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
                        var value = controller.getcandiateList.elementAt(index);
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
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'Candidate: ',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: '${value.hrcDFullName}',
                                          style: Get.textTheme.titleSmall)
                                    ])),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'InterView Date: ',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: '${value.hrcisCInterviewDate}',
                                          style: Get.textTheme.titleSmall)
                                    ])),
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
                                          text: 'Status : ',
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
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: controller.getcandiateList.length);
        }));
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }
}
