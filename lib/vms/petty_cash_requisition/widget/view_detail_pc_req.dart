import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/api/modal_view_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/api/view_data_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/cash_requisition_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class requestedParticularDetailsPC extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final CashRequisitionController controller;
  requestedParticularDetailsPC(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<requestedParticularDetailsPC> createState() =>
      _requestedParticularDetailsPCState();
}

class _requestedParticularDetailsPCState
    extends State<requestedParticularDetailsPC> {
  final CashRequisitionController requestedDetailsPC =
      Get.put(CashRequisitionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.getViewDataParticular.clear();
    super.dispose();
  }

  //${requestedDetailsPC.getViewDataParticular.elementAt(index).pcmparTParticularName}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "REQUISITION DETAILS").getAppBar(),
      body: widget.controller.getViewDataParticular.isNotEmpty
          ? Obx(
              () => Container(
                margin: EdgeInsets.only(top: 16.0),
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
                                    label: Text("Amount",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Remarks",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Action",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                              ],
                              rows: List.generate(
                                  widget.controller.getViewDataParticular
                                      .length, (index) {
                                var i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(Text(
                                      "${widget.controller.getViewDataParticular.elementAt(index).pcmparTParticularName}")),
                                  DataCell(Text(
                                      "${widget.controller.getViewDataParticular.elementAt(index).pcreqtndeTAmount}")),
                                  DataCell(Text(
                                      "${widget.controller.getViewDataParticular.elementAt(index).pcreqtndeTRemarks}")),
                                  DataCell(Row(
                                    children: [
                                      TextButton(
                                        onPressed: () async {

                                          var selectedData = widget.controller.getViewDataParticular[index]; 
                                          
                                          var status = await modalViewDetails(
                                            miId:
                                                widget.loginSuccessModel.mIID!,
                                            base: baseUrlFromInsCode(
                                                "issuemanager",
                                                widget.mskoolController),
                                            roleId: widget
                                                .loginSuccessModel.roleId!,
                                            userId: widget
                                                .loginSuccessModel.userId!,
                                            asmaYId: widget
                                                .loginSuccessModel.asmaYId!,
                                            roleFlag: widget.loginSuccessModel
                                                .roleforlogin!,
                                            pcReqTNid: widget.controller.getViewDataParticular[index].pcreqtNId! ,
                                            controller: requestedDetailsPC,
                                          );

                                          print(widget
                                                    .controller
                                                    .getModalView[0]
                                                    .firstApprovalperson);


                                          if (status == 200) {

                                            if (widget
                                                    .controller
                                                    .getModalView[0]
                                                    .firstApprovalperson ==
                                                null) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "First Level is Not Approved !");
                                            } else {
                                              widget
                                                    .controller
                                                    .getModalView[0]
                                                    .secondApprovalperson ==
                                                null ;
                                            } { 
                                              Fluttertoast.showToast(
                                                  msg:
                                                      " Not ");
                                            }
                                          }
                                        },
                                        child:
                                            Icon(Icons.remove_red_eye_rounded),
                                      ),
                                    ],
                                  )),
                                ]);
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : AnimatedProgressWidget(
              animationPath: 'assets/json/nodata.json',
              title: 'No Details found',
              desc: "Particular Indent has no data to show",
              animatorHeight: 250,
            ),
    );
  }
}























// var status = await modalViewDetails(
                                                    //     miId: widget
                                                    //         .loginSuccessModel
                                                    //         .mIID!,
                                                    //     base: baseUrlFromInsCode(
                                                    //         "issuemanager",
                                                    //         widget
                                                    //             .mskoolController),
                                                    //     roleId: widget
                                                    //         .loginSuccessModel
                                                    //         .roleId!,
                                                    //     userId: widget
                                                    //         .loginSuccessModel
                                                    //         .userId!,
                                                    //     asmaYId: widget
                                                    //         .loginSuccessModel
                                                    //         .asmaYId!,
                                                    //     roleFlag: widget
                                                    //         .loginSuccessModel
                                                    //         .roleforlogin!,
                                                    //     pcReqTNid:
                                                    //         requestedDetailsPC
                                                    //             .getLoadDataList
                                                    //             .elementAt(
                                                    //                 index)
                                                    //             .pcreqtNId!,
                                                    //     controller:
                                                    //         requestedDetailsPC);
                                                    // if (status == 200) {
                                                    //   Navigator.push(context,
                                                    //       MaterialPageRoute(
                                                    //           builder: (_) {
                                                    //     return requestedParticularDetailsPC(
                                                    //       loginSuccessModel: widget
                                                    //           .loginSuccessModel,
                                                    //       mskoolController: widget
                                                    //           .mskoolController,
                                                    //       controller:
                                                    //           requestedDetailsPC,
                                                    //     );
                                                    //   }));
                                                    // }