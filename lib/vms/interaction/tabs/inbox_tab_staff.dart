// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/interaction/controller/staff_interaction_inbox_related_controller.dart';
import 'package:m_skool_flutter/student/interaction/widget/chat_profile_tile.dart';
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
  final StaffInteractionInboxController staffInteractionInboxController =
      Get.put(StaffInteractionInboxController());

  void getInboxData() async {
    staffInteractionInboxController.isinboxloading(true);
    await staffInteractionInboxController
        .getStaffInboxList(
          miId: widget.loginSuccessModel.mIID!,
          amstId: widget.loginSuccessModel.amsTId!,
          asmayId: widget.loginSuccessModel.asmaYId!,
          roleId: widget.loginSuccessModel.roleId!,
          role: widget.loginSuccessModel.roleforlogin!,
          userId: widget.loginSuccessModel.userId!,
          base: baseUrlFromInsCode(
            'portal',
            widget.mskoolController,
          ),
        )
        .then((value) => logger.d(value));
    staffInteractionInboxController.isinboxloading(false);
  }

  @override
  void initState() {
    logger.d(widget.loginSuccessModel.roleforlogin);
    getInboxData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => staffInteractionInboxController.isInbox.value
          ? const Center(
              child: AnimatedProgressWidget(
                title: "Loading Inbox",
                desc: "Please wait while we generate a view for you..",
                animationPath: "assets/json/interaction.json",
              ),
            )
          : staffInteractionInboxController.inboxList.isEmpty
              ? const Center(
                  child: AnimatedProgressWidget(
                    title: "Empty Inbox",
                    desc: "",
                    animationPath: "assets/json/interaction.json",
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int itemCount = staffInteractionInboxController
                        .inboxMsgReadFlagValue.length;
                    int reversedIndex = itemCount - 1 - index;
                    logger.d({
                      "status": staffInteractionInboxController
                          .inboxMsgReadFlagValue[reversedIndex].istintReadFlg,
                      "id": staffInteractionInboxController
                          .inboxList[index].ismintId!
                    });
                    return ChatProfileTile(
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      ismintComposeById: staffInteractionInboxController
                          .inboxList[index].ismintComposedById!,
                      ismintDateTime: staffInteractionInboxController
                          .inboxList[index].ismintDateTime!,
                      ismintId: staffInteractionInboxController
                          .inboxList[index].ismintId!,
                      ismintSubject: staffInteractionInboxController
                          .inboxList[index].ismintSubject!,
                      istintId: staffInteractionInboxController
                          .inboxList[index].istintToId!,
                      designation: staffInteractionInboxController.userHrmeId ==
                              staffInteractionInboxController
                                  .inboxList[index].ismintComposedById
                          ? staffInteractionInboxController
                              .inboxList[index].istintToFlg!
                          : staffInteractionInboxController
                              .inboxList[index].ismintComposedByFlg!,
                      title: staffInteractionInboxController.inboxList
                                  .elementAt(index)
                                  .ismintGroupOrIndFlg!
                                  .toLowerCase() ==
                              'group'
                          ? 'Group'
                          : staffInteractionInboxController.userHrmeId ==
                                  staffInteractionInboxController
                                      .inboxList[index].ismintComposedById
                              ? staffInteractionInboxController
                                      .inboxList[index].receiver ??
                                  "N/a"
                              : staffInteractionInboxController.inboxList
                                  .elementAt(index)
                                  .sender!,
                      profileimage: staffInteractionInboxController
                                  .userHrmeId ==
                              staffInteractionInboxController
                                  .inboxList[index].ismintComposedById
                          ? staffInteractionInboxController
                                  .inboxList[index].receiverFilepath ??
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                          : staffInteractionInboxController
                              .inboxList[index].senderFilepath!,
                      role: staffInteractionInboxController
                          .inboxList[index].role!,

                      userHrmeId:
                          staffInteractionInboxController.userHrmeId.value,
                      sender: staffInteractionInboxController
                          .inboxList[index].sender!,
                      receiver: staffInteractionInboxController
                              .inboxList[index].receiver ??
                          "N/a",
                      isGroup: staffInteractionInboxController.inboxList
                                  .elementAt(index)
                                  .ismintGroupOrIndFlg!
                                  .toLowerCase() ==
                              'group'
                          ? true
                          : false,
                      isSeen: staffInteractionInboxController
                                  .inboxMsgReadFlagValue[reversedIndex]
                                  .istintReadFlg ==
                              1
                          ? false
                          : true,
                      // color: Color.fromRGBO(Random().nextInt(255),
                      //     Random().nextInt(255), Random().nextInt(255), 1),
                      getInboxFunction: getInboxData,
                    );
                  },
                  separatorBuilder: (_, index) => const Divider(height: 15),
                  itemCount: staffInteractionInboxController.inboxList.length),
    );
  }
}
