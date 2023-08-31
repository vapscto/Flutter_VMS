import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/interaction/apis/messaging_api.dart';

import '../../../model/login_success_model.dart';
import '../model/message_model.dart';

class InteractionController extends GetxController {
  // RxBool isStudent = true.obs;
  // RxBool isGroup = true.obs;
  // onGroupTypeSelect(bool state) {
  //   isGroup.value = state;
  // }
  // onUserGroupType(bool state) {
  //   isStudent.value = state;
  // }

  // onIndividualGroupType(String user) {}
  var pickImage = ImagePicker();
  RxBool isMessage = RxBool(false);
  RxBool isSending = RxBool(false);
  RxList<String> image = <String>[].obs;

  void isMessageloading(bool loading) async {
    isMessage.value = loading;
  }

  void isMessageSending(bool loading) async {
    isSending.value = loading;
  }

  RxList<ViewMessageValue> messageList = <ViewMessageValue>[].obs;

  final List<XFile?> attachment = RxList();
  final List<PlatformFile> attFiles = RxList();

  void addMultipleAttachment(List<XFile?> att) {
    attachment.addAll(att);
  }

  void addToAttachment(XFile f) {
    attachment.add(f);
  }

  void removeAttachment(int index) {
    attachment.removeAt(index);
  }

  void addMultipleAttFiles(List<PlatformFile> att) {
    attFiles.addAll(att);
  }

  void addToFile(PlatformFile f) {
    attFiles.add(f);
  }

  void removeAtt(int index) {
    attFiles.removeAt(index);
  }

  Future<bool> getMessage(
      {required int ismintId,
      required int miId,
      required int asmayId,
      required int userId,
      required String base,
      required int ivrmrtId}) async {
    try {
      MessageModel? messageModel = await getMessages(
          ismintId: ismintId,
          miId: miId,
          asmayId: asmayId,
          userId: userId,
          base: base,
          ivrmrtId: ivrmrtId);

      if (messageModel!.viewmessage != null ||
          messageModel.viewmessage!.values != null) {
        messageList.clear();
        for (var i = 0; i < messageModel.viewmessage!.values!.length; i++) {
          messageList.add(messageModel.viewmessage!.values!.elementAt(i));
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.i(e.toString());
      return false;
    }
  }

  Future<bool> getFromCamera({required int miId, required String base}) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String? imageUrl = await jpgToNetworkImageUrl(
          image: pickedFile.path, miId: miId, base: base);
      image.add(imageUrl!);
      return true;
    }
    return false;
  }

