import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/particular_indent_details_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/pc_indent_details_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/save_record_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/indent_details_model.dart';

import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';

class PcIndentApprovalScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PcIndentApprovalScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PcIndentApprovalScreen> createState() => _PcIndentApprovalScreenState();
}

class _PcIndentApprovalScreenState extends State<PcIndentApprovalScreen> {
  List<TextEditingController> textEditingControllerList = [];

  double totalApprovedAmount = 0.0;

  TextEditingController totalAmountController = TextEditingController();

  // String descriptionController = "";

  TextEditingController descriptionController = TextEditingController();

  ////*** SAVE VALIDATION ***////

  bool validateFields() {
    if (selectedIndent == null) {
      Fluttertoast.showToast(msg: "Select an Indent.");
      return false;
    }

    if (selectCheckBx!.isEmpty) {
      Fluttertoast.showToast(msg: "Select at least one checkbox.");
      return false;
    }

    bool showAmountError = false;

    for (int index = 0;
        index < _pcapprovalController.eTapprovalAmount.length;
        index++) {
      if (_pcapprovalController.checkList.elementAt(index)) {
        if (_pcapprovalController.eTapprovalAmount
            .elementAt(index)
            .text
            .isEmpty) {
          showAmountError = true;
          break;
        }
      }
    }

    if (showAmountError) {
      Fluttertoast.showToast(msg: "Enter an amount for all selected fields.");
      return false;
    }

    if (totalAmountController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter a total approved amount.");
      return false;
    }

    if (descriptionController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter a description.");
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    selectDate.text = getDateNeed(DateTime.now());

    selectEndDate.text = getEndDate(DateTime.now());

    // Initialize the TextEditingController list
    textEditingControllerList = List.generate(
      _pcapprovalController.particularIndentDetails.length,
      (index) => TextEditingController(),
    );
  }

  // Function to update the Total Approved Amount
  updateTotalApprovedAmount(int index) {
    totalApprovedAmount = 0.0;
    for (int i = 0; i < _pcapprovalController.eTapprovalAmount.length; i++) {
      double cellValue =
          double.tryParse(_pcapprovalController.eTapprovalAmount[i].text) ??
              0.0;
      totalApprovedAmount += cellValue;
    }
    totalAmountController.text = totalApprovedAmount.toString();
  }

  // TextEditingController? totalRequestedAmount;
  // double totalAmount = 0.0;
  // @override
  // void initState() {
  //   super.initState();
  //   totalRequestedAmount = TextEditingController(
  //     text: selectedIndent?.pcindenTRequestedAmount.toString() ?? "",
  //   );
  // }

  // List<double> numsList = [];
  // TextEditingController totalAmountController = TextEditingController();

  // void updateTotalAmount(int index) {
  //  totalAmount += double.parse(
  //         _pcapprovalController.eTapprovalAmount[index].text.toString());

  //   totalAmountController.text = totalAmount.toString();
  // }

  @override
  void dispose() {
    Get.delete<PettyCashApprovalController>();
    // totalAmountController.dispose();

    super.dispose();
  }

  bool isLoading = false;
  PcApprovalFromtoDateModelValues? selectedIndent;
  List<Map<String, dynamic>> featchList = [];
  final PettyCashApprovalController _pcapprovalController =
      Get.put(PettyCashApprovalController());

  int color = 0;

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final TextEditingController selectDate = TextEditingController();
  final TextEditingController selectEndDate = TextEditingController();
  RxInt changes = RxInt(-1);
  List<int>? selectCheckBx = <int>[].obs;
  bool selectAll = false;

  int? indentId;
  String? indentRemarks;
  double? requestedAmount;
  double? sanctionedAmoub;
  int? partId;

  saveRecordApproval() {
    featchList.clear();
    for (int i = 0; i < selectCheckBx!.length; i++) {
      featchList.add({
        "PCINDENTAPDT_Id": _pcapprovalController.particularIndentDetails
            .elementAt(selectCheckBx![i])
            .pcindenTId,
        "PCINDENTAPDT_Remarks": _pcapprovalController.particularIndentDetails
            .elementAt(selectCheckBx![i])
            .pcindentdeTRemarks,
        "PCINDENTAPDT_RequestedAmount": _pcapprovalController
            .particularIndentDetails
            .elementAt(selectCheckBx![i])
            .pcindentdeTAmount,
        "PCINDENTAPDT_SanctionedAmt": _pcapprovalController.eTapprovalAmount
            .elementAt(selectCheckBx![i])
            .text,
        "PCMPART_Id": _pcapprovalController.particularIndentDetails
            .elementAt(selectCheckBx![i])
            .pcmparTId
      });
    }
    // print("prathap${featchList.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 22.0,
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      readOnly: true,
                      controller: fromDate,
                      style: Theme.of(context).textTheme.titleSmall,
                      //controller: date,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 48.0, left: 12),
                        border: const OutlineInputBorder(),
                        label: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFDFFBFE),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/calendar.png",
                                height: 24.0,
                                color: const Color(0xFF28B6C8),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "From Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF28B6C8),
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Select Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () async {
                              DateTime? selectedDT = await showDatePicker(
                                context: context,
                                initialDate: _pcapprovalController
                                    .fromSelectedDate.value,
                                firstDate: DateTime(
                                    1000), //DateTime.now().year, 01, 01
                                lastDate: DateTime(DateTime.now().year, 12, 31),
                              );

                              if (selectedDT == null) {
                                Fluttertoast.showToast(
                                    msg: "You didn't selected the date");
                                return;
                              }
                              changes.value += 1;

                              _pcapprovalController.fromSelectedDate.value =
                                  selectedDT;
                              fromDate.text = getDate(
                                  _pcapprovalController.fromSelectedDate.value);

                              if (changes.value > 1) {
                                if (_pcapprovalController
                                    .pcIndentDetails.isNotEmpty) {
                                  _pcapprovalController.pcIndentDetails.clear();
                                }

                                _pcapprovalController.pcIndentDetails.clear();

                                await getPcIndentApproval(
                                    miId: widget.loginSuccessModel.mIID!,
                                    base: baseUrlFromInsCode("issuemanager",
                                        widget.mskoolController),
                                    roleId: widget.loginSuccessModel.roleId!,
                                    userId: widget.loginSuccessModel.userId!,
                                    asmaYId: widget.loginSuccessModel.asmaYId!,
                                    fromDate: getDateNeed(_pcapprovalController
                                        .fromSelectedDate.value),
                                    toDate: getDateNeed(_pcapprovalController
                                        .toSelectedDate.value),
                                    controller: _pcapprovalController);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                "assets/images/calendar.png",
                                height: 16.0,
                                width: 16.0,
                                color: const Color(0xFF28B6C8),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      readOnly: true,
                      style: Theme.of(context).textTheme.titleSmall,
                      controller: toDate,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(top: 48.0, left: 12),
                        border: const OutlineInputBorder(),
                        label: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFDFFBFE),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/images/calendar.png",
                                  height: 24.0, color: const Color(0xFF28B6C8)),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "To Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF28B6C8)),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Select Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () async {
                              if (changes.value == -1) {
                                Fluttertoast.showToast(
                                    msg: "Select from Date First");
                                return;
                              }
                              DateTime? selectedDT = await showDatePicker(
                                context: context,
                                initialDate: _pcapprovalController
                                    .fromSelectedDate.value,
                                firstDate: _pcapprovalController
                                    .fromSelectedDate.value,
                                lastDate: DateTime(DateTime.now().year, 12, 31),
                              );

                              if (selectedDT == null) {
                                Fluttertoast.showToast(
                                    msg: "You didn't selected the date");
                                return;
                              } else {
                                changes.value += 1;
                                _pcapprovalController.toSelectedDate.value =
                                    selectedDT;
                                toDate.text = getDate(
                                    _pcapprovalController.toSelectedDate.value);

                                // setState(() {

                                _pcapprovalController.pcIndentDetails.clear();

                                await getPcIndentApproval(
                                    miId: widget.loginSuccessModel.mIID!,
                                    base: baseUrlFromInsCode("issuemanager",
                                        widget.mskoolController),
                                    roleId: widget.loginSuccessModel.roleId!,
                                    userId: widget.loginSuccessModel.userId!,
                                    asmaYId: widget.loginSuccessModel.asmaYId!,
                                    fromDate: getDateNeed(_pcapprovalController
                                        .fromSelectedDate.value),
                                    toDate: getDateNeed(_pcapprovalController
                                        .toSelectedDate.value),
                                    controller: _pcapprovalController);

                                // });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                "assets/images/calendar.png",
                                height: 16.0,
                                width: 16.0,
                                color: const Color(0xFF28B6C8),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _pcapprovalController.pcIndentDetails.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),

                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, right: 0, bottom: 0),
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
                        child: DropdownButtonFormField<
                            PcApprovalFromtoDateModelValues>(
                          // value: _pcapprovalController.organizationList.first,
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
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText:
                                _pcapprovalController.pcIndentDetails.isNotEmpty
                                    ? 'Select Indent No.'
                                    : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/Library.png',
                              containerColor: Color.fromRGBO(250, 241, 247, 1),
                              text: 'Select Indent No.',
                              textColor: Color.fromRGBO(252, 77, 173, 1),
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
                              _pcapprovalController.pcIndentDetails.length,
                              (index) {
                            return DropdownMenuItem(
                              value:
                                  _pcapprovalController.pcIndentDetails[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  _pcapprovalController
                                      .pcIndentDetails[index].pcindenTIndentNo!,
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
                          onChanged: (selected) {
                            _pcapprovalController.particularIndentDetails
                                .clear();

                            setState(() {
                              selectedIndent = selected;
                              // totalAmount = 0.0;
                              totalAmountController.text = "";

                              //     numsList.clear();
                              //     print('${numsList}');
                            });
                            // _pcapprovalController.eTapprovalAmount.clear();

                            // indentId = selected!.pcindentaPId!;
                            // indentRemarks = selected.pcindentdeTRemarks!;
                            // requestedAmount = selected. ;
                            // sanctionedAmoub = selected. ;
                            // partId = ;

                            getParticularIndentDetails(
                                miId: widget.loginSuccessModel.mIID!,
                                base: baseUrlFromInsCode(
                                    "issuemanager", widget.mskoolController),
                                roleId: widget.loginSuccessModel.roleId!,
                                userId: widget.loginSuccessModel.userId!,
                                asmaYId: widget.loginSuccessModel.asmaYId!,
                                tempIndentId: selected!.pcindenTId!.toInt(),
                                controller: _pcapprovalController);
                          },
                        ),
                      ),

                      // AnimatedProgressWidget(
                      //         animationPath: 'assets/json/nodata.json',
                      //         title: 'Select',
                      //         desc: "Select the From and To Date to show the Data",
                      //         animatorHeight: 250,
                      //       ),

                      /////*****   DATA TABLE FOR INDENT    *****/////

                      _pcapprovalController.particularIndentDetails.isNotEmpty
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),

                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "INDENT DETAILS",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.indigo),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    dataTextStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromRGBO(5, 5, 5, 0.945),
                                        fontWeight: FontWeight.w500),
                                    dataRowHeight: 60,
                                    headingRowHeight: 55,
                                    horizontalMargin: 10,
                                    columnSpacing: 40,
                                    dividerThickness: 1,
                                    border: TableBorder.all(
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    headingRowColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor),
                                    columns: const [
                                      DataColumn(
                                          label: Text("S No.",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      DataColumn(
                                          label: Text("Indent No.",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      DataColumn(
                                          label: Text("Department",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      DataColumn(
                                          label: Text("Indent Approved By",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      DataColumn(
                                          label: Text("Date",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      DataColumn(
                                          label: Text("Indent Requested Amount",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      DataColumn(
                                          label: Text("Indent Approved Amount",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                    ],
                                    rows: [
                                      DataRow(
                                        cells: [
                                          const DataCell(Align(
                                            alignment: Alignment.center,
                                            child: Text('1'),
                                          )),
                                          DataCell(Text(
                                              "${selectedIndent?.pcindenTIndentNo}")),
                                          DataCell(Text(
                                              "${selectedIndent?.departmentname}")),
                                          DataCell(Text(
                                              "${selectedIndent?.employeename}")),
                                          DataCell(Text(selectedIndent
                                                      ?.createdate !=
                                                  null
                                              ? getDateNeed(DateTime.parse(
                                                  selectedIndent!.createdate!))
                                              : "No Date Available")),
                                          DataCell(Text(
                                              "${selectedIndent?.pcindenTRequestedAmount}")),
                                          DataCell(Text(
                                              "${selectedIndent?.pcindenTApprovedAmt}")),
                                        ],
                                      ),
                                      // Add more rows as needed
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 35,
                                ),

                                /////*****   DATA TABLE FOR PARTICULAR INDENT DETAILS   *****/////
                                Obx(
                                  () => Column(
                                    children: [
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "INDENT PARICULAR DETAILS",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.indigo),
                                          )),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                            dataTextStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    5, 5, 5, 0.945),
                                                fontWeight: FontWeight.w500),
                                            dataRowHeight: 60,
                                            headingRowHeight: 55,
                                            horizontalMargin: 10,
                                            columnSpacing: 40,
                                            dividerThickness: 1,
                                            border: TableBorder.all(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10))),
                                            headingRowColor:
                                                MaterialStateProperty.all(
                                                    Theme.of(context)
                                                        .primaryColor),
                                            columns: [
                                              DataColumn(
                                                  label: Checkbox(
                                                shape:
                                                    ContinuousRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                activeColor: Colors.indigo,
                                                value: selectAll,
                                                onChanged: (value) {
                                                  selectAll = value!;
                                                  setState(() {
                                                    if (selectAll) {
                                                      selectCheckBx!.clear();
                                                      for (int i = 0;
                                                          i <
                                                              _pcapprovalController
                                                                  .eTapprovalAmount
                                                                  .length;
                                                          i++) {
                                                        selectCheckBx!.add(i);
                                                        _pcapprovalController
                                                                .checkList[i] =
                                                            true;

                                                        logger.i(selectCheckBx
                                                            .toString());
                                                      }
                                                    } else {
                                                      for (int i = 0;
                                                          i <
                                                              _pcapprovalController
                                                                  .eTapprovalAmount
                                                                  .length;
                                                          i++) {
                                                        selectCheckBx!
                                                            .remove(i);

                                                        _pcapprovalController
                                                                .checkList[i] =
                                                            false;

                                                        _pcapprovalController
                                                            .eTapprovalAmount[i]
                                                            .text = '';
                                                        logger.i(selectCheckBx
                                                            .toString());
                                                      }
                                                    }
                                                  });
                                                },
                                              )),
                                              const DataColumn(
                                                  label: Text("S No.",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              const DataColumn(
                                                  label: Text("Indent No.",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              const DataColumn(
                                                  label: Text("Particulars",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              const DataColumn(
                                                  label: Text(
                                                      "Indent Requested Amount",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              const DataColumn(
                                                  label: Text("Indent Amount",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              const DataColumn(
                                                  label: Text("Approved Amount",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              const DataColumn(
                                                  label: Text("Remarks",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                            ],
                                            rows: List.generate(
                                                _pcapprovalController
                                                    .particularIndentDetails
                                                    .length, (index) {
                                              var i = index + 1;
                                              return DataRow(
                                                cells: [
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Checkbox(
                                                      activeColor:
                                                          Colors.indigo,
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      value:
                                                          _pcapprovalController
                                                              .checkList
                                                              .elementAt(index),
                                                      onChanged: (value) {
                                                        _pcapprovalController
                                                                .checkList[
                                                            index] = value!;
                                                        setState(() {
                                                          if (value) {
                                                            if (selectCheckBx!
                                                                .contains(
                                                                    index)) {
                                                              selectCheckBx!
                                                                  .remove(
                                                                      index);
                                                              logger.i(
                                                                  selectCheckBx
                                                                      .toString());

                                                              // totalApprovedAmount = 0.0;

                                                              _pcapprovalController
                                                                  .eTapprovalAmount
                                                                  .elementAt(
                                                                      index)
                                                                  .text = '';

                                                              if (_pcapprovalController
                                                                      .eTapprovalAmount
                                                                      .length !=
                                                                  selectCheckBx!
                                                                      .length) {
                                                                selectAll =
                                                                    false;
                                                              }
                                                            } else {
                                                              updateTotalApprovedAmount(
                                                                  index);
                                                              selectCheckBx!
                                                                  .add(index);
                                                              logger.i(
                                                                  selectCheckBx
                                                                      .toString());
                                                              if (_pcapprovalController
                                                                      .eTapprovalAmount
                                                                      .length ==
                                                                  selectCheckBx!
                                                                      .length) {
                                                                selectAll =
                                                                    true;
                                                              }
                                                            }
                                                          } else {
                                                            _pcapprovalController
                                                                .eTapprovalAmount
                                                                .elementAt(
                                                                    index)
                                                                .text = '';

                                                            // totalApprovedAmount = 0.0;

                                                            selectCheckBx!
                                                                .remove(index);
                                                            logger.i(
                                                                selectCheckBx
                                                                    .toString());
                                                            if (_pcapprovalController
                                                                    .eTapprovalAmount
                                                                    .length !=
                                                                selectCheckBx!
                                                                    .length) {
                                                              selectAll = false;
                                                            }
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  )),
                                                  DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('$i'))),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        "${_pcapprovalController.particularIndentDetails.elementAt(index).pcindenTIndentNo}"),
                                                  )),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        "${_pcapprovalController.particularIndentDetails.elementAt(index).pcmparTParticularName}"),
                                                  )),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        "${_pcapprovalController.particularIndentDetails.elementAt(index).pcindentdeTAmount}"),
                                                  )),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        "${_pcapprovalController.particularIndentDetails.elementAt(index).pcindentdeTApprovedAmt}"),
                                                  )),
                                                  DataCell(
                                                    Align(
                                                        alignment:
                                                            Alignment.center,
                                                        // child: TapRegion(
                                                        // onTapOutside:(event) {
                                                        //   if(_pcapprovalController.eTapprovalAmount.last ==true){
                                                        //      updateTotalAmount(index);
                                                        //   }

                                                        // } ,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (!_pcapprovalController
                                                                .checkList
                                                                .elementAt(
                                                                    index)) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Select Checkbox");
                                                            } else {
                                                              // Handle tap event when the condition is met
                                                            }
                                                          },
                                                          child: AbsorbPointer(
                                                            absorbing:
                                                                !_pcapprovalController
                                                                    .checkList
                                                                    .elementAt(
                                                                        index),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  _pcapprovalController
                                                                      .eTapprovalAmount
                                                                      .elementAt(
                                                                          index),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              enabled: _pcapprovalController
                                                                  .checkList
                                                                  .elementAt(
                                                                      index), // Enable the TextField when the condition is met
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Enter Amount';
                                                                }
                                                                return null;
                                                              },
                                                              onChanged:
                                                                  (text) {
                                                                if (!_pcapprovalController
                                                                    .checkList
                                                                    .elementAt(
                                                                        index)) {
                                                                  _pcapprovalController
                                                                      .eTapprovalAmount
                                                                      .elementAt(
                                                                          index)
                                                                      .text = '';
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        )),
                                                  )
                                                  // )
                                                  ,
                                                  DataCell(
                                                    Text(
                                                        "${_pcapprovalController.particularIndentDetails.elementAt(index).pcindentdeTRemarks}"),
                                                  ),
                                                ],
                                              );
                                            })),
                                      ),
                                      const SizedBox(height: 35),
                                      CustomContainer(
                                          child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 22.0,
                                                bottom: 22,
                                                left: 16,
                                                right: 4),
                                            child: Text(
                                              "Total Requested Amount :   ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 138, 137, 137)),
                                            ),
                                          ),
                                          Text(
                                            "${selectedIndent?.pcindenTRequestedAmount}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )),
                                      const SizedBox(height: 35),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                int index = 0;
                                                updateTotalApprovedAmount(
                                                    index);
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 241, 253, 240),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Text(
                                                "Calculate",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 15, 87, 42)),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 211, 211, 211)),
                                            ),
                                            child: TextField(
                                              onTap: () {
                                                setState(() {
                                                  int index = 0;
                                                  updateTotalApprovedAmount(
                                                      index);
                                                });
                                              },
                                              controller: totalAmountController,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Tap to view Total Amount",
                                                hintStyle: const TextStyle(
                                                    color: Color.fromARGB(
                                                        136, 189, 187, 187),
                                                    fontWeight:
                                                        FontWeight.w700),
                                                border:
                                                    const OutlineInputBorder(),
                                                label: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 12),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 6.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                    color: const Color.fromARGB(
                                                        255, 241, 253, 240),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/money.png",
                                                        height: 24.0,
                                                      ),
                                                      const SizedBox(
                                                          width: 6.0),
                                                      Text(
                                                        " Total Approved Amount ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .merge(const TextStyle(
                                                                fontSize: 20.0,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        15,
                                                                        87,
                                                                        42))),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 35),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 211, 211, 211)),
                                        ),
                                        child: TextField(
                                          // onTap: () {
                                          //   setState(() {
                                          //     int index = 0;
                                          //     updateTotalApprovedAmount(index);
                                          //   });
                                          // },
                                          controller: descriptionController,
                                          maxLines: 4,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,

                                          decoration: InputDecoration(
                                            hintText: "Enter Description",
                                            hintStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    136, 189, 187, 187),
                                                fontWeight: FontWeight.w700),
                                            border: const OutlineInputBorder(),
                                            label: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 12),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 6.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                color: const Color.fromARGB(
                                                    255, 241, 253, 240),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/abouticon.png",
                                                    height: 24.0,
                                                  ),
                                                  const SizedBox(width: 6.0),
                                                  Text(
                                                    "Description",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .merge(const TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    15,
                                                                    87,
                                                                    42))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      CustomContainer(
                                        child: TextField(
                                          readOnly: true,
                                          controller: selectDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 48.0, left: 12),
                                            border: const OutlineInputBorder(),
                                            label: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                color: const Color(0xFFDFFBFE),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/calendar.png",
                                                    height: 24.0,
                                                    color:
                                                        const Color(0xFF28B6C8),
                                                  ),
                                                  const SizedBox(
                                                    width: 6.0,
                                                  ),
                                                  Text(
                                                    "Select Date",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .merge(
                                                          const TextStyle(
                                                            fontSize: 20.0,
                                                            color: Color(
                                                                0xFF28B6C8),
                                                          ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            hintText: 'Select Date',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () async {
                                                DateTime? selectedDT =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1000),
                                                  lastDate: DateTime.now(),
                                                );

                                                if (selectedDT == null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "You didn't select the date");
                                                  return;
                                                }
                                                changes.value += 1;

                                                selectDate.text =
                                                    getDate(selectedDT);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Image.asset(
                                                  "assets/images/calendar.png",
                                                  height: 16.0,
                                                  width: 16.0,
                                                  color:
                                                      const Color(0xFF28B6C8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    235, 56, 23, 243),
                                          ),
                                          onPressed: () async {
                                            if (!validateFields()) {
                                              return;
                                            }

                                            setState(() {
                                              int index = 0;
                                              updateTotalApprovedAmount(index);
                                            });

                                            setState(() {
                                              isLoading = true;
                                            });

                                            await saveRecordApproval();
                                            int status = await approveApi(
                                              base: baseUrlFromInsCode(
                                                  "issuemanager",
                                                  widget.mskoolController),
                                              userId: widget
                                                  .loginSuccessModel.userId!,
                                              roleId: widget
                                                  .loginSuccessModel.roleId!,
                                              miId: widget
                                                  .loginSuccessModel.mIID!,
                                              asmayId: widget
                                                  .loginSuccessModel.asmaYId!,
                                              pcIndentId:
                                                  selectedIndent!.pcindenTId!,
                                              pcIndentNo: selectedIndent!
                                                  .pcindenTIndentNo!,
                                              pcIndentDesc:
                                                  descriptionController.text,
                                              pcIndentSanctionedAmt:
                                                  double.parse(
                                                      totalAmountController
                                                          .text),
                                              pcIndentRequestedAmt:
                                                  selectedIndent!
                                                      .pcindenTRequestedAmount!,
                                              pcIndentDate: getDateNeed(
                                                  _pcapprovalController
                                                      .selectDate.value),
                                              featchList: featchList,
                                            );

                                            if (status == 200) {
                                              setState(() {
                                                isLoading = false;
                                                // _pcapprovalController.eTapprovalAmount.clear();
                                                descriptionController.clear();

                                                _pcapprovalController
                                                    .pcIndentDetails
                                                    .clear();
                                                _pcapprovalController
                                                    .particularIndentDetails
                                                    .clear();
                                                _pcapprovalController
                                                    .eTapprovalAmount
                                                    .clear();
                                                _pcapprovalController
                                                    .pcIndentDetails
                                                    .clear();
                                                selectedIndent == null;
                                                selectCheckBx!.clear();
                                                totalAmountController.clear();
                                                fromDate.clear();
                                                toDate.clear();
                                              });
                                              Fluttertoast.showToast(
                                                  msg: "Saved Successfully");
                                            }
                                          },
                                          child: isLoading
                                              ? const SizedBox(
                                                  height: 18,
                                                  width: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 13.0,
                                                    bottom: 13,
                                                    left: 14,
                                                    right: 14,
                                                  ),
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Visibility(
                              visible: !_pcapprovalController
                                  .particularIndentDetails.isNotEmpty,
                              child: const AnimatedProgressWidget(
                                animationPath: 'assets/json/nodata.json',
                                title: 'Select Indent No.',
                                desc: "Select the Indent No. to show the Data",
                                animatorHeight: 250,
                              ),
                            ),
                    ],
                  )
                : Visibility(
                    visible: !_pcapprovalController.pcIndentDetails.isNotEmpty,
                    child: const AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'Select From and To Date',
                      desc: "Select the From and To Date to show the Data",
                      animatorHeight: 250,
                    ),
                  ),
          ],
        ),
      );
    });
  }

  String getEndDate(DateTime dt) {
    return "${dt.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
  }

  String getDateNeed(DateTime dt) {
    return "${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}-${dt.year}";
  }
}
