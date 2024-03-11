import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/modal_view_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class PersonApprovedDetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ModalViewController controller;
  const PersonApprovedDetailsScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<PersonApprovedDetailsScreen> createState() =>
      _PersonApprovedDetailsScreenState();
}

class _PersonApprovedDetailsScreenState
    extends State<PersonApprovedDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.getModalView.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "APPROVED DETAILS").getAppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: (widget.controller.getModalView.isEmpty)
                    ? const SizedBox()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "FIRST LEVEL",
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
                                      fontWeight: FontWeight.w400),
                                  dataRowHeight: 40,
                                  headingRowHeight: 55,
                                  horizontalMargin: 10,
                                  columnSpacing: 40,
                                  dividerThickness: 1,
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10)),
                                  headingRowColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  columns: const [
                                    DataColumn(
                                        label: Text("S No.",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Approved By",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Approved Date",
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
                                      widget.controller.getModalView.length,
                                      (index) {
                                    var i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "${widget.controller.getModalView.elementAt(index).firstApprovalperson}"),
                                        ),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text((widget
                                                    .controller.getModalView
                                                    .elementAt(index)
                                                    .firstApprovalDate !=
                                                null)
                                            ? getDateNeed(DateTime.parse(widget
                                                .controller.getModalView
                                                .elementAt(index)
                                                .firstApprovalDate!))
                                            : ''),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${widget.controller.getModalView.elementAt(index).firstApprovalAmount}"),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${widget.controller.getModalView.elementAt(index).firstApprovalRemark}"),
                                      )),
                                    ]);
                                  })),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SECOND LEVEL",
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
                                      fontWeight: FontWeight.w400),
                                  dataRowHeight: 40,
                                  headingRowHeight: 55,
                                  horizontalMargin: 10,
                                  columnSpacing: 40,
                                  dividerThickness: 1,
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10)),
                                  headingRowColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  columns: const [
                                    DataColumn(
                                        label: Text("S No.",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Approved By",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Approved Date",
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
                                      widget.controller.getModalView.length,
                                      (index) {
                                    var i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(widget
                                                .controller.getModalView
                                                .elementAt(index)
                                                .secondApprovalperson ??
                                            "-"),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          widget.controller.getModalView
                                                      .elementAt(index)
                                                      .secondApprovalDate !=
                                                  null
                                              ? getDateNeed(DateTime.parse(
                                                  widget.controller.getModalView
                                                      .elementAt(index)
                                                      .secondApprovalDate
                                                      .toString()))
                                              : "-",
                                        ),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (widget.controller.getModalView
                                                      .elementAt(index)
                                                      .secondApprovalAmount ??
                                                  0.0)
                                              .toString(),
                                        ),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(widget
                                                .controller.getModalView
                                                .elementAt(index)
                                                .secondApprovalRemark ??
                                            "-"),
                                      )),
                                    ]);
                                  })),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ));
  }

  String getDateNeed(DateTime dt) {
    return "${dt.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
  }
}
