import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/api/requested_details_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/api/view_data_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/cash_requisition_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/widget/view_detail_pc_req.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class PcRequisitionDetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PcRequisitionDetailsScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<PcRequisitionDetailsScreen> createState() =>
      _PcRequisitionDetailsScreenState();
}

class _PcRequisitionDetailsScreenState
    extends State<PcRequisitionDetailsScreen> {
  final CashRequisitionController requestedDetailsPC =
      Get.put(CashRequisitionController());

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    requestedDetails(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        roleId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        asmaYId: widget.loginSuccessModel.asmaYId!,
        roleFlag: widget.loginSuccessModel.roleforlogin!,
        controller: requestedDetailsPC);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => requestedDetailsPC.isLoadingRequestedDetails.isTrue
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading data',
                  desc: "Please wait we are loading data",
                )
              : requestedDetailsPC.getLoadDataList.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 16.0),
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
                                      headingRowColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor),
                                      columns: const [
                                        DataColumn(
                                            label: Text("S No.",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800))),
                                        DataColumn(
                                            label: Text("Requisition No.",
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
                                            label: Text("Requested By",
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
                                            label: Text("Purpose",
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
                                      rows: List.generate(
                                          requestedDetailsPC
                                              .getLoadDataList.length, (index) {
                                        var i = index + 1;
                                        return DataRow(cells: [
                                          DataCell(Align(
                                              alignment: Alignment.center,
                                              child: Text('$i'))),
                                          DataCell(Text(
                                              "${requestedDetailsPC.getLoadDataList.elementAt(index).pcreqtNRequisitionNo}")),
                                          DataCell(Text(
                                              "${requestedDetailsPC.getLoadDataList.elementAt(index).departmentname}")),
                                          DataCell(Text(
                                              "${requestedDetailsPC.getLoadDataList.elementAt(index).employeename}")),
                                          DataCell(Text(getDateNeed(
                                              DateTime.parse(requestedDetailsPC
                                                  .getLoadDataList
                                                  .elementAt(index)
                                                  .pcreqtNCreatedDate!)))),
                                          DataCell(Text(
                                              "${requestedDetailsPC.getLoadDataList.elementAt(index).pcreqtNPurpose}")),
                                          DataCell(Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () async {
                                                    var status = await getviewdataPcReq(
                                                        miId: widget
                                                            .loginSuccessModel
                                                            .mIID!,
                                                        base: baseUrlFromInsCode(
                                                            "issuemanager",
                                                            widget
                                                                .mskoolController),
                                                        roleId: widget
                                                            .loginSuccessModel
                                                            .roleId!,
                                                        userId: widget
                                                            .loginSuccessModel
                                                            .userId!,
                                                        asmaYId: widget
                                                            .loginSuccessModel
                                                            .asmaYId!,
                                                        roleFlag: widget
                                                            .loginSuccessModel
                                                            .roleforlogin!,
                                                        pcReqTNid:
                                                            requestedDetailsPC
                                                                .getLoadDataList
                                                                .elementAt(
                                                                    index)
                                                                .pcreqtNId!,
                                                        controller:
                                                            requestedDetailsPC);
                                                    if (status == 200) {
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (_) {
                                                        return RequestedParticularDetailsPC(
                                                          loginSuccessModel: widget
                                                              .loginSuccessModel,
                                                          mskoolController: widget
                                                              .mskoolController,
                                                          controller:
                                                              requestedDetailsPC,
                                                        );
                                                      }));
                                                    }
                                                  },
                                                  child: const Icon(Icons
                                                      .remove_red_eye_rounded)),
                                            ],
                                          )),
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
                        visible:
                            !requestedDetailsPC.isLoadingRequestedDetails.value,
                        child: const AnimatedProgressWidget(
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
    requestedDetailsPC.getLoadDataList.clear();

    super.dispose();
  }

  String getDateNeed(DateTime dt) {
    //.padLeft(2,"0")

    return "${dt.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }
}
