import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AttachmentViewer extends StatelessWidget {
  final String? url;
  final Uint8List? rawData;
  final bool loadFromRawData;
  const AttachmentViewer(
      {super.key, this.url, this.rawData, required this.loadFromRawData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Preview').getAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: loadFromRawData && rawData != null
            ? SfPdfViewer.memory(rawData!)
            : url!.isImageFileName
                ? InteractiveViewer(
                    child: Image.network(url!),
                  )
                : url!.isPDFFileName
                    ? SfPdfViewer.network(url!)
                    : Column(
                        children: [
                          Icon(
                            Icons.preview_outlined,
                            size: 36.0,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "No Preview Available",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.titleMedium!.merge(
                                      const TextStyle(fontSize: 18),
                                    ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "You can download this file to view the content inside it",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: MSkollBtn(
          title: "Download Now",
          onPress: () async {
            if (loadFromRawData) {
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
                  String savePath =
                      "${directory.path}${Platform.pathSeparator}/Media/document-${DateTime.now().millisecondsSinceEpoch}.pdf";
                  File file = await File(savePath).writeAsBytes(rawData!);
                  SaveServiceNotification.initializeNotification();
                  SaveServiceNotification.showSaveNotification(
                      file.path,
                      "document Saved",
                      "We have save document to your download folder, tap to view");

                  Fluttertoast.showToast(
                      msg: "File downloaded successfully in your device");
                } else {
                  await DocumentFileSavePlus.saveFile(
                    rawData!,
                    "document-${DateTime.now().millisecondsSinceEpoch}",
                    "application/pdf",
                  );
                  String filepath =
                      await SaveServiceNotification.getStoragePathAndSave(
                          rawData!, "document-");
                  SaveServiceNotification.initializeNotification();
                  SaveServiceNotification.showSaveNotification(
                      filepath,
                      "document Saved",
                      "We have save document to your download folder, tap to view");
                  Fluttertoast.showToast(
                      msg: "Document saved to download folder.");
                }
              } catch (e) {
                logger.e(e.toString());
                Fluttertoast.showToast(
                    msg: "Failed to generate Pdf.. Try again later");
              }
            } else {
              if (Platform.isIOS) {
                Dio dio = Dio();
                PermissionStatus permissionStatus =
                    await Permission.storage.request();
                if (permissionStatus.isDenied) {
                  Fluttertoast.showToast(
                      msg: "Unable to download, permission denied");
                  return;
                }
                Directory? directory = await getApplicationDocumentsDirectory();
                String savePath =
                    "${directory.path}${Platform.pathSeparator}/Media/${url!.split("/").last}";
                await dio.download(
                  url!,
                  savePath,
                  onReceiveProgress: (count, total) {
                    SaveServiceNotification.showProgressNotification(
                      total,
                    );
                  },
                ).then((value) {
                  logger.d(value.data);
                  Fluttertoast.showToast(
                      msg: "File downloaded successfully in your device");
                  SaveServiceNotification.showSaveNotification(directory.path,
                      "File Downloaded", "You can tap here to view the file");
                });
              } else {
                FileDownloader.downloadFile(
                    url: url!,
                    onProgress: (name, progress) {
                      SaveServiceNotification.showProgressNotification(
                        progress,
                      );
                    },
                    onDownloadCompleted: (String? path) {
                      // logger.d(path);

                      SaveServiceNotification.showSaveNotification(
                          path!,
                          "File Downloaded",
                          "You can tap here to view the file");
                    });
              }
            }
          },
        ),
      ),
    );
  }
}
