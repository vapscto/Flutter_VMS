import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/active_deactive_nb.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/get_attachment_api.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/nb_attachment_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/view_notice_data_model.dart';
import 'package:m_skool_flutter/staffs/punch_report/widget/punch_report_item.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/widget/hw_cw_content_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewNoticeCard extends StatelessWidget {
  final ViewNoticeDetailsModelValuesValues values;
  final String base;
  final int miId;
  final int userId;
  final int asmayId;
  final int ivrmrtId;
  final Function() func;
  const ViewNoticeCard({
    Key? key,
    required this.color,
    required this.values,
    required this.base,
    required this.func,
    required this.miId,
    required this.userId,
    required this.asmayId,
    required this.ivrmrtId,
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
                      color: values.intBActiveFlag == true
                          ? Colors.green
                          : Colors.grey.shade400,
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      values.intBActiveFlag == true ? "Active" : "Deactive",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(TextStyle(
                            fontWeight: FontWeight.w600,
                            color: values.intBActiveFlag == true
                                ? Colors.green
                                : Colors.grey.shade400,
                          )),
                    ),
                  ],
                ),
                PopupMenuButton(itemBuilder: (_) {
                  List<PopupMenuEntry> entries = [];
                  if (values.intBActiveFlag == true) {
                    entries.add(PopupMenuItem(
                      child: const Text("Deactive"),
                      onTap: () async {
                        await ActivateDeactivateNbApi.instance
                            .activateDeactivate(
                                base: base,
                                intBId: values.intBId!,
                                flag: false,
                                miId: miId);
                        func();
                      },
                    ));
                  } else {
                    entries.add(
                      PopupMenuItem(
                        child: const Text("Active"),
                        onTap: () async {
                          await ActivateDeactivateNbApi.instance
                              .activateDeactivate(
                                  base: base,
                                  intBId: values.intBId!,
                                  flag: true,
                                  miId: miId);
                          func();
                          func();
                        },
                      ),
                    );
                  }
                  return entries;
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
                        backgroundColor: noticeBackgroundColor.elementAt(color),
                        label: Text(
                          values.intBStartDate == null ||
                                  values.intBEndDate == null
                              ? "N/A"
                              : "${getFormatedDate(DateTime.parse(values.intBStartDate.toString())).substring(0, getFormatedDate(DateTime.parse(values.intBStartDate.toString())).length - 2).trim()} to ${getFormatedDate(DateTime.parse(values.intBEndDate.toString())).substring(0, getFormatedDate(DateTime.parse(values.intBEndDate.toString())).length - 2).trim()}",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(color: noticeColor.elementAt(color))),
                        )),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Chip(
                      backgroundColor: hwCwViewWorkColor.elementAt(color),
                      label: Row(
                        children: [
                          Text(
                            values.iNTBToStaffFlg == null ||
                                    values.iNTBToStaffFlg == false
                                ? ""
                                : "Staff",

                            // forHw
                            //     ? "${homeWork!.asmcLClassName!}-${homeWork!.asmCSectionName!}"
                            //     : "${classwork!.asmcLClassName!}-${classwork!.asmCSectionName!}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(TextStyle(
                                    color: noticeColor.elementAt(color))),
                          ),
                          Text(
                            values.iNTBToStudentFlg == null ||
                                    values.iNTBToStudentFlg == false
                                ? ""
                                : "Student",

                            // forHw
                            //     ? "${homeWork!.asmcLClassName!}-${homeWork!.asmCSectionName!}"
                            //     : "${classwork!.asmcLClassName!}-${classwork!.asmCSectionName!}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(TextStyle(
                                    color: noticeColor.elementAt(color))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  values.intBTitle ?? "N/A",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.2),
                      ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  values.intBDescription ?? "N/A",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.2),
                      ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                PunchReportItem(
                  title: "Start Date",
                  time: values.intBStartDate == null
                      ? "N/A"
                      : "${DateTime.parse(values.intBStartDate!).day}-${DateTime.parse(values.intBStartDate!).month}-${DateTime.parse(values.intBStartDate!).year}",
                ),
                const SizedBox(
                  height: 12.0,
                ),
                PunchReportItem(
                  title: "End Date",
                  time: values.intBEndDate == null
                      ? "N/A"
                      : "${DateTime.parse(values.intBEndDate!).day}-${DateTime.parse(values.intBEndDate!).month}-${DateTime.parse(values.intBEndDate!).year}",
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: InkWell(
                        onTap: () {
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
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.only(
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
                                              List<NBAttachmentModelValues>>(
                                          future: GetNbAttachmentApi.instance
                                              .getNbAtt(
                                            intbId: values.intBId!,
                                            base: base,
                                          ),
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
                                                          "For this particular notice there is no attachment",
                                                      animationPath:
                                                          "assets/json/nodata.json",
                                                      animatorHeight: 250,
                                                    ),
                                                  ],
                                                );
                                              }
                                              return ListView.separated(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  shrinkWrap: true,
                                                  itemBuilder: (_, index) {
                                                    return HwCwUploadedContentItem(
                                                      onDownloadClicked:
                                                          () async {
                                                        if (isWebsite(snapshot
                                                            .data!
                                                            .elementAt(index)
                                                            .intbfLFilePath!)) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .intbfLFilePath!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                          return;
                                                        }

                                                        SaveServiceNotification
                                                            .initializeNotification();
                                                        Navigator.pop(context);

                                                        FileDownloader
                                                            .downloadFile(
                                                          url: snapshot.data!
                                                              .elementAt(index)
                                                              .intbfLFilePath!,
                                                          onProgress:
                                                              (name, progress) {
                                                            SaveServiceNotification
                                                                .showProgressNotification(
                                                              progress,
                                                            );
                                                          },
                                                          onDownloadCompleted:
                                                              (String? path) {
                                                            logger.d(path);

                                                            SaveServiceNotification
                                                                .showSaveNotification(
                                                                    path!,
                                                                    "File Downloaded",
                                                                    "You can tap here to view the file");
                                                          },
                                                        );
                                                      },
                                                      title: snapshot.data!
                                                          .elementAt(index)
                                                          .intbfLFileName!,
                                                      isPdf: snapshot.data!
                                                          .elementAt(index)
                                                          .intbfLFileName!
                                                          .endsWith(".pdf"),
                                                      onViewClicked: () async {
                                                        Navigator.pop(context);

                                                        createPreview(
                                                            context,
                                                            snapshot.data!
                                                                .elementAt(
                                                                    index)
                                                                .intbfLFilePath!);

                                                        // showDialog(
                                                        //     context: context,
                                                        //     builder: (_) {
                                                        //       return Dialog(
                                                        //         insetPadding:
                                                        //             const EdgeInsets
                                                        //                     .all(
                                                        //                 16.0),
                                                        //         shape: RoundedRectangleBorder(
                                                        //             borderRadius:
                                                        //                 BorderRadius.circular(
                                                        //                     12.0)),
                                                        //         child: Column(
                                                        //           mainAxisSize:
                                                        //               MainAxisSize
                                                        //                   .min,
                                                        //           children: [
                                                        //             Container(
                                                        //               width: double
                                                        //                   .infinity,
                                                        //               padding: const EdgeInsets
                                                        //                       .symmetric(
                                                        //                   horizontal:
                                                        //                       16.0,
                                                        //                   vertical:
                                                        //                       16.0),
                                                        //               decoration:
                                                        //                   BoxDecoration(
                                                        //                 color: Theme.of(context)
                                                        //                     .primaryColor,
                                                        //                 borderRadius:
                                                        //                     const BorderRadius.only(
                                                        //                   topLeft:
                                                        //                       Radius.circular(8.0),
                                                        //                   topRight:
                                                        //                       Radius.circular(8.0),
                                                        //                 ),
                                                        //               ),
                                                        //               child:
                                                        //                   Row(
                                                        //                 mainAxisAlignment:
                                                        //                     MainAxisAlignment.spaceBetween,
                                                        //                 children: [
                                                        //                   Text(
                                                        //                     "Sent To",
                                                        //                     style: Theme.of(context).textTheme.titleSmall!.merge(
                                                        //                           const TextStyle(color: Colors.white, fontSize: 18.0),
                                                        //                         ),
                                                        //                   ),
                                                        //                   IconButton(
                                                        //                       padding: const EdgeInsets.all(0),
                                                        //                       visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                                                        //                       onPressed: () {
                                                        //                         Navigator.pop(context);
                                                        //                       },
                                                        //                       icon: const Icon(
                                                        //                         Icons.close,
                                                        //                         color: Colors.white,
                                                        //                       ))
                                                        //                 ],
                                                        //               ),
                                                        //             ),
                                                        //             FutureBuilder<
                                                        //                     List<
                                                        //                         NoticeRecordModelValues>>(
                                                        //                 future: GetNbAttachmentApi
                                                        //                     .instance
                                                        //                     .getSentList(
                                                        //                   base:
                                                        //                       base,
                                                        //                   asmayId:
                                                        //                       asmayId,
                                                        //                   intbId:
                                                        //                       values.intBId!,
                                                        //                   ivrmrtId:
                                                        //                       ivrmrtId,
                                                        //                   miId:
                                                        //                       miId,
                                                        //                   staffFlag:
                                                        //                       values.iNTBToStaffFlg ?? false,
                                                        //                   stuFlag:
                                                        //                       values.iNTBToStudentFlg ?? false,
                                                        //                   userId:
                                                        //                       userId,
                                                        //                 ),
                                                        //                 builder:
                                                        //                     (_, snapshot) {
                                                        //                   if (snapshot
                                                        //                       .hasData) {
                                                        //                     if (snapshot.data!.isEmpty) {
                                                        //                       return Column(
                                                        //                         mainAxisSize: MainAxisSize.min,
                                                        //                         children: const [
                                                        //                           AnimatedProgressWidget(
                                                        //                             title: "No SentList Found",
                                                        //                             desc: "For this particular notice there is no SentList",
                                                        //                             animationPath: "assets/json/nodata.json",
                                                        //                             animatorHeight: 250,
                                                        //                           ),
                                                        //                         ],
                                                        //                       );
                                                        //                     }
                                                        //                     return Expanded(
                                                        //                       child: ListView.separated(
                                                        //                           padding: const EdgeInsets.all(12.0),
                                                        //                           shrinkWrap: true,
                                                        //                           itemBuilder: (_, index) {
                                                        //                             return ListTile(
                                                        //                               title: Text("Class : ${snapshot.data!.elementAt(index).aSMCLClassName}"),
                                                        //                               subtitle: Text("Section: ${snapshot.data!.elementAt(index).aSMCSectionName}"),
                                                        //                             );
                                                        //                           },
                                                        //                           separatorBuilder: (context, index) {
                                                        //                             return const SizedBox(
                                                        //                               height: 12.0,
                                                        //                             );
                                                        //                           },
                                                        //                           itemCount: snapshot.data!.length),
                                                        //                     );
                                                        //                   }
                                                        //                   if (snapshot
                                                        //                       .hasError) {
                                                        //                     return ErrWidget(err: snapshot.error as Map<String, dynamic>);
                                                        //                   }
                                                        //                   return Column(
                                                        //                     mainAxisSize:
                                                        //                         MainAxisSize.min,
                                                        //                     children: const [
                                                        //                       AnimatedProgressWidget(
                                                        //                         title: "Loading Sent list",
                                                        //                         desc: "We are loading to whom this attachment is sent",
                                                        //                         animationPath: "assets/json/default.json",
                                                        //                       ),
                                                        //                     ],
                                                        //                   );
                                                        //                 }),
                                                        //           ],
                                                        //         ),
                                                        //       );
                                                        //     });
                                                      },
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox(
                                                      height: 12.0,
                                                    );
                                                  },
                                                  itemCount:
                                                      snapshot.data!.length);
                                            }
                                            if (snapshot.hasError) {
                                              return ErrWidget(
                                                  err: snapshot.error
                                                      as Map<String, dynamic>);
                                            }
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                AnimatedProgressWidget(
                                                  title: "Loading Attachment",
                                                  desc:
                                                      "We are loading attachment for this particular notice",
                                                  animationPath:
                                                      "assets/json/default.json",
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CustomContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attachment,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                const Expanded(
                                  child: Text("View Attachment"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 3, child: SizedBox())
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
