import 'dart:io';
import 'dart:typed_data';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/vms/call_letter/api/call_letter_api.dart';
import 'package:m_skool_flutter/vms/call_letter/model/call_letter_add_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CallLetterView extends StatelessWidget {
  final String name;
  final Uint8List? rawData;
  final MskoolController mskoolController;
  final String email;
  final LoginSuccessModel loginSuccessModel;
  final CallLetterModel value;
  const CallLetterView({
    super.key,
    required this.name,
    this.rawData,
    required this.mskoolController,
    required this.email,
    required this.loginSuccessModel,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '$name Call Letter').getAppBar(),
      body: (rawData!.isNotEmpty)
          ? SfPdfViewer.memory(rawData!)
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: (rawData!.isNotEmpty)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: MSkollBtn(
                      title: "Send Mail",
                      onPress: () async {
                        await CallLetterAPI.i.saveCallLetter(
                            base: baseUrlFromInsCode(
                                'recruitement', mskoolController),
                            body: {
                              "MI_Id": loginSuccessModel.mIID,
                              "HRCD_EmailId": email,
                              "UserId": loginSuccessModel.userId,
                              "Template": InterviewCallLetter(value: value)
                            });
                      }),
                ),
                MSkollBtn(
                    title: "Download Now",
                    onPress: () async {
                      try {
                        if (Platform.isIOS) {
                          PermissionStatus permissionStatus =
                              await Permission.storage.request();
                          if (permissionStatus.isDenied) {
                            Fluttertoast.showToast(
                                msg:
                                    "You have denied to allow storage permission, can't save pdf");
                            return;
                          }
                          Directory? directory =
                              await getApplicationDocumentsDirectory();
                          // ignore: prefer_typing_uninitialized_variables
                          String savePath =
                              "${directory.path}${Platform.pathSeparator}/$name-call_letter.pdf";
                          File file =
                              await File(savePath).writeAsBytes(rawData!);
                          SaveServiceNotification.initializeNotification();
                          SaveServiceNotification.showSaveNotification(
                              file.path,
                              "Call Letter Saved",
                              "We have save Call Letter to your download folder, tap to view");

                          Fluttertoast.showToast(
                              msg:
                                  "File downloaded successfully in your device");
                        } else {
                          await DocumentFileSavePlus.saveFile(
                            rawData!,
                            name,
                            "application/pdf",
                          );
                          String filepath = await SaveServiceNotification
                              .getStoragePathAndSave(rawData!, name);
                          SaveServiceNotification.initializeNotification();
                          SaveServiceNotification.showSaveNotification(
                              filepath,
                              "Call Letter Saved",
                              "We have save Call Letter to your download folder, tap to view");
                          Fluttertoast.showToast(
                              msg: "Call Letter saved to download folder.");
                        }
                      } catch (e) {
                        logger.e(e.toString());
                        Fluttertoast.showToast(
                            msg: "Failed to generate Pdf.. Try again later");
                      }
                    }),
              ],
            )
          : const SizedBox(),
    );
  }
}

class InterviewCallLetter extends StatelessWidget {
  final CallLetterModel value;
  const InterviewCallLetter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'INTERVIEW CALL LETTER',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3a5999),
                letterSpacing: 1.0,
//                   textTransform: TextTransform.uppercase,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Table(
              columnWidths: const {0: FlexColumnWidth(1)},
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Call Letter No. : ${value.callLetterNo}',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Date : ${dateFormat(DateTime.now())}',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'To',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Name : ${value.candidateName}',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Address: ${value.address}',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Dear ${value.candidateName},',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subject: Interview for the position of ${value.positionName}.',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'Reference: Our Advertisement/Job Posting in ${value.jobSite} dated ${dateFormat(DateTime.parse(value.jobPostDate!))}.',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'We are happy to inform you that you have been shortlisted for appointment to the position of ${value.positionName} located at ${value.jobLocation}.',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'In this regard you are requested to attend an interview on ${dateFormat(DateTime.parse(value.interviewDate!))} at ${value.interviewTime} at the address given below.',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Vaps Technosoft Pvt Ltd,\nNew No.58,Old No.20 1st stage,1st main Road,\nKamakshi palya,\nBasaveshwara Nagar,\nBangalore-560079\nEmail Address: ${value.officeMailId}\nPhone No: ${value.officePhoneNo}',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'You may please note that this letter is not an offer of Employment. The purpose of this letter will be to explore areas of mutual interest and to assess the fit between the individual and the position.',
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  'We enclose herewith the link to update the candidate information details for Employment. Please update. Fill this form and save it at least one day prior to the interview. Please confirm your attendance for the interview by replying to this letter.',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'https://vapsmanagementsoftware.azurewebsites.net/#/login/\nUserName : candidatevts\nPassword : Password@123',
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Steps: Recruitment - Transaction - Add Candidate (fill and Save).',
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  'You are requested to bring a certified copy of all the marks cards and certificates of your educational qualifications and other documents. You may wish for considering your application. Details like Job Description are enclosed to help you to understand us better.',
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  'If you have any questions, please feel free to contact us at our telephone number or email address.',
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  'We look forward to meeting you,',
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  'Best Wishes to you,',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Table(
              columnWidths: const {0: FlexColumnWidth(1)},
              children: const [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'For Vaps Technosoft Pvt Ltd.,',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'HR Team.',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
