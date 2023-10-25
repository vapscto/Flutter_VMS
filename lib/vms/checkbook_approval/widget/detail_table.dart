import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/detailed_todo_controller.dart';

class GetTaDa extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final GetDetailedToDo controller;
  final int mi_id;

  GetTaDa(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller,
      required this.mi_id});

  @override
  State<GetTaDa> createState() => _GetTaDaState();
}

class _GetTaDaState extends State<GetTaDa> {
  List<int> selectCheckBox = <int>[].obs;
  bool allSelect = false;
  List<Map<String, dynamic>> detailsList = [];
  bool isLoding = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  load() async {
    detailsList.clear();
    isLoding = true;

    for (int i = 0; i < selectCheckBox.length; i++) {
      detailsList.add({
        "VPAYVOU_Remarks": widget.controller.tEControllerListOfNarration
            .elementAt(selectCheckBox[i])
            .text,
        "VPAYVOUAUT_SanctionedAmount": widget
            .controller.tEControllerListOfSncAmount
            .elementAt(selectCheckBox[i])
            .text,
        "VPAYVOU_Id": widget.controller.getTaDaModelList
            .elementAt(selectCheckBox[i])
            .vPAYVOUId,
        "approvecnt": widget.controller.radioSelect[selectCheckBox[i]],
        "level": widget.controller.getTaDaModelList
            .elementAt(selectCheckBox[i])
            .sanctionLevelNo,
        "MI_Id": widget.controller.getTaDaModelList.elementAt(i).mIId,
        "VTADAAA_Remarks": widget.controller.tEControllerListOfApprovalRemark
            .elementAt(selectCheckBox[i])
            .text
      });

      isLoding = false;
    }
    // int status =  await approveApi(base: "",
    // userId: 60064,
    // mi_id: widget.mi_id,
    // detailsList: detailsList,otp: 1010) ;
    // if(status == 200){
    //  isLoding=false;
    //  setState(() {
    //    widget.controller.getTaDaModelList.clear();
    //  });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Form(
      key: _formKey,
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                        dataRowHeight: 60,
                        headingRowHeight: 40,
                        horizontalMargin: 10,
                        columnSpacing: 30,
                        dividerThickness: 1,
                        headingTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        border: TableBorder.all(
                            borderRadius: BorderRadius.circular(10),
                            width: 0.5),
                        headingRowColor: MaterialStateProperty.all(
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
                                        Color.fromRGBO(0, 4, 250, 0.898),
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    value: allSelect,
                                    onChanged: (value) {
                                      allSelect = value!;
                                      if (allSelect) {
                                        for (var i = 0;
                                            i <
                                                widget
                                                    .controller
                                                    .tEControllerListOfNarration
                                                    .length;
                                            i++) {
                                          selectCheckBox.add(i);
                                          widget.controller.checkList[i] = true;
                                        }
                                      } else {
                                        for (var i = 0;
                                            i <
                                                widget
                                                    .controller
                                                    .tEControllerListOfNarration
                                                    .length;
                                            i++) {
                                          selectCheckBox.clear();
                                          widget.controller.checkList[i] =
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
                                'Payment Refernce',
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
                            widget.controller.getTaDaModelList.length, (index) {
                          var i = index + 1;
                          return DataRow(
                            color: widget.controller.getTaDaModelList
                                            .elementAt(index)
                                            .vPAYVOUStatusFlg!
                                            .toString() ==
                                        "Rejected" ||
                                    widget.controller.radioSelect
                                            .elementAt(index) ==
                                        0
                                ? MaterialStateProperty.all(Colors.red.shade50)
                                : MaterialStateProperty.all(Colors.white),
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
                                      child: widget.controller.getTaDaModelList
                                                  .elementAt(index)
                                                  .vPAYVOUStatusFlg!
                                                  .toString() ==
                                              "Rejected"
                                          ? SizedBox()
                                          : Checkbox(
                                              activeColor: Color.fromRGBO(
                                                  0, 4, 250, 0.898),
                                              shape: ContinuousRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              onChanged: (value) {
                                                setState(() {
                                                  widget.controller
                                                          .checkList[index] =
                                                      value!;

                                                  if (selectCheckBox
                                                      .contains(index)) {
                                                    selectCheckBox
                                                        .remove(index);
                                                    // print("slected: " + selectCheckBox.toString());
                                                  } else {
                                                    selectCheckBox.add(index);
                                                    // print("slected: " + selectCheckBox.toString());
                                                  }
                                                });
                                              },
                                              value: widget.controller.checkList
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
                                            Theme.of(context).primaryColor,
                                        visualDensity: const VisualDensity(
                                            horizontal: -4.0),
                                        value: 1,
                                        groupValue: widget
                                            .controller.radioSelect
                                            .elementAt(index),
                                        onChanged: (value) {
                                          widget.controller.radioSelect[index] =
                                              value!;
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
                                            Color.fromARGB(255, 182, 180, 180)
                                                .withOpacity(.1),
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: 0,
                                        groupValue: widget
                                            .controller.radioSelect
                                            .elementAt(index),
                                        onChanged: (value) {
                                          widget.controller.radioSelect[index] =
                                              value!;
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
                                        "${widget.controller.getTaDaModelList.elementAt(index).hRMBDBranchName.toString()}"),
                                  ),
                                ),
                              ),
                              //b10
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    child: Text(widget
                                        .controller.getTaDaModelList
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
                                    child: Text(widget
                                                .controller.getTaDaModelList
                                                .elementAt(index)
                                                .vPAYVOUChequeNo ==
                                            null
                                        ? ""
                                        : widget.controller.getTaDaModelList
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
                                    child: Text(widget
                                                .controller.getTaDaModelList
                                                .elementAt(index)
                                                .vPAYVOUPaymentTo ==
                                            null
                                        ? widget.controller.getTaDaModelList
                                            .elementAt(index)
                                            .iNVMSSupplierName!
                                            .toString()
                                        : widget.controller.getTaDaModelList
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
                                    child: Text(getDateNeed(DateTime.parse(
                                        widget.controller.getTaDaModelList
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
                                    child: Text(widget
                                        .controller.getTaDaModelList
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
                                    child: Text(widget
                                        .controller.getTaDaModelList
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
                                    child: Text(widget
                                        .controller.getTaDaModelList
                                        .elementAt(index)
                                        .vPAYVOUAppliedAmount
                                        .toString()),
                                  ),
                                ),
                              ),
                              //b3
                              DataCell(
                                SizedBox(
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (selectCheckBox.contains(widget
                                            .controller.getTaDaModelList
                                            .indexOf(widget
                                                .controller.getTaDaModelList
                                                .elementAt(index)))) {
                                          if (double.parse(value!) >
                                              double.parse(widget
                                                  .controller.getTaDaModelList
                                                  .elementAt(index)
                                                  .vPAYVOUAppliedAmount
                                                  .toString())) {
                                            return "Amount is greater than";
                                          }
                                        }
                                      },
                                      readOnly: widget.controller
                                                      .radioSelect[index] ==
                                                  1 &&
                                              selectCheckBox.contains(widget
                                                  .controller.getTaDaModelList
                                                  .indexOf(widget.controller
                                                      .getTaDaModelList
                                                      .elementAt(index)))
                                          ? false
                                          : true,
                                      controller: widget.controller
                                          .tEControllerListOfSncAmount
                                          .elementAt(index),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              //b2
                              DataCell(
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: TextField(
                                    
                                     maxLines: 3,
                                    decoration: InputDecoration(
                                        border:  InputBorder.none),
                                 
                                    controller: widget
                                        .controller.tEControllerListOfNarration
                                        .elementAt(index),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14.0,
                                          letterSpacing: 0.3,
                                          overflow: TextOverflow.clip,
                                        )),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              //b1
                              DataCell(
                                SizedBox(
                                  width: 150,
                                  child: TextField(
                                 
                                   // maxLines: 3,
                                    
                                  
                                    controller: widget.controller
                                        .tEControllerListOfApprovalRemark
                                        .elementAt(index),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          letterSpacing: 0.3,
                                          overflow: TextOverflow.clip,
                                        )),
                                    textAlign: TextAlign.start,
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
                height: 50.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {});
                    if (_formKey.currentState!.validate()) {
                      load();
                    } else {
                      Fluttertoast.showToast(msg: "Amount is greater");
                    }
                  },
                  child: isLoding
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text("Submit"),
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDateNeed(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }

  @override
  void dispose() {
    widget.controller.radioSelect.clear();
    widget.controller.tEControllerListOfSncAmount.clear();
    widget.controller.tEControllerListOfNarration.clear();
    widget.controller.tEControllerListOfApprovalRemark.clear();
    widget.controller.checkList.clear();
    super.dispose();
  }
}
