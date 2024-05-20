import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/apis/final_tada_tour_plan.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/apis/final_view_tadaAdanced.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/controller/final_tada_tour_approval.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class FinalViewPlaner extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int ierID;
  final int miId;
  final int vtadaaId;
  final int vtadaaaaId;
  FinalViewPlaner(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.ierID,
      required this.vtadaaId,
      required this.vtadaaaaId,
      required this.miId});

  @override
  State<FinalViewPlaner> createState() => _FinalViewPlanerState();
}

class _FinalViewPlanerState extends State<FinalViewPlaner> {
  TadaTourApprovalController controller = TadaTourApprovalController();

  @override
  void initState() {
    initApi();
    super.initState();
  }

  initET() async {}
  initApi() async {
    await getFinalAdavncedPlanerDetails(
      base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
      controller: controller,
      ierId: widget.ierID,
      userId: widget.loginSuccessModel.userId!,
    );
    await getFinalAdavncedViewDetails(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        controller: controller,
        miID: widget.miId,
        userId: widget.loginSuccessModel.userId!,
        vtadaaId: widget.vtadaaId,
        vtadaaaaId: widget.vtadaaaaId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const CustomAppBar(title: "Final TADA TOUR View").getAppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  width: 1650,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blue,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Company Name : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue[600]))),
                            TextSpan(
                                text:
                                    controller.finalPalnerDetails.first.mIName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 10, 10, 10))))
                          ])),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Plan Name : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue[600]))),
                            TextSpan(
                                text: controller
                                    .finalPalnerDetails.first.iERPlanName!
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 10, 10, 10)))),
                          ])),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Staff Name : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue[600]))),
                            TextSpan(
                                text: controller.finalPalnerDetails.first
                                    .hRMEEmployeeFirstName!
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 110, 15, 15))))
                          ])),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Applied Date :",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue[600]))),
                            TextSpan(
                                text: getDate(DateTime.parse(controller
                                    .finalPalnerDetails
                                    .first
                                    .vTADAAAAppliedDate!)),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 10, 10, 10)))),
                          ])),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 1650,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 50,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 30,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("SL.No")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("File Name")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Remark")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("View")),
                                  ),
                                ),
                              ],
                              rows: List.generate(controller.fileList.length,
                                  (index) {
                                int num = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("$num"),
                                  )),
                                  DataCell(Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      controller.fileList
                                          .elementAt(index)
                                          .iLRTFileName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      "View",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 228, 4, 4))),
                                    ),
                                  )),
                                ]);
                              }),
                            )),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 20, vertical: 10),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blue,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LEVEL APPROVED BY - ${controller.finalViewAdvance.first.approvedBy}",
                        style: Theme.of(context).textTheme.titleLarge!.merge(
                            const TextStyle(fontSize: 16, color: Colors.blue)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 1610,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 50,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 30,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("SL.No")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Applied Date")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Expenditure Head")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Amount")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Total Slots")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Slots")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Applied Amount")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Approved Amount")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Approved Date")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Approval Remark")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(
                                        child: Text("ExpenditureHead Status")),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  controller.finalViewAdvance.length, (index) {
                                int num = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("$num"),
                                  )),
                                  DataCell(Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      getDate(DateTime.parse(controller
                                          .finalViewAdvance
                                          .elementAt(index)
                                          .vTADAAAAppliedDate!)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.finalViewAdvance
                                          .elementAt(index)
                                          .vTADAAADExpenditureHead!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.finalViewAdvance
                                                  .elementAt(index)
                                                  .vTADAAADTotalSlots!
                                                  .toInt() !=
                                              0
                                          ? controller.finalViewAdvance
                                              .elementAt(index)
                                              .vTADAAADTotalSlots!
                                              .toInt()
                                              .toString()
                                          : "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.finalViewAdvance
                                                  .elementAt(index)
                                                  .vTADAAADSlots! !=
                                              0
                                          ? controller.finalViewAdvance
                                              .elementAt(index)
                                              .vTADAAADSlots!
                                              .toInt()
                                              .toString()
                                          : "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.finalViewAdvance
                                          .elementAt(index)
                                          .headWiseAppliedAmount!
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.finalViewAdvance
                                          .elementAt(index)
                                          .headWiseSactionedAmount!
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      getDate(DateTime.parse(controller
                                          .finalViewAdvance
                                          .elementAt(index)
                                          .vTADAAAAppliedDate
                                          .toString())),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.finalViewAdvance
                                          .elementAt(index)
                                          .vTADAAAAHRemarks!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.finalViewAdvance
                                          .elementAt(index)
                                          .vTADAAAAHStatusFlg!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                ]);
                              }),
                            )),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blue,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LEAD STATUS LIST",
                        style: Theme.of(context).textTheme.titleLarge!.merge(
                            const TextStyle(fontSize: 16, color: Colors.blue)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 1610,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 50,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 30,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Category\nName")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Lead name")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Product\nName")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Source\nName")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Cost")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Lead\nCreatedBy")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Demo\ngiven By")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Lead\nStatus")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Lead\nComment")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Demo\nResponse")),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  controller.leadStatusList.length, (index) {
                                return DataRow(cells: [
                                  DataCell(Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .iMRCCategoryName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .iSMSLELeadName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .iSMSMPRProductName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .iSMSMSOSourceName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .totalCost!
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .hRMEEmployeeFirstName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .demoEmployeeFirstName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadStatusList
                                          .elementAt(index)
                                          .leadStatus!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  const DataCell(Align(
                                    child: Icon(
                                      Icons.visibility,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      "Demo Response | View",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue)),
                                    ),
                                  )),
                                ]);
                              }),
                            )),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blue,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LEAD EXECUTED LIST",
                        style: Theme.of(context).textTheme.titleLarge!.merge(
                            const TextStyle(fontSize: 16, color: Colors.blue)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 1610,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 50,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 30,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("SL.No")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Category Name")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Lead Count")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(child: Text("Percentage")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(
                                        child: Text("Execution Leadcount")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(
                                        child: Text("Balance Lead Count")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Center(child: Text("Applied\nAmount")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(
                                        child: Text("Total\nSanction Amount")),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Center(
                                        child: Text("Total Eligibale amount")),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  controller.leadFinalSubmission.length,
                                  (index) {
                                var num = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "$num",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadFinalSubmission
                                          .elementAt(index)
                                          .iMRCCategoryName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      "${controller.leadFinalSubmission.elementAt(index).iERPCPercentage!} %",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadFinalSubmission
                                          .elementAt(index)
                                          .leadCount!
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadFinalSubmission
                                                  .elementAt(index)
                                                  .executionLeadCount !=
                                              0
                                          ? controller.leadFinalSubmission
                                              .elementAt(index)
                                              .executionLeadCount
                                              .toString()
                                          : "--",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      "--",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadFinalSubmission
                                          .elementAt(index)
                                          .vTADAAATotalAppliedAmount!
                                          .toInt()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadFinalSubmission
                                          .elementAt(index)
                                          .vTADAAATotalSactionedAmount!
                                          .toInt()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Align(
                                    child: Text(
                                      controller.leadFinalSubmission
                                          .elementAt(index)
                                          .vTADAAATotalEligbleAmount!
                                          .toInt()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  )),
                                ]);
                              }),
                            )),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 1056,
                            decoration: const BoxDecoration(
                                border: Border(
                              left: BorderSide(color: Colors.black, width: 0.5),
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.5),
                              right:
                                  BorderSide(color: Colors.black, width: 0.5),
                            )),
                            child: Center(
                                child: const Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ).paddingSymmetric(vertical: 5)),
                          ),
                          Container(
                            width: 137,
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.5),
                              right:
                                  BorderSide(color: Colors.black, width: 0.5),
                            )),
                            child: Center(
                                child: Text(
                              "${controller.totalFinalappliedAmount.value.toInt()}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ).paddingSymmetric(vertical: 5)),
                          ),
                          Container(
                            width: 195,
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.5),
                              right:
                                  BorderSide(color: Colors.black, width: 0.5),
                            )),
                            child: Center(
                                child: Text(
                              "${controller.totalFinalSanctionAmount.value.toInt()}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ).paddingSymmetric(vertical: 5)),
                          ),
                          Container(
                            width: 222,
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.5),
                              right:
                                  BorderSide(color: Colors.black, width: 0.5),
                            )),
                            child: Center(
                              child: Text(
                                      "${controller.totalFinalElgibleAmount.value.toInt()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))
                                  .paddingSymmetric(vertical: 5),
                            ),
                          )
                        ],
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ),
                Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.blue,
                        )),
                    child: SizedBox(
                        width: 1650,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Total Root Plan Amount:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    readOnly: true,
                                    controller: controller.etPlanedAmount.value,
                                     
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                const Text(
                                  "Total Eligible Amount :",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    readOnly: true,
                                    controller:
                                        controller.etEligibleAmount.value,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                const Text(
                                  "Balance Debit Amount :",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    readOnly: true,
                                    controller: controller.etDebitAmount.value,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Text(
                                  "Adavance Paid Amount :",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    readOnly: true,
                                    controller: controller.etPaidAmount.value,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Salary Deducted\nAdavance Amount :",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    readOnly: true,
                                    controller:
                                        controller.etDeductectedAmount.value,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                const Text(
                                  "Total Sanction Amount:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    readOnly: true,
                                    controller:
                                        controller.etSnactionedAmount.value,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Remark :",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 115,
                                ),
                                Container(
                                  width: 400,
                                  child: TextField(
                                    controller: controller.etRemarks.value,
                                    maxLines: 4,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).marginSymmetric(horizontal: 10, vertical: 20)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDate(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, "0")}";
  }
}
