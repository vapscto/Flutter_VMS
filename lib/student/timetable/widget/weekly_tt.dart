import 'dart:io';
import 'dart:math';
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
import 'package:m_skool_flutter/student/timetable/api/tt_api.dart';
import 'package:m_skool_flutter/student/timetable/model/tt.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
// import 'package:pdf/pdf.dart';

class WeeklyTT extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const WeeklyTT(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<WeeklyTT> createState() => _WeeklyTTState();
}

final GlobalKey _globalKey = GlobalKey();
final GlobalKey _periodKey = GlobalKey();

class _WeeklyTTState extends State<WeeklyTT> {
  final RxList<List<String>> pdfTT = RxList();

  // final CreatePdfController pdfController = Get.put(CreatePdfController());

  @override
  void dispose() {
    // Get.delete<CreatePdfController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TT>(
        future: TTApi.instance.getTimeTable(
          miId: widget.loginSuccessModel.mIID!,
          asmayId: widget.loginSuccessModel.asmaYId!,
          asmtId: widget.loginSuccessModel.amsTId!,
          base: baseUrlFromInsCode("portal", widget.mskoolController),
        ),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: SingleChildScrollView(
                    child: CustomContainer(
                      child: Row(
                        children: [
                          RepaintBoundary(
                            key: _periodKey,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16.0)),
                              child: DataTable(
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor,
                                  ),
                                  border: TableBorder(
                                    right: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                    horizontalInside: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                    verticalInside: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      "Periods",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          )),
                                    ))
                                  ],
                                  rows: List.generate(
                                      snapshot.data!.periodsList.values!.length,
                                      (index) => DataRow(
                                              color: MaterialStateColor
                                                  .resolveWith(
                                                (states) => timetablePeriodColor
                                                    .elementAt(index),
                                              ),
                                              cells: [
                                                DataCell(Text(
                                                  "Period ${snapshot.data!.periodsList.values!.elementAt(index).ttmPPeriodName ?? "N/a"}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(
                                                        const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                )),
                                              ]))),
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: RepaintBoundary(
                                key: _globalKey,
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: List.generate(
                                      snapshot.data!.dayWise.length,
                                      (index) => DataTable(
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                          (states) =>
                                              Theme.of(context).primaryColor,
                                        ),
                                        border: TableBorder(
                                          right: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                          horizontalInside: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                          verticalInside: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        columns: [
                                          DataColumn(
                                              label: Text(
                                            snapshot.data!.dayWise
                                                .elementAt(index)
                                                .dayName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                )),
                                          ))
                                        ],
                                        rows: List.generate(
                                          snapshot.data!.dayWise
                                              .elementAt(index)
                                              .value
                                              .length,
                                          (index2) => DataRow(
                                            color:
                                                MaterialStateColor.resolveWith(
                                              (states) => timetablePeriodColor
                                                  .elementAt(
                                                      Random().nextInt(12))
                                                  .withOpacity(0.1),
                                            ),
                                            cells: [
                                              DataCell(Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data!.dayWise
                                                        .elementAt(index)
                                                        .value
                                                        .elementAt(index2)
                                                        .subjectName
                                                        .trim(),
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(
                                                          const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2.0,
                                                  ),
                                                  Text(
                                                    snapshot.data!.dayWise
                                                        .elementAt(index)
                                                        .value
                                                        .elementAt(index2)
                                                        .teacher,
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // DataTable(columns: columns, rows: rows);
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: DataTable(
                          //     columns: List.generate(
                          //       snapshot.data!.gridWeeks.values!.length,
                          //       (index) => DataColumn(
                          //         label: Text(snapshot.data!.gridWeeks.values!
                          //             .elementAt(index)
                          //             .ttmDDayCode!),
                          //       ),
                          //     ),
                          //     rows: List.generate(
                          //         1,
                          //         (index) =>
                          //             DataRow(cells: [DataCell(Text("KAN\nAPP"))])),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 64.0,
                ),
                ElevatedButton(
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
                                    borderRadius: BorderRadius.circular(24.0)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    AnimatedProgressWidget(
                                        title: "Saving File",
                                        desc:
                                            "Please wait we are saving file in your gallery",
                                        animationPath:
                                            "assets/json/default.json"),
                                  ],
                                ));
                          });

                      RenderRepaintBoundary periodBoundary =
                          _periodKey.currentContext!.findRenderObject()
                              as RenderRepaintBoundary;
                      RenderRepaintBoundary boundary =
                          _globalKey.currentContext!.findRenderObject()
                              as RenderRepaintBoundary;

                      ui.Image periodImage =
                          await periodBoundary.toImage(pixelRatio: 2.0);
                      ByteData? periodByteData = await periodImage.toByteData(
                          format: ui.ImageByteFormat.png);
                      var periodBytes = periodByteData!.buffer.asUint8List();

                      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
                      ByteData? byteData = await image.toByteData(
                          format: ui.ImageByteFormat.png);
                      var pngBytes = byteData!.buffer.asUint8List();

                      final pdf = pw.Document();

                      // var img = PdfImage.file(pdf.document, bytes: pngBytes);

                      // ttRow.addAll(List.generate(
                      //     snapshot.data!.dayWise.length, (index) => pw.TableRow(children: pw.Container()) ).toList());

                      // ttRow.addAll(List.generate(
                      //   snapshot.data!.dayWise.length,
                      //   (index) => pw.TableRow(
                      //     children: List.generate(
                      //       pdfTT.elementAt(index).length,
                      //       (index2) => pw.Container(
                      //           alignment: pw.Alignment.center,
                      //           padding: const pw.EdgeInsets.all(12.0),
                      //           color: PdfColor.fromInt(
                      //             timetablePdfSubColor.elementAt(
                      //               Random().nextInt(12),
                      //             ),
                      //           ).shade(0.01),
                      //           child: pw.Text(
                      //               pdfTT.elementAt(index).elementAt(index2))),
                      //     ),
                      //   ),
                      // ).toList());

                      // List<pw.TableRow> pdfPeriodsName = [
                      //   pw.TableRow(
                      //     children: [
                      //       // pw.Container(
                      //       //   color: PdfColor.fromHex("#1E38FC"),
                      //       //   padding: const pw.EdgeInsets.all(6.0),
                      //       //   child: pw.Text("Day",
                      //       //       style: pw.TextStyle(
                      //       //           color: PdfColor.fromHex("#FFFFFF"))),
                      //       // ),
                      //     ],
                      //   ),
                      // ];
                      // pdfPeriodsName.addAll(List.generate(
                      //   snapshot.data!.gridWeeks.values!.length,
                      //   (index) => pw.TableRow(
                      //     children: [
                      //       pw.Container(
                      //           padding: const pw.EdgeInsets.symmetric(
                      //               vertical: 13.0, horizontal: 15.0),
                      //           color: PdfColor.fromHex(
                      //               timetablePdfPeriodColor.elementAt(index)),
                      //           child: pw.Text(
                      //               "${snapshot.data!.gridWeeks.values!.elementAt(index).ttmDDayCode}",
                      //               style: pw.TextStyle(
                      //                   color: PdfColor.fromHex("#FFFFFF")))),
                      //     ],
                      //   ),
                      // ).toList());

                      List<pw.TableRow> pdfSub = [];
                      pdfSub.add(
                        pw.TableRow(children: [
                          pw.Container(
                              color: PdfColor.fromHex("#1E38FC"),
                              padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 6.0),
                              child: pw.Text("Days",
                                  style: pw.TextStyle(
                                      color: PdfColor.fromHex("#FFFFFF")))),
                          ...List.generate(
                              snapshot.data!.periodsList.values!.length,
                              (index) => pw.Container(
                                  color: PdfColor.fromHex("#1E38FC"),
                                  padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 6.0),
                                  child: pw.Text(
                                      "Period ${snapshot.data!.periodsList.values!.elementAt(index).ttmPPeriodName}",
                                      style: pw.TextStyle(
                                          color:
                                              PdfColor.fromHex("#FFFFFF"))))),
                        ]),
                      );

                      for (int i = 0; i < snapshot.data!.dayWise.length; i++) {
                        pdfSub.add(
                          pw.TableRow(children: [
                            pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 15.0),
                                // color: PdfColor.fromHex(
                                //     timetablePdfPeriodColor.elementAt(i)),
                                child: pw.Text(
                                    "${snapshot.data!.gridWeeks.values!.elementAt(i).ttmDDayCode}",
                                    style: pw.TextStyle(
                                        color: PdfColor.fromHex("#000000")))),
                            ...List.generate(
                                snapshot.data!.dayWise
                                    .elementAt(i)
                                    .value
                                    .length, (index) {
                              return pw.Container(
                                width: 50,
                                // color: PdfColor.fromInt(ttLighterBoxColor
                                //     .elementAt(Random().nextInt(12))),
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 6.0),
                                child: pw.Text(
                                    "${snapshot.data!.dayWise.elementAt(i).value.elementAt(index).subjectName}\n"),
                              );
                            }),
                          ]),
                        );
                      }
                      List<pw.Widget> pdfTemplate = [
                        // pw.Table(
                        //     border: pw.TableBorder.all(
                        //         color: PdfColor.fromHex("#000000")),
                        //     children: pdfPeriodsName),
                        pw.Table(
                            border: pw.TableBorder.all(
                                color: PdfColor.fromHex("#000000")),
                            children: pdfSub)
                      ];

                      pdf.addPage(pw.Page(
                          build: (_) {
                            return pw.Row(children: pdfTemplate);
                          },
                          orientation: pw.PageOrientation.landscape));

                      if (Platform.isIOS) {
                        PermissionStatus permissionStatus =
                            await Permission.storage.request();
                        Directory? directory =
                            await getApplicationDocumentsDirectory();
                        String savePath =
                            "${directory.path}${Platform.pathSeparator}/Media/WTT-${DateTime.now().millisecondsSinceEpoch}.pdf";
                        File file =
                            await File(savePath).writeAsBytes(await pdf.save());
                        Fluttertoast.showToast(
                            msg: "File downloaded successfully in your device");
                      } else {
                        DocumentFileSavePlus.saveFile(
                            await pdf.save(),
                            "WTT-${DateTime.now().millisecondsSinceEpoch}",
                            "application/pdf");
                        // document.dispose();
                        List<Directory>? directory =
                            await getExternalStorageDirectories(
                                type: StorageDirectory.downloads);

                        String path = directory!.first.path;

                        String fileName =
                            "tt${DateTime.now().microsecondsSinceEpoch}.pdf";

                        File file = File('$path/$fileName');
                        File file2 = File('$path/$fileName');

                        await file.writeAsBytes(await pdf.save(), flush: true);
                        // await file2.writeAsBytes(pngBytes, flush: true);

                        await file2.writeAsBytes(await pdf.save(), flush: true);
                        SaveServiceNotification.initializeNotification();
                        SaveServiceNotification.showSaveNotification(
                            file2.path,
                            "Time table Saved",
                            "We have save your daily time table in download folder, tap to view");
                        // Fluttertoast.showToast(
                        //     msg: "File saved at ${file.absolute.path}");

                        // String loc = await FileSaver.instance.saveFile(
                        //     fileName, pngBytes, "png",
                        //     mimeType: MimeType.PNG);
                        // await GallerySaver.saveImage(file2.path);
                        Fluttertoast.showToast(msg: "File saved to download");
                      }

                      Navigator.pop(context);
                    } catch (e) {
                      logger.e(e.toString());
                      Fluttertoast.showToast(
                          msg: "An Error Occured while saving timetable");
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Generate PDF"),
                ),
              ],
            );
          }

          if (snapshot.hasError) {
            return ErrWidget(err: snapshot.error as Map<String, dynamic>);
          }
          return Container(
            margin: EdgeInsets.only(top: Get.height * 0.2),
            child: const AnimatedProgressWidget(
                animationPath: "assets/json/tt.json",
                title: "Loading Weekly Timetable",
                desc: "Please wait while we load weekly timetable for you"),
          );
        }));
  }
}
