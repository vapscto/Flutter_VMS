import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/VMS/Fee_collection/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Fee_collection/api/onclick_purchase_api.dart';
import 'package:m_skool_flutter/vms/Fee_collection/screen/view_comment.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import '../../../widget/home_fab.dart';

class PurchaseDetails extends StatefulWidget {
  final  int invmpiId;
  const PurchaseDetails({super.key,
 required PurchaseController PurchaseController, required this.invmpiId,});
  @override
  _PurchaseDetailsState createState() => _PurchaseDetailsState();
}  

class _PurchaseDetailsState extends State<PurchaseDetails> {
 PurchaseController controller = Get.put(PurchaseController());
 
RxString selectedValue = "".obs;
  @override
  void initState() {
    OnclickPurchaseApi.instance.getOnclickPurchaseApiApi(base: "", userId: "", controller: controller, invmpiId:widget.invmpiId);                                  
    super.initState();
  }
  @override
  void dispose() {
    controller.getOnclickList.clear();
     super.dispose();
  }
  final remarkController = TextEditingController();
  final unitController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "PURCHASE INDENT DETAILS").getAppBar(),
      floatingActionButton: const HomeFab(),
        body: Obx(
          () => controller.getOnclickList.isEmpty
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: "assets/json/nodata.json",
                     animatorHeight: 300,
                      title: "Loading Purchase Indent",
                      desc:
                          "Please wait while we load detail table and create a view for you.",
                      ),
                )  
              : SingleChildScrollView(
                  child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 45,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 40,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(
                                  numeric: true,
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'SL.No.',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Approve',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                 DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                 DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Item',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                 DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'UOM',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                 DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'PR Quantity',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                 DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'PI Quantity',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                  DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Aproval Qty.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                 DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'PI Unit Rate',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                  DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Approximate Amount',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                  DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Remarks',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                  DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'view Comment',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                  
                              ],
                              rows: List.generate(
                                  controller.getOnclickList.length,
                                  (index) {
                                var i = index + 1;
                                remarkController.text = controller.getOnclickList.elementAt(index).iNVTPIRemarks.toString();
                                unitController.text = controller.getOnclickList.elementAt(index).iNVTPIPIUnitRate.toString();
                              
                                return DataRow(
                                  cells: [
                                    DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text('$i'))),
                                    DataCell(Radio(
                                   fillColor: MaterialStateColor.resolveWith(
                                   (states) => Theme.of(context).primaryColor),
                                   groupValue: selectedValue.value,
                                   value: 'Approved',
                                   onChanged: (value) {
                                    setState(() {
                                      selectedValue.value = value!;
                                                 });
                                                 },
                                                )),
                                                  DataCell(Radio(
                                   fillColor: MaterialStateColor.resolveWith(
                                   (states) => Theme.of(context).primaryColor),
                                   groupValue: selectedValue.value,
                                   value: 'Reject',
                                   onChanged: (value) {
                                    setState(() {
                                      selectedValue.value = value!;
                                                 });
                                                 },
                                                )),
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.getOnclickList.elementAt(index).iNVMIItemName.toString()),
                                        )
                                        ),   
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.getOnclickList.elementAt(index).iNVMUOMUOMName.toString()),
                                        )
                                        ), 
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.getOnclickList.elementAt(index).iNVTPIPIQty.toString()),
                                        )
                                        ), 
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.getOnclickList.elementAt(index).iNVTPIPIQty.toString()),
                                        )
                                        ), 
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.getOnclickList.elementAt(index).iNVTPIAPPApprovedQty.toString()),
                                        )
                                        ), 
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: TextField( controller: unitController),
                                        )
                                        ), 
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.getOnclickList.elementAt(index).iNVTPIApproxAmount.toString()),
                                        )
                                        ), 
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: TextField( controller: remarkController),
                                        )
                                        ), 
                                         DataCell( IconButton(
                                          onPressed: () {
                                                Get.to( () => ViewComment (purchaseController:controller, invmpiId:controller.purchaseIndentList.elementAt(index).iNVMPIId!,
                                            )
                                            );
                                          },                                        
                                          icon: const Icon(Icons.visibility),
                                        )
                                        ), 
                                       
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 128.0,
                      ),
                    ],
                  ),
                )),
        ));
    
     
    

  }

}