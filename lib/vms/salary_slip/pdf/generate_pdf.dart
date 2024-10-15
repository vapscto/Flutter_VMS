import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:m_skool_flutter/screens/attachment_viewer.dart';
import 'package:m_skool_flutter/vms/salary_slip/controller/salary_slip_related_controller.dart';

class GenerateSalarySlip {
  GenerateSalarySlip.init();
  static final GenerateSalarySlip instance = GenerateSalarySlip.init();

  generateNow({
    required SalarySlipController controller,
    required LoginSuccessModel loginSuccessModel,
  }) async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      double netSalary = 0.0;
      double earning = 0.0;
      double deduction = 0.0;
      num gross = 0;

      DateTime dt = DateTime.parse(controller
          .salarySlipDetail.first.currentemployeeDetails!.hrmEDoj!
          .toIso8601String());
      var date = '${dt.day}-${dt.month}-${dt.year}';

      // Calculate earnings and deductions
      for (int i = 0;
          i <
              controller.salarySlipDetail.first.employeeSalaryslipDetails!
                  .values!.length;
          i++) {
        if (controller.salarySlipDetail.first.employeeSalaryslipDetails!.values!
                .elementAt(i)!
                .hrmedEarnDedFlag!
                .toLowerCase() ==
            "earning") {
          earning += controller
              .salarySlipDetail.first.employeeSalaryslipDetails!.values!
              .elementAt(i)!
              .amount!;
        } else if (controller
                .salarySlipDetail.first.employeeSalaryslipDetails!.values!
                .elementAt(i)!
                .hrmedEarnDedFlag!
                .toLowerCase() ==
            "deduction") {
          deduction += controller
              .salarySlipDetail.first.employeeSalaryslipDetails!.values!
              .elementAt(i)!
              .amount!;
        }
      }
      netSalary = earning - deduction;

      final pw.Document document = pw.Document();
      gross = controller
          .salarySlipDetail.first.employeeSalaryslipDetails!.values!
          .elementAt(controller
              .salarySlipDetail.first.employeeSalaryslipDetails!.values!
              .indexWhere((element) => element!.hrmedName == "Gross"))!
          .amount!;
      logger.i(gross);
      var logo = await networkImage(
          controller.salarySlipDetail.first.institutionDetails!.mILogo!);
      document.addPage(
        pw.Page(
          build: (_) {
            return pw.Container(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Image(logo),
                  pw.SizedBox(height: 24.0),
                  pw.Text(
                    "Salary Slip : ${controller.salarySlipDetail.first.hreSMonth} ${controller.salarySlipDetail.first.hreSYear}",
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                  pw.SizedBox(height: 12.0),
                  pw.Table(children: [
                    pw.TableRow(children: [
                      pw.Text(
                        'Name  : ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeFirstName} ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeMiddleName ?? ''} ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeLastName ?? ''}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                      pw.Text(
                        'Employee Code : ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeCode} ',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Text(
                        'Department  : ${controller.salarySlipDetail.first.departmentName} ',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                      pw.Text(
                        'Date Of Joining : $date ',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Text(
                        'Designation  : ${controller.salarySlipDetail.first.designationName} ',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                      pw.Text(
                        'Total Days : ${controller.salarySlipDetail.first.empsaldetail!.hreSWorkingDays} ',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ])
                  ]),
                  pw.SizedBox(height: 20.0),
                  pw.Table(
                    border: pw.TableBorder.all(),
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("Earnings"),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("Amount"),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("Deductions"),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("Amount"),
                          ),
                        ],
                      ),
                      ...List.generate(
                        controller.salarySlipEarning.length,
                        (index) => pw.TableRow(
                          children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(8.0),
                              child: pw.Text(controller.salarySlipEarning
                                  .elementAt(index)
                                  .hrmedName!),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(8.0),
                              child: pw.Text(
                                controller.salarySlipEarning
                                    .elementAt(index)
                                    .amount
                                    .toString(),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(8.0),
                              child:
                                  index < controller.salarySlipDeduction.length
                                      ? pw.Text(
                                          controller.salarySlipDeduction
                                                  .elementAt(index)
                                                  .hrmedName ??
                                              "",
                                        )
                                      : pw.Text(""),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(8.0),
                              child:
                                  index < controller.salarySlipDeduction.length
                                      ? pw.Text(
                                          (controller.salarySlipDeduction
                                                      .elementAt(index)
                                                      .amount !=
                                                  0.0)
                                              ? controller.salarySlipDeduction
                                                  .elementAt(index)
                                                  .amount
                                                  .toString()
                                              : "",
                                        )
                                      : pw.Text(""),
                            ),
                          ],
                        ),
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("Total"),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("$earning"),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("Total"),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text("$deduction"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16.0),
                  pw.Text("Net Salary : $netSalary"),
                  pw.SizedBox(height: 8.0),
                  pw.RichText(
                      text: pw.TextSpan(children: [
                    const pw.TextSpan(text: "Salary In Words : "),
                    pw.TextSpan(
                        text:
                            "${NumberToWordsEnglish.convert(netSalary.toInt())} rupees only"
                                .toUpperCase())
                  ])),
                  pw.SizedBox(height: 8.0),
                  pw.Text(
                      "Note : Signature is not required because it is computer generated statement"),
                ],
              ),
            );
          },
        ),
      );

      Uint8List rawData = await document.save();

      Get.back();

      Get.to(() => AttachmentViewer(
            loadFromRawData: true,
            rawData: rawData,
          ));
    } catch (e) {
      Get.back();
      Fluttertoast.showToast(msg: "Error generating PDF");
    }
  }
}
