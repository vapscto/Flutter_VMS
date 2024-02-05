import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class IndentViewDataDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PettyIndentApprovalController controller;

  const IndentViewDataDetails(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<IndentViewDataDetails> createState() => _IndentViewDataDetailsState();
}

class _IndentViewDataDetailsState extends State<IndentViewDataDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.viewDataList.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "INDENT DETAILS").getAppBar(),
      body: widget.controller.viewDataList.isNotEmpty
          ? Obx(
              () => Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(5, 5, 5, 0.945),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 40,
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
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Particular",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Requested Amount",
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
                                  widget.controller.viewDataList.length,
                                  (index) {
                                var i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(Text(
                                      "${widget.controller.viewDataList.elementAt(index).pcmparTParticularName}")),
                                  DataCell(Text(
                                      "${widget.controller.viewDataList.elementAt(index).pcindentdeTAmount}")),
                                  DataCell(Text(
                                      "${widget.controller.viewDataList.elementAt(index).pcindentdeTApprovedAmt}")),
                                  DataCell(Text(
                                      "${widget.controller.viewDataList.elementAt(index).pcindentdeTRemarks}")),
                                ]);
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const AnimatedProgressWidget(
              animationPath: 'assets/json/nodata.json',
              title: 'No Details found',
              desc: "Particular Indent has no data to show",
              animatorHeight: 250,
            ),
    );
  }
}
