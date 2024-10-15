import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/Screen/visitor_details.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/api/qr_data_api.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  final MskoolController mskoolController;
  const QrScannerScreen({
    super.key,
    required this.mskoolController,
  });

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;
  VisitorManagementsController vController =
      Get.put(VisitorManagementsController());
  @override
  void reassemble() {
    super.reassemble();
    // controller!.flipCamera();
    if (controller != null) {
      if (mounted) {
        controller!.pauseCamera();
        controller!.resumeCamera();
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Scan Qr Code").getAppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Scan Qr Code to see Visitor Details",
                style: Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  scannedData != null
                      ? 'Scanned Data: $scannedData'
                      : 'Scan a code',
                ),
              ),
            ],
          ),
          Obx(() {
            return Visibility(
                visible: vController.isQrLoading.value,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey),
                  padding: const EdgeInsets.all(8),
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.red,
                    strokeWidth: 8,
                  ),
                ));
          })
        ],
      ),
    );
  }

  int miId = 0;
  int userId = 0;
  String flag = "";
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        scannedData = scanData.code;
        controller.pauseCamera();
        List<String> newList = scannedData!.split("#");
        flag = newList[0];
        miId = int.parse(newList[1]);
        userId = int.parse(newList[2]);
        logger.i(scannedData);
        vController.isQrLoading.value = true;
      });
      await QrDataAPI.i.getData(
          base: baseUrlFromInsCode(
              "visitorsmanagementservicehub", widget.mskoolController),
          body: {"flag": flag, "MI_Id": miId, "VMMV_Id": userId},
          controller: vController);
      setState(() {
        vController.isQrLoading.value = false;
      });
      if (vController.visitorData.isNotEmpty) {
        // ignore: use_build_context_synchronously
        getbuttomSheeet(context, vController, controller);
      } else {
        Get.snackbar("Error", "Visitor data not found");
      }
    });
  }

  getbuttomSheeet(BuildContext context, VisitorManagementsController controller,
      QRViewController c) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: (controller.visitorData.isEmpty)
              ? const Center(
                  child: Text("Visitor Details is not Available"),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Visitor Details",
                          style: Get.textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Name:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text:
                                controller.visitorData.first.vmmVVisitorName ??
                                    "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Contact Number:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller
                                .visitorData.first.vmmVVisitorContactNo
                                .toString(),
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Email Id:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller
                                    .visitorData.first.vmmVVisitorEmailid ??
                                "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Identity Card Type:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller
                                    .visitorData.first.vmmVIdentityCardType ??
                                "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Card No:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller.visitorData.first.vmmVCardNo ?? "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "From Place:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller.visitorData.first.vmmVFromPlace ??
                                "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Meeting Duration:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller
                                    .visitorData.first.vmmVMeetingDuration ??
                                "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Date:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: getDate(DateTime.parse(controller
                                .visitorData.first.vmmVMeetingDateTime!)),
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Meeting Purpose:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller
                                    .visitorData.first.vmmVMeetingPurpose ??
                                "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Entry Time:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller
                                    .visitorData.first.vmmVEntryDateTime ??
                                "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Visiting Flag:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text:
                                controller.visitorData.first.vmmVVisitTypeFlg ??
                                    "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Status:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: controller
                                    .visitorData.first.vmmVCkeckedInOutStatus ??
                                "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Person To Meet:- ",
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text:
                                controller.visitorData.first.vmmVPersonToMeet ??
                                    "",
                            style: Get.textTheme.titleSmall),
                      ])),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: MSkollBtn(
                              title: "Save",
                              onPress: () async {
                                await QrDataAPI.i.saveQrData(
                                    base: baseUrlFromInsCode(
                                        "visitorsmanagementservicehub",
                                        widget.mskoolController),
                                    body: {
                                      "vmmV_Id":
                                          controller.visitorData.first.vmmVId,
                                      "mI_Id":
                                          controller.visitorData.first.mIId,
                                      "empname": controller
                                          .visitorData.first.vmmVVisitorName,
                                      "VMMV_MeetingDateTime": controller
                                          .visitorData
                                          .first
                                          .vmmVMeetingDateTime,
                                      "VMMV_EntryDateTime": controller
                                          .visitorData.first.vmmVEntryDateTime,
                                      "VMMV_Remarks": controller.visitorData
                                              .first.vmmVMeetingPurpose ??
                                          "",
                                    }).then((value) async {
                                  await QrDataAPI.i.getData(
                                      base: baseUrlFromInsCode(
                                          "visitorsmanagementservicehub",
                                          widget.mskoolController),
                                      body: {
                                        "flag": flag,
                                        "MI_Id": miId,
                                        "VMMV_Id": userId
                                      },
                                      controller: vController);
                                  Get.off(() => VisitorDetailsData(
                                        vController: vController,
                                      ));
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    ).whenComplete(() {
      c.resumeCamera();
    });
  }
}
