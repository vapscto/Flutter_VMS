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
    // final Response response = await getGlobalDio()
    //     .get(controller.salarySlipDetail.first.institutionDetails!.mILogo!);
    // logger.d(response.data.runtimeType);
    double netSalary = 0.0;
    double earning = 0.0;
    double deduction = 0.0;
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
    int i = 0;
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
                    'Name  : ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeFirstName} ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeMiddleName} ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEEmployeeLastName ?? ''}',
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
                    'Date Of Joining : ${controller.salarySlipDetail.first.currentemployeeDetails!.hrmEDoj!.toLocal().toString().split(" ").first} ',
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
                        child: Text("S No."),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Name"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Type"),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Amount")),
                    ],
                  ),
                  ...List.generate(
                    controller.salarySlipDetail.first.employeeSalaryslipDetails!
                        .values!.length,
                    (index) => TableRow(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${++i}"),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.salarySlipDetail.first
                              .employeeSalaryslipDetails!.values!
                              .elementAt(index)!
                              .hrmedName!),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.salarySlipDetail.first
                              .employeeSalaryslipDetails!.values!
                              .elementAt(index)!
                              .hrmedEarnDedFlag!),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.salarySlipDetail.first
                                .employeeSalaryslipDetails!.values!
                                .elementAt(index)!
                                .amount
                                .toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text("Total Earning : $earning"),
              SizedBox(height: 8.0),
              Text("Total Deduction : $deduction"),
              SizedBox(height: 8.0),
              Text("Net Salary : $netSalary"),
              SizedBox(height: 8.0),
              Text(
                  "Salary In Words : ${NumberToWordsEnglish.convert(netSalary.toInt())} rupee only"),
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
    // try {
    //   if (Platform.isIOS) {
    //     PermissionStatus permissionStatus = await Permission.storage.request();
    //     Directory? directory = await getApplicationDocumentsDirectory();
    //     String savePath =
    //         "${directory.path}${Platform.pathSeparator}/Media/Salary-Slip-${DateTime.now().millisecondsSinceEpoch}.pdf";
    //     File file = await File(savePath).writeAsBytes(await document.save());

    //     Fluttertoast.showToast(
    //         msg: "File downloaded successfully in your device");
    //   } else {
    //     await DocumentFileSavePlus.saveFile(
    //       await document.save(),
    //       "Salary-Slip-${DateTime.now().millisecondsSinceEpoch}",
    //       "application/pdf",
    //     );
    //     String filepath = await SaveServiceNotification.getStoragePathAndSave(
    //         await document.save(), "Salary-Slip-");
    //     SaveServiceNotification.initializeNotification();
    //     SaveServiceNotification.showSaveNotification(
    //         filepath,
    //         "Salary Slip Saved",
    //         "We have save salary slip to your download folder, tap to view");
    //     Fluttertoast.showToast(msg: "Salary slip saved to download folder.");
    //   }
    // } catch (e) {
    //   logger.e(e.toString());
    //   Fluttertoast.showToast(msg: "Failed to generate Pdf.. Try again later");
    // }
  }
}
