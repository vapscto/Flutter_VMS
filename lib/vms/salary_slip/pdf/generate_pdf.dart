import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:m_skool_flutter/screens/attachment_viewer.dart';
import 'package:m_skool_flutter/vms/salary_slip/controller/salary_slip_related_controller.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class GenerateSalarySlip {
  GenerateSalarySlip.init();
  static final GenerateSalarySlip instance = GenerateSalarySlip.init();
  generateNow({
    required SalarySlipController controller,
  }) async {
    double netSalary = 0.0;
    double earning = 0.0;
    double deduction = 0.0;
    // ignore: unused_local_variable
    num gross = 0;
    DateTime dt = DateTime.parse(controller
        .salarySlipDetail.first.currentemployeeDetails!.hrmEDoj!
        .toIso8601String());
    var date = '${dt.day}-${dt.month}-${dt.year}';
    for (int i = 0;
        i <
            controller.salarySlipDetail.first.employeeSalaryslipDetails!.values!
                .length;
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
    final Document document = Document();
    gross = controller.salarySlipDetail.first.employeeSalaryslipDetails!.values!
        .elementAt(controller
            .salarySlipDetail.first.employeeSalaryslipDetails!.values!
            .indexWhere((element) => element!.hrmedName == "Gross"))!
        .amount!;

    controller.salarySlipDetail.first.employeeSalaryslipDetails!.values!
        .removeWhere((element) => element!.hrmedName == "Gross");
    var logo = await networkImage(
        controller.salarySlipDetail.first.institutionDetails!.mILogo!);
    document.addPage(
      Page(
        build: (_) {
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(logo),
              SizedBox(height: 24.0),
              Text(
                "Salary Slip : ${controller.salarySlipDetail.first.hreSMonth} ${controller.salarySlipDetail.first.hreSYear}",
                style: TextStyle(
                  fontSize: 12,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 12.0),
              Table(children: [
                TableRow(children: [
                  Text(
                    'Name  : ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeFirstName} ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeMiddleName ?? ''} ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeLastName ?? ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                  Text(
                    'Employee Code : ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeCode} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'Department  : ${controller.salarySlipDetail.first.departmentName} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                  Text(
                    'Date Of Joining : $date ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'Designation  : ${controller.salarySlipDetail.first.designationName} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                  Text(
                    'Total Days : ${controller.salarySlipDetail.first.empsaldetail!.hreSWorkingDays} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ])
              ]),
              SizedBox(height: 20.0),
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Earnings"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Amount"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Deductions"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Amount"),
                      ),
                    ],
                  ),
                  ...List.generate(
                    controller.salarySlipEarning.length,
                    (index) => TableRow(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.salarySlipEarning
                              .elementAt(index)
                              .hrmedName!),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.salarySlipEarning
                                .elementAt(index)
                                .amount
                                .toString(),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: index < controller.salarySlipDeduction.length
                              ? Text(
                                  controller.salarySlipDeduction
                                          .elementAt(index)
                                          .hrmedName ??
                                      "",
                                )
                              : Text(""),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: index < controller.salarySlipDeduction.length
                              ? Text(
                                  controller.salarySlipDeduction
                                      .elementAt(index)
                                      .amount
                                      .toString(),
                                )
                              : Text(""),
                        ),
                      ],
                    ),
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$earning"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$deduction"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text("Net Salary : $netSalary"),
              SizedBox(height: 8.0),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(text: "Salary In Words : "),
                TextSpan(
                    text:
                        "${NumberToWordsEnglish.convert(netSalary.toInt())} rupees only"
                            .toUpperCase())
              ])),
              SizedBox(height: 8.0),
              Text(
                  "Note : Signature is not required because it is computer generated statement"),
            ],
          ));
        },
      ),
    );
    Uint8List rawData = await document.save();
    Get.to(() => AttachmentViewer(
          loadFromRawData: true,
          rawData: rawData,
        ));
  }
}
