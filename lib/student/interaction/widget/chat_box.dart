import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/student/interaction/screen/show_image_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatBox extends StatelessWidget {
  final String name;
  final bool isFromMe;
  final String messages;
  final DateTime istintDateTime;
  final String attactment;
  final bool isGroup;
  const ChatBox(
      {required this.name,
      required this.isFromMe,
      required this.messages,
      required this.istintDateTime,
      required this.attactment,
      required this.isGroup,
      super.key});

  @override
  Widget build(BuildContext context) {
    Radius radius = const Radius.circular(10);
    Radius zero = const Radius.circular(0);
    Widget profile = CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(name[0].toUpperCase(),
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400)),
    );
    return Align(
      alignment: isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isFromMe) ...[profile, const SizedBox(width: 7)],
          Column(
            crossAxisAlignment:
                isFromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Stack(
              //   children: [

              Container(
                width: messages.length > 18
                    ? MediaQuery.of(context).size.width / 2
                    : null,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: isFromMe ? 25 : 10),
                decoration: BoxDecoration(
                    color: Color(isFromMe ? 0xffC1E2FF : 0xffEEEEEE),
                    borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                        bottomLeft: isFromMe ? radius : zero,
                        bottomRight: isFromMe ? zero : radius)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isFromMe && isGroup)
                      Text(
                        name,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    attactment.isNotEmpty
                        ? attactment.endsWith(".doc") ||
                                attactment.endsWith(".docx")
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/wordicon.png',
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      attactment.split("-").last,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        // launchUrl(Uri.parse(attactment),
                                        //     mode:
                                        //         LaunchMode.externalApplication);
                                        SaveServiceNotification
                                            .initializeNotification();

                                        if (Platform.isAndroid) {
                                          FileDownloader.downloadFile(
                                              url: attactment,
                                              onProgress: (name, progress) {
                                                SaveServiceNotification
                                                    .showProgressNotification(
                                                  progress,
                                                );
                                              },
                                              onDownloadCompleted:
                                                  (String? path) {
                                                // logger.d(path);

                                                SaveServiceNotification
                                                    .showSaveNotification(
                                                        path!,
                                                        "File Downloaded",
                                                        "You can tap here to view the file");
                                              });
                                        } else {
                                          Dio dio = Dio();
                                          PermissionStatus permissionStatus =
                                              await Permission.storage
                                                  .request();
                                          Directory? directory =
                                              await getApplicationDocumentsDirectory();
                                          String savePath =
                                              "${directory.path}${Platform.pathSeparator}/Media/${attactment.split("/").last}";
                                          await dio.download(
                                            attactment,
                                            savePath,
                                            onReceiveProgress:
                                                (count, total) async {
                                              await Future.delayed(
                                                  const Duration(seconds: 3));
                                              SaveServiceNotification
                                                  .showProgressNotification(
                                                total,
                                              );
                                            },
                                          ).then((value) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "File downloaded successfully");
                                            logger.d(value.data);
                                            SaveServiceNotification
                                                .showSaveNotification(
                                                    directory.path,
                                                    "File Downloaded",
                                                    "You can tap here to view the file");
                                          });
                                        }
                                      },
                                      child: const Icon(
                                        Icons.download,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : attactment.endsWith(".xls") ||
                                    attactment.endsWith(".xlsx")
                                ? SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/xlsicon.png',
                                          height: 40,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          attactment.split("-").last,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // launchUrl(Uri.parse(attactment),
                                            //     mode: LaunchMode
                                            //         .externalApplication);
                                            SaveServiceNotification
                                                .initializeNotification();

                                            if (Platform.isAndroid) {
                                              FileDownloader.downloadFile(
                                                  url: attactment,
                                                  onProgress: (name, progress) {
                                                    SaveServiceNotification
                                                        .showProgressNotification(
                                                      progress,
                                                    );
                                                  },
                                                  onDownloadCompleted:
                                                      (String? path) {
                                                    // logger.d(path);

                                                    SaveServiceNotification
                                                        .showSaveNotification(
                                                            path!,
                                                            "File Downloaded",
                                                            "You can tap here to view the file");
                                                  });
                                            } else {
                                              Dio dio = Dio();
                                              PermissionStatus
                                                  permissionStatus =
                                                  await Permission.storage
                                                      .request();
                                              Directory? directory =
                                                  await getApplicationDocumentsDirectory();
                                              String savePath =
                                                  "${directory.path}${Platform.pathSeparator}/Media/${attactment.split("/").last}";
                                              await dio.download(
                                                attactment,
                                                savePath,
                                                onReceiveProgress:
                                                    (count, total) {
                                                  SaveServiceNotification
                                                      .showProgressNotification(
                                                    total,
                                                  );
                                                },
                                              ).then((value) {
                                                logger.d(value.data);
                                                SaveServiceNotification
                                                    .showSaveNotification(
                                                        directory.path,
                                                        "File Downloaded",
                                                        "You can tap here to view the file");
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.download,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : attactment.endsWith(".pdf")
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/pdf.svg',
                                              height: 40,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Text(
                                              attactment.split("-").last,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // launchUrl(Uri.parse(attactment),
                                                //     mode: LaunchMode
                                                //         .externalApplication);
                                                SaveServiceNotification
                                                    .initializeNotification();

                                                if (Platform.isAndroid) {
                                                  FileDownloader.downloadFile(
                                                      url: attactment,
                                                      onProgress:
                                                          (name, progress) {
                                                        SaveServiceNotification
                                                            .showProgressNotification(
                                                          progress,
                                                        );
                                                      },
                                                      onDownloadCompleted:
                                                          (String? path) {
                                                        // logger.d(path);

                                                        SaveServiceNotification
                                                            .showSaveNotification(
                                                                path!,
                                                                "File Downloaded",
                                                                "You can tap here to view the file");
                                                      });
                                                } else {
                                                  Dio dio = Dio();
                                                  PermissionStatus
                                                      permissionStatus =
                                                      await Permission.storage
                                                          .request();
                                                  Directory? directory =
                                                      await getApplicationDocumentsDirectory();
                                                  String savePath =
                                                      "${directory.path}${Platform.pathSeparator}/Media/${attactment.split("/").last}";
                                                  await dio.download(
                                                    attactment,
                                                    savePath,
                                                    onReceiveProgress:
                                                        (count, total) {
                                                      SaveServiceNotification
                                                          .showProgressNotification(
                                                        total,
                                                      );
                                                    },
                                                  ).then((value) {
                                                    logger.d(value.data);
                                                    SaveServiceNotification
                                                        .showSaveNotification(
                                                            directory.path,
                                                            "File Downloaded",
                                                            "You can tap here to view the file");
                                                  });
                                                }
                                              },
                                              child: const Icon(
                                                Icons.download,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : attactment.endsWith(".ppt") ||
                                            attactment.endsWith(".pptx")
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/ppticon.png',
                                                  height: 40,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  attactment.split("-").last,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    // launchUrl(
                                                    //     Uri.parse(attactment),
                                                    //     mode: LaunchMode
                                                    //         .externalApplication);

                                                    SaveServiceNotification
                                                        .initializeNotification();

                                                    if (Platform.isAndroid) {
                                                      FileDownloader
                                                          .downloadFile(
                                                              url: attactment,
                                                              onProgress: (name,
                                                                  progress) {
                                                                SaveServiceNotification
                                                                    .showProgressNotification(
                                                                  progress,
                                                                );
                                                              },
                                                              onDownloadCompleted:
                                                                  (String?
                                                                      path) {
                                                                // logger.d(path);

                                                                SaveServiceNotification
                                                                    .showSaveNotification(
                                                                        path!,
                                                                        "File Downloaded",
                                                                        "You can tap here to view the file");
                                                              });
                                                    } else {
                                                      Dio dio = Dio();
                                                      PermissionStatus
                                                          permissionStatus =
                                                          await Permission
                                                              .storage
                                                              .request();
                                                      Directory? directory =
                                                          await getApplicationDocumentsDirectory();
                                                      String savePath =
                                                          "${directory.path}${Platform.pathSeparator}/Media/${attactment.split("/").last}";
                                                      await dio.download(
                                                        attactment,
                                                        savePath,
                                                        onReceiveProgress:
                                                            (count, total) {
                                                          SaveServiceNotification
                                                              .showProgressNotification(
                                                            total,
                                                          );
                                                        },
                                                      ).then((value) {
                                                        logger.d(value.data);
                                                        SaveServiceNotification
                                                            .showSaveNotification(
                                                                directory.path,
                                                                "File Downloaded",
                                                                "You can tap here to view the file");
                                                      });
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.download,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : attactment.endsWith(".jpg") ||
                                                attactment.endsWith(".jpeg") ||
                                                attactment.endsWith('.png') ||
                                                attactment.endsWith('.gif')
                                            ? InkWell(
                                                onTap: () {
                                                  Get.to(() => ShowImageScreen(
                                                        image: attactment,
                                                      ));
                                                },
                                                child: SizedBox(
                                                    height: 200,
                                                    width: 100,
                                                    child: Image.network(
                                                      attactment,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      fit: BoxFit.cover,
                                                    )),
                                              )
                                            : Row(
                                                children: [
                                                  const Icon(
                                                    Icons.file_copy,
                                                    size: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: Text(attactment
                                                          .split("-")
                                                          .last)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // launchUrl(
                                                      //     Uri.parse(attactment),
                                                      //     mode: LaunchMode
                                                      //         .externalApplication);
                                                      SaveServiceNotification
                                                          .initializeNotification();

                                                      FileDownloader
                                                          .downloadFile(
                                                              url: attactment,
                                                              onProgress: (name,
                                                                  progress) {
                                                                SaveServiceNotification
                                                                    .showProgressNotification(
                                                                  progress,
                                                                );
                                                              },
                                                              onDownloadCompleted:
                                                                  (String?
                                                                      path) {
                                                                logger.d(path);

                                                                SaveServiceNotification
                                                                    .showSaveNotification(
                                                                        path!,
                                                                        "File Downloaded",
                                                                        "You can tap here to view the file");
                                                              });
                                                    },
                                                    child: const Icon(
                                                        Icons.download),
                                                  ),
                                                ],
                                              )
                        : const SizedBox(),
                    if (messages.isNotEmpty) const SizedBox(height: 5),
                    Text(messages,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              // if (isFromMe)
              //   Positioned(
              //       right: 2,
              //       bottom: 2,
              //       child: SvgPicture.asset(
              //           "assets/svg/blue_double_check.svg"))
              //   ],
              // ),
              Text(
                convertToAgoShort(istintDateTime),
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          if (isFromMe) ...[const SizedBox(width: 7), profile],
        ],
      ),
    );
  }
}
