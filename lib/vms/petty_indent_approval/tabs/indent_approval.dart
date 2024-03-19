// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/api/date_onchange_indent_api.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/api/onchange_indent_approval_api.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/api/onload_indent_approve_api.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/api/particular_details_api.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/api/save_indent_approval_api.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/onload_ins_indent_approve_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';

class IndentApproval extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const IndentApproval(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<IndentApproval> createState() => _IndentApprovalState();
}

class _IndentApprovalState extends State<IndentApproval> {
  // final ValueNotifier<bool?> allSelected = ValueNotifier(false);
  final Map<int, bool?> selectedRowsParticular = {};
  Map<int, TextEditingController> textEditingCtrlParticularAmt = {};
  bool dataColumnSelected = false;

  PettyIndentApprovalController indentApprovalController =
      Get.put(PettyIndentApprovalController());

  InstitutionIndentApprovalModelValues? selectedOrganization;

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final TextEditingController selectDate = TextEditingController();
  RxInt changes = RxInt(-1);
  List<int>? selectCheckBx = <int>[].obs;
  bool selectAll = false;
  bool isLoading = false;
  bool dateinvisible = false;
  Set<int> selectedRows = {};

  List<int> selectedRequisitionIds = [];

  List<Map<String, dynamic>> tempRequisitionId = [];

  double totalRequestedAmount = 0.0;

  void clearFirstCheckboxDt() {
    setState(() {
      fromDate.clear();
      toDate.clear();
      selectedRows.clear();
      selectedRequisitionIds.clear();
      tempRequisitionId.clear();
      indentApprovalController.requisitiondetais.clear();
    });
  }

  @override
  void initState() {
    indentApprovalController = Get.put(PettyIndentApprovalController());
    selectDate.text = getDate(DateTime.now());
    onLoadData();
    super.initState();
  }

  ////*** SAVE VALIDATION ***////

