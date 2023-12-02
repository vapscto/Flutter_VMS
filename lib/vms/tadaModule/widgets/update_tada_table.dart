import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/apis/save_tada_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/apis/tada_apply_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/apis/tada_details_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/controller/tada_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/model/tada_apply_list.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class UpdateTADATable extends StatefulWidget {
  final TADAController tadaController;
  final double amount;
  final GetadvancetadaValues values;
  final MskoolController mskoolController;

  const UpdateTADATable(
      {super.key,
      required this.tadaController,
      required this.amount,
      required this.values,
      required this.mskoolController});

  @override
  State<UpdateTADATable> createState() => _UpdateTADATableState();
}

class _UpdateTADATableState extends State<UpdateTADATable> {
  final remarkController = TextEditingController();
  // final sanctionController = TextEditingController();
  final sanctionController2 = TextEditingController();
  final parcentageController = TextEditingController();
  String fromDate = '';
  String toDate = '';
  String fromTime = '';
  String toTime = '';
  List<Map<String, dynamic>> headArray = [];
  var days;
  num amount = 0;
  void addAmount(double a) {
    amount += a;
  }

  void removeAmount(double a) {
    amount -= a;
  }

  _getData() async {
    widget.tadaController.updateIsLoading(true);
    TADADetailsAPI.instance.tadaDetails(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.values.userId!,
        tadaController: widget.tadaController,
        vtaDaaaId: widget.values.vTADAAAId!);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      widget.tadaController.updateIsLoading(false);
    });
    setState(() {
      DateTime dt = DateTime.parse(widget.values.vTADAAAFromDate!);
      fromDate = '${dt.day}-${dt.month}-${dt.year}';
      DateTime toDt = DateTime.parse(widget.values.vTADAAAToDate!);
      toDate = '${toDt.day}-${toDt.month}-${toDt.year}';
      DateTime dt1 = DateTime.parse(widget.values.vTADAAAFromDate!);
      DateTime dt2 = DateTime.parse(widget.values.vTADAAAToDate!);

      Duration diff = dt1.difference(dt2);
      days = diff.inDays;
      logger.e(days);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.tadaController.tadaEditValues;
    });
    setState(() {
      for (int index = 0;
          index < widget.tadaController.tadaEditValues.length;
          index++) {
        widget.tadaController.textEditingControllerList
            .add(TextEditingController(text: '0.0'));
        widget.tadaController.approvalTextEditingControllerList
            .add(TextEditingController(text: ''));
        widget.tadaController.textEditingControllerList[index].addListener(() {
          addAllAmount();
        });
        // sanctionController2.text = widget
        //     .tadaController.approvalTextEditingControllerList
        //     .elementAt(index)
        //     .text;
        // remarkController.text =
        //     widget.tadaController.tadaEditValues[index].vTADAAADRemarks ?? "";
      }
    });
    super.initState();
  }

  void addAllAmount() {
    double sum = 0;
    for (TextEditingController controller
        in widget.tadaController.textEditingControllerList) {
      double value = double.tryParse(controller.text) ?? 0;
      sum += value;
    }
    setState(() {
      sanctionController2.text = '$sum';
    });
  }

  double sum = 0;
  removeAllAmount(double amount) {
    sum -= amount;
    sanctionController2.text = sum.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _createTable(),
                  ),
                ),
                const SizedBox(height: 10),
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
                      amount.toString(),
                      style: Get.textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                CustomContainer(
                    child: TextFormField(
                  style: Get.textTheme.titleSmall,
                  maxLines: 4,
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
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
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
        const SizedBox(height: 20),
        Align(
            alignment: Alignment.bottomCenter,
            child: MSkollBtn(
                title: "Save",
                onPress: () {
                  if (widget.tadaController.selectedValue.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Select Status");
                  } else if (widget
                      .tadaController.textEditingControllerList.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter sanction amount");
                  } else if (amount >
                      widget.values.vTADAAATotalAppliedAmount!) {
                    Fluttertoast.showToast(
                        msg:
                            "sanction amount should be lessthen applied amount");
                  } else if (remarkController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Remarks");
                  } else if (widget.tadaController
                      .approvalTextEditingControllerList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please Enter Approval or Reject Remarks");
                  } else {
                    for (int i = 0;
                        i < widget.tadaController.tadaEditValues.length;
                        i++) {
                      headArray.add({
                        'VTADAAAD_Id': widget.values.vTADAAAId,
                        "VTADAAAAH_SactionedAmount": widget
                            .tadaController.textEditingControllerList
                            .elementAt(i)
                            .text,
                        'VTADAAAAH_Remarks': widget
                            .tadaController.approvalTextEditingControllerList
                            .elementAt(i)
                            .text,
                        'flag':
                            widget.tadaController.selectedValue.elementAt(i),
                      });
                    }

                    logger.i(headArray);
                    SaveTADAAPI.instance.saveTADA(
                        base: baseUrlFromInsCode(
                            'issuemanager', widget.mskoolController),
                        body: {
                          'VTADAAA_Remarks': remarkController.text,
                          'VTADAAA_TotalSactionedAmount':
                              sanctionController2.text,
                          'headarray': headArray,
                          'VTADAAA_Id': widget.values.vTADAAAId,
                          "MI_Id": widget.values.mIId,
                          "approvecnt": 0,
                          "level": 0,
                          "HRME_Id": widget.values.hRMEId,
                          'UserId': widget.values.userId
                        }).then((v) {
                      logger.i("success");
                      TADAApplyListAPI.instance.showApplyList(
                          base: baseUrlFromInsCode(
                              'issuemanager', widget.mskoolController),
                          userId: widget.values.userId!,
                          tadaController: widget.tadaController);
                      _getData();
                      Get.back();
                    });
                  }
                })),
      ],
    );
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
      DataColumn(label: Text("Total Slots")),
      DataColumn(label: Text("Slots")),
      DataColumn(label: Text("Amount")),
      DataColumn(label: Text("Percentage")),
      DataColumn(label: Text("Sanction Amount")),
      DataColumn(label: Text("Approval Remarks")),
    ];
  }

  List<DataRow> createRow() {
    return List.generate(widget.tadaController.tadaEditValues.length, (index) {
      var value = index + 1;

      return DataRow(cells: [
        DataCell(Text(value.toString())),
        DataCell(Radio(
          fillColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
          groupValue: widget.tadaController.selectedValue[index],
          value: 'Approved',
          onChanged: (value) {
            setState(() {
              widget.tadaController.selectedValue[index] = value!;
              addAllAmount();
              // addAmount(double.parse(widget
              //     .tadaController.textEditingControllerList
              //     .elementAt(index)
              //     .text));
            });
          },
        )),
        DataCell(Radio(
          fillColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
          groupValue: widget.tadaController.selectedValue[index],
          value: 'Rejected',
          onChanged: (dynamic value) {
            setState(() {
              widget.tadaController.selectedValue[index] = value;
              if (amount >=
                  double.parse(widget.tadaController.textEditingControllerList
                      .elementAt(index)
                      .text)) {
                removeAllAmount(double.parse(widget
                    .tadaController.textEditingControllerList
                    .elementAt(index)
                    .text));
              }
            });
          },
        )),
        DataCell(Text(widget
                .tadaController.tadaEditValues[index].vTADAAADExpenditureHead ??
            "")),
        DataCell(Text(
            '${widget.tadaController.tadaEditValues[index].vTADAAADTotalSlots ?? ' '}')),
        DataCell(Text(
            '${widget.tadaController.tadaEditValues[index].vTADAAADSlots ?? " "}')),
        DataCell(Text(
            "${widget.tadaController.tadaEditValues[index].vTADAAADAmount ?? ''}")),
        DataCell(Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            style: Get.textTheme.titleSmall,
            controller: parcentageController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: " ",
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                if (widget.tadaController.selectedValue[index] == 'Approved') {
                  addAllAmount();
                } else if (widget.tadaController.selectedValue[index] ==
                    'Rejected') {
                  removeAllAmount(double.parse(value));
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
