// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/chat_profile_tile.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import '../controller/inbox_tab_controller.dart';

class UnReadTabScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const UnReadTabScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<UnReadTabScreen> createState() => _UnReadTabScreenState();
}

class _UnReadTabScreenState extends State<UnReadTabScreen> {
  final InboxController inboxController = Get.put(InboxController());
  void loadingUnread() async {
    // inboxController.isUnreadloading(true);
    // await inboxController.getUnread(
    //   miId: widget.loginSuccessModel.mIID!,
    //   amstId: widget.loginSuccessModel.amsTId!,
    //   asmayId: widget.loginSuccessModel.asmaYId!,
    //   userId: widget.loginSuccessModel.userId!,
    //   base: baseUrlFromInsCode(
    //     'portal',
    //     widget.mskoolController,
    //   ),
    // );
    // inboxController.isUnreadloading(false);
  }

  @override
  void initState() {
    // loadingUnread();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => inboxController.isUnreadLoading.value
          ? const Center(
              child: AnimatedProgressWidget(
                title: "Loading Unread",
                desc: "Please wait while we generate a view for you..",
                animationPath: "assets/json/interaction.json",
              ),
            )
          : inboxController.unReadList.isEmpty
              ? const Center(
                  child: AnimatedProgressWidget(
                    title: "Empty Unread",
                    desc: "This Screen is under contruction............",
                    animationPath: "assets/json/interaction.json",
                  ),
                )
              : ListView.separated(
                  itemBuilder: (_, index) {
                    return ChatProfileTile(
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      ismintComposeById:
                          inboxController.inboxList[index].ismintComposedById!,
                      ismintDateTime:
                          inboxController.inboxList[index].ismintDateTime!,
                      ismintId: inboxController.inboxList[index].ismintId!,
                      ismintSubject:
                          inboxController.inboxList[index].ismintSubject!,
                      istintId: inboxController.inboxList[index].istintId!,
                      designation: inboxController.userHrmeId ==
                              inboxController
                                  .inboxList[index].ismintComposedById
                          ? inboxController
                              .inboxList[index].ismintComposedByFlg!
                          : inboxController.inboxList[index].istintToFlg!,
                      title: inboxController.userHrmeId ==
                              inboxController
                                  .inboxList[index].ismintComposedById
                          ? inboxController.inboxList[index].receiver!
                          : inboxController.inboxList[index].sender!,
                      profileimage: inboxController.userHrmeId ==
                              inboxController
                                  .inboxList[index].ismintComposedById
                          ? inboxController.inboxList[index].receiverFilepath!
                          : inboxController
                              .inboxList[index].senderSenderFilepath!,
                      role: inboxController.inboxList[index].role!,
                      userHrmeId: inboxController.userHrmeId.value,
                      sender: inboxController.inboxList[index].sender!,
                      receiver: inboxController.inboxList[index].receiver!,
                      isGroup: inboxController.inboxList
                                  .elementAt(index)
                                  .ismintGroupOrIndFlg!
                                  .toLowerCase() ==
                              'group'
                          ? true
                          : false,
                      // isSeen:
                      //     inboxController.unReadList[index].istintReadFlg == 1
                      //         ? true
                      //         : false,
                      // color: Color.fromRGBO(Random().nextInt(255),
                      //     Random().nextInt(255), Random().nextInt(255), 1),
                      getInboxFunction: loadingUnread,
                    );
                  },
                  separatorBuilder: (_, index) => const Divider(thickness: 1.5),
                  itemCount: inboxController.unReadList.length),
    );
  }
}
