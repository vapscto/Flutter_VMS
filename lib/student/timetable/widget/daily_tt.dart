import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/student/timetable/api/daily_tt_api.dart';
import 'package:m_skool_flutter/student/timetable/model/daywise_tt.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/pgr_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class DailyTT extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String? month;
  const DailyTT({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    this.month,
  });

  @override
  State<DailyTT> createState() => _DailyTTState();
}

class _DailyTTState extends State<DailyTT> with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    if (widget.month == null) {
      controller = TabController(length: 7, vsync: this);
    } else {
      int index = 0;
      switch (widget.month!.toLowerCase().trim()) {
        case "monday":
          index = 0;
          break;
        case "tuesday":
          index = 1;
          break;
        case "wednesday":
          index = 2;
          break;
        case "thursday":
          index = 3;
          break;
        case "friday":
          index = 4;
          break;
        case "saturday":
          index = 5;
          break;
        default:
          index = 6;
          break;
      }
      controller = TabController(length: 7, vsync: this, initialIndex: index);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: controller!,
          labelColor: Theme.of(context).textTheme.titleMedium!.color,
          labelStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .merge(const TextStyle(fontSize: 16.0)),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 4,

          // indicator: BoxDecoration(
          //     borderRadius: BorderRadius.circular(24.0),
          //     color: Theme.of(context).primaryColor),
          unselectedLabelColor: Colors.grey.shade600,
          isScrollable: true,
          tabs: const [
            Tab(
              text: "Monday",
            ),
            Tab(
              text: "Tuesday",
            ),
            Tab(
              text: "Wednesday",
            ),
            Tab(
              text: "Thursday",
            ),
            Tab(
              text: "Friday",
            ),
            Tab(
              text: "Saturday",
            ),
            Tab(
              text: "Sunday",
            ),
          ],
        ),
        SizedBox(
          // color: Colors.amber,
          height: Get.height,
          child: TabBarView(controller: controller, children: [
            ShowTT(
              day: "Monday",
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            ShowTT(
              day: 'Tuesday',
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            ShowTT(
              day: 'Wednesday',
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            ShowTT(
              day: 'Thursday',
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            ShowTT(
              day: 'Friday',
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            ShowTT(
              day: 'Saturday',
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ),
            ShowTT(
              day: 'Sunday',
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            )
          ]),
        ),
        const Divider(
          height: 1.0,
          thickness: 1.0,
        )
      ],
    );
  }
}

class ShowTT extends StatefulWidget {
  final String day;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ShowTT(
      {super.key,
      required this.day,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<ShowTT> createState() => _ShowTTState();
}

class _ShowTTState extends State<ShowTT> {
  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyTTModelValues>>(
        future: DailyttApi.instance.loadDailyTT(
          miId: widget.loginSuccessModel.mIID!,
          asmayId: widget.loginSuccessModel.asmaYId!,
          asmclId: widget.loginSuccessModel.asmcLId!,
          asmsId: widget.loginSuccessModel.asmSId!,
          amstId: widget.loginSuccessModel.amsTId!,
          dayName: widget.day,
          base: baseUrlFromInsCode(
            "portal",
            widget.mskoolController,
          ),
        ),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? Container(
                    margin: EdgeInsets.only(bottom: Get.height * 0.3),
                    child: const AnimatedProgressWidget(
                        animatorHeight: 250,
                        title: "No Timetable found",
                        desc: "Seem's like today timetable is not yet uploaded",
                        animationPath: "assets/json/nodata.json"),
                  )
                // ? Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "No timetable found",
                //         style: Theme.of(context)
                //             .textTheme
                //             .titleSmall!
                //             .merge(const TextStyle(
                //               //fontWeight: FontWeight.w500,
                //               fontSize: 26.0,
                //             )),
                //       ),
                //       const SizedBox(
                //         height: 8.0,
                //       ),
                //       Text(
                //         "It's Holiday.. Enjoy more..",
                //         style: Theme.of(context).textTheme.labelSmall!.merge(
                //             const TextStyle(
                //                 fontSize: 16.0, letterSpacing: 0.2)),
                //       )
                //     ],
                //   )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RepaintBoundary(
                          key: _globalKey,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: List.generate(
                                  snapshot.data!.length,
                                  (index) => Column(
                                        children: [
                                          Material(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              contentPadding: EdgeInsets.zero,
                                              tileColor: timetablePeriodColor
                                                  .elementAt(index)
                                                  .withOpacity(0.15),
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16.0),
                                                child: Text(
                                                  "${snapshot.data!.elementAt(index).iSMSSubjectName} |  ${snapshot.data!.elementAt(index).tTMDPTStartTime}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(const TextStyle(
                                                          fontSize: 16.0,
                                                          height: 1.5)),
                                                ),
                                              ),
                                              leading: Container(
                                                alignment: Alignment.center,
                                                height: double.infinity,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: timetablePeriodColor
                                                      .elementAt(index),
                                                ),
                                                child: Text(
                                                  "P${index + 1}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .merge(
                                                        const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                        ],
                                      )),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Expanded(
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0)),
                                minimumSize: Size(Get.width * 0.5, 50)),
                            onPressed: () async {
                              try {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24.0)),
                                          child: const ProgressWidget());
                                    });

                                RenderRepaintBoundary boundary = _globalKey
                                        .currentContext!
                                        .findRenderObject()
                                    as RenderRepaintBoundary;

                                ui.Image image =
                                    await boundary.toImage(pixelRatio: 2.0);
                                ByteData? byteData = await image.toByteData(
                                    format: ui.ImageByteFormat.png);
                                var pngBytes = byteData!.buffer.asUint8List();

                                List<Directory>? directory =
                                    await getExternalStorageDirectories(
                                        type: StorageDirectory.pictures);

                                String path = directory!.first.path;

                                String fileName =
                                    "tt${DateTime.now().microsecondsSinceEpoch}.png";
                                File file = File('$path/$fileName');

                                var document = pw.Document();
                                document.addPage(pw.Page(build: (_) {
                                  return pw.ListView.separated(
                                      itemBuilder: (_, index) {
                                        return pw.Container(
                                          decoration: pw.BoxDecoration(
                                              borderRadius:
                                                  pw.BorderRadius.circular(8.0),
                                              color: PdfColor.fromInt(
                                                  timetableLLPeriodColor
                                                      .elementAt(index))),
                                          child: pw.Row(children: [
                                            pw.Container(
                                              width: 80,
                                              height: 80,
                                              decoration: pw.BoxDecoration(
                                                  borderRadius:
                                                      pw.BorderRadius.circular(
                                                          8.0),
                                                  color: PdfColor.fromHex(
                                                      timetablePdfPeriodColor
                                                          .elementAt(index))),
                                              child: pw.Center(
                                                child: pw.Text(
                                                  "P${index + 1}",
                                                  style: pw.TextStyle(
                                                    color: PdfColor.fromHex(
                                                      "#FFFFFF",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            pw.SizedBox(
                                              width: 12.0,
                                            ),
                                            pw.Expanded(
                                              child: pw.Text(
                                                "${snapshot.data!.elementAt(index).iSMSSubjectName}  | ${snapshot.data!.elementAt(index).tTMDPTStartTime}",
                                              ),
                                            )
                                          ]),
                                        );
                                      },
                                      separatorBuilder: (_, index) {
                                        return pw.SizedBox(height: 6.0);
                                      },
                                      itemCount: snapshot.data!.length);
                                }));
                                String fileName2 =
                                    "tt${DateTime.now().microsecondsSinceEpoch}.pdf";
                                if (Platform.isIOS) {
                                  PermissionStatus permissionStatus =
                                      await Permission.storage.request();
                                  Directory? directory =
                                      await getApplicationDocumentsDirectory();
                                  String savePath =
                                      "${directory.path}${Platform.pathSeparator}/Media/DTT-${DateTime.now().millisecondsSinceEpoch}.pdf";
                                  File file = await File(savePath)
                                      .writeAsBytes(await document.save());
                                  Fluttertoast.showToast(
                                      msg:
                                          "File downloaded successfully in your device");
                                } else {
                                  File file2 = File('$path/$fileName2');
                                  await DocumentFileSavePlus.saveFile(
                                      await document.save(),
                                      "DTT-${DateTime.now().millisecondsSinceEpoch}",
                                      "application/pdf");

                                  await file2.writeAsBytes(
                                      await document.save(),
                                      flush: true);
                                  SaveServiceNotification
                                      .initializeNotification();
                                  SaveServiceNotification.showSaveNotification(
                                      file2.path,
                                      "Time table Saved",
                                      "We have save your daily time table in download folder, tap to view");
                                  // await file.writeAsBytes(pngBytes, flush: true);

                                  // await GallerySaver.saveImage(file.path);
                                  Fluttertoast.showToast(
                                      msg: "File saved to Download Folder");
                                }
                                Navigator.pop(context);
                              } catch (e) {
                                logger.e(e.toString());
                                Fluttertoast.showToast(
                                    msg:
                                        "An Error Occured while saving timetable");
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Generate PDF"),
                          ),
                        ),
                      )
                    ],
                  );
          }

          if (snapshot.hasError) {
            return ErrWidget(err: snapshot.error as Map<String, dynamic>);
          }

          return Container(
            margin: EdgeInsets.only(bottom: Get.height * 0.4),
            child: AnimatedProgressWidget(
              animationPath: "assets/json/tt.json",
              title: "Loading ${widget.day}'s timetable",
              desc: "Please wait while we load timetable for you",
            ),
          );
        });
  }

  Future<bool> showT() async {
    await Future.delayed(const Duration(seconds: 5));
    return Future.value(true);
  }
}
