import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/api/approve_cheque_book.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/api/fetch_companies_list.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/api/otp_fetch.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/api/update_check.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/cheque_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/detailed_todo_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/company_model.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/widget/otp_screen.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class ChequeApproval extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ChequeApproval(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<ChequeApproval> createState() => _ChequeApprovalState();
}

class _ChequeApprovalState extends State<ChequeApproval> {
  final ChequeController _chequeController = Get.put(ChequeController());
  final GetDetailedToDo _controller = Get.put(GetDetailedToDo());
  List<int> selectCheckBox = <int>[].obs;
  DrDetailsCtrlr loadingCntrl = Get.put(DrDetailsCtrlr());

  bool allSelect = false;
  List<Map<String, dynamic>> detailsList = [];
  bool isLoding = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? mid;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await getCompaniesList(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        controller: _chequeController,
        userId: widget.loginSuccessModel.userId!);
  }

  submitData() async {
    detailsList.clear();
    loadingCntrl.updateTabLoading(true);
    for (int i = 0; i < selectCheckBox.length; i++) {
      detailsList.add({
        "MI_Id": _controller.getTaDaModelList.elementAt(i).mIId,
        "VPAYVOUAUT_SanctionedAmount": _controller.tEControllerListOfSncAmount
            .elementAt(selectCheckBox[i])
            .text,
        "VPAYVOU_Id":
            _controller.getTaDaModelList.elementAt(selectCheckBox[i]).vPAYVOUId,
        "VPAYVOU_Remarks": _controller.tEControllerListOfNarration
            .elementAt(selectCheckBox[i])
            .text,
        "VTADAAA_Remarks": _controller.tEControllerListOfApprovalRemark
            .elementAt(selectCheckBox[i])
            .text,
        "approvecnt": _controller.radioSelect[selectCheckBox[i]],
        "level": _controller.getTaDaModelList
            .elementAt(selectCheckBox[i])
            .sanctionLevelNo!,
      });
    }
    // print(detailsList);
    int status = await approveApi(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        detailsList: detailsList,
        otp: 1010);
    if (status == 200) {
      Fluttertoast.showToast(msg: " Successfully  submitted ");
    }
    loadingCntrl.updateTabLoading(false);
    setState(() {
      _controller.getTaDaModelList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: const CustomGoBackButton(),
          title: const Text(
            "Cheque Approval",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          // actions: [
          //   Padding(
          //     padding:
          //         const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          //     child: Obx(
          //       () => _controller.isLoading.value
          //           ? const SizedBox()
          //           : BtnSave(
          //               title: 'Submit',
          //               onPress: () {
          //                 if (_formKey.currentState!.validate()) {
          //                   submitData();
          //                 } else {
          //                   Fluttertoast.showToast(msg: "Amount is greater");
          //                 }
          //               },
          //             ),
          //     ),
          //   )
          // ],
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(children: [
            Obx(
              () => _chequeController.isErrorOccuredWhileLoading.value
                  ? const Center(
                      child: ErrWidget(
                        err: {
                          "errorTitle": "Unexpected Error Occured",
                          "errorMsg":
                              "While loading company we encountered an error"
                        },
                      ),
                    )
                  : _chequeController.isLoading.value
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
                          child: DropdownButtonFormField<CompanyListValues>(
                            value: _chequeController.companiesList.first,
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
                                  _chequeController.companiesList.isNotEmpty
                                      ? 'Select Organization'
                                      : 'No data available',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              isDense: true,
                              label: const CustomDropDownLabel(
                                icon: 'assets/images/hat.png',
                                containerColor:
                                    Color.fromRGBO(223, 251, 254, 1),
                                text: 'Organization',
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
                                _chequeController.companiesList.length,
                                (index) {
                              return DropdownMenuItem(
                                value: _chequeController.companiesList[index],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 13, left: 5),
                                  child: Text(
                                    overflow: TextOverflow.clip,
                                    _chequeController
                                        .companiesList[index].mIName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0,
                                            letterSpacing: 0.3)),
                                  ),
                                ),
                              );
                            }),
                            onChanged: (s) async {
                              _controller.getTaDaModelList.clear();
                              _controller.radioSelect.clear();
                              _controller.tEControllerListOfSncAmount.clear();
                              _controller.tEControllerListOfNarration.clear();
                              _controller.tEControllerListOfApprovalRemark
                                  .clear();
                              _controller.checkList.clear();
                              mid = s!.mIId;
                              await updateCheque(
                                  userId: widget.loginSuccessModel.userId!,
                                  miId: s.mIId!,
                                  base: baseUrlFromInsCode(
                                      "issuemanager", widget.mskoolController),
                                  controller: _controller);
                            },
                          ),
                        ),
            ),
            Obx(() => _controller.isLoading.isTrue
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading data',
                    desc: "Please wait we are loading data",
                  )
                : _controller.getTaDaModelList.isNotEmpty
                    ?
                    // ? GetTaDa(
                    //     loginSuccessModel: widget.loginSuccessModel,
                    //     mskoolController: widget.mskoolController,
                    //     controller: _controller,
                    //     mi_id: mid!,
                    //   )

                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: DataTable(
                                      dataTextStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(0, 0, 0, 0.95),
                                          fontWeight: FontWeight.w500),
                                      dataRowHeight: 80,
                                      headingRowHeight: 40,
                                      horizontalMargin: 10,
                                      columnSpacing: 20,
                                      dividerThickness: 1,
                                      headingTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      border: TableBorder.all(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 0.5),
                                      headingRowColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor),
                                      columns: [
                                        //c15
                                        const DataColumn(
                                          numeric: true,
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'S.No',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //c14
                                        DataColumn(
                                          label: Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                child: Checkbox(
                                                  activeColor:
                                                      const Color.fromRGBO(
                                                          0, 4, 250, 0.898),
                                                  shape:
                                                      ContinuousRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  value: allSelect,
                                                  onChanged: (value) {
                                                    allSelect = value!;
                                                    if (allSelect) {
                                                      for (var i = 0;
                                                          i <
                                                              _controller
                                                                  .tEControllerListOfNarration
                                                                  .length;
                                                          i++) {
                                                        selectCheckBox.add(i);
                                                        _controller
                                                                .checkList[i] =
                                                            true;
                                                      }
                                                    } else {
                                                      for (var i = 0;
                                                          i <
                                                              _controller
                                                                  .tEControllerListOfNarration
                                                                  .length;
                                                          i++) {
                                                        selectCheckBox.clear();
                                                        _controller
                                                                .checkList[i] =
                                                            false;
                                                      }
                                                    }
                                                  },
                                                ),
                                              )),
                                        ),
                                        //  //c13
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Approve',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        //c13

                                        // //c12
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Reject',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c11
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Bank Details',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c10
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Payment Mode',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Payment reference',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c9
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Pay Name',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c8
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Applied Date',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c7
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Applied Amount',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c6
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Total Charges',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c5
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Total Payble',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        //c4
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Sanctioned Amount',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c3
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Narration',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        // //c2
                                        const DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Approval Remark',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                          _controller.getTaDaModelList.length,
                                          (index) {
                                        var i = index + 1;
                                        return DataRow(
                                          color: _controller.getTaDaModelList
                                                          .elementAt(index)
                                                          .vPAYVOUStatusFlg!
                                                          .toString() ==
                                                      "Rejected" ||
                                                  _controller.radioSelect
                                                          .elementAt(index) ==
                                                      0
                                              ? MaterialStateProperty.all(
                                                  Colors.red.shade50)
                                              : MaterialStateProperty.all(
                                                  Colors.white),
                                          cells: [
                                            //b14
                                            DataCell(Align(
                                                alignment: Alignment.center,
                                                child: Text('$i'))),
                                            //b13
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Align(
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Checkbox(
                                                      activeColor:
                                                          const Color.fromRGBO(
                                                              0, 4, 250, 0.898),
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _controller.checkList[
                                                              index] = value!;

                                                          if (selectCheckBox
                                                              .contains(
                                                                  index)) {
                                                            selectCheckBox
                                                                .remove(index);
                                                            if (_controller
                                                                        .checkList[
                                                                    index] ==
                                                                false) {
                                                              _controller.radioSelect[index] =
                                                                  0;
                                                              _controller
                                                                      .getTaDaModelList
                                                                      .elementAt(
                                                                          index)
                                                                      .vPAYVOUStatusFlg =
                                                                  "Rejected";
                                                            }
                                                            } else {
                                                            selectCheckBox
                                                                .add(index);

                                                            if (_controller
                                                                    .checkList[
                                                                index]) {
                                                              _controller
                                                                      .getTaDaModelList
                                                                      .elementAt(
                                                                          index)
                                                                      .vPAYVOUStatusFlg =
                                                                  "Approved";
                                                            }
                                                         }
                                                        });
                                                      },
                                                      value: _controller
                                                          .checkList
                                                          .elementAt(index),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //b12
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Align(
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 40,
                                                    child: Radio(
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      visualDensity:
                                                          const VisualDensity(
                                                              horizontal: -4.0),
                                                      value: 1,
                                                      groupValue: _controller
                                                          .radioSelect
                                                          .elementAt(index),
                                                      onChanged: (value) {
                                                        _controller.radioSelect[
                                                            index] = value!;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Align(
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 40,
                                                    child: Radio(
                                                      focusColor:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  182,
                                                                  180,
                                                                  180)
                                                              .withOpacity(.1),
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      value: 0,
                                                      groupValue: _controller
                                                          .radioSelect
                                                          .elementAt(index),
                                                      onChanged: (value) {
                                                        _controller.radioSelect[
                                                            index] = value!;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //b11
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(
                                                      "${_controller.getTaDaModelList.elementAt(index).hRMBDBankName} \n ${_controller.getTaDaModelList.elementAt(index).hRMBDBankAddress} "),
                                                ),
                                              ),
                                            ),
                                            //b10
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(_controller
                                                      .getTaDaModelList
                                                      .elementAt(index)
                                                      .vPAYVOUPaymentMode
                                                      .toString()),
                                                ),
                                              ),
                                            ),
                                            // //b9
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(_controller
                                                              .getTaDaModelList
                                                              .elementAt(index)
                                                              .vPAYVOUChequeNo ==
                                                          null
                                                      ? ""
                                                      : _controller
                                                          .getTaDaModelList
                                                          .elementAt(index)
                                                          .vPAYVOUChequeNo
                                                          .toString()),
                                                ),
                                              ),
                                            ),
                                            // //b8
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(_controller
                                                              .getTaDaModelList
                                                              .elementAt(index)
                                                              .vPAYVOUPaymentTo ==
                                                          null
                                                      ? _controller
                                                          .getTaDaModelList
                                                          .elementAt(index)
                                                          .iNVMSSupplierName!
                                                          .toString()
                                                      : _controller
                                                          .getTaDaModelList
                                                          .elementAt(index)
                                                          .vPAYVOUPaymentTo
                                                          .toString()),
                                                ),
                                              ),
                                            ),
                                            // //b7
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(getDateNeed(
                                                      DateTime.parse(_controller
                                                          .getTaDaModelList
                                                          .elementAt(index)
                                                          .vPAYVOUPaymentDate
                                                          .toString()))),
                                                ),
                                              ),
                                            ),
                                            // //b6
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(_controller
                                                      .getTaDaModelList
                                                      .elementAt(index)
                                                      .vPAYVOUAppliedAmount
                                                      .toString()),
                                                ),
                                              ),
                                            ),
                                            // //b5
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(_controller
                                                      .getTaDaModelList
                                                      .elementAt(index)
                                                      .vPAYVOUApprovedAmount
                                                      .toString()),
                                                ),
                                              ),
                                            ),
                                            // //b4
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  child: Text(_controller
                                                      .getTaDaModelList
                                                      .elementAt(index)
                                                      .vPAYVOUAppliedAmount
                                                      .toString()),
                                                ),
                                              ),
                                            ),
                                            //b3
                                            DataCell(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              InputBorder.none),
                                                  validator: (value) {
                                                    if (selectCheckBox.contains(
                                                        _controller
                                                            .getTaDaModelList
                                                            .indexOf(_controller
                                                                .getTaDaModelList
                                                                .elementAt(
                                                                    index)))) {
                                                      if (double.parse(value!) >
                                                          double.parse(_controller
                                                              .getTaDaModelList
                                                              .elementAt(index)
                                                              .vPAYVOUAppliedAmount
                                                              .toString())) {
                                                        return "Amount is greater than";
                                                      }
                                                    }
                                                    return null;
                                                  },
                                                  readOnly: _controller
                                                                      .radioSelect[
                                                                  index] ==
                                                              1 &&
                                                          selectCheckBox.contains(_controller
                                                              .getTaDaModelList
                                                              .indexOf(_controller
                                                                  .getTaDaModelList
                                                                  .elementAt(
                                                                      index)))
                                                      ? false
                                                      : true,
                                                  controller: _controller
                                                      .tEControllerListOfSncAmount
                                                      .elementAt(index),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            //b2
                                            DataCell(
                                              SizedBox(
                                                width: 150,
                                                child: TextField(
                                                  maxLines: 3,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              InputBorder.none),
                                                  controller: _controller
                                                      .tEControllerListOfNarration
                                                      .elementAt(index),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      )),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                            //b1
                                            DataCell(
                                              SizedBox(
                                                width: 150,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    maxLines: 3,
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                    controller: _controller
                                                        .tEControllerListOfApprovalRemark
                                                        .elementAt(index),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Visibility(
                                    visible: _chequeController.updateBtn.isTrue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MSkollBtn(
                                        title: " Submit ",
                                        onPress: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (selectCheckBox.isNotEmpty) {
                                              submitData();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Pease select any one");
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Amount is greater");
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        _chequeController.updateBtn.isFalse &&
                                            selectCheckBox.isNotEmpty,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MSkollBtn(
                                        title: "Send Otp",
                                        onPress: () async {
                                          // Random randomOtp = Random.secure();
                                          int otps = generateOTP(
                                              6); //randomOtp.nextInt(999999);
                                          if (otps
                                                  .toString()
                                                  .characters
                                                  .length >
                                              5) {
                                            await otpCheck(
                                                    base: baseUrlFromInsCode(
                                                        "issuemanager",
                                                        widget
                                                            .mskoolController),
                                                    miId: mid!,
                                                    otp: otps,
                                                    userId: widget
                                                        .loginSuccessModel
                                                        .userId!,
                                                    controller:
                                                        _chequeController)
                                                .then(
                                              (value) {
                                                if (value) {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2,
                                                            child: OTpScreen(
                                                                loginSuccessModel:
                                                                    widget
                                                                        .loginSuccessModel,
                                                                mskoolController:
                                                                    widget
                                                                        .mskoolController,
                                                                chequeController:
                                                                    _chequeController,
                                                                cmpnymiId:
                                                                    mid)),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "Failed send otp");
                                                }
                                              },
                                            );
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Pin is not Generate");
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )

                    //
                    : const Center(
                        child: AnimatedProgressWidget(
                          animationPath: 'assets/json/nodata.json',
                          title: 'No Details found',
                          desc: "For this company has no data to show",
                          animatorHeight: 250,
                        ),
                      ))
          ]),
        ),
      ),
    );
  }

  String getDateNeed(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.radioSelect.clear();
    _controller.tEControllerListOfSncAmount.clear();
    _controller.tEControllerListOfNarration.clear();
    _controller.tEControllerListOfApprovalRemark.clear();
    _controller.checkList.clear();
    selectCheckBox.clear();
    super.dispose();
  }

  int generateOTP(int length) {
    if (length < 6) {
      throw Exception("OTP length must be at least 6 digits");
    }
    Random random = Random.secure();
    int min = pow(10, length - 1).toInt();
    int max = pow(10, length).toInt() - 1;
    return min + random.nextInt(max - min);
  }
}
