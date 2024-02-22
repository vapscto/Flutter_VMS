import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/api/noc_approve_api.dart';
import 'package:m_skool_flutter/vms/noc_approval/controller/noc_approved_controller.dart';
import 'package:m_skool_flutter/vms/noc_approval/screens/noc_approved_list.dart';
import 'package:m_skool_flutter/vms/noc_approval/screens/noc_details_screen.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

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
  NocApprovedController controller = Get.put(NocApprovedController());
  _getData() async {
    controller.approved(true);
    await NocApproveAPI.i.certificateLoad(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: controller,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!);
    controller.approved(false);
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
      appBar: const CustomAppBar(title: 'NOC Approval').getAppBar(),
      body: Obx(() {
        return controller.isApprovedLoading.value
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading",
                desc: "We are under process to get your details from server.")
            : (controller.nocList.isEmpty)
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "Certificate is not available for approval ",
                    animatorHeight: 250,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    itemBuilder: (context, index) {
                      var value = controller.nocList.elementAt(index);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Employee Name: ',
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                            TextSpan(
                                                text:
                                                    '${value.hRMEEmployeeFirstname}',
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith()),
                                          ],
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Request Date: ',
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                            TextSpan(
                                                text:
                                                    '${value.iSMCERTREQRequestDate}',
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith()),
                                          ],
                                        ),
                                      ),
                                      (value.iSMCERTREQFilePath!.isNotEmpty)
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Document:",
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      createPreview(
                                                          context,
                                                          value
                                                              .iSMCERTREQFilePath!);
                                                    },
                                                    icon: Icon(
                                                      Icons.visibility,
                                                      color: noticeColor
                                                          .elementAt(bgColor),
                                                    ))
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => NocDetailsScreen(
                                          controller: controller,
                                          loginSuccessModel:
                                              widget.loginSuccessModel,
                                          mskoolController:
                                              widget.mskoolController,
                                          value: controller.nocList[index],
                                        ));
                                  },
                                  child: Chip(
                                      backgroundColor:
                                          noticeColor.elementAt(bgColor),
                                      labelPadding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 2),
                                      label: Text(
                                        "Action",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: controller.nocList.length);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MSkollBtn(
          title: "NOC Approve/Reject Details",
          onPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NocApprovedListScreen(
                          controller: controller,
                          mskoolController: widget.mskoolController,
                          loginSuccessModel: widget.loginSuccessModel,
                        )));
          }),
    );
  }
}
