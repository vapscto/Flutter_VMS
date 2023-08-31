import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherAttachment extends StatelessWidget {
  final String attachmentUrl;
  final String attachmentName;
  const OtherAttachment({
    Key? key,
    required this.attachmentUrl,
    required this.attachmentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomContainer(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Text(
                            attachmentName,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.1,
        ),
        InkWell(
          onTap: () async {
            if (attachmentUrl.isEmpty) {
              // logger.d(values.iNTBFLFileName);
              // logger.d(values.iNTBFLFilePath);
              Fluttertoast.showToast(msg: "No File to download");
              return;
            }

            if (isWebsite(attachmentUrl)) {
              await launchUrl(Uri.parse(attachmentUrl),
                  mode: LaunchMode.externalApplication);
              return;
            }
            SaveServiceNotification.initializeNotification();
            if (Platform.isAndroid) {
              FileDownloader.downloadFile(
                  url: attachmentUrl,
                  onProgress: (name, progress) {
                    SaveServiceNotification.showProgressNotification(
                      progress,
                    );
                  },
                  onDownloadCompleted: (String? path) {
                    // logger.d(path);

                    Fluttertoast.showToast(
                        msg: "File downloaded successfully in your device");
                    SaveServiceNotification.showSaveNotification(path!,
                        "File Downloaded", "You can tap here to view the file");
                  });
            } else {
              Dio dio = Dio();
              PermissionStatus permissionStatus =
                  await Permission.storage.request();
              Directory? directory = await getApplicationDocumentsDirectory();
              String savePath =
                  "${directory.path}${Platform.pathSeparator}/Media/${attachmentUrl.split("/").last}";
              await dio.download(
                attachmentUrl,
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
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xFFD9EDFF)),
            child: SvgPicture.asset(
              "assets/svg/download.svg",
              height: 24.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