  Future<List<String>> getFromGallery({
    required int miId,
    required String base,
    required BuildContext context,
    required LoginSuccessModel loginSuccessModel,
    required MskoolController mskoolController,
    required String sms,
    required int istintId,
    required int ismintId,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload Attachment's",
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  // InkWell(
                  //   onTap: () async {
                  //     Navigator.pop(context);
                  //     final XFile? xfile =
                  //         await pickImage.pickImage(source: ImageSource.camera);
                  //     if (xfile == null) {
                  //       Fluttertoast.showToast(msg: "No Image selected");
                  //       return;
                  //     }
                  //     addToAttachment(xfile);

                  //     String? imageUrl = await jpgToNetworkImageUrl(
                  //         image: xfile.path, miId: miId, base: base);
                  //     image.add(imageUrl!);

                  //     isMessageSending(true);
                  //     await sendMessage(
                  //       miId: loginSuccessModel.mIID!,
                  //       amstId: loginSuccessModel.amsTId!,
                  //       asmayId: loginSuccessModel.asmaYId!,
                  //       message: sms,
                  //       istintComposedByFlg: istintId,
                  //       ismintId: ismintId,
                  //       userId: loginSuccessModel.userId!,
                  //       image: image,
                  //       roleId: loginSuccessModel.roleId!,
                  //       base: baseUrlFromInsCode('portal', mskoolController),
                  //     ).then(
                  //       (value) async {
                  //         image.clear();
                  //         if (value) {
                  //           await getMessage(
                  //               ismintId: ismintId,
                  //               miId: loginSuccessModel.mIID!,
                  //               asmayId: loginSuccessModel.asmaYId!,
                  //               userId: loginSuccessModel.userId!,
                  //               base: baseUrlFromInsCode(
                  //                   'portal', mskoolController),
                  //               ivrmrtId: loginSuccessModel.roleId!);
                  //         }
                  //       },
                  //     );
                  //     image.clear();
                  //     isMessageSending(false);
                  //   },
                  //   child: Column(
                  //     children: [
                  //       CircleAvatar(
                  //         minRadius: 36.0,
                  //         backgroundColor: Theme.of(context).dividerColor,
                  //         child: Icon(
                  //           Icons.camera_alt,
                  //           size: 36.0,
                  //           color:
                  //               Theme.of(context).textTheme.titleMedium!.color,
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 8.0,
                  //       ),
                  //       const Text("Camera"),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 16.0,
                  // ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final List<XFile?> pickedImage =
                          await pickImage.pickMultiImage();
                      if (pickedImage.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "No Image selected for attachment");
                        return;
                      }
                      addMultipleAttachment(pickedImage);
                      for (var i = 0; i < pickedImage.length; i++) {
                        String? imageUrl = await jpgToNetworkImageUrl(
                            image: pickedImage.elementAt(i)!.path,
                            miId: miId,
                            base: base);
                        image.add(imageUrl!);
                        isMessageSending(true);

                        await sendMessage(
                          miId: loginSuccessModel.mIID!,
                          amstId: loginSuccessModel.amsTId!,
                          asmayId: loginSuccessModel.asmaYId!,
                          message: sms,
                          istintComposedByFlg: istintId,
                          ismintId: ismintId,
                          userId: loginSuccessModel.userId!,
                          image: image,
                          roleId: loginSuccessModel.roleId!,
                          base: baseUrlFromInsCode('portal', mskoolController),
                        ).then(
                          (value) async {
                            image.clear();
                            if (value) {
                              await getMessage(
                                  ismintId: ismintId,
                                  miId: loginSuccessModel.mIID!,
                                  asmayId: loginSuccessModel.asmaYId!,
                                  userId: loginSuccessModel.userId!,
                                  base: baseUrlFromInsCode(
                                      'portal', mskoolController),
                                  ivrmrtId: loginSuccessModel.roleId!);
                            }
                          },
                        );
                        image.clear();
                        isMessageSending(false);
                      }
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 36.0,
                          backgroundColor: Theme.of(context).dividerColor,
                          child: Icon(
                            Icons.image,
                            size: 36.0,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text("Gallery"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);

                      final FilePickerResult? pickerRes =
                          await FilePicker.platform.pickFiles(
                              dialogTitle: "Select Attachment's",
                              allowMultiple: true);

                      if (pickerRes == null) {
                        Fluttertoast.showToast(msg: "No File selected..");
                        return;
                      }

                      addMultipleAttFiles(pickerRes.files);

                      for (var i = 0; i < pickerRes.files.length; i++) {
                        String? imageUrl = await jpgToNetworkImageUrl(
                            image: pickerRes.files.elementAt(i).path!,
                            miId: miId,
                            base: base);
                        image.add(imageUrl!);
                        isMessageSending(true);

                        await sendMessage(
                          miId: loginSuccessModel.mIID!,
                          amstId: loginSuccessModel.amsTId!,
                          asmayId: loginSuccessModel.asmaYId!,
                          message: sms,
                          istintComposedByFlg: istintId,
                          ismintId: ismintId,
                          userId: loginSuccessModel.userId!,
                          image: image,
                          roleId: loginSuccessModel.roleId!,
                          base: baseUrlFromInsCode('portal', mskoolController),
                        ).then(
                          (value) async {
                            image.clear();
                            if (value) {
                              await getMessage(
                                  ismintId: ismintId,
                                  miId: loginSuccessModel.mIID!,
                                  asmayId: loginSuccessModel.asmaYId!,
                                  userId: loginSuccessModel.userId!,
                                  base: baseUrlFromInsCode(
                                      'portal', mskoolController),
                                  ivrmrtId: loginSuccessModel.roleId!);
                            }
                          },
                        );
                        image.clear();
                        isMessageSending(false);
                      }
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 36.0,
                          backgroundColor: Theme.of(context).dividerColor,
                          child: Icon(
                            Icons.document_scanner_outlined,
                            size: 36.0,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text("Others"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    logger.d(image);
    return image;
  }
}
