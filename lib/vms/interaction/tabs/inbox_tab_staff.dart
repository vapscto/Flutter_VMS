// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/interaction/api/staff_interaction_compose_related_api.dart';
import 'package:m_skool_flutter/vms/interaction/controller/staff_interaction_compose_related_controller.dart';
import 'package:m_skool_flutter/vms/interaction/widget/chat_widgets.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class InboxTabStaff extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const InboxTabStaff({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<InboxTabStaff> createState() => _InboxTabStaffState();
}

class _InboxTabStaffState extends State<InboxTabStaff> {
  StaffInteractionComposeController staffInteractionComposeController =
      Get.find();

  void getInboxData() async {
    staffInteractionComposeController.isgetdetailloading(true);
    await InteractionListAPI.instance.getInteractionList(
        base: baseUrlFromInsCode(
          'issuemanager',
          widget.mskoolController,
        ),
        staffInteractionComposeController: staffInteractionComposeController,
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        irmrtId: widget.loginSuccessModel.roleId!,
        flag: "S",
        ismintrId: 234);
    staffInteractionComposeController.isgetdetailloading(false);
  }

  @override
  void initState() {
    getInboxData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return staffInteractionComposeController.isGetDetail.value
            ? const Center(
                child: AnimatedProgressWidget(
                  title: "Loading Inbox",
                  desc: "Please wait while we generate a view for you..",
                  animationPath: "assets/json/interaction.json",
                ),
              )
            : staffInteractionComposeController.getDetailList.isEmpty
                ? const Center(
                    child: AnimatedProgressWidget(
                      title: "Empty Inbox",
                      desc: "",
                      animationPath: "assets/json/interaction.json",
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      var value = staffInteractionComposeController
                          .getDetailList
                          .elementAt(index);
                      return ChatWidgets(
                        loginSuccessModel: widget.loginSuccessModel,
                        mskoolController: widget.mskoolController,
                        profileimage: '',
                        title: value.iSMINTRSubject!,
                        designation: value.iSMINTRInteraction!,
                        ismintDateTime: DateTime.parse(value.iSMINTRDateTime!),
                        ismintId: value.iSMINTRId!,
                        istintId: 0,
                        hrmeId: value.iSMINTRComposedByHRMEId!,
                        sender: value.sender!,
                        receiver: value.receiver!,
                        isGroup:
                            value.iSMINTRGroupOrIndFlg == "G" ? true : false,
                        getInboxFunction: getInboxData,
                        toId: value.iSMINTRDToId!,
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(height: 15),
                    itemCount:
                        staffInteractionComposeController.getDetailList.length);
      }),
    );
  }
}
