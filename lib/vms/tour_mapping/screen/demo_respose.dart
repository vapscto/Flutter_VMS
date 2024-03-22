import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';

import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/tour_mapping/api/demo_response_api.dart';
import 'package:m_skool_flutter/vms/tour_mapping/api/save_demo_response.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/status_demo.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class DemoResponsePage extends StatefulWidget {
  final TourLeadController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String category;
  final int ismsLEDMID;
  final int iredId;
  final String stataName;
  final int iSMSLEId;
  final int categoryId;
  DemoResponsePage(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller,
      required this.category,
      required this.ismsLEDMID,
      required this.iredId,
      required this.stataName,
      required this.iSMSLEId,
      required this.categoryId});

  @override
  State<DemoResponsePage> createState() => _DemoResponsePageState();
}

class _DemoResponsePageState extends State<DemoResponsePage> {
  RxBool checkAll = RxBool(false);
  final GetEmpDetailsController gpsController =
      Get.put(GetEmpDetailsController());
  List<Map<String, dynamic>> detailsList = [];
  List<Map<String, dynamic>> saveDataList = [];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          color: Colors.white, fontWeight: FontWeight.w700),
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(10), width: 0.5),
                      headingRowColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      columns: widget.category == "Closure"
                          ? [
                              DataColumn(
                                  label: Align(
                                child: Checkbox(
                                  checkColor: Colors.indigo[800],
                                  value: checkAll.value,
                                  onChanged: (value) {
                                    checkAll.value = value!;
                                    if (checkAll.value) {
                                      for (int i = 0;
                                          i <
                                              widget.controller.checkBoxList
                                                  .length;
                                          i++) {
                                        widget.controller.checkBoxList[i] =
                                            true;
                                        widget.controller.cheackedCheckBox
                                            .add(i);
                                      }
                                    } else {
                                      for (int i = 0;
                                          i <
                                              widget.controller.checkBoxList
                                                  .length;
                                          i++) {
                                        widget.controller.checkBoxList[i] =
                                            false;
                                        widget.controller.cheackedCheckBox
                                            .clear();
                                      }
                                    }
                                    // for(var i = 0; i < widget.controller.cheackedCheckBox.length;i++){
                                    //       logger.e(widget.controller.cheackedCheckBox[i]);
                                    //      }
                                  },
                                ),
                              )),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'SL No',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Product',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Discussion Points',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Remark',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'MOU Request',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Negotiation',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Negotiation Amount',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Demo Cancel',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          : [
                              DataColumn(
                                  label: Align(
                                child: Checkbox(
                                  checkColor: Colors.indigo[800],
                                  value: checkAll.value,
                                  onChanged: (value) {
                                    checkAll.value = value!;
                                    if (checkAll.value) {
                                      for (int i = 0;
                                          i <
                                              widget.controller.checkBoxList
                                                  .length;
                                          i++) {
                                        widget.controller.checkBoxList[i] =
                                            true;
                                        widget.controller.cheackedCheckBox
                                            .add(i);
                                      }
                                    } else {
                                      for (int i = 0;
                                          i <
                                              widget.controller.checkBoxList
                                                  .length;
                                          i++) {
                                        widget.controller.checkBoxList[i] =
                                            false;
                                        widget.controller.cheackedCheckBox
                                            .clear();
                                      }
                                    }
                                    // for(var i = 0; i < widget.controller.cheackedCheckBox.length;i++){
                                    //       logger.e(widget.controller.cheackedCheckBox[i]);
                                    //      }
                                  },
                                ),
                              )),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'SL No',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Product',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Discussion Points',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Remark',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Quotation Request',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Demo Cancel',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                      rows: widget.category == "Closure"
                          ? List.generate(
                              widget.controller.listDemoRespose.length,
                              (index) {
                              var num = index + 1;
                              return DataRow(cells: [
                                DataCell(Align(
                                  child: Checkbox(
                                    value:
                                        widget.controller.checkBoxList[index],
                                    onChanged: (value) {
                                      widget.controller.checkBoxList[index] =
                                          value!;
                                      if (widget.controller.cheackedCheckBox
                                          .contains(index)) {
                                        widget.controller.cheackedCheckBox
                                            .remove(index);
                                      } else {
                                        widget.controller.cheackedCheckBox
                                            .add(index);
                                      }
                                      if (widget.controller.cheackedCheckBox
                                              .length ==
                                          widget
                                              .controller.checkBoxList.length) {
                                        checkAll.value = true;
                                      } else {
                                        checkAll.value = false;
                                      }
                                      // for(var i = 0; i < widget.controller.cheackedCheckBox.length;i++){
                                      //     logger.e(widget.controller.cheackedCheckBox[i]);
                                      //    }
                                    },
                                  ),
                                )),
                                DataCell(Align(
                                  child: Text("$num"),
                                )),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(widget
                                        .controller.listDemoRespose
                                        .elementAt(index)
                                        .ismsmpRProductName!))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(widget
                                        .controller.listDemoRespose
                                        .elementAt(index)
                                        .ismsledmpRDiscussionPoints!))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 120,
                                      margin: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: .5, color: Colors.black),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: DropdownButtonFormField<
                                          StatusDemoModelValues>(
                                        decoration: InputDecoration(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                          hintText: widget.controller
                                                  .listDemoStatus.isNotEmpty
                                              ? 'Select'
                                              : 'No data available',
                                          isDense: true,
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
                                            widget.controller.listDemoStatus
                                                .length, (index) {
                                          return DropdownMenuItem(
                                            value: widget.controller
                                                .listDemoStatus[index],
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 13, left: 5),
                                              child: Text(
                                                overflow: TextOverflow.clip,
                                                widget
                                                    .controller
                                                    .listDemoStatus[index]
                                                    .ismsmsTStatusName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.3)),
                                              ),
                                            ),
                                          );
                                        }),
                                        onChanged: (s) async {
                                          widget.controller
                                                  .demoDropDown[index] =
                                              s!.ismsmsTId!.toString();
                                        },
                                      ),
                                    ))),
                                DataCell(Align(
                                  child: SizedBox(
                                    width: 350,
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                      controller: widget
                                          .controller.demoRemarkEdt
                                          .elementAt(index),
                                    ),
                                  ),
                                )),
                                DataCell(Align(
                                  child: widget.controller
                                              .demoNegotiateList[index] ||
                                          widget
                                              .controller.demoCancelList[index]
                                      ? Checkbox(
                                          value: false,
                                          onChanged: (value) {},
                                        )
                                      : Checkbox(
                                          checkColor: Colors.indigo[800],
                                          value: widget.controller.demoMouList
                                              .elementAt(index),
                                          onChanged: (value) {
                                            widget.controller
                                                .demoMouList[index] = value!;
                                          },
                                        ),
                                )),
                                DataCell(Align(
                                  child: widget.controller.demoMouList[index] ||
                                          widget
                                              .controller.demoCancelList[index]
                                      ? Checkbox(
                                          value: false,
                                          onChanged: (value) {},
                                        )
                                      : Checkbox(
                                          checkColor: Colors.indigo[800],
                                          value: widget
                                              .controller.demoNegotiateList
                                              .elementAt(index),
                                          onChanged: (value) {
                                            widget.controller
                                                    .demoNegotiateList[index] =
                                                value!;
                                            if (widget.controller
                                                .demoNegotiateList[index]) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please Enter Negotition Amount");
                                            }
                                          },
                                        ),
                                )),
                                DataCell(Align(
                                    child: SizedBox(
                                  width: 180,
                                  child: TextField(
                                    controller: widget.controller.demoNegotiate
                                        .elementAt(index),
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                  ),
                                ))),
                                DataCell(Align(
                                  child: widget.controller.demoMouList[index] ||
                                          widget.controller
                                              .demoNegotiateList[index]
                                      ? Checkbox(
                                          value: false,
                                          onChanged: (value) {},
                                        )
                                      : Checkbox(
                                          checkColor: Colors.indigo[800],
                                          value: widget
                                              .controller.demoCancelList
                                              .elementAt(index),
                                          onChanged: (value) {
                                            widget.controller
                                                .demoCancelList[index] = value!;
                                          },
                                        ),
                                ))
                              ]);
                            })
                          : List.generate(
                              widget.controller.listDemoRespose.length,
                              (index) {
                              var num = index + 1;
                              return DataRow(cells: [
                                DataCell(Align(
                                  child: Checkbox(
                                    value:
                                        widget.controller.checkBoxList[index],
                                    onChanged: (value) {
                                      widget.controller.checkBoxList[index] =
                                          value!;
                                      if (widget.controller.cheackedCheckBox
                                          .contains(index)) {
                                        widget.controller.cheackedCheckBox
                                            .remove(index);
                                      } else {
                                        widget.controller.cheackedCheckBox
                                            .add(index);
                                      }
                                      if (widget.controller.cheackedCheckBox
                                              .length ==
                                          widget
                                              .controller.checkBoxList.length) {
                                        checkAll.value = true;
                                      } else {
                                        checkAll.value = false;
                                      }
                                      // for(var i = 0; i < widget.controller.cheackedCheckBox.length;i++){
                                      //     logger.e(widget.controller.cheackedCheckBox[i]);
                                      //    }
                                    },
                                  ),
                                )),
                                DataCell(Align(
                                  child: Text("$num"),
                                )),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(widget
                                        .controller.listDemoRespose
                                        .elementAt(index)
                                        .ismsmpRProductName!))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(widget
                                        .controller.listDemoRespose
                                        .elementAt(index)
                                        .ismsledmpRDiscussionPoints!))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 120,
                                      margin: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: .5, color: Colors.black),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: DropdownButtonFormField<
                                          StatusDemoModelValues>(
                                        decoration: InputDecoration(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                          hintText: widget.controller
                                                  .listDemoStatus.isNotEmpty
                                              ? 'Select'
                                              : 'No data available',
                                          isDense: true,
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
                                            widget.controller.listDemoStatus
                                                .length, (index) {
                                          return DropdownMenuItem(
                                            value: widget.controller
                                                .listDemoStatus[index],
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 13, left: 5),
                                              child: Text(
                                                overflow: TextOverflow.clip,
                                                widget
                                                    .controller
                                                    .listDemoStatus[index]
                                                    .ismsmsTStatusName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.3)),
                                              ),
                                            ),
                                          );
                                        }),
                                        onChanged: (s) async {
                                          widget.controller
                                                  .demoDropDown[index] =
                                              s!.ismsmsTId!.toString();
                                        },
                                      ),
                                    ))),
                                DataCell(Align(
                                  child: SizedBox(
                                    width: 350,
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                      controller: widget
                                          .controller.demoRemarkEdt
                                          .elementAt(index),
                                    ),
                                  ),
                                )),
                                DataCell(Align(
                                  child: widget.controller.demoCancelList[index]
                                      ? Checkbox(
                                          value: false,
                                          onChanged: (value) {},
                                        )
                                      : Checkbox(
                                          checkColor: Colors.indigo[800],
                                          value: widget
                                              .controller.demoQutionFlag
                                              .elementAt(index),
                                          onChanged: (value) {
                                            widget.controller
                                                .demoQutionFlag[index] = value!;
                                          },
                                        ),
                                )),
                                DataCell(Align(
                                  child: widget.controller.demoMouList[index] ||
                                          widget.controller
                                              .demoNegotiateList[index]
                                      ? Checkbox(
                                          value: false,
                                          onChanged: (value) {},
                                        )
                                      : Checkbox(
                                          checkColor: Colors.indigo[800],
                                          value: widget
                                              .controller.demoCancelList
                                              .elementAt(index),
                                          onChanged: (value) {
                                            widget.controller
                                                .demoCancelList[index] = value!;
                                          },
                                        ),
                                ))
                              ]);
                            })))),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MSkollBtn(
                title: "Save",
                onPress: () async {
                  detailsList.clear();
                  saveDataList.clear();
                  for (int i = 0;
                      i < widget.controller.cheackedCheckBox.length;
                      i++) {
                    detailsList.add({
                      "ISMSLEDM_Id": widget.controller.listDemoRespose
                          .elementAt(widget.controller.cheackedCheckBox[i])
                          .ismsledMId,
                      "ISMSLEDMPR_Id": widget.iSMSLEId,
                      "ISMSMST_Id": widget.controller.demoDropDown
                          .elementAt(widget.controller.cheackedCheckBox[i]),
                      "ISMSLEDMPR_Remarks": widget.controller.demoRemarkEdt
                          .elementAt(widget.controller.cheackedCheckBox[i])
                          .text,
                      "ISMSLECOM_SendQuotationFlg":
                          widget.controller.demoQutionFlag.elementAt(
                                      widget.controller.cheackedCheckBox[i]) ==
                                  true
                              ? 1
                              : 0,
                      "ISMSLECOM_MoMFlg": widget.controller.demoMouList
                                  .elementAt(
                                      widget.controller.cheackedCheckBox[i]) ==
                              true
                          ? 1
                          : 0,
                      "ISMSLECOM_NonFlg": widget.controller.demoNegotiateList
                                  .elementAt(
                                      widget.controller.cheackedCheckBox[i]) ==
                              true
                          ? 1
                          : 0,
                      "NON_Amount": widget.controller.demoNegotiateList
                                  .elementAt(
                                      widget.controller.cheackedCheckBox[i]) ==
                              true
                          ? widget.controller.demoNegotiate
                              .elementAt(widget.controller.cheackedCheckBox[i])
                              .text
                          : "",
                      "ISMSLECOM_CancelFlg": widget.controller.demoCancelList
                                  .elementAt(
                                      widget.controller.cheackedCheckBox[i]) ==
                              true
                          ? 1
                          : 0,
                      "SMSLEDM_CategaroyId": widget.categoryId,
                      "IER_ID": widget.iredId,
                      "ISMSLEDMPR_ActiveFlag": false,
                      "ISMSMST_StatusName": widget.stataName
                    });
                  }
                  saveDataList.add({
                    "ILRR_Lat": "${gpsController.latitude}",
                    "ILRR_Long": "${gpsController.longitude}",
                    "MI_Id": widget.loginSuccessModel.mIID,
                    "UserId": widget.loginSuccessModel.userId,
                    "product_demo_master_temp2": detailsList
                  });

                  await saveDemoResponse(
                      base: baseUrlFromInsCode(
                          "issuemanager", widget.mskoolController),
                      context: context,
                      saveDataList: saveDataList);
                  for (int i = 0; i < saveDataList.length; i++) {
                    logger.i(saveDataList[i]);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
