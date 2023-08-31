import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_classwork_attachment_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_homework_attachment_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_student_attachment_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/upload_hw.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/controller/pick_image_controller.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/cw_student_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/hw_student_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/images_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_hw_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/widget/hw_cw_content_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyHwCwItem extends StatefulWidget {
  final Color color;
  final VerifyHwListModelValues? model;
  final VerifyClassworkListValues? cwList;
  final LoginSuccessModel loginSuccessModel;
  final TextEditingController marks;
  final PickImageController imageController;
  final RxBool selectAll;
  final Function(bool) onSelect;

  const VerifyHwCwItem({
    Key? key,
    required this.forHw,
    required this.color,
    this.model,
    required this.miId,
    required this.base,
    required this.loginSuccessModel,
    required this.asmayId,
    this.cwList,
    required this.marks,
    required this.imageController,
    required this.selectAll,
    required this.onSelect,
  }) : super(key: key);

  final bool forHw;
  final int miId;
  final String base;
  final int asmayId;

  @override
  State<VerifyHwCwItem> createState() => _VerifyHwCwItemState();
}

class _VerifyHwCwItemState extends State<VerifyHwCwItem> {
  RxBool isSelected = RxBool(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RxBool select =
        widget.selectAll.value ? RxBool(widget.selectAll.value) : RxBool(false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: widget.color),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Checkbox(
                  value: select.value,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)),
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (b) {
                    select.value = b!;
                    widget.onSelect(b);
                  },
                );
              }),
              Expanded(
                flex: 8,
                child: Column(children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 36.0,
                        backgroundImage: NetworkImage(
                          widget.forHw
                              ? widget.model!.aMSTPhotoname ??
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                              : widget.cwList!.aMSTPhotoname ??
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.forHw
                                  ? widget.model!.studentname ?? "N/a"
                                  : widget.cwList!.studentname ?? "N/a",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0)),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              widget.forHw
                                  ? widget.model!.amstAdmno ?? "N/a"
                                  : widget.cwList!.amstAdmno ?? "N/a",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .merge(TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .color,
                                      fontSize: 14.0,
                                      letterSpacing: 0.2)),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ]),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: widget.marks,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            fontSize: 20.0,
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
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
                              borderRadius: BorderRadius.circular(16.0),
                            ),
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
                                          padding: const EdgeInsets.all(0),
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
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
                                widget.forHw
                                    ? FutureBuilder<
                                            List<HwStuAttachmentModelValues>>(
                                        future: GetStudentAttachmentApi.instance
                                            .getHomeWorkUploads(
                                                miId: widget.miId,
                                                loginId: widget
                                                    .loginSuccessModel.userId!,
                                                asmayId: widget.asmayId,
                                                userId: widget
                                                    .loginSuccessModel.userId!,
                                                amstId: widget.model!.aMSTId!,
                                                iHwuplId:
                                                    widget.model!.iHWUPLId!,
                                                iHwId: widget.model!.iHWId!,
                                                base: widget.base),
                                        builder: (_, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data!.isEmpty) {
                                              return Column(
                                                children: const [
                                                  AnimatedProgressWidget(
                                                    title: "No Attachment",
                                                    desc:
                                                        "There is no attachment for this item",
                                                    animationPath:
                                                        "assets/json/nodata.json",
                                                    animatorHeight: 250,
                                                  ),
                                                ],
                                              );
                                            }
                                            return Expanded(
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  itemBuilder: (_, index) {
                                                    // if (snapshot.data!
                                                    //         .elementAt(index)
                                                    //         .ihwupLFileName ==
                                                    //     null) {
                                                    //   return;
                                                    // }
                                                    if (snapshot.data!
                                                        .elementAt(index)
                                                        .ihwupLFileName!
                                                        .endsWith(".pdf")) {
                                                      return HwCwUploadedContentItem(
                                                        onViewClicked:
                                                            () async {
                                                          // if (await canLaunchUrl(
                                                          //     Uri.parse(snapshot
                                                          //         .data!
                                                          //         .elementAt(
                                                          //             index)
                                                          //         .ihwupLAttachment!))) {
                                                          //   await launchUrl(
                                                          //       Uri.parse(snapshot
                                                          //           .data!
                                                          //           .elementAt(
                                                          //               index)
                                                          //           .ihwupLAttachment!),
                                                          //       mode: LaunchMode
                                                          //           .externalApplication);
                                                          // }
                                                          createPreview(
                                                              context,
                                                              snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment!);
                                                        },
                                                        onDownloadClicked:
                                                            () async {
                                                          if (snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment ==
                                                              null) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "No link available to download");
                                                          }
                                                          if (isWebsite(snapshot
                                                              .data!
                                                              .elementAt(index)
                                                              .ihwupLAttachment!)) {
                                                            await launchUrl(
                                                                Uri.parse(snapshot
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .ihwupLAttachment!),
                                                                mode: LaunchMode
                                                                    .externalApplication);
                                                            return;
                                                          }

                                                          SaveServiceNotification
                                                              .initializeNotification();

                                                          FileDownloader
                                                              .downloadFile(
                                                                  url: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .ihwupLAttachment!,
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

                                                                    SaveServiceNotification.showSaveNotification(
                                                                        path!,
                                                                        "File Downloaded",
                                                                        "You can tap here to view the file");
                                                                  });
                                                        },
                                                        title: snapshot.data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwupLFileName ??
                                                            "N/a",
                                                        isPdf: true,
                                                      );
                                                    }
                                                    return HwCwUploadedContentItem(
                                                        onViewClicked:
                                                            () async {
                                                          createPreview(
                                                              context,
                                                              snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment!);
                                                        },
                                                        onDownloadClicked:
                                                            () async {
                                                          if (snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment ==
                                                              null) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "No link available to download");
                                                            return;
                                                          }

                                                          SaveServiceNotification
                                                              .initializeNotification();

                                                          FileDownloader
                                                              .downloadFile(
                                                                  url: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .ihwupLAttachment!,
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

                                                                    SaveServiceNotification.showSaveNotification(
                                                                        path!,
                                                                        "File Downloaded",
                                                                        "You can tap here to view the file");
                                                                  });
                                                          // if (await canLaunchUrl(
                                                          //     Uri.parse(snapshot
                                                          //         .data!
                                                          //         .elementAt(
                                                          //             index)
                                                          //         .ihwupLAttachment!))) {
                                                          //   await launchUrl(
                                                          //       Uri.parse(snapshot
                                                          //           .data!
                                                          //           .elementAt(
                                                          //               index)
                                                          //           .ihwupLAttachment!),
                                                          //       mode: LaunchMode
                                                          //           .externalApplication);
                                                          // }
                                                        },
                                                        title: snapshot.data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwupLFileName ??
                                                            "N/a",
                                                        isPdf: false);
                                                  },
                                                  separatorBuilder: (_, index) {
                                                    return const SizedBox(
                                                      height: 16.0,
                                                    );
                                                  },
                                                  itemCount:
                                                      snapshot.data!.length),
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return ErrWidget(
                                                err: snapshot.error
                                                    as Map<String, dynamic>);
                                          }
                                          return const AnimatedProgressWidget(
                                            animationPath:
                                                "assets/json/default.json",
                                            title: "Loading attachment",
                                            desc:
                                                'Student uploaded files will appear here..',
                                          );
                                        })
                                    : FutureBuilder<
                                            List<CwStuAttachmentModelValues>>(
                                        future: GetStudentAttachmentApi.instance
                                            .getClassWorkUploads(
                                                miId: widget.miId,
                                                loginId: widget
                                                    .loginSuccessModel.userId!,
                                                asmayId: widget.asmayId,
                                                userId: widget
                                                    .loginSuccessModel.userId!,
                                                amstId: widget.cwList!.aMSTId!,
                                                icwuplId:
                                                    widget.cwList!.iCWUPLId!,
                                                icwId: widget.cwList!.iCWId!,
                                                base: widget.base),
                                        builder: (_, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data!.isEmpty) {
                                              return Column(
                                                children: const [
                                                  AnimatedProgressWidget(
                                                    title: "No Attachment",
                                                    desc:
                                                        "There is no attachment for this item",
                                                    animationPath:
                                                        "assets/json/nodata.json",
                                                    animatorHeight: 250,
                                                  ),
                                                ],
                                              );
                                            }
                                            return Expanded(
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  itemBuilder: (_, index) {
                                                    if (snapshot.data!
                                                        .elementAt(index)
                                                        .icwupLFileName!
                                                        .endsWith(".pdf")) {
                                                      return HwCwUploadedContentItem(
                                                        onViewClicked:
                                                            () async {
                                                          // if (await canLaunchUrl(
                                                          //     Uri.parse(snapshot
                                                          //         .data!
                                                          //         .elementAt(
                                                          //             index)
                                                          //         .icwupLAttachment!))) {
                                                          //   await launchUrl(
                                                          //       Uri.parse(snapshot
                                                          //           .data!
                                                          //           .elementAt(
                                                          //               index)
                                                          //           .icwupLAttachment!),
                                                          //       mode: LaunchMode
                                                          //           .externalApplication);
                                                          // }
                                                          createPreview(
                                                              context,
                                                              snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwupLAttachment!);
                                                        },
                                                        onDownloadClicked:
                                                            () async {
                                                          // if (await canLaunchUrl(
                                                          //     Uri.parse(snapshot
                                                          //         .data!
                                                          //         .elementAt(
                                                          //             index)
                                                          //         .icwupLAttachment!))) {
                                                          //   await launchUrl(
                                                          //       Uri.parse(snapshot
                                                          //           .data!
                                                          //           .elementAt(
                                                          //               index)
                                                          //           .icwupLAttachment!),
                                                          //       mode: LaunchMode
                                                          //           .externalApplication);
                                                          // }

                                                          SaveServiceNotification
                                                              .initializeNotification();

                                                          FileDownloader
                                                              .downloadFile(
                                                                  url: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .icwupLAttachment!,
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

                                                                    SaveServiceNotification.showSaveNotification(
                                                                        path!,
                                                                        "File Downloaded",
                                                                        "You can tap here to view the file");
                                                                  });
                                                        },
                                                        title: snapshot.data!
                                                            .elementAt(index)
                                                            .icwupLAttachment!,
                                                        isPdf: true,
                                                      );
                                                    }
                                                    return HwCwUploadedContentItem(
                                                        onViewClicked:
                                                            () async {
                                                          // if ([
                                                          //   ".jpg",
                                                          //   ".png",
                                                          //   ".jpeg",
                                                          //   ".gif",
                                                          // ].contains(p.extension(
                                                          //     "snapshot.data.elementAt(index).ihwupLAttachment"))) {
                                                          //   Navigator.push(
                                                          //       context,
                                                          //       MaterialPageRoute(
                                                          //           builder: (_) => ViewImage(
                                                          //               image: snapshot
                                                          //                   .data!
                                                          //                   .elementAt(index)
                                                          //                   .icwupLAttachment!)));
                                                          //   return;
                                                          // }
                                                          // if (await canLaunchUrl(
                                                          //     Uri.parse(snapshot
                                                          //         .data!
                                                          //         .elementAt(
                                                          //             index)
                                                          //         .icwupLAttachment!))) {
                                                          //   await launchUrl(
                                                          //       Uri.parse(snapshot
                                                          //           .data!
                                                          //           .elementAt(
                                                          //               index)
                                                          //           .icwupLAttachment!),
                                                          //       mode: LaunchMode
                                                          //           .externalApplication);
                                                          // }
                                                          createPreview(
                                                              context,
                                                              snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwupLAttachment!);
                                                        },
                                                        onDownloadClicked:
                                                            () async {
                                                          // if (await canLaunchUrl(
                                                          //     Uri.parse(snapshot
                                                          //         .data!
                                                          //         .elementAt(
                                                          //             index)
                                                          //         .icwupLAttachment!))) {
                                                          //   await launchUrl(
                                                          //       Uri.parse(snapshot
                                                          //           .data!
                                                          //           .elementAt(
                                                          //               index)
                                                          //           .icwupLAttachment!),
                                                          //       mode: LaunchMode
                                                          //           .externalApplication);
                                                          // }
                                                          SaveServiceNotification
                                                              .initializeNotification();

                                                          FileDownloader
                                                              .downloadFile(
                                                                  url: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .icwupLAttachment!,
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

                                                                    SaveServiceNotification.showSaveNotification(
                                                                        path!,
                                                                        "File Downloaded",
                                                                        "You can tap here to view the file");
                                                                  });
                                                        },
                                                        title: snapshot.data!
                                                                .elementAt(
                                                                    index)
                                                                .icwupLFileName ??
                                                            "N/a",
                                                        isPdf: false);
                                                  },
                                                  separatorBuilder: (_, index) {
                                                    return const SizedBox(
                                                      height: 16.0,
                                                    );
                                                  },
                                                  itemCount:
                                                      snapshot.data!.length),
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return ErrWidget(
                                                err: snapshot.error
                                                    as Map<String, dynamic>);
                                          }
                                          return const AnimatedProgressWidget(
                                            animationPath:
                                                "assets/json/default.json",
                                            title: "Loading attachment",
                                            desc:
                                                'Student uploaded files will appear here..',
                                          );
                                        })
                              ],
                            ),
                          );
                        });
                  },
                  child: CustomContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attachment_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "View Attachment's",
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 3, child: SizedBox())
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          // HwCwUploadedContentItem(
          //   onViewClicked: () {},
          //   onDownloadClicked: () {},
          //   isPdf: false,
          //   title: 'Eye Diagram',
          // ),
          // const SizedBox(
          //   height: 12.0,
          // ),
          // HwCwUploadedContentItem(
          //   onViewClicked: () {},
          //   onDownloadClicked: () {},
          //   isPdf: false,
          //   title: 'Intestine Description',
          // ),
          // const SizedBox(
          //   height: 12.0,
          // ),
          // HwCwUploadedContentItem(
          //   onViewClicked: () {},
          //   onDownloadClicked: () {},
          //   isPdf: true,
          //   title: 'Human eye',
          // ),
          // const SizedBox(
          //   height: 16.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                AnimatedProgressWidget(
                                    title: "Loading Your upload's",
                                    desc:
                                        "Please wait we are loading upload's for you.. after that download will start",
                                    animationPath: "assets/json/default.json")
                              ],
                            ),
                          ),
                        );
                      });

                  if (widget.forHw) {
                    GetHomeworkAttachmentApi.instance
                        .getHwAttachedFile(
                            iHwId: widget.model!.iHWId!,
                            miId: widget.miId,
                            base: widget.base)
                        .then((value) async {
                      Navigator.pop(context);
                      SaveServiceNotification.initializeNotification();

                      if (Platform.isAndroid) {
                        FileDownloader.downloadFile(
                            url: value.first.ihwatTAttachment!,
                            onProgress: (name, progress) {
                              SaveServiceNotification.showProgressNotification(
                                progress,
                              );
                            },
                            onDownloadCompleted: (String? path) {
                              // logger.d(path);

                              Fluttertoast.showToast(
                                  msg:
                                      "File downloaded successfully in your device");
                              SaveServiceNotification.showSaveNotification(
                                  path!,
                                  "File Downloaded",
                                  "You can tap here to view the file");
                            });
                      } else {
                        Dio dio = Dio();

                        PermissionStatus permissionStatus =
                            await Permission.storage.request();

                        Directory? directory =
                            await getApplicationDocumentsDirectory();

                        String savePath =
                            "${directory.path}${Platform.pathSeparator}/Media/${value.first.ihwatTAttachment!.split("/").last}";
                        await dio.download(
                          value.first.ihwatTAttachment!,
                          savePath,
                          onReceiveProgress: (count, total) {
                            SaveServiceNotification.showProgressNotification(
                              total,
                            );
                          },
                        ).then((value) {
                          logger.d(value.data);
                          Fluttertoast.showToast(
                              msg:
                                  "File downloaded successfully in your device");
                          SaveServiceNotification.showSaveNotification(
                              directory.path,
                              "File Downloaded",
                              "You can tap here to view the file");
                        });
                      }
                      // if (await canLaunchUrl(
                      //     Uri.parse(value.first.ihwatTAttachment!))) {
                      //   await launchUrl(
                      //       Uri.parse(value.first.ihwatTAttachment!),
                      //       mode: LaunchMode.externalApplication);
                      //   return;
                      // }
                      // Fluttertoast.showToast(
                      //     msg:
                      //         "No Specific application found to view this file");
                    });
                  } else {
                    GetClassworkAttachmentApi.instance
                        .getAttachedFiles(
                            miId: widget.miId,
                            base: widget.base,
                            asmayId: widget.asmayId,
                            iCwId: widget.cwList!.iCWId!,
                            userId: widget.loginSuccessModel.userId!)
                        .then((value) async {
                      Navigator.pop(context);
                      SaveServiceNotification.initializeNotification();

                      FileDownloader.downloadFile(
                          url: value.first.icwatTAttachment!,
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
                      // if (await canLaunchUrl(
                      //     Uri.parse(value.first.icwatTAttachment!))) {
                      //   await launchUrl(
                      //       Uri.parse(value.first.icwatTAttachment!),
                      //       mode: LaunchMode.externalApplication);
                      //   return;
                      // }
                      // Fluttertoast.showToast(
                      //     msg:
                      //         "No Specific application found to view this file");
                    });
                  }
                  // showDialog(
                  //     context: context,
                  //     builder: (_) {
                  //       return Dialog(
                  //         insetPadding: const EdgeInsets.all(16.0),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(8.0),
                  //         ),
                  //         child: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Container(
                  //               width: double.infinity,
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 16.0, vertical: 16.0),
                  //               decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColor,
                  //                 borderRadius: const BorderRadius.only(
                  //                   topLeft: Radius.circular(8.0),
                  //                   topRight: Radius.circular(8.0),
                  //                 ),
                  //               ),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     "Uploaded Files",
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .titleSmall!
                  //                         .merge(
                  //                           const TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 18.0),
                  //                         ),
                  //                   ),
                  //                   IconButton(
                  //                       padding: const EdgeInsets.all(0),
                  //                       visualDensity: const VisualDensity(
                  //                           horizontal:
                  //                               VisualDensity.minimumDensity,
                  //                           vertical:
                  //                               VisualDensity.minimumDensity),
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
                  //             widget.forHw
                  //                 ? FutureBuilder<
                  //                         List<HwAttachmentModelValues>>(
                  //                     future: GetHomeworkAttachmentApi.instance
                  //                         .getHwAttachedFile(
                  //                             iHwId: widget.model!.iHWId!,
                  //                             miId: widget.miId,
                  //                             base: widget.base),
                  //                     builder: (_, snapshot) {
                  //                       if (snapshot.hasData) {
                  //                         return ListView.separated(
                  //                             shrinkWrap: true,
                  //                             padding:
                  //                                 const EdgeInsets.all(16.0),
                  //                             itemBuilder: (_, index) {
                  //                               return HwCwUploadedContentItem(
                  //                                 onViewClicked: () async {
                  //                                   if ([
                  //                                     ".jpg",
                  //                                     ".jpeg",
                  //                                     ".png",
                  //                                     ".gif"
                  //                                   ].contains(p.extension(snapshot
                  //                                       .data!
                  //                                       .elementAt(index)
                  //                                       .ihwatTAttachment!))) {
                  //                                     Navigator.push(context,
                  //                                         MaterialPageRoute(
                  //                                             builder: (_) {
                  //                                       return ViewImage(
                  //                                           image: snapshot
                  //                                               .data!
                  //                                               .elementAt(
                  //                                                   index)
                  //                                               .ihwatTAttachment!);
                  //                                     }));
                  //                                     return;
                  //                                   }

                  //                                   if (await canLaunchUrl(
                  //                                       Uri.parse(snapshot.data!
                  //                                           .elementAt(index)
                  //                                           .ihwatTAttachment!))) {
                  //                                     await launchUrl(Uri.parse(
                  //                                         snapshot.data!
                  //                                             .elementAt(index)
                  //                                             .ihwatTAttachment!));
                  //                                     return;
                  //                                   }
                  //                                   Fluttertoast.showToast(
                  //                                       msg:
                  //                                           "No Specific application found to view this file");
                  //                                 },
                  //                                 onDownloadClicked: () async {
                  //                                   if (await canLaunchUrl(
                  //                                       Uri.parse(snapshot.data!
                  //                                           .elementAt(index)
                  //                                           .ihwatTAttachment!))) {
                  //                                     await launchUrl(Uri.parse(
                  //                                         snapshot.data!
                  //                                             .elementAt(index)
                  //                                             .ihwatTAttachment!));
                  //                                     return;
                  //                                   }
                  //                                   Fluttertoast.showToast(
                  //                                       msg:
                  //                                           "No Specific application found to view this file");
                  //                                 },
                  //                                 isPdf: p.extension(snapshot
                  //                                             .data!
                  //                                             .elementAt(index)
                  //                                             .ihwatTAttachment!) ==
                  //                                         ".pdf"
                  //                                     ? true
                  //                                     : false,
                  //                                 title: snapshot.data!
                  //                                     .elementAt(index)
                  //                                     .ihwatTFileName!,
                  //                                 // deleteAsset: "assets/svg/delete.svg",
                  //                               );
                  //                             },
                  //                             separatorBuilder: (_, index) {
                  //                               return const SizedBox(
                  //                                 height: 16.0,
                  //                               );
                  //                             },
                  //                             itemCount: snapshot.data!.length);
                  //                       }

                  //                       if (snapshot.hasError) {
                  //                         return ErrWidget(
                  //                             err: snapshot.error
                  //                                 as Map<String, dynamic>);
                  //                       }
                  //                       return const AnimatedProgressWidget(
                  //                           title: "Loading Your upload's",
                  //                           desc:
                  //                               "Please wait we are loading upload's for you..",
                  //                           animationPath:
                  //                               "assets/json/default.json");
                  //                     })
                  //                 : FutureBuilder<
                  //                         List<CwAttachmentModelValues>>(
                  //                     future: GetClassworkAttachmentApi.instance
                  //                         .getAttachedFiles(
                  //                       miId: widget.miId,
                  //                       base: widget.base,
                  //                       asmayId: widget.asmayId,
                  //                       iCwId: widget.cwList!.iCWId!,
                  //                       userId:
                  //                           widget.loginSuccessModel.userId!,
                  //                     ),
                  //                     builder: (_, snapshot) {
                  //                       if (snapshot.hasData) {
                  //                         return ListView.separated(
                  //                             shrinkWrap: true,
                  //                             padding:
                  //                                 const EdgeInsets.all(16.0),
                  //                             itemBuilder: (_, index) {
                  //                               return HwCwUploadedContentItem(
                  //                                 onViewClicked: () async {
                  //                                   if ([
                  //                                     ".jpg",
                  //                                     ".jpeg",
                  //                                     ".png",
                  //                                     ".gif"
                  //                                   ].contains(p.extension(snapshot
                  //                                       .data!
                  //                                       .elementAt(index)
                  //                                       .icwatTAttachment!))) {
                  //                                     Navigator.push(context,
                  //                                         MaterialPageRoute(
                  //                                             builder: (_) {
                  //                                       return ViewImage(
                  //                                           image: snapshot
                  //                                               .data!
                  //                                               .elementAt(
                  //                                                   index)
                  //                                               .icwatTAttachment!);
                  //                                     }));
                  //                                     return;
                  //                                   }

                  //                                   if (await canLaunchUrl(
                  //                                       Uri.parse(snapshot.data!
                  //                                           .elementAt(index)
                  //                                           .icwatTAttachment!))) {
                  //                                     await launchUrl(Uri.parse(
                  //                                         snapshot.data!
                  //                                             .elementAt(index)
                  //                                             .icwatTAttachment!));
                  //                                     return;
                  //                                   }
                  //                                   Fluttertoast.showToast(
                  //                                       msg:
                  //                                           "No Specific application found to view this file");
                  //                                 },
                  //                                 onDownloadClicked: () async {
                  //                                   if (await canLaunchUrl(
                  //                                       Uri.parse(snapshot.data!
                  //                                           .elementAt(index)
                  //                                           .icwatTAttachment!))) {
                  //                                     await launchUrl(Uri.parse(
                  //                                         snapshot.data!
                  //                                             .elementAt(index)
                  //                                             .icwatTAttachment!));
                  //                                     return;
                  //                                   }
                  //                                   Fluttertoast.showToast(
                  //                                       msg:
                  //                                           "No Specific application found to view this file");
                  //                                 },
                  //                                 isPdf: p.extension(snapshot
                  //                                             .data!
                  //                                             .elementAt(index)
                  //                                             .icwatTAttachment!) ==
                  //                                         ".pdf"
                  //                                     ? true
                  //                                     : false,
                  //                                 title: snapshot.data!
                  //                                     .elementAt(index)
                  //                                     .icwatTFileName!,
                  //                                 // deleteAsset: "assets/svg/delete.svg",
                  //                               );
                  //                             },
                  //                             separatorBuilder: (_, index) {
                  //                               return const SizedBox(
                  //                                 height: 16.0,
                  //                               );
                  //                             },
                  //                             itemCount: snapshot.data!.length);
                  //                       }

                  //                       if (snapshot.hasError) {
                  //                         return ErrWidget(
                  //                             err: snapshot.error
                  //                                 as Map<String, dynamic>);
                  //                       }
                  //                       return const AnimatedProgressWidget(
                  //                           title: "Loading Your upload's",
                  //                           desc:
                  //                               "Please wait we are loading upload's for you..",
                  //                           animationPath:
                  //                               "assets/json/default.json");
                  //                     })
                  //           ],
                  //         ),
                  //       );
                  //     });
                },
                child: Text(
                  "Download Corrected File",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width * 0.4, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                onPressed: () {
                  final ImagePicker picker = ImagePicker();
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upload Attachment",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Obx(() {
                                return widget.imageController.images.isEmpty
                                    ? Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              final XFile? xfile =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (xfile == null) {
                                                Fluttertoast.showToast(
                                                    msg: "No Image selected");
                                                return;
                                              }

                                              widget.imageController.images.add(
                                                  ImageModel(
                                                      amstId: widget.forHw
                                                          ? widget
                                                              .model!.aMSTId!
                                                          : widget
                                                              .cwList!.aMSTId!,
                                                      xfile: [xfile]));
                                            },
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  minRadius: 36.0,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .dividerColor,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    size: 36.0,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .color,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                const Text("Camera"),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16.0,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              final XFile? pickedImage =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (pickedImage == null) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "No Image selected for attachment");
                                                return;
                                              }
                                              widget.imageController.images.add(
                                                  ImageModel(
                                                      amstId: widget.forHw
                                                          ? widget
                                                              .model!.aMSTId!
                                                          : widget
                                                              .cwList!.aMSTId!,
                                                      xfile: [pickedImage]));
                                            },
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  minRadius: 36.0,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .dividerColor,
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 36.0,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .color,
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
                                          // InkWell(
                                          //   onTap: () async {
                                          //     final FilePickerResult? pickerRes =
                                          //         await FilePicker.platform.pickFiles(
                                          //             dialogTitle:
                                          //                 "Select Attachment's",
                                          //             allowMultiple: true);
                                          //     if (pickerRes == null) {
                                          //       Fluttertoast.showToast(
                                          //           msg: "No File selected..");
                                          //       return;
                                          //     }
                                          //     widget.imageController
                                          //         .addPlatformFile(pickerRes.files);
                                          //   },
                                          //   child: Column(
                                          //     children: [
                                          //       CircleAvatar(
                                          //         minRadius: 36.0,
                                          //         backgroundColor:
                                          //             Theme.of(context).dividerColor,
                                          //         child: Icon(
                                          //           Icons.document_scanner_outlined,
                                          //           size: 36.0,
                                          //           color: Theme.of(context)
                                          //               .textTheme
                                          //               .titleMedium!
                                          //               .color,
                                          //         ),
                                          //       ),
                                          //       const SizedBox(
                                          //         height: 8.0,
                                          //       ),
                                          //       const Text("Others"),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Obx(() {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(children: [
                                          ...List.generate(
                                            widget
                                                .imageController.images.length,
                                            (index) => Container(
                                              height: 100,
                                              width: 100,
                                              padding: const EdgeInsets.all(24),
                                              margin: const EdgeInsets.only(
                                                  right: 12.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey.shade300,
                                                    width: 1.0,
                                                  ),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(File(
                                                          widget.imageController
                                                              .images
                                                              .elementAt(index)
                                                              .xfile
                                                              .first
                                                              .path))),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0)),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black45,
                                                ),
                                                child: IconButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    widget
                                                        .imageController.images
                                                        .removeAt(index);
                                                  },
                                                  icon: const Icon(Icons.close),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ...List.generate(
                                            widget.imageController.platformFile
                                                .length,
                                            (index) => Container(
                                              width: 100,
                                              height: 100,
                                              margin: const EdgeInsets.only(
                                                  right: 12.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      widget.imageController
                                                          .platformFile
                                                          .removeAt(index);
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
                                                  ),
                                                  p.extension(widget
                                                              .imageController
                                                              .platformFile
                                                              .elementAt(index)
                                                              .path!) ==
                                                          ".pdf"
                                                      ? const Icon(
                                                          Icons
                                                              .picture_as_pdf_outlined,
                                                          size: 36.0,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .file_copy_outlined,
                                                          size: 36.0,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      widget.imageController.images
                                                  .isNotEmpty ||
                                              widget.imageController
                                                  .platformFile.isNotEmpty
                                          ? MSkollBtn(
                                              title: "Upload Now",
                                              onPress: () async {
                                                Navigator.pop(context);
                                                UploadHwAttachment.instance
                                                    .uploadNow(
                                                        miId: widget.miId,
                                                        controller: widget
                                                            .imageController,
                                                        base: "base",
                                                        forHw: widget.forHw);

                                                await showModalBottomSheet(
                                                    context: context,
                                                    builder: (_) {
                                                      return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Obx(() {
                                                            return widget
                                                                    .imageController
                                                                    .isErrorOccured
                                                                    .value
                                                                ? ErrWidget(
                                                                    err: {
                                                                        "errorTitle":
                                                                            "An Error Occured",
                                                                        "errorMsg": widget
                                                                            .imageController
                                                                            .uploadStatus
                                                                            .value,
                                                                      })
                                                                : widget
                                                                        .imageController
                                                                        .isUploading
                                                                        .value
                                                                    ? AnimatedProgressWidget(
                                                                        title:
                                                                            "Uploading Attachment's",
                                                                        desc: widget
                                                                            .imageController
                                                                            .uploadStatus
                                                                            .value,
                                                                        animationPath:
                                                                            "assets/json/default.json")
                                                                    : Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          const CircleAvatar(
                                                                            minRadius:
                                                                                36.0,
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                            child:
                                                                                Icon(
                                                                              Icons.check,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                12.0,
                                                                          ),
                                                                          Text(
                                                                            "Upload Completed",
                                                                            style:
                                                                                Theme.of(context).textTheme.titleSmall!.merge(const TextStyle(fontWeight: FontWeight.w600)),
                                                                          ),
                                                                        ],
                                                                      );
                                                          }));
                                                    });

                                                widget.imageController.images
                                                    .clear();
                                                widget.imageController
                                                    .platformFile
                                                    .clear();
                                              },
                                              size: Size(Get.width * 0.5, 50),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        );
                      });
                },
                child: const Text("Upload"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
