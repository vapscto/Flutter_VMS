import 'dart:io';
import 'dart:typed_data';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/vms/call_letter/api/call_letter_api.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CallLetterView extends StatelessWidget {
  final String name;
  final Uint8List? rawData;
  final MskoolController mskoolController;
  final String email;
  final LoginSuccessModel loginSuccessModel;
  // final String document;
  const CallLetterView({
    super.key,
    required this.name,
    this.rawData,
    required this.mskoolController,
    required this.email,
    required this.loginSuccessModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '$name Call Letter').getAppBar(),
      body: (rawData!.isNotEmpty)
          ? SfPdfViewer.memory(rawData!)
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: (rawData!.isNotEmpty)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: MSkollBtn(
                      title: "Send Mail",
                      onPress: () async {
                        PdfDocument document = PdfDocument(inputBytes: rawData);

                        PdfTextExtractor extractor = PdfTextExtractor(document);

                        String result = extractor.extractText(
                          layoutText: true,
                          startPageIndex: 0,
                        );
                        logger.w((result));
                        await CallLetterAPI.i.saveCallLetter(
                            base: baseUrlFromInsCode(
                                'recruitement', mskoolController),
                            body: {
                              "MI_Id": loginSuccessModel.mIID,
                              "HRCD_EmailId": email,
                              "UserId": loginSuccessModel.userId,
                              "Template": result
                            });
                      }),
                ),
                MSkollBtn(
                    title: "Download Now",
                    onPress: () async {
                      try {
                        if (Platform.isIOS) {
                          PermissionStatus permissionStatus =
                              await Permission.storage.request();
                          if (permissionStatus.isDenied) {
                            Fluttertoast.showToast(
                                msg:
                                    "You have denied to allow storage permission, can't save pdf");
                            return;
                          }
                          Directory? directory =
                              await getApplicationDocumentsDirectory();
                          // ignore: prefer_typing_uninitialized_variables
                          String savePath =
                              "${directory.path}${Platform.pathSeparator}/$name-call_letter.pdf";
                          File file =
                              await File(savePath).writeAsBytes(rawData!);
                          SaveServiceNotification.initializeNotification();
                          SaveServiceNotification.showSaveNotification(
                              file.path,
                              "Call Letter Saved",
                              "We have save Call Letter to your download folder, tap to view");

                          Fluttertoast.showToast(
                              msg:
                                  "File downloaded successfully in your device");
                        } else {
                          await DocumentFileSavePlus.saveFile(
                            rawData!,
                            name,
                            "application/pdf",
                          );
                          String filepath = await SaveServiceNotification
                              .getStoragePathAndSave(rawData!, name);
                          SaveServiceNotification.initializeNotification();
                          SaveServiceNotification.showSaveNotification(
                              filepath,
                              "Call Letter Saved",
                              "We have save Call Letter to your download folder, tap to view");
                          Fluttertoast.showToast(
                              msg: "Call Letter saved to download folder.");
                        }
                      } catch (e) {
                        logger.e(e.toString());
                        Fluttertoast.showToast(
                            msg: "Failed to generate Pdf.. Try again later");
                      }
                    }),
              ],
            )
          : const SizedBox(),
    );
  }
}
