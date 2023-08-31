import 'dart:io';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/student/fees/controller/fee_related_controller.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_details_model.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_no_model.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_year_list_model.dart';
import 'package:m_skool_flutter/student/fees/widgets/feereceipt_detail_container.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/pgr_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class FeeReceiptTab extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const FeeReceiptTab({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<FeeReceiptTab> createState() => _FeeReceiptTabState();
}

class _FeeReceiptTabState extends State<FeeReceiptTab> {
  final ScrollController _controller = ScrollController();
  final feeController = Get.put(FeeController());

  YearlistValues? selectedValue;
  ReceiptNoList? receiptNoSelectedValue;

  final GlobalKey _receiptKey = GlobalKey();

  Future<void> getFeeYearList() async {
    feeController.isfeeloading(true);
    await feeController
        .getFeeReceiptYearData(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode('portal', widget.mskoolController),
    )
        .then((value) {
      if (value) {
        selectedValue = feeController.feeReceiptYearList.first;
        getFeeReceiptList(selectedValue!.asmaYId!);
      }
      debugPrint(value.toString());
    });
    feeController.isfeeloading(false);
  }

  Future<void> getFeeReceiptList(int asmayId) async {
    feeController.feeReceiptNoList.clear();
    feeController.feeReceiptDetailsList.clear();
    feeController.currentPaymentDetailList.clear();
    feeController.isreceipt(true);

    await feeController
        .getFeeReceiptNoListData(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: asmayId,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode('portal', widget.mskoolController),
    )
        .then((value) {
      if (value) {
        if (feeController.feeReceiptNoList.isNotEmpty) {
          receiptNoSelectedValue = feeController.feeReceiptNoList.first;
          getFeesReceiptDetail(receiptNoSelectedValue!.fyPId!);
        }
      }
    });
    feeController.isreceipt(false);
  }

  Future<void> getFeesReceiptDetail(int fypId) async {
    feeController.feeReceiptDetailsList.clear();
    feeController.currentPaymentDetailList.clear();
    feeController.isfeeDetail(true);
    await feeController.getFeeReceiptDetail(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: selectedValue!.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      fypId: fypId,
      base: baseUrlFromInsCode(
        'portal',
        widget.mskoolController,
      ),
    );
    feeController.isfeeDetail(false);
  }

  // void removeFeeDetailsContainer(int index) {
  //   feeController.feeReceiptDetailsList.removeAt(index);
  // }

