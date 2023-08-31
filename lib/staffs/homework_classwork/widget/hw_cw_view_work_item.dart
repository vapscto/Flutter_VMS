import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/active_deactive.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/get_attachment_api.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/classwork_attachment_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/classwork_view_work_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/homework_attachment_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/homework_view_work_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/hw_cw_content_item.dart';
import 'package:m_skool_flutter/staffs/punch_report/widget/punch_report_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HwCwViewWorkItem extends StatelessWidget {
  final bool forHw;
  final ClassWorkViewWorkValues? classwork;
  final HomeWorkViewWorkValues? homeWork;
  final MskoolController mskoolController;
  final int miId;
  final Function() func;
  const HwCwViewWorkItem({
    Key? key,
    required this.color,
    required this.forHw,
    this.classwork,
    this.homeWork,
    required this.mskoolController,
    required this.miId,
    required this.func,
  }) : super(key: key);

  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: lighterColor.elementAt(color).withOpacity(0.3),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: forHw
                          ? homeWork!.ihWActiveFlag == null
                              ? Colors.grey.shade400
                              : homeWork!.ihWActiveFlag!
                                  ? Colors.green
                                  : Colors.grey.shade400
                          : classwork!.icWActiveFlag == null
                              ? Colors.grey.shade400
                              : classwork!.icWActiveFlag!
                                  ? Colors.green
                                  : Colors.grey.shade400,
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      forHw
                          ? homeWork!.ihWActiveFlag == null
                              ? "N/a"
                              : homeWork!.ihWActiveFlag!
                                  ? "Active"
                                  : "Deactive"
                          : classwork!.icWActiveFlag == null
                              ? "N/a"
                              : classwork!.icWActiveFlag!
                                  ? "Active"
                                  : "Deactive",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(TextStyle(
                            fontWeight: FontWeight.w600,
                            color: forHw
                                ? homeWork!.ihWActiveFlag == null
                                    ? Colors.grey.shade400
                                    : homeWork!.ihWActiveFlag!
                                        ? Colors.green
                                        : Colors.grey.shade400
                                : classwork!.icWActiveFlag == null
                                    ? Colors.grey.shade400
                                    : classwork!.icWActiveFlag!
                                        ? Colors.green
                                        : Colors.grey.shade400,
                          )),
                    ),
                  ],
                ),
                PopupMenuButton(itemBuilder: (_) {
                  List<PopupMenuEntry<dynamic>> menuList = [];
                  if (forHw) {
                    if (homeWork!.ihWActiveFlag == null) {
                      return [];
                    }
                    if (homeWork!.ihWActiveFlag!) {
                      menuList.add(PopupMenuItem(
                        child: const Text("Deactive"),
                        onTap: () async {
                          await ActiveDeactiveApi.instance.activeDeactiveHwNow(
                            miId: miId,
                            ihcId: homeWork!.ihWId ?? 0,
                            flag: 0,
                            base: baseUrlFromInsCode(
                              "portal",
                              mskoolController,
                            ),
                          );

                          func();
                        },
                      ));
                    } else {
                      menuList.add(PopupMenuItem(
                        child: const Text("Active"),
                        onTap: () async {
                          await ActiveDeactiveApi.instance.activeDeactiveHwNow(
                            miId: miId,
                            ihcId: homeWork!.ihWId ?? 0,
                            flag: 1,
                            base: baseUrlFromInsCode(
                              "portal",
                              mskoolController,
                            ),
                          );

                          func();
                        },
                      ));
                    }
                  } else {
                    if (classwork!.icWActiveFlag == null) {
                      return [];
                    }
                    if (classwork!.icWActiveFlag!) {
                      menuList.add(PopupMenuItem(
                        child: const Text("Deactive"),
                        onTap: () async {
                          await ActiveDeactiveApi.instance.activeDeactiveCw(
                            miId: miId,
                            ihcId: classwork!.icWId!,
                            flag: 0,
                            base: baseUrlFromInsCode(
                              "portal",
                              mskoolController,
                            ),
                          );

                          func();
                        },
                      ));
                    } else {
                      menuList.add(PopupMenuItem(
                        child: const Text("Active"),
                        onTap: () async {
                          await ActiveDeactiveApi.instance.activeDeactiveCw(
                            miId: miId,
                            ihcId: classwork!.icWId!,
                            flag: 1,
                            base: baseUrlFromInsCode(
                              "portal",
                              mskoolController,
                            ),
                          );

                          func();
                        },
                      ));
                    }
                  }

                  return menuList;
                })
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Chip(
                      backgroundColor: hwCwViewWorkColor.elementAt(color),
                      label: Text(
                        forHw
                            ? homeWork!.ihWDate == null
                                ? "N/A"
                                : getFormatedDate(
                                    DateTime.parse(homeWork!.ihWDate!))
                            : classwork!.icWFromDate == null ||
                                    classwork!.icWToDate == null
                                ? "N/A"
                                : "${getFormatedDate(DateTime.parse(classwork!.icWFromDate!))} to ${getFormatedDate(DateTime.parse(classwork!.icWToDate!))}",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                            TextStyle(color: noticeColor.elementAt(color))),
                      ),
                    ),
                    const SizedBox(
                      width: 12.00,
                    ),
                    Chip(
                      backgroundColor: hwCwViewWorkColor.elementAt(color),
                      label: Text(
                        forHw
                            ? "${homeWork!.asmcLClassName ?? "N/a"}-${homeWork!.asmCSectionName ?? "N/a"}"
                            : "${classwork!.asmcLClassName ?? "N/a"}-${classwork!.asmCSectionName ?? "N/a"}",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                            TextStyle(color: noticeColor.elementAt(color))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                PunchReportItem(
                  title: "Subject",
                  time: forHw
                      ? homeWork!.ismSSubjectName ?? "N/A"
                      : classwork!.ismSSubjectName ?? "N/A",
                ),
                const SizedBox(
                  height: 12.0,
                ),
                PunchReportItem(
                  title: "Topic",
                  time: forHw
                      ? homeWork!.ihWTopic ?? "N/A".toString()
                      : classwork!.icWTopic ?? "N/A".toString(),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                // PunchReportItem(
                //   title: "Chapter",
                //   time: forHw ? "N/A" : "${classwork!.icWAssignment} ",
                // ),
                // const SizedBox(
                //   height: 12.0,
                // ),
                PunchReportItem(
                  title: "Content",
                  time: forHw
                      ? "${homeWork!.ihWAssignment ?? "N/A"} "
                      : classwork!.icWContent ?? "N/A",
                ),
                // const SizedBox(
                //   height: 12.0,
                // ),
                // const PunchReportItem(
                //   title: "Url",
                //   time: "Url will come here",
                // ),
                const SizedBox(
                  height: 16.0,
                ),
                // HwCwContentItem(
                //     onDownloadClicked: () {

                //     },
                //     title: "View Attachment's",
                //     isPdf: false)

                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: InkWell(
                        onTap: () {
                          if (forHw) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Dialog(
                                    insetPadding: const EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 16.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Attachment's",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(
                                                      const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.0),
                                                    ),
                                              ),
                                              IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal:
                                                              VisualDensity
                                                                  .minimumDensity,
                                                          vertical: VisualDensity
                                                              .minimumDensity),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        FutureBuilder<
                                                List<
                                                    HomeWorkAttachmentModelValues>>(
                                            future: GetAttachmentApi.instance
                                                .getHomeWorkAttachment(
                                                    ihwId: homeWork!.ihWId!,
                                                    base: baseUrlFromInsCode(
                                                        "portal",
                                                        mskoolController)),
                                            builder: (_, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data!.isEmpty) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      AnimatedProgressWidget(
                                                        title:
                                                            "No Attachment Found",
                                                        desc:
                                                            "There are no attachment for this homework",
                                                        animationPath:
                                                            "assets/json/nodata.json",
                                                        animatorHeight: 250,
                                                      ),
                                                    ],
                                                  );
                                                }
                                                return ListView.separated(
                                                    shrinkWrap: true,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    itemBuilder: (_, index) {
                                                      return HwCwContentItem(
                                                        onDownloadClicked:
                                                            () async {
                                                          if (snapshot.data ==
                                                                  null ||
                                                              snapshot.data!
                                                                      .elementAt(
                                                                          index)
                                                                      .ihwatTAttachment ==
                                                                  null) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Attachment url is not available");
                                                            return;
                                                          }

                                                          if (isWebsite(snapshot
                                                              .data!
                                                              .elementAt(index)
                                                              .ihwatTAttachment!)) {
                                                            launchUrl(
                                                                Uri.parse(snapshot
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .ihwatTAttachment!),
                                                                mode: LaunchMode
                                                                    .externalApplication);
                                                            return;
                                                          }

                                                          SaveServiceNotification
                                                              .initializeNotification();
                                                          Navigator.pop(
                                                              context);
                                                          if (Platform.isIOS) {
                                                            Dio dio = Dio();
                                                            PermissionStatus
                                                                permissionStatus =
                                                                await Permission
                                                                    .storage
                                                                    .request();
                                                            Directory?
                                                                directory =
                                                                await getApplicationDocumentsDirectory();
                                                            String savePath =
                                                                "${directory.path}${Platform.pathSeparator}/Media/${snapshot.data!.elementAt(index).ihwatTAttachment!.split("/").last}";
                                                            await dio.download(
                                                              snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwatTAttachment!,
                                                              savePath,
                                                              onReceiveProgress:
                                                                  (count,
                                                                      total) {
                                                                SaveServiceNotification
                                                                    .showProgressNotification(
                                                                  total,
                                                                );
                                                              },
                                                            ).then((value) {
                                                              logger.d(
                                                                  value.data);
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "File downloaded successfully in your device");
                                                              SaveServiceNotification
                                                                  .showSaveNotification(
                                                                      directory
                                                                          .path,
                                                                      "File Downloaded",
                                                                      "You can tap here to view the file");
                                                            });
                                                          } else {
                                                            FileDownloader
                                                                .downloadFile(
                                                              url: snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwatTAttachment!,
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
                                                              },
                                                            );
                                                          }
                                                        },
                                                        title: snapshot.data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwatTFileName ??
                                                            "N/A",
                                                        isPdf: snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .ihwatTFileName ==
                                                                null
                                                            ? false
                                                            : snapshot.data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwatTFileName!
                                                                .endsWith(
                                                                    ".pdf"),
                                                        onViewClicked: () {
                                                          Navigator.pop(
                                                              context);
                                                          createPreview(
                                                              context,
                                                              snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwatTAttachment!);
                                                          // if (snapshot.data!
                                                          //     .elementAt(index)
                                                          //     .ihwatTAttachment!
                                                          //     .isVideoFileName) {
                                                          //   Navigator.push(
                                                          //       context,
                                                          //       MaterialPageRoute(
                                                          //           builder:
                                                          //               (_) {
                                                          //     return VideoScreen(
                                                          //         videoUrl: snapshot
                                                          //             .data!
                                                          //             .elementAt(
                                                          //                 index)
                                                          //             .ihwatTAttachment!);
                                                          //   }));
                                                          // } else {
                                                          //   Navigator.push(
                                                          //       context,
                                                          //       MaterialPageRoute(
                                                          //           builder:
                                                          //               (_) {
                                                          //     return AttachmentViewer(
                                                          //       loadFromRawData:
                                                          //           false,
                                                          //       url: snapshot
                                                          //           .data!
                                                          //           .elementAt(
                                                          //               index)
                                                          //           .ihwatTAttachment,
                                                          //     );
                                                          //   }));
                                                          // }
                                                        },
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (_, index) {
                                                      return const SizedBox(
                                                        height: 16.0,
                                                      );
                                                    },
                                                    itemCount:
                                                        snapshot.data!.length);
                                              }

                                              if (snapshot.hasError) {
                                                return ErrWidget(
                                                    err: snapshot.error as Map<
                                                        String, dynamic>);
                                              }

                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  AnimatedProgressWidget(
                                                      title:
                                                          "Loading Attachment",
                                                      desc:
                                                          "Please wait while we load attached files for you.",
                                                      animationPath:
                                                          "assets/json/default.json"),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Dialog(
                                    insetPadding: const EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 16.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Attachment's",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(
                                                      const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.0),
                                                    ),
                                              ),
                                              IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal:
                                                              VisualDensity
                                                                  .minimumDensity,
                                                          vertical: VisualDensity
                                                              .minimumDensity),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        FutureBuilder<
                                                List<
                                                    ClassWorkAttachmentModelValues>>(
                                            future: GetAttachmentApi.instance
                                                .getClassWorkAttachment(
                                                    icwId: classwork!.icWId!,
                                                    base: baseUrlFromInsCode(
                                                        "portal",
                                                        mskoolController)),
                                            builder: (_, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data!.isEmpty) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      AnimatedProgressWidget(
                                                        title: "No Attachment",
                                                        desc:
                                                            "There are no attachment.. try with another work",
                                                        animationPath:
                                                            "assets/json/nodata.json",
                                                        animatorHeight: 250,
                                                      ),
                                                    ],
                                                  );
                                                }

                                                return SizedBox(
                                                  height: Get.height * 0.4,
                                                  child: ListView.separated(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      itemBuilder: (_, index) {
                                                        return HwCwContentItem(
                                                          onDownloadClicked:
                                                              () async {
                                                            if (snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .icwatTAttachment ==
                                                                null) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "No attachment url found to download this file");
                                                              return;
                                                            }

                                                            if (isWebsite(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .icwatTAttachment!)) {
                                                              launchUrl(
                                                                  Uri.parse(snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .icwatTAttachment!),
                                                                  mode: LaunchMode
                                                                      .externalApplication);
                                                              return;
                                                            }

                                                            SaveServiceNotification
                                                                .initializeNotification();
                                                            Navigator.pop(
                                                                context);
                                                            if (Platform
                                                                .isIOS) {
                                                              Dio dio = Dio();
                                                              PermissionStatus
                                                                  permissionStatus =
                                                                  await Permission
                                                                      .storage
                                                                      .request();
                                                              Directory?
                                                                  directory =
                                                                  await getApplicationDocumentsDirectory();
                                                              String savePath =
                                                                  "${directory.path}${Platform.pathSeparator}/Media/${snapshot.data!.elementAt(index).icwatTAttachment!.split("/").last}";
                                                              await dio
                                                                  .download(
                                                                snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .icwatTAttachment!,
                                                                savePath,
                                                                onReceiveProgress:
                                                                    (count,
                                                                        total) {
                                                                  SaveServiceNotification
                                                                      .showProgressNotification(
                                                                    total,
                                                                  );
                                                                },
                                                              ).then((value) {
                                                                logger.d(
                                                                    value.data);
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "File downloaded successfully in your device");
                                                                SaveServiceNotification
                                                                    .showSaveNotification(
                                                                        directory
                                                                            .path,
                                                                        "File Downloaded",
                                                                        "You can tap here to view the file");
                                                              });
                                                            } else {
                                                              FileDownloader
                                                                  .downloadFile(
                                                                url: snapshot
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .icwatTAttachment!,
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
                                                                  logger
                                                                      .d(path);

                                                                  SaveServiceNotification
                                                                      .showSaveNotification(
                                                                          path!,
                                                                          "File Downloaded",
                                                                          "You can tap here to view the file");
                                                                },
                                                              );

                                                              // if (await canLaunchUrl(
                                                              //     Uri.parse(snapshot
                                                              //         .data!
                                                              //         .elementAt(
                                                              //             index)
                                                              //         .icwatTAttachment!))) {
                                                              //   await launchUrl(
                                                              //       Uri.parse(snapshot
                                                              //           .data!
                                                              //           .elementAt(
                                                              //               index)
                                                              //           .icwatTAttachment!),
                                                              //       mode: LaunchMode
                                                              //           .externalApplication);
                                                              // }
                                                            }
                                                          },
                                                          title: snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwatTFileName ??
                                                              "N/a",
                                                          isPdf: snapshot.data!
                                                                      .elementAt(
                                                                          index)
                                                                      .icwatTFileName ==
                                                                  null
                                                              ? false
                                                              : snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwatTFileName!
                                                                  .endsWith(
                                                                      ".pdf"),
                                                          onViewClicked: () {
                                                            if (snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .icwatTAttachment ==
                                                                null) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Unable to show preview, because file url is not available");
                                                              return;
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            createPreview(
                                                                context,
                                                                snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .icwatTAttachment!);
                                                            // if (snapshot.data!
                                                            //     .elementAt(
                                                            //         index)
                                                            //     .icwatTAttachment!
                                                            //     .isVideoFileName) {
                                                            //   Navigator.push(
                                                            //       context,
                                                            //       MaterialPageRoute(
                                                            //           builder:
                                                            //               (_) {
                                                            //     return VideoScreen(
                                                            //         videoUrl: snapshot
                                                            //             .data!
                                                            //             .elementAt(
                                                            //                 index)
                                                            //             .icwatTAttachment!);
                                                            //   }));
                                                            // } else {
                                                            //   Navigator.push(
                                                            //       context,
                                                            //       MaterialPageRoute(
                                                            //           builder:
                                                            //               (_) {
                                                            //     return AttachmentViewer(
                                                            //       loadFromRawData:
                                                            //           false,
                                                            //       url: snapshot
                                                            //           .data!
                                                            //           .elementAt(
                                                            //               index)
                                                            //           .icwatTAttachment,
                                                            //     );
                                                            //   }));
                                                            // }
                                                          },
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (_, index) {
                                                        return const SizedBox(
                                                          height: 16.0,
                                                        );
                                                      },
                                                      itemCount: snapshot
                                                          .data!.length),
                                                );
                                              }

                                              if (snapshot.hasError) {
                                                return ErrWidget(
                                                    err: snapshot.error as Map<
                                                        String, dynamic>);
                                              }
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  AnimatedProgressWidget(
                                                      title:
                                                          "Loading Attachment",
                                                      desc:
                                                          "Please wait while we load attached files for you.",
                                                      animationPath:
                                                          "assets/json/default.json"),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: CustomContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Icon(
                                  Icons.attachment,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                const Expanded(
                                    child: Text("View Attachment's")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 3, child: SizedBox())
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
