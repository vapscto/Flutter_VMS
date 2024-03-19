import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/ontapview_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

import '../../../controller/global_utilities.dart';

class OnTapViewDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int invmpRId;

 const OnTapViewDetails(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController, required this.invmpRId,
     });

  @override
  State<OnTapViewDetails> createState() => _OnTapViewDetailsState();

}

class _OnTapViewDetailsState extends State<OnTapViewDetails> {
   final PurchaseRequisitionController controller = Get.put(PurchaseRequisitionController());

   



@override
  void initState() {
onviewload();
    super.initState();
  }
onviewload() async{
  controller.getontapviewList.clear();
 await getOntapdetailsApi(
 base: baseUrlFromInsCode( "inventory",widget.mskoolController),
 userId: widget.loginSuccessModel.userId!,
 mIIdNew:widget.loginSuccessModel.mIID!, 
 controller: controller,
 invmpRId: widget.invmpRId);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "INDENT DETAILS").getAppBar(),
      body:SingleChildScrollView(
      child: Obx(
         () => controller.getontapviewList.isEmpty
              ? const AnimatedProgressWidget(
                  animationPath: "assets/json/default.json",
                  title: "Loading...",
                  desc:
                      "Please wait while we are loading Consolidated Report Details",
                )
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
                                    label: Text("UOM",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Date",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                DataColumn(
                                    label: Text("Quantity",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                               DataColumn(
                                    label: Text("Approved Quantity",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                               DataColumn(
                                    label: Text("Approx Rate",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800))),
                                               DataColumn(
                                    label: Text("Approx Amount",
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
                                  controller.getontapviewList.length,
                                  (index) {
                                var i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(Text(
                                      "${controller.getontapviewList.elementAt(index).invmIItemName}")),
                                  DataCell(Text(
                                      "${controller.getontapviewList.elementAt(index).invmuoMUOMName}")),
                                   DataCell(Text(getDate(DateTime.parse( controller.getrequestRequisitionGridList.elementAt(index).invmpRPRDate!)))),
                                  DataCell(Text(
                                      "${controller.getontapviewList.elementAt(index).invtpRPRQty}")),
                                 DataCell(Text(
                                      "${controller.getontapviewList.elementAt(index).invtpRApprovedQty}")),
                                 DataCell(Text(
                                      "${controller.getontapviewList.elementAt(index).invtpRPRUnitRate}")),
                                 DataCell(Text(
                                      "${controller.getontapviewList.elementAt(index).invtpRApproxAmount}")),
                                 DataCell(Text(
                                      "${controller.getontapviewList.elementAt(index).invtpRActiveFlg}")),
                                ]);
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
    ));
  }
    @override
  void dispose() {
   controller.getontapviewList.clear();
    super.dispose();
  }
}
