import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/particular_indent_details_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/api/pc_indent_details_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/indent_details_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class PcIndentApprovalScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  PcIndentApprovalScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PcIndentApprovalScreen> createState() => _PcIndentApprovalScreenState();
}

class _PcIndentApprovalScreenState extends State<PcIndentApprovalScreen> {
  TextEditingController boardingDateController = new TextEditingController();

  PcApprovalFromtoDateModelValues? selectedIndent;
  List<Map<String, dynamic>> featchList = [];
  final PettyCashApprovalController _pcapprovalController =
      Get.put(PettyCashApprovalController());

  int color = 0;

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  RxInt changes = RxInt(-1);
  List<int>? selectCheckBx = <int>[].obs;
  bool selectAll = false;
  @override
  void dispose() {
    Get.delete<PettyCashApprovalController>();
    super.dispose();
  }

  sendData() {
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
    print("prathap${featchList.toString()}");
  }
  // @override
  // void initState() {
  //   loadData();
  //   super.initState();
  // }

  // loadData() async {
  //   getPcIndentApproval(
  //       miId: widget.loginSuccessModel.mIID!,
  //       base: baseUrlFromInsCode("", widget.mskoolController),
  //       roleId: widget.loginSuccessModel.roleId!,
  //       userId: widget.loginSuccessModel.userId!,
  //       asmaYId: widget.loginSuccessModel.asmaYId!,
  //       fromDate: "2021-01-01",
  //       toDate: "2023-05-31",
  //       controller: _pcapprovalController);
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
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
                              initialDate:
                                  _pcapprovalController.fromSelectedDate.value,
                              firstDate:
                                  DateTime(1000), //DateTime.now().year, 01, 01
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