  bool validateFields() {
    if (selectCheckBx!.isEmpty) {
      Fluttertoast.showToast(
          msg: "Select Requisition Particular Details checkbox");
      return false;
    }

    if (selectCheckBx!.isNotEmpty &&
        selectCheckBx!.any((index) =>
            indentApprovalController.eTapprovalAmount[index].text.isEmpty)) {
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

  double totalApprovedAmount = 0.0;

  TextEditingController totalAmountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  updateTotalApprovedAmount(int index) {
    totalApprovedAmount = 0.0;
    for (int i = 0; i < indentApprovalController.eTapprovalAmount.length; i++) {
      double cellValue =
          double.tryParse(indentApprovalController.eTapprovalAmount[i].text) ??
              0.0;
      totalApprovedAmount += cellValue;
    }
    totalAmountController.text = totalApprovedAmount.toString();
  }

  onLoadData() {
    getIndentApprovalOnload(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        roleId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        asmaYId: widget.loginSuccessModel.asmaYId!,
        roleFlag: widget.loginSuccessModel.roleforlogin!,
        controller: indentApprovalController);
  }

  List<Map<String, dynamic>> featchList = [];

  saveRecordApproval() {
    featchList.clear();
    for (int i = 0; i < selectCheckBx!.length; i++) {
      featchList.add({
        "PCINDENT_Id": indentApprovalController.particularRequisitionDetais
            .elementAt(selectCheckBx![i])
            .pcindenTId,
        "PCINDENTDET_Remarks": indentApprovalController
            .particularRequisitionDetais
            .elementAt(selectCheckBx![i])
            .pcreqtndeTRemarks,
        "PCINDENTDET_Amount": indentApprovalController
            .particularRequisitionDetais
            .elementAt(selectCheckBx![i])
            .pcreqtndeTAmount,
        "PCINDENTDET_ApprovedAmt": indentApprovalController.eTapprovalAmount
            .elementAt(selectCheckBx![i])
            .text,
        "PCMPART_Id": indentApprovalController.particularRequisitionDetais
            .elementAt(selectCheckBx![i])
            .pcmparTId,
        "PCREQTN_Id": indentApprovalController.particularRequisitionDetais
            .elementAt(selectCheckBx![i])
            .pcreqtNId
      });
    }
    print("prathap${featchList.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    print("$totalRequestedAmount");
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            indentApprovalController.isLoadingOnloadorganization.isTrue
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading data',
                    desc: "Please wait we are loading data",
                    // animatorHeight: 250,
                  )
                : Container(
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
                        InstitutionIndentApprovalModelValues>(
                      value: indentApprovalController.organizationList.first,
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
                            indentApprovalController.organizationList.isNotEmpty
                                ? 'Select Organization'
                                : 'No data available',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        isDense: true,
                        label: const CustomDropDownLabel(
                          icon: 'assets/images/Library.png',
                          containerColor: Color.fromRGBO(250, 241, 247, 1),
                          text: 'Select Organization',
                          textColor: Color.fromRGBO(252, 77, 173, 1),
                        ),
                      ),
                      icon: const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 25,
                        ),
                      ),
                      iconSize: 30,
                      items: List.generate(
                          indentApprovalController.organizationList.length,
                          (index) {
                        return DropdownMenuItem(
                          value:
                              indentApprovalController.organizationList[index],
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 5, bottom: 2),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text(
                                indentApprovalController
                                    .organizationList[index].mIName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          ),
                        );
                      }),
                      onChanged: (selected) {
                        setState(() {
                          selectedOrganization = selected;
                        });

                        getIndentApprovalOnChange(
                            miId: selectedOrganization!
                                .mIId!, //widget.loginSuccessModel.mIID!,
                            base: baseUrlFromInsCode(
                                "issuemanager", widget.mskoolController),
                            controller: indentApprovalController,
                            roleId: widget.loginSuccessModel.roleId!,
                            userId: widget.loginSuccessModel.userId!,
                            asmaYId: widget.loginSuccessModel.asmaYId!,
                            roleFlag: widget.loginSuccessModel.roleforlogin!);
                      },
                    ),
                  ),
            const SizedBox(
              height: 32.0,
            ),
            Visibility(
              visible: indentApprovalController.organizationList.isNotEmpty,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomContainer(
                      child: TextField(
                        readOnly: true,
                        controller: fromDate,
                        style: Theme.of(context).textTheme.titleSmall,
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
                                  initialDate: indentApprovalController
                                      .fromSelectedDate.value,
                                  firstDate: DateTime(
                                      1000), //DateTime.now().year, 01, 01
                                  lastDate: DateTime.now(),
                                );

                                if (selectedDT == null) {
                                  Fluttertoast.showToast(
                                      msg: "You didn't selected the date");
                                  return;
                                }
                                changes.value += 1;

                                fromDate.text = getDate(selectedDT);

                                indentApprovalController
                                    .fromSelectedDate.value = selectedDT;
                                fromDate.text = getDate(indentApprovalController
                                    .fromSelectedDate.value);

                                if (changes.value > 1) {
                                  if (indentApprovalController
                                      .getapproveddata.isNotEmpty) {
                                    indentApprovalController.getapproveddata
                                        .clear();
                                  }

                                  indentApprovalController.requisitiondetais
                                      .clear();

                                  await getPcIndentApproval(
                                      miId: selectedOrganization!
                                          .mIId!, //widget.loginSuccessModel.mIID!,
                                      base: baseUrlFromInsCode("issuemanager",
                                          widget.mskoolController),
                                      roleId: widget.loginSuccessModel.roleId!,
                                      userId: widget.loginSuccessModel.userId!,
                                      asmaYId:
                                          widget.loginSuccessModel.asmaYId!,
                                      fromDate: getDateNeed(
                                          indentApprovalController
                                              .fromSelectedDate.value),
                                      toDate: getDateNeed(
                                          indentApprovalController
                                              .toSelectedDate.value),
                                      controller: indentApprovalController);
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
                                    height: 24.0,
                                    color: const Color(0xFF28B6C8)),
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
                                  initialDate: indentApprovalController
                                      .fromSelectedDate.value,
                                  firstDate: indentApprovalController
                                      .fromSelectedDate.value,
                                  lastDate: DateTime.now(),
                                );

                                if (selectedDT == null) {
                                  Fluttertoast.showToast(
                                      msg: "You didn't selected the date");
                                  return;
                                } else {
                                  changes.value += 1;
                                  indentApprovalController
                                      .toSelectedDate.value = selectedDT;
                                  toDate.text = getDate(indentApprovalController
                                      .toSelectedDate.value);

                                  indentApprovalController.requisitiondetais
                                      .clear();

                                  await getPcIndentApproval(
                                      miId: selectedOrganization!
                                          .mIId!, //widget.loginSuccessModel.mIID!,
                                      base: baseUrlFromInsCode("issuemanager",
                                          widget.mskoolController),
                                      roleId: widget.loginSuccessModel.roleId!,
                                      userId: widget.loginSuccessModel.userId!,
                                      asmaYId:
                                          widget.loginSuccessModel.asmaYId!,
                                      fromDate: getDateNeed(
                                          indentApprovalController
                                              .fromSelectedDate.value),
                                      toDate: getDateNeed(
                                          indentApprovalController
                                              .toSelectedDate.value),
                                      controller: indentApprovalController);
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
            ),
            indentApprovalController.requisitiondetais.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "REQUISITION DETAILS",
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            dataTextStyle: const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(5, 5, 5, 0.945),
                              fontWeight: FontWeight.w400,
                            ),
                            dataRowHeight: 60,
                            headingRowHeight: 55,
                            horizontalMargin: 10,
                            columnSpacing: 40,
                            dividerThickness: 1,
                            border: TableBorder.all(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            headingRowColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            columns: [
                              DataColumn(
                                label: Checkbox(
                                  activeColor:
                                      const Color.fromARGB(31, 68, 4, 247),
                                  value: selectedRows.length ==
                                      indentApprovalController
                                          .requisitiondetais.length,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          indentApprovalController
                                              .particularRequisitionDetais
                                              .clear();

                                          // selectedRows.clear();
                                          selectedRows = Set<int>.from(
                                            List.generate(
                                              indentApprovalController
                                                  .requisitiondetais.length,
                                              (index) => index,
                                            ),
                                          );
                                        } else {
                                          indentApprovalController
                                              .particularRequisitionDetais
                                              .clear();
                                          selectedRows.clear();
                                        }

                                        selectedRequisitionIds.clear();
                                        totalRequestedAmount = 0.0;
                                        tempRequisitionId.clear();
                                        for (int i = 0;
                                            i < selectedRows.length;
                                            i++) {
                                          selectedRequisitionIds.add(i);
                                          tempRequisitionId.add({
                                            "PCREQTN_Id":
                                                indentApprovalController
                                                    .requisitiondetais[i]
                                                    .pcreqtNId,
                                          });
                                          totalRequestedAmount +=
                                              indentApprovalController
                                                      .requisitiondetais[
                                                          selectedRows
                                                              .elementAt(i)]
                                                      .pcreqtNTotAmount ??
                                                  0.0;
                                        }

                                        // selectedRows.clear();

                                        particularReqDetails(
                                          tempRequisitionId: tempRequisitionId,
                                          miId: selectedOrganization!
                                              .mIId!, //widget.loginSuccessModel.mIID!,
                                          asmaYId:
                                              widget.loginSuccessModel.asmaYId!,
                                          base: baseUrlFromInsCode(
                                              "issuemanager",
                                              widget.mskoolController),
                                          controller: indentApprovalController,
                                          roleFlag: widget
                                              .loginSuccessModel.roleforlogin!,
                                          roleId:
                                              widget.loginSuccessModel.roleId!,
                                          userId:
                                              widget.loginSuccessModel.userId!,
                                        );
                                      }
                                    });
                                  },
                                ),
                              ),
                              const DataColumn(
                                label: Text("Sl No",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                              const DataColumn(
                                label: Text("Requisition No.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                              const DataColumn(
                                label: Text("Department",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                              const DataColumn(
                                label: Text("Requested By",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                              const DataColumn(
                                label: Text("Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                              const DataColumn(
                                label: Text("Total Amount",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                              const DataColumn(
                                label: Text("Purpose",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ],
                            rows: List.generate(
                              indentApprovalController.requisitiondetais.length,
                              (index) {
                                var i = index + 1;

                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Checkbox(
                                        activeColor: const Color.fromARGB(
                                            255, 55, 67, 241),
                                        value: selectedRequisitionIds
                                            .contains(index),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value != null) {
                                              if (value) {
                                                selectedRequisitionIds
                                                    .add(index);
                                                totalRequestedAmount +=
                                                    indentApprovalController
                                                            .requisitiondetais[
                                                                index]
                                                            .pcreqtNTotAmount ??
                                                        0.0;
                                              } else {
                                                selectedRequisitionIds
                                                    .remove(index);
                                                totalRequestedAmount -=
                                                    indentApprovalController
                                                            .requisitiondetais[
                                                                index]
                                                            .pcreqtNTotAmount ??
                                                        0;

                                                indentApprovalController
                                                    .checkBoxList
                                                    .clear();
                                                selectAll = false;
                                              }
                                              tempRequisitionId.clear();
                                              for (int i = 0;
                                                  i <
                                                      selectedRequisitionIds
                                                          .length;
                                                  i++) {
                                                tempRequisitionId.add({
                                                  "PCREQTN_Id":
                                                      indentApprovalController
                                                          .requisitiondetais[
                                                              selectedRequisitionIds[
                                                                  i]]
                                                          .pcreqtNId,
                                                });
                                              }

                                              if (indentApprovalController
                                                  .particularRequisitionDetais
                                                  .isNotEmpty) {
                                                indentApprovalController
                                                    .particularRequisitionDetais
                                                    .clear();
                                                selectCheckBx!.clear();
                                              }

                                              particularReqDetails(
                                                tempRequisitionId:
                                                    tempRequisitionId,
                                                miId: selectedOrganization!
                                                    .mIId!, //widget.loginSuccessModel.mIID!,
                                                asmaYId: widget
                                                    .loginSuccessModel.asmaYId!,
                                                base: baseUrlFromInsCode(
                                                    "issuemanager",
                                                    widget.mskoolController),
                                                controller:
                                                    indentApprovalController,
                                                roleFlag: widget
                                                    .loginSuccessModel
                                                    .roleforlogin!,
                                                roleId: widget
                                                    .loginSuccessModel.roleId!,
                                                userId: widget
                                                    .loginSuccessModel.userId!,
                                              );
                                            } else {
                                              selectCheckBx!.clear();
                                              selectCheckBx!.remove(index);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text('$i')),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${indentApprovalController.requisitiondetais.elementAt(index).pcreqtNRequisitionNo}"),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${indentApprovalController.requisitiondetais.elementAt(index).departmentname}"),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${indentApprovalController.requisitiondetais.elementAt(index).employeename}"),
                                      ),
                                    ),
                                    DataCell(
                                      Text(getDateNeed(DateTime.parse(
                                          indentApprovalController
                                              .requisitiondetais
                                              .elementAt(index)
                                              .createdate!))),
                                    ),
                                    DataCell(
                                      Text(
                                          "${indentApprovalController.requisitiondetais.elementAt(index).pcreqtNTotAmount}"),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${indentApprovalController.requisitiondetais.elementAt(index).pcreqtNPurpose}"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 45,
                      ),

                      ///*****   DATA TABLE FOR PARTICULAR INDENT DETAILS   *****/////

                      indentApprovalController
                              .particularRequisitionDetais.isEmpty
                          ? const AnimatedProgressWidget(
                              animationPath: 'assets/json/nodata.json',
                              title: "Select Requisition Checkbox",
                              desc:
                                  "Select Requisition Detail's Checkbox to show the available Data",
                              animatorHeight: 250,
                            )
                          : Obx(
                              () => Column(
                                children: [
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "REQUISITION PARTICULAR DETAILS",
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: DataTable(
                                          dataTextStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  5, 5, 5, 0.945),
                                              fontWeight: FontWeight.w400),
                                          dataRowHeight: 60,
                                          headingRowHeight: 55,
                                          horizontalMargin: 10,
                                          columnSpacing: 40,
                                          dividerThickness: 1,
                                          border: TableBorder.all(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          headingRowColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor),
                                          columns: [
                                            DataColumn(
                                                label: Checkbox(
                                              shape: ContinuousRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              activeColor: Colors.indigo,
                                              value: selectAll,
                                              onChanged: (value) {
                                                selectAll = value!;
                                                setState(() {
                                                  if (selectAll) {
                                                    selectCheckBx!.clear();
                                                    for (int i = 0;
                                                        i <
                                                            indentApprovalController
                                                                .eTapprovalAmount
                                                                .length;
                                                        i++) {
                                                      selectCheckBx!.add(i);
                                                      indentApprovalController
                                                              .checkBoxList[i] =
                                                          true;

                                                      print(selectCheckBx
                                                          .toString());
                                                    }
                                                  } else {
                                                    for (int i = 0;
                                                        i <
                                                            indentApprovalController
                                                                .eTapprovalAmount
                                                                .length;
                                                        i++) {
                                                      selectCheckBx!.remove(i);

                                                      indentApprovalController
                                                              .checkBoxList[i] =
                                                          false;

                                                      indentApprovalController
                                                          .eTapprovalAmount[i]
                                                          .text = '';
                                                      print(selectCheckBx
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
                                                        fontWeight:
                                                            FontWeight.w800))),
                                            const DataColumn(
                                                label: Text("Requisition No.",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                            const DataColumn(
                                                label: Text("Particulars",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                            const DataColumn(
                                                label: Text("Requested Amount",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                            const DataColumn(
                                                label: Text("Approved Amount",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                            const DataColumn(
                                                label: Text("Remarks",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                          ],
                                          rows: List.generate(
                                              indentApprovalController
                                                  .particularRequisitionDetais
                                                  .length, (index) {
                                            var i = index + 1;
                                            return DataRow(
                                              cells: [
                                                DataCell(Align(
                                                  alignment: Alignment.center,
                                                  child: Checkbox(
                                                    activeColor: Colors.indigo,
                                                    shape:
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    value:
                                                        indentApprovalController
                                                            .checkBoxList
                                                            .elementAt(index),
                                                    onChanged: (value) {
                                                      indentApprovalController
                                                              .checkBoxList[
                                                          index] = value!;
                                                      setState(() {
                                                        if (value) {
                                                          if (selectCheckBx!
                                                              .contains(
                                                                  index)) {
                                                            selectCheckBx!
                                                                .remove(index);
                                                            print(selectCheckBx
                                                                .toString());

                                                            indentApprovalController
                                                                .eTapprovalAmount
                                                                .elementAt(
                                                                    index)
                                                                .text = '';

                                                            if (indentApprovalController
                                                                    .checkBoxList
                                                                    .length !=
                                                                selectCheckBx!
                                                                    .length) {
                                                              selectAll = false;
                                                            }
                                                          } else {
                                                            updateTotalApprovedAmount(
                                                                index);
                                                            selectCheckBx!
                                                                .add(index);
                                                            print("select  ");
                                                            if (indentApprovalController
                                                                    .checkBoxList
                                                                    .length ==
                                                                selectCheckBx!
                                                                    .length) {
                                                              selectAll = true;
                                                              print(
                                                                  "select all");
                                                            }
                                                          }
                                                        } else {
                                                          indentApprovalController
                                                              .eTapprovalAmount
                                                              .elementAt(index)
                                                              .text = '';

                                                          selectCheckBx!
                                                              .remove(index);
                                                          print(selectCheckBx
                                                              .toString());
                                                          if (indentApprovalController
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
                                                    alignment: Alignment.center,
                                                    child: Text('$i'))),
                                                DataCell(Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      "${indentApprovalController.particularRequisitionDetais.elementAt(index).pcreqtNRequisitionNo}"),
                                                )),
                                                DataCell(Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      "${indentApprovalController.particularRequisitionDetais.elementAt(index).pcmparTParticularName}"),
                                                )),
                                                DataCell(Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      "${indentApprovalController.particularRequisitionDetais.elementAt(index).pcreqtndeTAmount}"),
                                                )),
                                                DataCell(
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      // child: TapRegion(
                                                      // onTapOutside:(event) {
                                                      //   if(indentApprovalController.eTapprovalAmount.last ==true){
                                                      //      updateTotalAmount(index);
                                                      //   }

                                                      // } ,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (!indentApprovalController
                                                              .checkBoxList
                                                              .elementAt(
                                                                  index)) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Select Checkbox");
                                                          } else {
                                                            // Handle tap event when the condition is met
                                                          }
                                                        },
                                                        child: AbsorbPointer(
                                                          absorbing:
                                                              !indentApprovalController
                                                                  .checkBoxList
                                                                  .elementAt(
                                                                      index),
                                                          child: TextFormField(
                                                            style: Get.textTheme
                                                                .titleSmall,
                                                            controller:
                                                                indentApprovalController
                                                                    .eTapprovalAmount
                                                                    .elementAt(
                                                                        index),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            enabled: indentApprovalController
                                                                .checkBoxList
                                                                .elementAt(
                                                                    index), // Enable the TextField when the condition is met
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Enter Amount';
                                                              }
                                                              return null;
                                                            },
                                                            // onChanged: (text) {
                                                            //   if (!indentApprovalController
                                                            //       .checkBoxList
                                                            //       .elementAt(
                                                            //           index)) {
                                                            //     indentApprovalController
                                                            //         .eTapprovalAmount
                                                            //         .elementAt(
                                                            //             index)
                                                            //         .text = '';
                                                            //   }
                                                            // },

                                                            onChanged: (text) {
                                                              if (!indentApprovalController
                                                                  .checkBoxList
                                                                  .elementAt(
                                                                      index)) {
                                                                indentApprovalController
                                                                    .eTapprovalAmount
                                                                    .elementAt(
                                                                        index)
                                                                    .text = '';
                                                              } else {
                                                                double
                                                                    approvalAmount =
                                                                    double.tryParse(
                                                                            text) ??
                                                                        0.0;
                                                                double requestedAmount = double.tryParse(indentApprovalController
                                                                        .particularRequisitionDetais
                                                                        .elementAt(
                                                                            index)
                                                                        .pcreqtndeTAmount
                                                                        .toString()) ??
                                                                    0.0;

                                                                setState(() {
                                                                  if (approvalAmount >
                                                                      requestedAmount) {
                                                                    indentApprovalController
                                                                        .eTapprovalAmount
                                                                        .elementAt(
                                                                            index)
                                                                        .text = '';

                                                                    // Show a popup message
                                                                    showPopup(
                                                                        "Approved amount should not be greater than requested amount");
                                                                  }
                                                                });
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
                                                      "${indentApprovalController.particularRequisitionDetais.elementAt(index).pcreqtndeTRemarks}"),
                                                ),
                                              ],
                                            );
                                          })),
                                    ),
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
                                        totalRequestedAmount.toStringAsFixed(2),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(
                                                255, 73, 73, 73)),
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
                                            updateTotalApprovedAmount(index);
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 241, 253, 240),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(1, 2.1),
                                                    blurRadius: 0,
                                                    spreadRadius: 0,
                                                    color: Colors.black12),
                                              ]),
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
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 211, 211, 211)),
                                        ),
                                        child: TextField(
                                          onTap: () {
                                            setState(() {
                                              int index = 0;
                                              updateTotalApprovedAmount(index);
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
                                                    "assets/images/money.png",
                                                    height: 24.0,
                                                  ),
                                                  const SizedBox(width: 6.0),
                                                  Text(
                                                    "Total Amount",
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
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 6.0),
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
                                                        color: Color.fromARGB(
                                                            255, 15, 87, 42))),
                                              ),
                                            ],
                                          ),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                                        contentPadding: const EdgeInsets.only(
                                            top: 48.0, left: 12),
                                        border: const OutlineInputBorder(),
                                        label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
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
                                                color: const Color(0xFF28B6C8),
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
                                                        color:
                                                            Color(0xFF28B6C8),
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        hintText: 'Select Date',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image.asset(
                                              "assets/images/calendar.png",
                                              height: 16.0,
                                              width: 16.0,
                                              color: const Color(0xFF28B6C8),
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
                                        backgroundColor: const Color.fromARGB(
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

                                        int status = await indentApproveApi(
                                          base: baseUrlFromInsCode(
                                              "issuemanager",
                                              widget.mskoolController),
                                          userId:
                                              widget.loginSuccessModel.userId!,
                                          roleId:
                                              widget.loginSuccessModel.roleId!,
                                          miId: selectedOrganization!
                                              .mIId!, //widget.loginSuccessModel.mIID!,
                                          asmayId:
                                              widget.loginSuccessModel.asmaYId!,
                                          // pcIndentId: ,
                                          pcIndentId: 0,
                                          pcIndentDesc:
                                              descriptionController.text,
                                          pcIndentApprovedAmt: double.parse(
                                              totalAmountController.text),
                                          pcIndentRequestedAmt:
                                              totalRequestedAmount,
                                          pcIndentDate: getDateNeed(
                                              indentApprovalController
                                                  .selectDate.value),
                                          featchList: featchList,
                                        );

                                        if (status == 200) {
                                          setState(() {
                                            isLoading = false;
                                            indentApprovalController
                                                .eTapprovalAmount
                                                .clear();
                                            descriptionController.clear();
                                            fromDate.clear();
                                            toDate.clear();
                                            totalRequestedAmount = 0.0;
                                            selectedOrganization == null;
                                            totalAmountController.clear();

                                            clearFirstCheckboxDt();
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Saved Successfully");
                                        }
                                      },
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
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
                : const SizedBox(),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    indentApprovalController.organizationList.clear();
    indentApprovalController.requisitiondetais.clear();
    indentApprovalController.particularRequisitionDetais.clear();
    selectedRequisitionIds.clear();
    textEditingCtrlParticularAmt.forEach((key, controller) {
      controller.dispose();
    });
    tempRequisitionId.clear();
    totalRequestedAmount = 0.0;
    super.dispose();
  }

  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Approval Amount",
              style: TextStyle(
                  color: Color.fromARGB(255, 69, 86, 236),
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  String getDateNeed(DateTime dt) {
    return "${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}-${dt.year}";
  }
}
