import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/requisition_grid_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/screen/indent_approval.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/screen/ontapview_data.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/screen/purchase_indent_table.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import '../../../controller/global_utilities.dart';


class RequisitionGrid extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const RequisitionGrid({
    Key? key,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  @override
  State<RequisitionGrid> createState() => _RequisitionGridState();
  
}

class _RequisitionGridState extends State<RequisitionGrid> {
  final PurchaseRequisitionController controller = Get.put(PurchaseRequisitionController());




@override
  void initState() {
onload();
    super.initState();
  }
onload() async{
  controller.getrequestRequisitionGridList.clear();
  await  getPurchaseRequisitionGridApi( base: baseUrlFromInsCode(
 "inventory", widget.mskoolController), 
 userId: widget.loginSuccessModel.userId!,
  miId: widget.loginSuccessModel.mIID!, 
  controller: controller);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Requsition Grid").getAppBar(),
    body: SingleChildScrollView(
   child: Obx(
          () => controller.getrequestRequisitionGridList.isEmpty
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 15, right: 15, bottom: 30),
                          child: Column(
                            children: [
                              DataTable(
                                dataTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(5, 5, 5, 0.945),
                                  fontWeight: FontWeight.w500,
                                ),
                                dataRowHeight: 30,
                                headingRowHeight: 35,
                                horizontalMargin: 10,
                                columnSpacing: 40,
                                dividerThickness: 1,
                                border: TableBorder.all(
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                      headingRowColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor),
                      columns: [
                        DataColumn(
                          label: Text(
                            "SL No",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "PR Number",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Date",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Total Approx Amount",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Action",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Indent Remark",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Indent Approval",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                          DataColumn(
                          label: Text(
                            "Order Approval",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                          DataColumn(
                          label: Text(
                            "Order Approval Remark",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                        
                      ],
                      rows: List.generate(
                        controller.getrequestRequisitionGridList.length,
                        (index){
                          var i = index+1;
                          return  DataRow(
                          cells: [
                            DataCell(Center(child: Text("$i"))),
                            DataCell(Center(
                              child: Text(
                                "${controller.getrequestRequisitionGridList.elementAt(index).invmpRPRNo}",
                                textAlign: TextAlign.center,
                              ),
                            )),
                               DataCell(Text(getDate(DateTime.parse( controller.getrequestRequisitionGridList.elementAt(index).invmpRPRDate!)))),
                            DataCell(Center(
                              child: Text(
                                "${controller.getrequestRequisitionGridList.elementAt(index).invmpRApproxTotAmount}",
                                textAlign: TextAlign.center,
                              ),
                            )),
 DataCell(
  TextButton(
    onPressed: () async {
      OnTapViewDetails onTapViewDetails = OnTapViewDetails(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController, invmpRId: controller.getrequestRequisitionGridList.elementAt(index).invmpRId!,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => onTapViewDetails),
      );
    },
    child: const Icon(Icons.remove_red_eye_rounded),
  ),
),
 DataCell(
  TextButton(
    onPressed: () async {
      PurchaseViewDetails purchaseViewDetails = PurchaseViewDetails(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController, invmpRId: controller.getrequestRequisitionGridList.elementAt(index).invmpRId!,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => purchaseViewDetails),
      );
    },
    child: const Icon(Icons.remove_red_eye_rounded),
  ),
),


 DataCell(
  TextButton(
    onPressed: () async {
      PurchaseApprovalDetails purchaseApprovalDetails = PurchaseApprovalDetails(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController, invmpRId: controller.getrequestRequisitionGridList.elementAt(index).invmpRId!,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => purchaseApprovalDetails),
      );
    },
    child: const Icon(Icons.remove_red_eye_rounded),
  ),
),

                              DataCell(TextButton(
                                          onPressed: () async {
                                          },
                                          child: const Icon(
                                              Icons.remove_red_eye_rounded))),
                             DataCell(TextButton(
                                          onPressed: () async {
                                          },
                                          child: const Icon(
                                              Icons.remove_red_eye_rounded))),
                          ],
                        );}
                      ),
                    ),
       ] ),
                
                )
              )
              )
        ),
       
    )
    );
  }
  @override
  void dispose() {
  controller.getrequestRequisitionGridList.clear();
    super.dispose();
  }

}
