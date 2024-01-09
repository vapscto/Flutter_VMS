import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/apis/messaging_api.dart';
import 'package:m_skool_flutter/student/interaction/controller/interaction_controller.dart';
import 'package:m_skool_flutter/student/interaction/widget/chat_box.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_text_file.dart';
import 'package:m_skool_flutter/vms/interaction/api/staff_interaction_compose_related_api.dart';
import 'package:m_skool_flutter/vms/interaction/controller/staff_interaction_compose_related_controller.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';

class VMSMessagingScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int ismintId;
  final int istintId;
  final int ismintComposedById;
  final int hrmeId;
  final bool isGroup;
  const VMSMessagingScreen({
    super.key,
    required this.ismintId,
    required this.istintId,
    required this.ismintComposedById,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.hrmeId,
    required this.isGroup,
  });

  @override
  State<VMSMessagingScreen> createState() => _VMSMessagingScreenState();
}

class _VMSMessagingScreenState extends State<VMSMessagingScreen> {
  // final InteractionController interactionController =
  //     Get.put(InteractionController());
  StaffInteractionComposeController staffInteractionComposeController =
      Get.put(StaffInteractionComposeController());
  final TextEditingController textMessage = TextEditingController();

  Future<void> getMessageData() async {
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
    getMessageData();
    logger.d({
      "miId": widget.loginSuccessModel.mIID!,
      "asmayId": widget.loginSuccessModel.asmaYId!,
      "userId": widget.loginSuccessModel.userId!,
      "roleId": widget.loginSuccessModel.roleId!,
      "ismintId": widget.ismintId,
      "role": widget.loginSuccessModel.roleforlogin
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 30,
        toolbarHeight: 65,
        title: Text("Message",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white.withOpacity(0.8))),
        leading: const CustomGoBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => staffInteractionComposeController.isGetDetail.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : staffInteractionComposeController.getDetailList.isEmpty
                        ? const Text('No message, start chatting.')
                        : ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: staffInteractionComposeController
                                .getDetailList.length,
                            itemBuilder: (context, index) {
                              int itemCount = staffInteractionComposeController
                                  .getDetailList.length;
                              int reversedIndex = itemCount - 1 - index;
                              return Column(
                                children: [
                                  ChatBox(
                                    name: widget.hrmeId ==
                                            staffInteractionComposeController
                                                .getDetailList
                                                .elementAt(reversedIndex)
                                                .iSMINTRComposedByHRMEId
                                        ? staffInteractionComposeController
                                            .getDetailList
                                            .elementAt(reversedIndex)
                                            .sender!
                                        : staffInteractionComposeController
                                            .getDetailList
                                            .elementAt(reversedIndex)
                                            .sender!,
                                    isFromMe: widget.hrmeId ==
                                            staffInteractionComposeController
                                                .getDetailList
                                                .elementAt(reversedIndex)
                                                .iSMINTRComposedByHRMEId
                                        ? true
                                        : false,
                                    messages: staffInteractionComposeController
                                        .getDetailList
                                        .elementAt(reversedIndex)
                                        .iSMINTRInteraction!,
                                    istintDateTime: DateTime.parse(
                                        staffInteractionComposeController
                                            .getDetailList
                                            .elementAt(reversedIndex)
                                            .iSMINTRDateTime!),
                                    attactment: '',
                                    isGroup: widget.isGroup,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: CustomTextField(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
                  controller: textMessage,
                  hintText: " Text Message",
                  radius: 25,
                )),
                const SizedBox(width: 12),
                Obx(
                  () => FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: staffInteractionComposeController.isGetDetail.value
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : SvgPicture.asset("assets/svg/send_arrow.svg"),
                    onPressed: () async {
                      staffInteractionComposeController.issubmitloading(true);
                      await sendVMSMessage(
                        miId: widget.loginSuccessModel.mIID!,
                        asmayId: widget.loginSuccessModel.asmaYId!,
                        message: textMessage.text,
                        ismintId: widget.ismintId,
                        userId: widget.loginSuccessModel.userId!,
                        roleId: widget.loginSuccessModel.roleId!,
                        base: baseUrlFromInsCode(
                            'portal', widget.mskoolController),
                      ).then(
                        (value) async {
                          if (value) {
                            getMessageData();
                            textMessage.text = '';
                          }
                        },
                      );
                      staffInteractionComposeController.issubmitloading(false);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7)
          ],
        ),
      ),
    );
  }
}
