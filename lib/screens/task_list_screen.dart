import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/profile/api/profile_api.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class TaskListScreen extends StatefulWidget {
  final String status;
  final String companyName;
  final int hRMPRId;
  final ProfileController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const TaskListScreen(
      {super.key,
      required this.status,
      required this.companyName,
      required this.hRMPRId,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  _getData() async {
    widget.controller.taskDataLoading(true);
    await ProfileAPI.instance.issuesList(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        profileController: widget.controller,
        body: {
          "HRMPR_Id": widget.hRMPRId,
          "MI_Id": widget.loginSuccessModel.mIID,
          "UserId": widget.loginSuccessModel.userId,
          "IVRMRT_Id": widget.loginSuccessModel.roleId
        });
    widget.controller.taskDataLoading(false);
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
      appBar: CustomAppBar(
              title: '${widget.status} Issues from ${widget.companyName}')
          .getAppBar(),
      body: Obx(() {
        return widget.controller.taskLoading.value
            ? AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title:
                    "Loading ${widget.status} Issues from ${widget.companyName}",
                desc:
                    "We are under process to get ${widget.status} Issues from ${widget.companyName} from server.")
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var value = widget.controller.issuesList.elementAt(index);
                  bgColor += 1;
                  if (bgColor % 6 == 0) {
                    bgColor = 0;
                  }
                  return InkWell(
                    onTap: () {},
                    child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${value.iSMTCRTaskNo}',
                            style: Get.textTheme.titleMedium!.copyWith(
                                color: noticeColor.elementAt(bgColor)),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Title: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '${value.iSMTCRTitle}',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Start Date: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: formatedDate(DateTime.parse(
                                        value.iSMTCRASTOStartDate!)),
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'End Date: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: formatedDate(DateTime.parse(
                                        value.iSMTCRASTOEndDate!)),
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Deviation: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '${value.totaldeviation!} Days',
                                    style: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.red)),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Created By: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '${value.createdBy}',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Assigned By: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '${value.assignedBy}',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Description: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '${value.iSMTCRDesc}',
                                    style:
                                        Get.textTheme.titleSmall!.copyWith()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                itemCount: widget.controller.issuesList.length);
      }),
    );
  }

  String formatedDate(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }
}
