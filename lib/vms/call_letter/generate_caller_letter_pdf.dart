import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/call_letter/call_letter_view.dart';
import 'package:m_skool_flutter/vms/call_letter/model/call_letter_add_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class GenerateCallLetter {
  GenerateCallLetter.init();
  static final GenerateCallLetter instance = GenerateCallLetter.init();
  generatePdf(
      {required CallLetterModel value,
      required MskoolController mskoolController,
      required LoginSuccessModel loginSuccessModel}) async {
    final Document document = Document();
    String dateFormat(DateTime dt) {
      return '${dt.day}-${dt.month}-${dt.year}';
    }

    document.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        // pageTheme: PageTheme(theme: ),
        build: (_) {
          return Column(children: [
            Align(
                alignment: Alignment.topCenter,
                child: Text("INTERVIEW CALL LETTER",
                    style: const TextStyle(fontSize: 15))),
            SizedBox(height: 8),
            Align(
                alignment: Alignment.topRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Call Letter No. : ${value.callLetterNo}"),
                      Text("Date: ${dateFormat(DateTime.now())}"),
                    ])),
            SizedBox(height: 8),
            Align(
                alignment: Alignment.topLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("To"),
                      Text("Name: ${value.candidateName}"),
                      Text("Address: ${value.address}"),
                      Text("Dear ${value.candidateName},"),
                    ])),
            SizedBox(height: 8),
            Align(
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Subject: Interview For The Position of ${value.positionName}"),
                      SizedBox(height: 2),
                      Text(
                          "Reference: Our Advertisement/Job Posting in ${value.jobSite} dated ${dateFormat(DateTime.parse(value.jobPostDate!))}."),
                      SizedBox(height: 2),
                      Text(
                          "We are happy to inform you that you have been shortlisted for appointment to the position of ${value.positionName} located at ${value.jobLocation}."),
                      SizedBox(height: 2),
                      Text(
                          "In this regard you are requested to attend an interview on ${dateFormat(DateTime.parse(value.interviewDate!))} at ${value.interviewTime} at the address given below."),
                      SizedBox(height: 8),
                      Text("Vaps Technosoft Pvt Ltd,"),
                      Text("New No.58,Old No.20 1st stage,1st main Road,"),
                      Text("Kamakshi palya,"),
                      Text("Basaveshwara Nagar,"),
                      Text("Bangalore-560079"),
                      Text("Email Address: ${value.officeMailId}"),
                      Text("Email Address: ${value.officePhoneNo}"),
                      SizedBox(height: 8),
                      Text(
                          "You may please note that this letter is not an offer of Employment .The purpose of this letter will be to explore areas of mutual interest and to assess the fit between the individual and the position."),
                      SizedBox(height: 8),
                      Text(
                          "We enclose herewith the link to update the candidate information details for Employment.Please update.fill this form and save it atleast one day prior to the interview.Please confirm your attendance for the interview by replying to this letter."),
                      SizedBox(height: 8),
                      Text(
                          "https://vapsmanagementsoftware.azurewebsites.net/#/login/"),
                      SizedBox(height: 8),
                      Text("UserName : candidatevks"),
                      Text("Password : Password@123"),
                      SizedBox(height: 8),
                      Text(
                          "Steps: Recruitment - Transaction - Add Candidate (fill and Save)."),
                      SizedBox(height: 8),
                      Text(
                          "You are requested to bring a certified copy of all the marks cards and certificates of your educational qualifications and other documents.You may wish for considering your application.Details like Job Description are enclosed to help you to understand us better."),
                      Text(
                          "If you have any questions,please feel free to contact us at our telephone number or email address."),
                      SizedBox(height: 8),
                      Text("We look forward to meeting you,"),
                      Text("Best Wishes to you,"),
                    ])),
            SizedBox(height: 8),
            Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("For Vaps Technosoft Pvt Ltd.,",
                          style: const TextStyle(fontSize: 15)),
                      Text("HR Team", style: const TextStyle(fontSize: 15))
                    ])),
          ]);
        }));
    Uint8List data = await document.save();
    // String data1 = await document.save();

    Get.to(() => CallLetterView(
          name: value.candidateName!,
          rawData: data,
          mskoolController: mskoolController,
          email: value.candidateEmail!,
          loginSuccessModel: loginSuccessModel,
          value: value,
        ));
  }
}
