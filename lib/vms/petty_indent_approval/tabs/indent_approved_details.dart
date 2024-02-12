import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/api/indent_details_approved_api.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/api/indent_view_data_api.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/widget/indent_view_data.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class IndentApprovedDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const IndentApprovedDetails(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<IndentApprovedDetails> createState() => _IndentApprovedDetailsState();
}

class _IndentApprovedDetailsState extends State<IndentApprovedDetails> {
  final PettyIndentApprovalController indentController =
      Get.put(PettyIndentApprovalController());

  // ParticularApprovedIndentModelValues? approvedparticular;

  // final ManagerInventoryController inventoryController =
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    getIndentDetails(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        roleId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        asmaYId: widget.loginSuccessModel.asmaYId!,
        roleFlag: widget.loginSuccessModel.roleforlogin!,
        controller: indentController);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => indentController.isLoadingIndentDetails.isTrue
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading data',
                  desc: "Please wait we are loading data",
                )
              : Container(
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
                                  headingRowColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  columns: const [
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
                                        label: Text("Approved By",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Date",
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
                                      indentController
                                          .approvedIndentList.length, (index) {
                                    var i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Text(
                                          "${indentController.approvedIndentList.elementAt(index).pcindenTIndentNo}")),
                                      DataCell(Text(
                                          "${indentController.approvedIndentList.elementAt(index).departmentname}")),
                                      DataCell(Text(
                                          "${indentController.approvedIndentList.elementAt(index).employeename}")),
                                      DataCell(Text(getDateNeed(DateTime.parse(
                                          indentController.approvedIndentList
                                              .elementAt(index)
                                              .createdate!)))),
                                      DataCell(TextButton(
                                          onPressed: () async {
                                            var status =
                                                await getIndentViewData(
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
                                                    userId:
                                                        widget.loginSuccessModel
                                                            .userId!,
                                                    asmaYId:
                                                        widget.loginSuccessModel
                                                            .asmaYId!,
                                                    roleFlag: widget
                                                        .loginSuccessModel
                                                        .roleforlogin!,
                                                    pcIndentId:
                                                        indentController
                                                            .approvedIndentList
                                                            .elementAt(index)
                                                            .pcindenTId!,
                                                    controller:
                                                        indentController);
                                            logger.i(status);
                                            // if (status == 200) {
                                            // ignore: use_build_context_synchronously
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return IndentViewDataDetails(
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                                controller: indentController,
                                              );
                                            }));
                                            // }
                                          },
                                          child: const Icon(
                                              Icons.remove_red_eye_rounded))),
                                    ]);
                                  })),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    indentController.approvedIndentList.clear();

    super.dispose();
  }

  String getDateNeed(DateTime dt) {
    //.padLeft(2,"0")

    return "${dt.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }
}
