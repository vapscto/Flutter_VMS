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
  final InteractionController interactionController =
      Get.put(InteractionController());

  final TextEditingController textMessage = TextEditingController();

  Future<void> getMessageData() async {
    interactionController.isMessageloading(true);
    await interactionController.getMessage(
        ismintId: widget.ismintId,
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('portal', widget.mskoolController),
        ivrmrtId: widget.loginSuccessModel.roleId!);
    interactionController.isMessageloading(false);
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
                () => interactionController.isMessage.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : interactionController.messageList.isEmpty
                        ? const Text('No message, start chatting.')
                        : ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: interactionController.messageList.length,
                            itemBuilder: (context, index) {
                              int itemCount =
                                  interactionController.messageList.length;
                              int reversedIndex = itemCount - 1 - index;
                              return Column(
                                children: [
                                  ChatBox(
                                    name: widget.hrmeId ==
                                            interactionController.messageList
                                                .elementAt(reversedIndex)
                                                .istintComposedById
                                        ? interactionController.messageList
                                            .elementAt(reversedIndex)
                                            .sender!
                                        : interactionController.messageList
                                            .elementAt(reversedIndex)
                                            .sender!,
                                    isFromMe: widget.hrmeId ==
                                            interactionController.messageList
                                                .elementAt(reversedIndex)
                                                .istintComposedById
                                        ? true
                                        : false,
                                    messages: interactionController.messageList
                                        .elementAt(reversedIndex)
                                        .istintInteraction!,
                                    istintDateTime: interactionController
                                        .messageList
                                        .elementAt(reversedIndex)
                                        .istintDateTime!,
                                    attactment: interactionController
                                        .messageList
                                        .elementAt(reversedIndex)
                                        .istintAttachment!,
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
                    child: interactionController.isSending.value
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
                      interactionController.isMessageSending(true);
                      await sendMessage(
                        miId: widget.loginSuccessModel.mIID!,
                        amstId: widget.loginSuccessModel.amsTId!,
                        asmayId: widget.loginSuccessModel.asmaYId!,
                        message: textMessage.text,
                        istintComposedByFlg: widget.ismintComposedById,
                        ismintId: widget.ismintId,
                        userId: widget.loginSuccessModel.userId!,
                        image: interactionController.image,
                        roleId: widget.loginSuccessModel.roleId!,
                        base: baseUrlFromInsCode(
                            'portal', widget.mskoolController),
                      ).then(
                        (value) async {
                          if (value) {
                            await interactionController.getMessage(
                                ismintId: widget.ismintId,
                                miId: widget.loginSuccessModel.mIID!,
                                asmayId: widget.loginSuccessModel.asmaYId!,
                                userId: widget.loginSuccessModel.userId!,
                                base: baseUrlFromInsCode(
                                    'portal', widget.mskoolController),
                                ivrmrtId: widget.loginSuccessModel.roleId!);
                            textMessage.text = '';
                          }
                        },
                      );
                      interactionController.isMessageSending(false);
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