  @override
  void initState() {
    super.initState();
    getFeeYearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => feeController.isFeeLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                  title: "Loading Fee Receipt",
                  desc: "Please wait while we load previous paid receipt.",
                  animationPath: "assets/json/fee.json",
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 8,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<YearlistValues>(
                        value: selectedValue,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          isDense: true,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.3)),
                          hintText: feeController.feeReceiptYearList.isNotEmpty
                              ? 'select year'
                              : "No data available",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(223, 251, 254, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 33,
                                  child: Image.asset(
                                    'assets/images/hat.png',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Academic Year',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(
                                        const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0,
                                            color: Color.fromRGBO(
                                                40, 182, 200, 1)),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30,
                          ),
                        ),
                        iconSize: 30,
                        items: List.generate(
                            feeController.feeReceiptYearList.length, (index) {
                          return DropdownMenuItem(
                            value: feeController.feeReceiptYearList
                                .elementAt(index),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                feeController.feeReceiptYearList
                                        .elementAt(index)
                                        .asmaYYear ??
                                    "N/A",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) {
                          selectedValue = s;
                          getFeeReceiptList(s!.asmaYId ?? 0);
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    feeController.isReceipt.value
                        ? const Center(
                            child: AnimatedProgressWidget(
                              title: "Getting Fee Receipt",
                              desc:
                                  "Loading fee receipt for the selected academic year.",
                              animationPath: "assets/json/fee.json",
                            ),
                          )
                        : feeController.feeReceiptNoList.isEmpty
                            ? const Center(
                                child: AnimatedProgressWidget(
                                  animatorHeight: 300,
                                  animationPath: 'assets/json/nodata.json',
                                  title: "No Receipt Found",
                                  desc:
                                      "For this academic year, we couldn't find any receipt.",
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 8,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<ReceiptNoList>(
                                  value: receiptNoSelectedValue,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    isDense: true,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                            letterSpacing: 0.3)),
                                    hintText: feeController
                                            .feeReceiptNoList.isNotEmpty
                                        ? 'select receipt no.'
                                        : "No data available",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(255, 235, 234, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                            child: Image.asset(
                                                'assets/images/receipt.png'),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Receipt No.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20.0,
                                                      color: Color.fromRGBO(
                                                          255, 111, 103, 1)),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 3.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                    ),
                                  ),
                                  iconSize: 30,
                                  items: List.generate(
                                      feeController.feeReceiptNoList.length,
                                      (index) {
                                    return DropdownMenuItem(
                                      value: feeController.feeReceiptNoList
                                          .elementAt(index),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, left: 5),
                                        child: Text(
                                          feeController.feeReceiptNoList
                                                  .elementAt(index)
                                                  .fyPReceiptNo ??
                                              "N/a",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .merge(const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.3)),
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (s) {
                                    receiptNoSelectedValue = s;
                                    getFeesReceiptDetail(s!.fyPId!);
                                  },
                                ),
                              ),
                    const SizedBox(height: 16),
                    Obx(
                      () => feeController.isFeeDetail.value
                          ? const Center(
                              child: AnimatedProgressWidget(
                                title: "Opening Receipt..",
                                desc: "Please wait while open receipt for you",
                                animationPath: "assets/json/fee.json",
                              ),
                            )
                          : feeController.feeReceiptDetailsList.isEmpty
                              ? feeController.feeReceiptNoList.isEmpty
                                  ? const SizedBox()
                                  : Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            child: Image.asset(
                                                'assets/images/pana.png'),
                                          ),
                                          const SizedBox(height: 25),
                                          const Text(
                                            'No Receipt Details available for selected receipt No.!!',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                              : Column(
                                  children: [
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: feeController
                                            .feeReceiptDetailsList.length,
                                        itemBuilder: (context, receiptIndex) {
                                          return RepaintBoundary(
                                            key: _receiptKey,
                                            child: FeeReceiptDetailContainer(
                                                logo: widget.loginSuccessModel
                                                        .mILogo ??
                                                    widget
                                                        .loginSuccessModel
                                                        .institutedetails!
                                                        .values!
                                                        .first
                                                        .mIName!,
                                                dataModel: feeController
                                                    .feeReceiptDetailsList
                                                    .elementAt(receiptIndex),
                                                currentPaymentDataList:
                                                    feeController
                                                        .currentPaymentDetailList),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 24.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 60),
                                      child: MSkollBtn(
                                          title: 'Generate PDF',
                                          onPress: () async {
                                            try {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (_) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0)),
                                                      child:
                                                          const ProgressWidget(),
                                                    );
                                                  });

                                              var document = pw.Document();
                                              var logo = await networkImage(
                                                  widget.loginSuccessModel
                                                      .mILogo!);
                                              List<List<pw.TableRow>>
                                                  receiptRow = [];

                                              List<List<FillStudentViewDetailsValues>>
                                                  receiptDat = [];
                                              for (int i = 0;
                                                  i <
                                                      feeController
                                                          .feeReceiptDetailsList
                                                          .first
                                                          .values!
                                                          .length;
                                                  i += 15) {
                                                int end = (i + 15 <
                                                        feeController
                                                            .feeReceiptDetailsList
                                                            .first
                                                            .values!
                                                            .length)
                                                    ? i + 15
                                                    : feeController
                                                        .feeReceiptDetailsList
                                                        .first
                                                        .values!
                                                        .length;
                                                receiptDat.add(feeController
                                                    .feeReceiptDetailsList
                                                    .first
                                                    .values!
                                                    .sublist(i, end));
                                              }
                                              double total = 0.0;
                                              double concession = 0.0;
                                              int indexes = 0;
                                              for (int i = 0;
                                                  i < receiptDat.length;
                                                  i++) {
                                                receiptRow.add(List.generate(
                                                    receiptDat
                                                        .elementAt(i)
                                                        .length, (index) {
                                                  indexes += 1;
                                                  concession += receiptDat
                                                          .elementAt(i)
                                                          .elementAt(index)
                                                          .ftPConcessionAmt ??
                                                      0;

                                                  total += receiptDat
                                                          .elementAt(i)
                                                          .elementAt(index)
                                                          .ftPPaidAmt ??
                                                      0;
                                                  return pw.TableRow(children: [
                                                    pw.Container(
                                                      padding: const pw
                                                          .EdgeInsets.all(6.0),
                                                      child:
                                                          pw.Text("$indexes"),
                                                    ),
                                                    pw.Container(
                                                      padding: const pw
                                                          .EdgeInsets.all(6.0),
                                                      child: pw.Text(receiptDat
                                                              .elementAt(i)
                                                              .elementAt(index)
                                                              .fmHFeeName ??
                                                          "N/a"),
                                                    ),
                                                    pw.Container(
                                                      padding: const pw
                                                          .EdgeInsets.all(6.0),
                                                      child: pw.Text(receiptDat
                                                              .elementAt(i)
                                                              .elementAt(index)
                                                              .ftIName ??
                                                          "N/a"),
                                                    ),
                                                    pw.Container(
                                                      padding: const pw
                                                          .EdgeInsets.all(6.0),
                                                      child: pw.Text(receiptDat
                                                          .elementAt(i)
                                                          .elementAt(index)
                                                          .ftPConcessionAmt
                                                          .toString()),
                                                    ),
                                                    pw.Container(
                                                      padding: const pw
                                                          .EdgeInsets.all(6.0),
                                                      child: pw.Text(receiptDat
                                                          .elementAt(i)
                                                          .elementAt(index)
                                                          .ftPPaidAmt
                                                          .toString()),
                                                    ),
                                                  ]);
                                                }).toList());
                                              }

                                              List<pw.Widget> pdfPages = [];

                                              pdfPages.add(pw.Row(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.center,
                                                  children: [
                                                    pw.Center(
                                                        child: pw.Image(logo,
                                                            width: 200))
                                                  ]));
                                              pdfPages.add(
                                                  pw.SizedBox(height: 16.0));
                                              pdfPages.add(pw.Table(
                                                children: [
                                                  pw.TableRow(
                                                    children: [
                                                      pw.Text(
                                                        'Receipt No : ${feeController.feeReceiptDetailsList.first.values!.first.fyPReceiptNo}',
                                                        style: pw.TextStyle(
                                                          fontSize: 9,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#000000"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Date : ${feeController.feeReceiptDetailsList.first.values!.first.fyPDate!.day} - ${feeController.feeReceiptDetailsList.first.values!.first.fyPDate!.month} - ${feeController.feeReceiptDetailsList.first.values!.first.fyPDate!.year}',
                                                        style: pw.TextStyle(
                                                          fontSize: 9,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#000000"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  pw.TableRow(children: [
                                                    pw.Text(
                                                      'Adm No : ${feeController.feeReceiptDetailsList.first.values!.first.admno}',
                                                      style: pw.TextStyle(
                                                        fontSize: 9,
                                                        color: PdfColor.fromHex(
                                                            "#000000"),
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      'Session : ${feeController.feeReceiptDetailsList.first.values!.first.admno}',
                                                      style: pw.TextStyle(
                                                        fontSize: 9,
                                                        color: PdfColor.fromHex(
                                                            "#000000"),
                                                      ),
                                                    ),
                                                  ]),
                                                  pw.TableRow(children: [
                                                    pw.Text(
                                                      'Name : ${feeController.feeReceiptDetailsList.first.values!.first.amsTFirstName} ${feeController.feeReceiptDetailsList.first.values!.first.amsTMiddleName} ${feeController.feeReceiptDetailsList.first.values!.first.amsTLastName}',
                                                      style: pw.TextStyle(
                                                        fontSize: 9,
                                                        color: PdfColor.fromHex(
                                                            "#000000"),
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      'Class/sec : ${feeController.feeReceiptDetailsList.first.values!.first.classname}/${feeController.feeReceiptDetailsList.first.values!.first.sectionname}',
                                                      style: pw.TextStyle(
                                                        fontSize: 9,
                                                        color: PdfColor.fromHex(
                                                            "#000000"),
                                                      ),
                                                    ),
                                                  ]),
                                                  pw.TableRow(
                                                    children: [
                                                      pw.Text(
                                                        'Father Name : ${feeController.feeReceiptDetailsList.first.values!.first.fathername}',
                                                        style: pw.TextStyle(
                                                          fontSize: 9,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#000000"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Type : ${feeController.feeReceiptDetailsList.first.values!.first.fMCCConcessionName}',
                                                        style: pw.TextStyle(
                                                          fontSize: 9,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#000000"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  pw.TableRow(children: [
                                                    pw.Text(
                                                      'TransactionId : ${feeController.feeReceiptDetailsList.first.values!.first.fypTransactionId}',
                                                      style: pw.TextStyle(
                                                        fontSize: 9,
                                                        color: PdfColor.fromHex(
                                                            "#000000"),
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      'Duration : ${feeController.feeReceiptDetailsList.first.values!.first.admno}',
                                                      style: pw.TextStyle(
                                                        fontSize: 9,
                                                        color: PdfColor.fromHex(
                                                            "#000000"),
                                                      ),
                                                    ),
                                                  ]),
                                                ],
                                              ));
                                              pdfPages.add(
                                                  pw.SizedBox(height: 24.0));
                                              pdfPages.add(pw.Table(
                                                  border: pw.TableBorder.all(
                                                      color: PdfColor.fromHex(
                                                          "#000000")),
                                                  columnWidths: {
                                                    0: const pw
                                                        .FixedColumnWidth(62),
                                                    1: const pw
                                                        .FixedColumnWidth(150),
                                                    2: const pw
                                                        .FixedColumnWidth(120),
                                                    3: const pw
                                                        .FixedColumnWidth(100),
                                                    4: const pw
                                                        .FixedColumnWidth(100),
                                                  },
                                                  children: [
                                                    pw.TableRow(children: [
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text("S.No."),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text(
                                                            "Particulars"),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text(
                                                            "Installments"),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text(
                                                            "Concession"),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text(
                                                            "Paid Amount"),
                                                      ),
                                                    ]),
                                                  ]));
                                              pdfPages.addAll(
                                                List.generate(
                                                  receiptDat.length,
                                                  (index) => pw.Table(
                                                      columnWidths: {
                                                        0: const pw
                                                            .FixedColumnWidth(62),
                                                        1: const pw
                                                                .FixedColumnWidth(
                                                            150),
                                                        2: const pw
                                                                .FixedColumnWidth(
                                                            120),
                                                        3: const pw
                                                                .FixedColumnWidth(
                                                            100),
                                                        4: const pw
                                                                .FixedColumnWidth(
                                                            100),
                                                      },
                                                      border: pw.TableBorder.all(
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#000000")),
                                                      children: [
                                                        ...List.generate(
                                                          receiptRow
                                                              .elementAt(index)
                                                              .length,
                                                          (index2) => receiptRow
                                                              .elementAt(index)
                                                              .elementAt(
                                                                  index2),
                                                        ),
                                                        pw.TableRow(children: [
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child:
                                                                pw.Text("**"),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                "Total Amount"),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                "------"),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                concession
                                                                    .toString()),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(total
                                                                .toString()),
                                                          ),
                                                        ])
                                                      ]),
                                                ),
                                              );
                                              pdfPages.add(
                                                  pw.SizedBox(height: 24.0));
                                              pdfPages.add(pw.Text(
                                                "Current Payment Details",
                                                style: pw.TextStyle(
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ));
                                              pdfPages.add(
                                                  pw.SizedBox(height: 10.0));
                                              pdfPages.add(pw.Table(
                                                  border: pw.TableBorder.all(
                                                      color: PdfColor.fromHex(
                                                          "#000000")),
                                                  columnWidths: {
                                                    0: const pw
                                                        .FixedColumnWidth(62),
                                                    1: const pw
                                                        .FixedColumnWidth(150),
                                                    2: const pw
                                                        .FixedColumnWidth(120),
                                                    3: const pw
                                                        .FixedColumnWidth(100),
                                                    4: const pw
                                                        .FixedColumnWidth(100),
                                                  },
                                                  children: [
                                                    pw.TableRow(children: [
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text("S.No."),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child:
                                                            pw.Text("Amount"),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text("Bank"),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text("DD.No"),
                                                      ),
                                                      pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            6.0),
                                                        decoration:
                                                            pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#E5F4FF")),
                                                        child: pw.Text("Date"),
                                                      ),
                                                    ]),
                                                  ]));
                                              pdfPages.addAll(
                                                List.generate(
                                                    feeController
                                                        .currentPaymentDetailList
                                                        .length, (i) {
                                                  var dt = DateTime.parse(
                                                      feeController
                                                          .currentPaymentDetailList
                                                          .elementAt(i)
                                                          .fyPDate!);
                                                  return pw.Table(
                                                      columnWidths: {
                                                        0: const pw
                                                            .FixedColumnWidth(62),
                                                        1: const pw
                                                                .FixedColumnWidth(
                                                            150),
                                                        2: const pw
                                                                .FixedColumnWidth(
                                                            120),
                                                        3: const pw
                                                                .FixedColumnWidth(
                                                            100),
                                                        4: const pw
                                                                .FixedColumnWidth(
                                                            100),
                                                      },
                                                      border: pw.TableBorder.all(
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#000000")),
                                                      children: [
                                                        pw.TableRow(children: [
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                "${i + 1}"),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                feeController
                                                                    .currentPaymentDetailList
                                                                    .elementAt(
                                                                        i)
                                                                    .ftPPaidAmt
                                                                    .toString()),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                feeController
                                                                    .currentPaymentDetailList
                                                                    .elementAt(
                                                                        i)
                                                                    .fyPBankName
                                                                    .toString()),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                feeController
                                                                    .currentPaymentDetailList
                                                                    .elementAt(
                                                                        i)
                                                                    .fyPDDChequeNo
                                                                    .toString()),
                                                          ),
                                                          pw.Container(
                                                            padding: const pw
                                                                    .EdgeInsets.all(
                                                                6.0),
                                                            child: pw.Text(
                                                                "${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}"),
                                                          ),
                                                        ]),
                                                      ]);
                                                }),
                                              );

                                              document.addPage(
                                                pw.MultiPage(
                                                  build: (_) {
                                                    return pdfPages;
                                                  },
                                                ),
                                              );

                                              // RenderRepaintBoundary boundary =
                                              //     _receiptKey.currentContext!
                                              //             .findRenderObject()
                                              //         as RenderRepaintBoundary;

                                              // ui.Image image = await boundary
                                              //     .toImage(pixelRatio: 2.0);
                                              // ByteData? byteData =
                                              //     await image.toByteData(
                                              //         format: ui
                                              //             .ImageByteFormat.png);
                                              // var pngBytes = byteData!.buffer
                                              //     .asUint8List();

                                              List<Directory>? directory =
                                                  await getExternalStorageDirectories(
                                                      type: StorageDirectory
                                                          .documents);

                                              String path =
                                                  directory!.first.path;

                                              // String fileName =
                                              //     "FR-${DateTime.now().microsecondsSinceEpoch}.png";
                                              // File file =
                                              //     File('$path/$fileName');
                                              String receiptName =
                                                  "FR${DateTime.now().microsecondsSinceEpoch}.pdf";
                                              File receipt =
                                                  File('$path/$receiptName');
                                              await receipt.writeAsBytes(
                                                  await document.save(),
                                                  flush: true);

                                              SaveServiceNotification
                                                  .initializeNotification();
                                              SaveServiceNotification
                                                  .showSaveNotification(
                                                      receipt.path,
                                                      "Fee Receipt Saved",
                                                      "We have saved your fee Receipt in download folder, tap to view");

                                              // await file.writeAsBytes(pngBytes,
                                              //     flush: true);

                                              // await GallerySaver.saveImage(
                                              //     file.path);
                                              if (Platform.isIOS) {
                                                PermissionStatus
                                                    permissionStatus =
                                                    await Permission.storage
                                                        .request();
                                                Directory? directory =
                                                    await getApplicationDocumentsDirectory();
                                                String savePath =
                                                    "${directory.path}${Platform.pathSeparator}/Media/FR-${DateTime.now().millisecondsSinceEpoch}.pdf";
                                                File file = await File(savePath)
                                                    .writeAsBytes(
                                                        await document.save());
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "File downloaded successfully in your device");
                                              } else {
                                                await DocumentFileSavePlus.saveFile(
                                                    await document.save(),
                                                    "FR-${DateTime.now().millisecondsSinceEpoch}.pdf",
                                                    "application/pdf");
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Receipt saved to Download");
                                              }

                                              Navigator.pop(context);
                                            } catch (e) {
                                              logger.e(e.toString());
                                              Navigator.pop(context);
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                    ),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 60),
      //   child: MSkollBtn(title: 'Generate PDF', onPress: () {

      //   }),
      // ),
      //  Padding(
      //   padding: const EdgeInsets.only(bottom: 60),
      //   child: ElevatedButton(
      //     style: ButtonStyle(
      //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //         RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     onPressed: () {},
      //     child: const Padding(
      //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40),
      //       child: Text(
      //         'Generate PDF',
      //         style: TextStyle(
      //             fontSize: 16,
      //             fontWeight: FontWeight.w700,
      //             color: Colors.white),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
