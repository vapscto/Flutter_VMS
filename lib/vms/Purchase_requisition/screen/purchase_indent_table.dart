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

class PurchaseViewDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int invmpRId;

 const PurchaseViewDetails(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController, required this.invmpRId,
     });

  @override
  State<PurchaseViewDetails> createState() => _PurchaseViewDetailsState();

}

class _PurchaseViewDetailsState extends State<PurchaseViewDetails> {
   final PurchaseRequisitionController controller = Get.put(PurchaseRequisitionController());

   



@override
  void initState() {
onviewload();
    super.initState();
  }
onviewload() async{
  controller.getpurchasetapList.clear;
 await getpurchasedetailsApi(
 base: baseUrlFromInsCode( "inventory",widget.mskoolController),
 userId: widget.loginSuccessModel.userId!,
 miId:widget.loginSuccessModel.mIID!, 
 controller: controller,
 invmpRId: widget.invmpRId, 
 flag: 'Purchase_Indent', asmaYId: widget.loginSuccessModel.asmaYId!);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "INDENT REMARKS").getAppBar(),
      body: SingleChildScrollView(
      child: Obx(
         () =>   controller.getpurchasetapList.isEmpty
                ? const AnimatedProgressWidget(
                    animatorHeight: 250,
                    animationPath: "assets/json/nodata.json",
                    title: "No Data Found",
                    desc:
                        "We are under process to get your details from server.")
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
                          DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(5, 5, 5, 0.945),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 40,
                              headingRowHeight: 30,
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
                                    label: Text("SL.No.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Item Name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Indent Quntity",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Approve Quntity",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Indent Date",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                               DataColumn(
                                    label: Text("Approve",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                               DataColumn(
                                    label: Text("	Indent Remark",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                              ],
                              rows: List.generate(
                                  controller.getpurchasetapList.length,
                                  (index) {
                                var i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(Text(
                                      "${controller.getpurchasetapList.elementAt(index).iNVMIItemName}")),
                                  DataCell(Text(
                                      "${controller.getpurchasetapList.elementAt(index).iNVTPIPIQty}")),
                                  DataCell(Text(
                                      "${controller.getpurchasetapList.elementAt(index).iNVTPIApproveQty}")),
                                DataCell(Text(getDate(DateTime.parse( controller.getpurchasetapList.elementAt(index).iNVMPIPIDate!)))),
                                 DataCell(Text(
                                      "${controller.getpurchasetapList.elementAt(index).iNVTPIRejectFlg}")),
                                 DataCell(Text(
                                      "${controller.getpurchasetapList.elementAt(index).iNVTPIRemarks}")),
                                ]);
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
      )
    );
  }
    @override
  void dispose() {
   controller.getpurchasetapList.clear();
    super.dispose();
  }
}
