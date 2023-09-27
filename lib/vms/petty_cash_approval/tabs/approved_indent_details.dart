import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/onchange_approved_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/onload_approved_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/particular_approved_indent_details_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/onload_approved_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/widget/approved_particular_indent_details.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class PcApprovedHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  PcApprovedHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PcApprovedHome> createState() => _PcApprovedHomeState();
}

class _PcApprovedHomeState extends State<PcApprovedHome> {
  final PettyCashApprovalController _pcapprovalController =
      Get.put(PettyCashApprovalController());

  // ParticularApprovedIndentModelValues? approvedparticular;

  // final ManagerInventoryController inventoryController =
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    getPcApprovalOnload(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        roleId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        asmaYId: widget.loginSuccessModel.asmaYId!,
        controller: _pcapprovalController);
    // getPcApprovalOnChange(
    //     miId: widget.loginSuccessModel.mIID!,
    //     base: baseUrlFromInsCode("", widget.mskoolController),
    //     roleId: widget.loginSuccessModel.roleId!,
    //     userId: widget.loginSuccessModel.userId!,
    //     asmaYId: widget.loginSuccessModel.asmaYId!,
    //     controller: _pcapprovalController);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => _pcapprovalController
                  .isErrorOccuredWhileLoadingOnloadorganization.value
              ? const Center(
                  child: ErrWidget(
                    err: {
                      "errorTitle": "Unexpected Error Occured",
                      "errorMsg":
                          "While loading company we encountered an error"
                    },
                  ),
                )
              : _pcapprovalController.isLoadingOnloadorganization.value
                  ? const AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading data',
                      desc: "Please wait we are loading data",
                    )
                  : Container(
                      margin: const EdgeInsets.only(
                          top: 40, left: 16, right: 16, bottom: 16),
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
                      child:
                          DropdownButtonFormField<PCApprovalOnloadModelValues>(
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
                              _pcapprovalController.organizationList.isNotEmpty
                                  ? 'Select Organization'
                                  : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Select Organization',
                            textColor: Color.fromRGBO(40, 182, 200, 1),
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
                            _pcapprovalController.organizationList.length,
                            (index) {
                          return DropdownMenuItem(
                            value:
                                _pcapprovalController.organizationList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                _pcapprovalController
                                    .organizationList[index].mIName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          );
                        }),
                        onChanged: (selected) {
                          _pcapprovalController.pcApprovedList.clear();

                          // setState(() {
                          //   approvedparticular = selected ;
                          // });

                          getPcApprovalOnChange(
                              miId: selected!.mIId!,
                              base: baseUrlFromInsCode(
                                  "issuemanager", widget.mskoolController),
                              roleId: widget.loginSuccessModel.roleId!,
                              userId: widget.loginSuccessModel.userId!,
                              asmaYId: widget.loginSuccessModel.asmaYId!,
                              controller: _pcapprovalController);
                        },
                      ),
                    )),
          Obx(() => _pcapprovalController.isLoadingIndentApprovedDetails.isTrue
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading data',
                  desc: "Please wait we are loading data",
                )
              : _pcapprovalController.pcApprovedList.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 16.0),
                      height: Get.height * 0.85,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 180),
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
                                      headingRowColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                      columns: [
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
                                            label: Text("Approved By",
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
                                            label: Text("Action",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800))),
                                      ],
                                      rows: List.generate(_pcapprovalController.pcApprovedList.length, (index) {
                                        var i = index + 1;
                                        return DataRow(cells: [
                                          DataCell(Align(
                                              alignment: Alignment.center,
                                              child: Text('$i'))),
                                          DataCell(Text(
                                              "${_pcapprovalController.pcApprovedList.elementAt(index).pcindentapTIndentNo}")),
                                          DataCell(Text(
                                              "${_pcapprovalController.pcApprovedList.elementAt(index).departmentname}")),
                                          DataCell(Text(
                                              "${_pcapprovalController.pcApprovedList.elementAt(index).employeename}")),
                                          DataCell(Text(getDateNeed(
                                              DateTime.parse(
                                                  _pcapprovalController
                                                      .pcApprovedList
                                                      .elementAt(index)
                                                      .createdate!)))),
                                          DataCell(TextButton(
                                              onPressed: () async {
                                                var status = await getPcapprovedIndentParticular(
                                                    miId: widget.loginSuccessModel.mIID!,
                                                    base: baseUrlFromInsCode(
                                                        "issuemanager",
                                                        widget
                                                            .mskoolController),
                                                    roleId: widget.loginSuccessModel.roleId!,
                                                    userId: widget.loginSuccessModel.userId!,
                                                    asmaYId: widget
                                                        .loginSuccessModel
                                                        .asmaYId!,
                                                    pcIndentApproved:
                                                        _pcapprovalController
                                                            .pcApprovedList
                                                            .elementAt(index)
                                                            .pcindentaPId!,
                                                    pcIndentId:
                                                        _pcapprovalController
                                                            .pcApprovedList
                                                            .elementAt(index)
                                                            .pcindenTId!,
                                                    controller:
                                                        _pcapprovalController);
                                                if (status == 200) {
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                    return ApprovedParticularIndentDetails(
                                                      loginSuccessModel: widget
                                                          .loginSuccessModel,
                                                      mskoolController: widget
                                                          .mskoolController,
                                                      controller:
                                                          _pcapprovalController,
                                                    );
                                                  }));
                                                }
                                              },
                                              child: Icon(Icons
                                                  .remove_red_eye_rounded))),
                                        ]);
                                      })),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Visibility(
                        visible: !_pcapprovalController
                            .isLoadingOnloadorganization.value,
                        child: AnimatedProgressWidget(
                          animationPath: 'assets/json/nodata.json',
                          title: 'Select Organization',
                          desc: "Select the Organization to show the Data",
                          animatorHeight: 250,
                        ),
                      ),
                    )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pcapprovalController.pcApprovedList.clear();

    super.dispose();
  }

  String getDateNeed(DateTime dt) {
    //.padLeft(2,"0")

    return "${dt.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }
}


