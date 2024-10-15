import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class VisitorDetailsData extends StatefulWidget {
  final VisitorManagementsController vController;
  const VisitorDetailsData({super.key, required this.vController});

  @override
  State<VisitorDetailsData> createState() => _VisitorDetailsDataState();
}

class _VisitorDetailsDataState extends State<VisitorDetailsData> {
  int bgColor = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Visitor Management",
      ).getAppBar(),
      body: Obx(() {
        return (widget.vController.visitorData.isEmpty)
            ? const Center(
                child: Text("Scan Qr code to add Visitors"),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  bgColor += 1;
                  if (bgColor % 2 == 0) {
                    bgColor = 0;
                  }
                  var d = widget.vController.visitorData.elementAt(index);
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lighterColor.elementAt(bgColor),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Name:- ",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(
                              text: d.vmmVVisitorName ?? "",
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
                              text: d.vmmVVisitorContactNo.toString(),
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
                              text: d.vmmVVisitorEmailid ?? "",
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
                              text: d.vmmVIdentityCardType ?? "",
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
                              text: d.vmmVCardNo ?? "",
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
                              text: d.vmmVFromPlace ?? "",
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
                              text: d.vmmVMeetingDuration ?? "",
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
                              text: getDate(
                                  DateTime.parse(d.vmmVMeetingDateTime!)),
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
                              text: d.vmmVMeetingPurpose ?? "",
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
                              text: d.vmmVEntryDateTime ?? "",
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
                              text: d.vmmVVisitTypeFlg ?? "",
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
                              text: d.vmmVCkeckedInOutStatus ?? "",
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
                              text: d.vmmVPersonToMeet ?? "",
                              style: Get.textTheme.titleSmall),
                        ])),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: widget.vController.visitorData.length);
      }),
    );
  }
}