                              await getPcIndentApproval(
                                  miId: widget.loginSuccessModel.mIID!,
                                  base: baseUrlFromInsCode(
                                      "", widget.mskoolController),
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
                                  msg: "Please Select from Date First");
                              return;
                            }
                            DateTime? selectedDT = await showDatePicker(
                              context: context,
                              initialDate:
                                  _pcapprovalController.fromSelectedDate.value,
                              firstDate:
                                  _pcapprovalController.fromSelectedDate.value,
                              lastDate: DateTime(DateTime.now().year, 12, 31),
                            );

                            if (selectedDT == null) {
                              Fluttertoast.showToast(
                                  msg: "You didn't selected the date");
                              return;
                            }
                            changes.value += 1;
                            _pcapprovalController.toSelectedDate.value =
                                selectedDT;
                            toDate.text = getDate(
                                _pcapprovalController.toSelectedDate.value);

                            await getPcIndentApproval(
                                miId: widget.loginSuccessModel.mIID!,
                                base: baseUrlFromInsCode(
                                    "", widget.mskoolController),
                                roleId: widget.loginSuccessModel.roleId!,
                                userId: widget.loginSuccessModel.userId!,
                                asmaYId: widget.loginSuccessModel.asmaYId!,
                                fromDate: getDateNeed(_pcapprovalController
                                    .fromSelectedDate.value),
                                toDate: getDateNeed(
                                    _pcapprovalController.toSelectedDate.value),
                                controller: _pcapprovalController);
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
          const SizedBox(
            height: 16.0,
          ),
          Obx(() => Container(
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
                child: DropdownButtonFormField<PcApprovalFromtoDateModelValues>(
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
                    hintStyle: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            letterSpacing: 0.3)),
                    hintText: _pcapprovalController.pcIndentDetails.isNotEmpty
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
                      _pcapprovalController.pcIndentDetails.length, (index) {
                    return DropdownMenuItem(
                      value: _pcapprovalController.pcIndentDetails[index],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, left: 5),
                        child: Text(
                          _pcapprovalController
                              .pcIndentDetails[index].pcindenTIndentNo!,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    );
                  }),
                  onChanged: (selected) {
                    _pcapprovalController.particularIndentDetails.clear();

                    setState(() {
                      selectedIndent = selected;
                    });
                    _pcapprovalController.eTapprovalAmount.clear();

                    getParticularIndentDetails(
                        miId: widget.loginSuccessModel.mIID!,
                        base: baseUrlFromInsCode("", widget.mskoolController),
                        roleId: widget.loginSuccessModel.roleId!,
                        userId: widget.loginSuccessModel.userId!,
                        asmaYId: widget.loginSuccessModel.asmaYId!,
                        tempIndentId: selected!.pcindenTId!.toInt(),
                        controller: _pcapprovalController);
                  },
                ),
              )),

          SizedBox(
            height: 25,
          ),

          /////*****   DATA TABLE FOR INDENT    *****/////
          Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "INDENT DETAILS",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo),
                  )),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  dataTextStyle: const TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(5, 5, 5, 0.945),
                      fontWeight: FontWeight.w500),
                  dataRowHeight: 40,
                  headingRowHeight: 55,
                  horizontalMargin: 10,
                  columnSpacing: 40,
                  dividerThickness: 1,
                  border: TableBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  headingRowColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  columns: [
                    DataColumn(
                        label: Text("S No.",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("Indent No.",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("Department",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("Indent Approved By",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("Date",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("Indent Requested Amount",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                    DataColumn(
                        label: Text("Indent Approved Amount",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800))),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text('1'),
                        )),
                        DataCell(Text("${selectedIndent?.pcindenTIndentNo}")),
                        DataCell(Text("${selectedIndent?.departmentname}")),
                        DataCell(Text("${selectedIndent?.employeename}")),
                        DataCell(Text("${selectedIndent?.createdate}")),
                        DataCell(
                            Text("${selectedIndent?.pcindenTRequestedAmount}")),
                        DataCell(
                            Text("${selectedIndent?.pcindenTApprovedAmt}")),
                      ],
                    ),
                    // Add more rows as needed
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 25,
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
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo),
                    )),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      dataTextStyle: const TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(5, 5, 5, 0.945),
                          fontWeight: FontWeight.w500),
                      dataRowHeight: 40,
                      headingRowHeight: 55,
                      horizontalMargin: 10,
                      columnSpacing: 40,
                      dividerThickness: 1,
                      border: TableBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      headingRowColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      columns: [
                        DataColumn(
                            label: Checkbox(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
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
                                            .eTapprovalAmount.length;
                                    i++) {
                                  selectCheckBx!.add(i);
                                  _pcapprovalController.checkList[i] = true;
                                  print(selectCheckBx.toString());
                                }
                              } else {
                                for (int i = 0;
                                    i <
                                        _pcapprovalController
                                            .eTapprovalAmount.length;
                                    i++) {
                                  selectCheckBx!.remove(i);
                                  _pcapprovalController.checkList[i] = false;
                                  print(selectCheckBx.toString());
                                }
                              }
                            });
                          },
                        )),
                        DataColumn(
                            label: Text("S No.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Indent No.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Particulars",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Indent Requested Amount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Indent Amount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Approved Amount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Remarks",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                      ],
                      rows: List.generate(
                          _pcapprovalController.particularIndentDetails.length,
                          (index) {
                        var i = index + 1;
                        return DataRow(
                          cells: [
                            DataCell(Align(
                              alignment: Alignment.center,
                              child: Checkbox(
                                activeColor: Colors.indigo,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                value: _pcapprovalController.checkList
                                    .elementAt(index),
                                onChanged: (value) {
                                  _pcapprovalController.checkList[index] =
                                      value!;
                                  setState(() {
                                    if (value) {
                                      if (selectCheckBx!.contains(index)) {
                                        selectCheckBx!.remove(index);
                                        print(selectCheckBx.toString());
                                        if (_pcapprovalController
                                                .eTapprovalAmount.length !=
                                            selectCheckBx!.length) {
                                          selectAll = false;
                                        }
                                      } else {
                                        selectCheckBx!.add(index);
                                        print(selectCheckBx.toString());
                                        if (_pcapprovalController
                                                .eTapprovalAmount.length ==
                                            selectCheckBx!.length) {
                                          selectAll = true;
                                        }
                                      }
                                    } else {
                                      selectCheckBx!.remove(index);
                                      print(selectCheckBx.toString());
                                      if (_pcapprovalController
                                              .eTapprovalAmount.length !=
                                          selectCheckBx!.length) {
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
                            DataCell(Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: _pcapprovalController
                                    .eTapprovalAmount
                                    .elementAt(index),
                              ),
                            )),
                            DataCell(
                              Text(
                                  "${_pcapprovalController.particularIndentDetails.elementAt(index).pcindentdeTRemarks}"),
                            ),
                          ],
                        );
                      })),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        sendData();
                      },
                      child: Text("Save")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getDateNeed(DateTime dt) {
    //.padLeft(2,"0")

    return "${dt.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }
}

//         Obx(() =>
//         _pcapprovalController.isLoadingIndentDetails.isTrue ?
//          const AnimatedProgressWidget(
//             animationPath: 'assets/json/default.json',
//             title: 'Loading data',
//             desc: "Please wait we are loading data",
//           ):
//         _pcapprovalController.pcApprovedList.isNotEmpty ?
//            PcParticularDetailsTable(
//   loginSuccessModel: widget.loginSuccessModel,
//   mskoolController: widget.mskoolController,
// ): const Center(
//       child: AnimatedProgressWidget(
//         animationPath: 'assets/json/nodata.json',
//         title: 'No Details found',
//         desc: "Organization has no data to show",
//         animatorHeight: 250,
//       ),
//     ))

// DataTable(
//     dataTextStyle: const TextStyle(
//         fontSize: 15,
//         color: Color.fromRGBO(5, 5, 5, 0.945),
//         fontWeight: FontWeight.w500),
//     dataRowHeight: 40,
//     headingRowHeight: 55,
//     horizontalMargin: 10,
//     columnSpacing: 40,
//     dividerThickness: 1,
//     border: TableBorder(
//         borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(10),
//             bottomLeft: Radius.circular(10))),
//     headingRowColor: MaterialStateProperty.all(
//         Theme.of(context).primaryColor),
//     columns: [
//       DataColumn(
//           label: Text("S No.",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800))),
//       DataColumn(
//           label: Text("Indent No.",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800))),
//     ],
//     rows: List.generate(
//         _pcapprovalController.pcApprovedList.length, (index) {
//       var i = index + 1;
//       return DataRow(cells: [
//         DataCell(Align(
//             alignment: Alignment.center, child: Text('$i'))),
//         DataCell(Text(
//             "${_pcapprovalController.pcApprovedList.elementAt(index).pcindentapTIndentNo}")),
//       ]);
//     }))
