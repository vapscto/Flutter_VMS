import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/purchase_indent_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

import '../../../controller/global_utilities.dart';

class PurchaseApprovalDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int invmpRId;

  const PurchaseApprovalDetails({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.invmpRId,
  });

  @override
  State<PurchaseApprovalDetails> createState() =>
      _PurchaseApprovalDetailsState();
}

class _PurchaseApprovalDetailsState extends State<PurchaseApprovalDetails> {
  final PurchaseRequisitionController controller =
      Get.put(PurchaseRequisitionController());

  @override
  void initState() {
    onviewload();
    super.initState();
  }

  onviewload() async {
    controller.getpurchaseapprovaltapList.clear;
    await getpurchasedetailsApi(
        base: baseUrlFromInsCode("inventory", widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        controller: controller,
        invmpRId: widget.invmpRId,
        flag: 'Purchase_Approved',
        asmaYId: widget.loginSuccessModel.asmaYId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "INDENT APPROVAL").getAppBar(),
        body: SingleChildScrollView(
            child: Obx(
          () => controller.getpurchaseapprovaltapList.isEmpty
              ? const AnimatedProgressWidget(
                  animatorHeight: 250,
                  animationPath: "assets/json/nodata.json",
                  title: "No Data Found",
                  desc: "We are under process to get your details from server.")
              : Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: DataTable(
                                  dataTextStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(5, 5, 5, 0.945),
                                      fontWeight: FontWeight.w400),
                                  dataRowHeight: 40,
                                  headingRowHeight: 30,
                                  horizontalMargin: 10,
                                  columnSpacing: 40,
                                  dividerThickness: 1,
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10)),
                                  headingRowColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  columns: const [
                                    DataColumn(
                                        label: Text("SL.No.",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Approval Date",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Total Amount",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Approved By",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Remark",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                    DataColumn(
                                        label: Text("Status",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800))),
                                  ],
                                  rows: List.generate(
                                      controller.getpurchaseapprovaltapList
                                          .length, (index) {
                                    var i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Text(
                                          "${controller.getpurchaseapprovaltapList.elementAt(index).iNVMPIAPPApproxTotAmount}")),
                                      DataCell(Text(
                                          "${controller.getpurchaseapprovaltapList.elementAt(index).approvedBy}")),
                                      DataCell(Text(getDate(DateTime.parse(
                                          controller.getpurchaseapprovaltapList
                                              .elementAt(index)
                                              .iNVMPIAPPPIDate!)))),
                                      DataCell(Text(
                                          "${controller.getpurchaseapprovaltapList.elementAt(index).iNVMPIAPPRemarks}")),
                                      DataCell(Text(
                                          "${controller.getpurchaseapprovaltapList.elementAt(index).iNVMPIAPPRejectFlg}"))
                                    ]);
                                  })),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        )));
  }

  @override
  void dispose() {
    controller.getpurchaseapprovaltapList.clear();
    super.dispose();
  }
}
