import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/interaction/widget/vms_messaging.dart';

// ignore: must_be_immutable
class ChatWidgets extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String profileimage;
  final String title;
  final String designation;
  final DateTime ismintDateTime;
  final int ismintId;
  final int istintId;
  final int toId;
  final String sender;
  final String receiver;
  final bool isGroup;
  bool? isSeen;
  int hrmeId;

  final Function() getInboxFunction;
  ChatWidgets(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.profileimage,
      required this.title,
      required this.designation,
      required this.ismintDateTime,
      required this.ismintId,
      required this.istintId,
      required this.hrmeId,
      required this.toId,
      required this.sender,
      required this.receiver,
      required this.isGroup,
      this.isSeen,
      required this.getInboxFunction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        dense: true,
        onTap: () => Get.to(
          () => VMSMessagingScreen(
            ismintId: ismintId,
            istintId: istintId,
            ismintComposedById: hrmeId,
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            hrmeId: toId,
            isGroup: isGroup,
          ),
        )!
            .then((value) => getInboxFunction()),
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        leading: isGroup
            ? const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/group.png'),
              )
            : CircleAvatar(
                radius: 30,
                backgroundImage: profileimage.isNotEmpty
                    ? NetworkImage(profileimage.toString())
                    : const NetworkImage(
                        "https://img.icons8.com/fluency/48/null/user-male-circle.png"),
              ),
        title: Text(
          title,
          style:
              Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "",
          style: Get.textTheme.titleSmall,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                convertToAgo(ismintDateTime),
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(height: 10),
            hrmeId == toId
                ? Text(
                    'To : $receiver',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 10),
                  )
                : Text(
                    'From : $sender',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 10),
                  ),
          ],
        ),
      ),
    );
  }
}
