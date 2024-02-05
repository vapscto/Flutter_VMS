import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/api/tada_approval_details.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/api/tada_approval_save_API.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/api/tada_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/controller/tada_approval_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/model/tada_approval_list_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class Item {
  bool isApproved;
  bool isRejected;

  Item({required this.isApproved, required this.isRejected});
}

class ApproveTADATableData extends StatefulWidget {
  final TadaApprovalController tadaController;
  final double amount;
  final TadaApprovalListModelValues values;
  final MskoolController mskoolController;
  final int vtadaaaaId;
  final int vtadaaId;
  const ApproveTADATableData(
      {super.key,
      required this.tadaController,
      required this.amount,
      required this.values,
      required this.mskoolController,
      required this.vtadaaaaId,
      required this.vtadaaId});

  @override
  State<ApproveTADATableData> createState() => _ApproveTADATableDataState();
}

class _ApproveTADATableDataState extends State<ApproveTADATableData> {
  final remarkController = TextEditingController();
  final sanctionController2 = TextEditingController();
  final parcentageController = TextEditingController();
  String fromDate = '';
  String toDate = '';
  String fromTime = '';
  String toTime = '';
  List<Map<String, dynamic>> headArray = [];
  List<Map<String, dynamic>> balanceHeadArray = [];
  List<Map<String, dynamic>> balanceHeadrejectArray = [];
  var days;
  num sanctionAmount = 0;
  RxList<String> slesRadioBtn = <String>[].obs;

  // void removeAmount(double a) {
  //   amount -= a;
  // }

  var approveCent = 0;
  getData() async {
    widget.tadaController.updateIsLoading(true);
    await TADAApprovalDetailsAPI.instance.tadaDetails(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.values.userId!,
        tadaController: widget.tadaController,
        vtaDaaId: widget.values.vTADAAId!,
        vtadaaaaId: widget.vtadaaaaId);

    DateTime dt = DateTime.parse(widget.values.vTADAAFromDate!);
    fromDate = '${dt.day}-${dt.month}-${dt.year}';
    DateTime toDt = DateTime.parse(widget.values.vTADAAToDate!);
    toDate = '${toDt.day}-${toDt.month}-${toDt.year}';
    widget.tadaController.updateIsLoading(false);
  }

  int vtadaaId = 0;
  double status = 0.0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.tadaController.editArrayList;
    });
    addAllAmount(0);
    widget.tadaController.selectedValue = List.generate(
        widget.tadaController.editArrayList.length,
        (index) => (widget.tadaController.editArrayList
                    .elementAt(index)
                    .sanctionLevelNo ==
                2)
            ? Item(
                isApproved: (widget.tadaController.editArrayList
                            .elementAt(index)
                            .vTADAAAHSactionedAmount !=
                        0)
                    ? true
                    : false,
                isRejected: (widget.tadaController.editArrayList
                            .elementAt(index)
                            .vTADAAAHSactionedAmount ==
                        0)
                    ? true
                    : false)
            : (widget.tadaController.editArrayList
                        .elementAt(index)
                        .sanctionLevelNo ==
                    3)
                ? Item(
                    isApproved: (widget.tadaController.editArrayList
                                .elementAt(index)
                                .vTADAAAHSactionedAmount !=
                            0)
                        ? true
                        : false,
                    isRejected: (widget.tadaController.editArrayList
                                .elementAt(index)
                                .vTADAAAHSactionedAmount ==
                            0)
                        ? true
                        : false)
                : Item(isApproved: true, isRejected: false));
    setState(() {
      updateCounts();
      for (int index = 0;
          index < widget.tadaController.editArrayList.length;
          index++) {
        logger.v(
            widget.tadaController.editArrayList[index].vTADAAAHSactionedAmount);
        widget.tadaController.approvalTextEditingControllerList
            .add(TextEditingController(text: ''));
        widget.tadaController.textEditingControllerList[index].addListener(() {
          addAllAmount(0);
        });
        sanctionController2.text = widget
            .tadaController.textEditingControllerList
            .elementAt(index)
            .text;
        (widget.tadaController.editArrayList.first.vTADAADId == null)
            ? sanctionAmount = widget.amount
            : sanctionAmount;
      }
    });
    super.initState();
  }

  void addAllAmount(double sum) {
    double value = 0;
    for (TextEditingController controller
        in widget.tadaController.textEditingControllerList) {
      value = double.tryParse(controller.text) ?? 0;
      sum += value;
    }
    setState(() {
      sanctionAmount = sum;
    });
  }

  double sum = 0;
  removeAllAmount(double amount) {
    sum -= amount;
    sanctionAmount -= amount;
    setState(() {});
  }

  @override
  void dispose() {
    widget.tadaController.selectedValue.clear();
    super.dispose();
  }

  int approvedCount = 0;
  int rejectedCount = 0;
  void updateCounts() {
    approvedCount = widget.tadaController.selectedValue
        .where((item) => item.isApproved)
        .length;
    rejectedCount = widget.tadaController.selectedValue
        .where((item) => item.isRejected)
        .length;
    logger.i(approvedCount);
    logger.i(rejectedCount);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          CustomContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  (widget.tadaController.editArrayList.first.vTADAADId != null)
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _createTable(),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  widget.tadaController.balanceApplyList.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Advance Details",
                              style: Get.textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 6),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Approved By :- ${widget.tadaController.balanceApplyList.first.approvedBy}',
                                  style: Get.textTheme.titleMedium!.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(height: 6),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: DataTable(
                                        dataRowHeight: 35,
                                        headingRowHeight: 40,
                                        columnSpacing: 20,
                                        headingTextStyle: const TextStyle(
                                            color: Colors.white),
                                        border: TableBorder.all(
                                          color: Colors.black,
                                          width: 0.6,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Theme.of(context)
                                                    .primaryColor),
                                        columns: const [
                                          DataColumn(label: Text("SL.NO.")),
                                          DataColumn(
                                              label: Text("Applied Date")),
                                          DataColumn(
                                              label: Text("Expenditure Head")),
                                          DataColumn(label: Text("Amount")),
                                          DataColumn(
                                              label: Text("Total Slots")),
                                          DataColumn(label: Text("Slots")),
                                          DataColumn(
                                              label: Text("Applied Amount")),
                                          DataColumn(
                                              label: Text("Approved Amount")),
                                          DataColumn(
                                              label: Text("Approved Date")),
                                          DataColumn(
                                              label: Text("Approval Remark")),
                                          DataColumn(
                                              label: Text(
                                                  "ExpenditureHead Status")),
                                        ],
                                        rows: List.generate(
                                            widget
                                                .tadaController
                                                .balanceApplyList
                                                .length, (index) {
                                          var i = index + 1;
                                          var v = widget
                                              .tadaController.balanceApplyList
                                              .elementAt(index);
                                          DateTime dt = DateTime.parse(
                                              v.vTADAAAAppliedDate!);
                                          var appliedDate =
                                              '${dt.day}-${dt.month}-${dt.year}';
                                          DateTime dt2 =
                                              DateTime.parse(v.vTADAAAADate!);
                                          var approvedDate =
                                              '${dt2.day}-${dt2.month}-${dt2.year}';
                                          return DataRow(cells: [
                                            DataCell(Text(i.toString())),
                                            DataCell(Text(appliedDate)),
                                            DataCell(Text(
                                                v.vTADAAADExpenditureHead!)),
                                            DataCell(Text(
                                                (v.vTADAAADExpenditureHead ==
                                                        'Food')
                                                    ? v.vTADACMFoodAmt
                                                        .toString()
                                                    : v.vTADACMAccommodationAmt
                                                        .toString())),
                                            DataCell(Text(v.vTADAAADTotalSlots
                                                .toString())),
                                            DataCell(Text(
                                                v.vTADAAADSlots.toString())),
                                            DataCell(Text(v
                                                .headWiseAppliedAmount
                                                .toString())),
                                            DataCell(Text(v
                                                .headWiseSactionedAmount
                                                .toString())),
                                            DataCell(Text(approvedDate)),
                                            DataCell(Text(
                                                v.vTADAAAAHRemarks.toString())),
                                            DataCell(
                                                Text(v.vTADAAAAHStatusFlg!))
                                          ]);
                                        })),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 6),
                            widget.tadaController.balanceApplySecondList.isEmpty
                                ? const SizedBox()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Approved By :- ${widget.tadaController.balanceApplySecondList.first.approvedBy}',
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      const SizedBox(height: 6),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: DataTable(
                                              dataRowHeight: 35,
                                              headingRowHeight: 40,
                                              columnSpacing: 20,
                                              headingTextStyle: const TextStyle(
                                                  color: Colors.white),
                                              border: TableBorder.all(
                                                color: Colors.black,
                                                width: 0.6,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              headingRowColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Theme.of(context)
                                                              .primaryColor),
                                              columns: const [
                                                DataColumn(
                                                    label: Text("SL.NO.")),
                                                DataColumn(
                                                    label:
                                                        Text("Applied Date")),
                                                DataColumn(
                                                    label: Text(
                                                        "Expenditure Head")),
                                                DataColumn(
                                                    label: Text("Amount")),
                                                DataColumn(
                                                    label: Text("Total Slots")),
                                                DataColumn(
                                                    label: Text("Slots")),
                                                DataColumn(
                                                    label:
                                                        Text("Applied Amount")),
                                                DataColumn(
                                                    label: Text(
                                                        "Approved Amount")),
                                                DataColumn(
                                                    label:
                                                        Text("Approved Date")),
                                                DataColumn(
                                                    label: Text(
                                                        "Approval Remark")),
                                                DataColumn(
                                                    label: Text(
                                                        "ExpenditureHead Status")),
                                              ],
                                              rows: List.generate(
                                                  widget
                                                      .tadaController
                                                      .balanceApplySecondList
                                                      .length, (index) {
                                                var i = index + 1;
                                                var v = widget.tadaController
                                                    .balanceApplySecondList
                                                    .elementAt(index);
                                                DateTime dt = DateTime.parse(
                                                    v.vTADAAAAppliedDate!);
                                                var appliedDate =
                                                    '${dt.day}-${dt.month}-${dt.year}';
                                                DateTime dt2 = DateTime.parse(
                                                    v.vTADAAAADate!);
                                                var approvedDate =
                                                    '${dt2.day}-${dt2.month}-${dt2.year}';
                                                return DataRow(cells: [
                                                  DataCell(Text(i.toString())),
                                                  DataCell(Text(appliedDate)),
                                                  DataCell(Text(v
                                                      .vTADAAADExpenditureHead!)),
                                                  DataCell(Text(
                                                      (v.vTADAAADExpenditureHead ==
                                                              'Food')
                                                          ? v.vTADACMFoodAmt
                                                              .toString()
                                                          : v.vTADACMAccommodationAmt
                                                              .toString())),
                                                  DataCell(Text(v
                                                      .vTADAAADTotalSlots
                                                      .toString())),
                                                  DataCell(Text(v.vTADAAADSlots
                                                      .toString())),
                                                  DataCell(Text(v
                                                      .headWiseAppliedAmount
                                                      .toString())),
                                                  DataCell(Text(v
                                                      .headWiseSactionedAmount
                                                      .toString())),
                                                  DataCell(Text(approvedDate)),
                                                  DataCell(Text(v
                                                      .vTADAAAAHRemarks
                                                      .toString())),
                                                  DataCell(Text(
                                                      v.vTADAAAAHStatusFlg!))
                                                ]);
                                              })),
                                        ),
                                      )
                                    ],
                                  ),
                            const SizedBox(height: 6),
                            widget.tadaController.balanceApplyThirdList.isEmpty
                                ? const SizedBox()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Approved By :- ${widget.tadaController.balanceApplyThirdList.first.approvedBy}',
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      const SizedBox(height: 6),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: DataTable(
                                              dataRowHeight: 35,
                                              headingRowHeight: 40,
                                              columnSpacing: 20,
                                              headingTextStyle: const TextStyle(
                                                  color: Colors.white),
                                              border: TableBorder.all(
                                                color: Colors.black,
                                                width: 0.6,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              headingRowColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Theme.of(context)
                                                              .primaryColor),
                                              columns: const [
                                                DataColumn(
                                                    label: Text("SL.NO.")),
                                                DataColumn(
                                                    label:
                                                        Text("Applied Date")),
                                                DataColumn(
                                                    label: Text(
                                                        "Expenditure Head")),
                                                DataColumn(
                                                    label: Text("Amount")),
                                                DataColumn(
                                                    label: Text("Total Slots")),
                                                DataColumn(
                                                    label: Text("Slots")),
                                                DataColumn(
                                                    label:
                                                        Text("Applied Amount")),
                                                DataColumn(
                                                    label: Text(
                                                        "Approved Amount")),
                                                DataColumn(
                                                    label:
                                                        Text("Approved Date")),
                                                DataColumn(
                                                    label: Text(
                                                        "Approval Remark")),
                                                DataColumn(
                                                    label: Text(
                                                        "ExpenditureHead Status")),
                                              ],
                                              rows: List.generate(
                                                  widget
                                                      .tadaController
                                                      .balanceApplyThirdList
                                                      .length, (index) {
                                                var i = index + 1;
                                                var v = widget.tadaController
                                                    .balanceApplyThirdList
                                                    .elementAt(index);
                                                DateTime dt = DateTime.parse(
                                                    v.vTADAAAAppliedDate!);
                                                var appliedDate =
                                                    '${dt.day}-${dt.month}-${dt.year}';
                                                DateTime dt2 = DateTime.parse(
                                                    v.vTADAAAADate!);
                                                var approvedDate =
                                                    '${dt2.day}-${dt2.month}-${dt2.year}';
                                                return DataRow(cells: [
                                                  DataCell(Text(i.toString())),
                                                  DataCell(Text(appliedDate)),
                                                  DataCell(Text(v
                                                      .vTADAAADExpenditureHead!)),
                                                  DataCell(Text(
                                                      (v.vTADAAADExpenditureHead ==
                                                              'Food')
                                                          ? v.vTADACMFoodAmt
                                                              .toString()
                                                          : v.vTADACMAccommodationAmt
                                                              .toString())),
                                                  DataCell(Text(v
                                                      .vTADAAADTotalSlots
                                                      .toString())),
                                                  DataCell(Text(v.vTADAAADSlots
                                                      .toString())),
                                                  DataCell(Text(v
                                                      .headWiseAppliedAmount
                                                      .toString())),
                                                  DataCell(Text(v
                                                      .headWiseSactionedAmount
                                                      .toString())),
                                                  DataCell(Text(approvedDate)),
                                                  DataCell(Text(v
                                                      .vTADAAAAHRemarks
                                                      .toString())),
                                                  DataCell(Text(
                                                      v.vTADAAAAHStatusFlg!))
                                                ]);
                                              })),
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  (widget.tadaController.balanceApplyList.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Adavance Total Amount :",
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  widget.tadaController.balanceApplyList.first
                                      .advancedAppliedAmount
                                      .toString(),
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Adavance Paid Amount :",
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  widget.tadaController.balanceApplyList.first
                                      .paidAmount
                                      .toString(),
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Balance Amount :",
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  '${widget.tadaController.balanceApplyList.first.advancedAppliedAmount! - widget.tadaController.balanceApplyList.first.paidAmount!}',
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Extra Amount :",
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  widget.tadaController.balanceApplyList.first
                                      .vTADACMTransportAmt
                                      .toString(),
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Applied Amount:",
                        style: Get.textTheme.titleSmall,
                      ),
                      Text(
                        widget.amount.toString(),
                        style: Get.textTheme.titleSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Sanction Amount:",
                        style: Get.textTheme.titleSmall,
                      ),
                      Text(
                        sanctionAmount.toString(),
                        style: Get.textTheme.titleSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CustomContainer(
                      child: TextFormField(
                    style: Get.textTheme.titleSmall,
                    maxLines: 2,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    controller: remarkController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      border: const OutlineInputBorder(),
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
                      hintText: "Enter Remark",
                      label: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFFBFE),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/noteicon.svg',
                              color: const Color.fromRGBO(40, 182, 200, 1),
                              height: 24,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "Remark",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(40, 182, 200, 1),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          (widget.vtadaaaaId != 0)
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: (widget
                                      .tadaController.isDetailsLoading.value ==
                                  true)
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : MSkollBtn(
                                  title: "Save",
                                  onPress: () async {
                                    await TADAApprovalSaveAPI.instance.saveTADA(
                                        base: baseUrlFromInsCode('issuemanager',
                                            widget.mskoolController),
                                        body: {
                                          'VTADAA_Remarks':
                                              remarkController.text,
                                          'VTADAA_TotalSactionedAmount':
                                              sanctionAmount,
                                          'VTADAA_Id': widget.vtadaaId,
                                          "MI_Id": widget.values.mIId,
                                          "approvecnt": approvedCount,
                                          "level":
                                              widget.values.sanctionLevelNo,
                                          "HRME_Id": widget.values.hRMEId,
                                          'UserId': widget.values.userId
                                        }).then((v) {
                                      TADAApprovalListAPI.instance
                                          .showApplyList(
                                              base: baseUrlFromInsCode(
                                                  'issuemanager',
                                                  widget.mskoolController),
                                              userId: widget.values.userId!,
                                              tadaController:
                                                  widget.tadaController);
                                      Get.back();
                                      Get.back();
                                    });
                                  })),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () async {
                            await TADAApprovalSaveAPI.instance.saveTADA(
                                base: baseUrlFromInsCode(
                                    'issuemanager', widget.mskoolController),
                                body: {
                                  'VTADAA_Remarks': remarkController.text,
                                  'VTADAA_TotalSactionedAmount': 0,
                                  'VTADAA_Id': widget.vtadaaId,
                                  "MI_Id": widget.values.mIId,
                                  "approvecnt": 0,
                                  "level": widget.values.sanctionLevelNo,
                                  "HRME_Id": widget.values.hRMEId,
                                  'UserId': widget.values.userId
                                }).then((v) {
                              TADAApprovalListAPI.instance.showApplyList(
                                  base: baseUrlFromInsCode(
                                      'issuemanager', widget.mskoolController),
                                  userId: widget.values.userId!,
                                  tadaController: widget.tadaController);
                              Fluttertoast.showToast(
                                  msg: "Reject Successfully");
                              Get.back();
                              Get.back();
                              setState(() {});
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Cancel",
                              style: Get.textTheme.titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: (widget.tadaController.isDetailsLoading.value == true)
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : MSkollBtn(
                          title: "Save",
                          onPress: () async {
                            updateCounts();

                            logger.i(approveCent);
                            if (widget
                                .tadaController.editArrayList.isNotEmpty) {
                              headArray.clear();
                              for (int i = 0;
                                  i <
                                      widget
                                          .tadaController.editArrayList.length;
                                  i++) {
                                var value = widget.tadaController.editArrayList
                                    .elementAt(i);
                                vtadaaId = value.vTADAAId!;
                                headArray.add({
                                  "VTADAAD_Id": value.vTADAADId,
                                  "VTADAA_Id": value.vTADAAId,
                                  "VTADAAAD_Remarks": widget.tadaController
                                      .textEditingControllerList[i].text,
                                  "VTADAAD_Amount": value.vTADAADAmount,
                                  "VTADAAAH_SactionedAmount": widget
                                      .tadaController.textEditingControllerList
                                      .elementAt(i)
                                      .text,
                                  "flag": (widget.tadaController.selectedValue
                                              .elementAt(i)
                                              .isApproved ==
                                          true)
                                      ? "A"
                                      : "R",
                                });
                              }
                              await TADAApprovalSaveAPI.instance.saveTADA(
                                  base: baseUrlFromInsCode(
                                      'issuemanager', widget.mskoolController),
                                  body: {
                                    'VTADAA_Remarks': remarkController.text,
                                    'VTADAA_TotalSactionedAmount':
                                        sanctionAmount,
                                    'headarray': headArray,
                                    'VTADAA_Id': widget.vtadaaId,
                                    "MI_Id": widget.values.mIId,
                                    "approvecnt": approvedCount,
                                    "level": widget.values.sanctionLevelNo,
                                    "HRME_Id": widget.values.hRMEId,
                                    'UserId': widget.values.userId
                                  }).then((v) {
                                Fluttertoast.showToast(
                                    msg: "TADA Saved Successfully");
                                TADAApprovalListAPI.instance.showApplyList(
                                    base: baseUrlFromInsCode('issuemanager',
                                        widget.mskoolController),
                                    userId: widget.values.userId!,
                                    tadaController: widget.tadaController);
                              });
                              Get.back();
                              Get.back();
                            }
                          })),
        ],
      ),
    );
  }

  double calculatePercentage(double amount, double percentage) {
    if (percentage > 0) {
      double a = percentage / 100;
      double result = amount * a;
      return result;
    } else {
      return amount;
    }
  }

  DataTable _createTable() {
    return DataTable(
        dataRowHeight: 35,
        headingRowHeight: 40,
        columnSpacing: 20,
        headingTextStyle: const TextStyle(color: Colors.white),
        border: TableBorder.all(
          color: Colors.black,
          width: 0.6,
          borderRadius: BorderRadius.circular(10),
        ),
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Theme.of(context).primaryColor),
        columns: createColumn(),
        rows: createRow());
  }

  List<DataColumn> createColumn() {
    return const [
      DataColumn(label: Text("SL.NO.")),
      DataColumn(label: Text("Approve")),
      DataColumn(label: Text("Reject")),
      DataColumn(label: Text("Header")),
      DataColumn(label: Text("Amount")),
      DataColumn(label: Text("Total Slots")),
      DataColumn(label: Text("Slots")),
      DataColumn(label: Text("Applied Amount")),
      // DataColumn(label: Text("Percentage")),
      DataColumn(label: Text("Sanction Amount")),
      DataColumn(label: Text("Approval Remarks")),
    ];
  }

  List<DataRow> createRow() {
    return List.generate(widget.tadaController.editArrayList.length, (index) {
      var value = index + 1;
      return DataRow(cells: [
        DataCell(Text(value.toString())),
        DataCell(Radio(
          fillColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
          groupValue: widget.tadaController.selectedValue[index].isApproved,
          value: true,
          onChanged: (value) {
            setState(() {
              widget.tadaController.selectedValue[index].isApproved = value!;
              widget.tadaController.selectedValue[index].isRejected = !value;

              if (widget.tadaController.selectedValue[index].isApproved) {
                widget.tadaController.textEditingControllerList
                        .elementAt(index)
                        .text =
                    widget.tadaController.editArrayList[index]
                        .vTADAAAHSactionedAmount
                        .toString();

                updateCounts();
              }
            });
          },
        )),
        DataCell(Radio(
          fillColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
          groupValue: widget.tadaController.selectedValue[index].isRejected,
          value: true,
          onChanged: (dynamic value) {
            setState(() {
              widget.tadaController.selectedValue[index].isRejected = value;
              widget.tadaController.selectedValue[index].isApproved = !value;
              if (widget.tadaController.selectedValue[index].isRejected) {
                widget.tadaController.textEditingControllerList
                    .elementAt(index)
                    .text = '0';
              }
              if (widget.tadaController.editArrayList[index]
                      .vTADAAAHSactionedAmount! ==
                  double.parse(widget.tadaController.textEditingControllerList
                      .elementAt(index)
                      .text)) {
                removeAllAmount(double.parse(widget
                    .tadaController.textEditingControllerList
                    .elementAt(index)
                    .text));
              }
              updateCounts();
            });
          },
        )),
        DataCell(Text(
            widget.tadaController.editArrayList[index].vTADAADExpenditureHead ??
                "")),
        DataCell(Text((widget.tadaController.editArrayList[index]
                    .vTADAADExpenditureHead ==
                'Food')
            ? widget.tadaController.foodAmount.toString()
            : (widget.tadaController.editArrayList[index]
                        .vTADAADExpenditureHead ==
                    'Accommodation')
                ? widget.tadaController.accommodationAmount.toString()
                : '')),
        DataCell(Text(
            '${widget.tadaController.editArrayList[index].vTADAADTotalslots ?? ''}')),
        DataCell(Text(
            '${widget.tadaController.editArrayList[index].vTADAADSlots ?? " "}')),
        DataCell(Text(
            "${widget.tadaController.editArrayList[index].vTADAADAmount ?? ''}")),
        // DataCell(Padding(
        //   padding: const EdgeInsets.only(bottom: 4.0),
        //   child: TextFormField(
        //     inputFormatters: [LengthLimitingTextInputFormatter(2)],
        //     readOnly: (widget.tadaController.selectedValue[index] == 'Approved')
        //         ? false
        //         : true,
        //     onChanged: (value) {
        //       setState(() {
        //         if (value != null && value != "" && double.parse(value) > 0) {
        //           double a = 0;
        //           double b = 0;
        //           a = double.parse(value) / 100;
        //           b = double.parse(widget
        //                   .tadaController.tadaEditValues[index].vTADAAADAmount
        //                   .toString()) *
        //               a;
        //           widget.tadaController.textEditingControllerList
        //               .elementAt(index)
        //               .text = b.toStringAsFixed(2);
        //         }
        //       });
        //     },
        //     style: Get.textTheme.titleSmall,
        //     controller: parcentageController,
        //     keyboardType: TextInputType.phone,
        //     decoration: const InputDecoration(
        //       hintText: " ",
        //       contentPadding: EdgeInsets.symmetric(horizontal: 8),
        //     ),
        //   ),
        // )),
        DataCell(Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            readOnly:
                (widget.tadaController.selectedValue[index].isApproved == true)
                    ? false
                    : true,
            onChanged: (value) {
              setState(() {
                if (double.parse(widget
                        .tadaController.editArrayList[index].vTADAADAmount
                        .toString()) >=
                    double.parse(value)) {
                  double totalAmount = 0;
                  value = totalAmount.toStringAsFixed(2);
                  addAllAmount(totalAmount);
                } else {
                  widget.tadaController.textEditingControllerList
                          .elementAt(index)
                          .text =
                      (widget.tadaController.editArrayList[index].vTADAADAmount)
                          .toString();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Sanction Amount should not exceed Actual Amount'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            style: Get.textTheme.titleSmall,
            controller: widget.tadaController.textEditingControllerList
                .elementAt(index),
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "Enter amount",
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
            ),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            readOnly:
                (widget.tadaController.selectedValue[index].isApproved == true)
                    ? false
                    : true,
            style: Get.textTheme.titleSmall,
            controller: widget.tadaController.approvalTextEditingControllerList
                .elementAt(index),
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: "Enter remark",
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
            ),
          ),
        )),
      ]);
    });
  }
}
