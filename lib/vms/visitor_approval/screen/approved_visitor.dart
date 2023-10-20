// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:m_skool_flutter/controller/mskoll_controller.dart';
// import 'package:m_skool_flutter/model/login_success_model.dart';
// import 'package:m_skool_flutter/vms/Purchase_indent/screen/view_comment.dart';
// import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
// import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
// import 'package:m_skool_flutter/widget/custom_app_bar.dart';
// import 'package:m_skool_flutter/widget/custom_container.dart';
// import 'package:m_skool_flutter/widget/mskoll_btn.dart';
// import '../../../widget/home_fab.dart';

// class ApprovedVisitor extends StatefulWidget {
//   const ApprovedVisitor({
//     super.key,
//      required LoginSuccessModel loginSuccessModel, 
//   required MskoolController mskoolController

//   });
//   @override
//  ApprovedVisitorState createState() => ApprovedVisitorState();
// }

// class ApprovedVisitorState extends State<ApprovedVisitor> {
//   VisitorManagementsController controller = Get.put(VisitorManagementsController());



//   @override
//   void initState() {
  
//   }



//   List<Map<String, dynamic>> transRowEdit = [];

//   final remarkController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar:
//             const CustomAppBar(title: "PURCHASE INDENT DETAILS").getAppBar(),
//         floatingActionButton: const HomeFab(),
//         body: Obx(
//           () => controller.getOnclickList.isEmpty
//               ? const Center(
//                   child: AnimatedProgressWidget(
//                     animationPath: "assets/json/nodata.json",
//                     animatorHeight: 300,
//                     title: "Loading Purchase Indent",
//                     desc:
//                         "Please wait while we load detail table and create a view for you.",
//                   ),
//                 )
//               : ListView(
//                   padding: const EdgeInsets.all(12.0),
//                   children: [
//                     CustomContainer(
//                         child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: "Company Name: ",
//                                   style: Get.textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Theme.of(context).primaryColor)),
//                               TextSpan(
//                                   text: controller
//                                       .purchaseIndentList.first.mIName,
//                                   style: Get.textTheme.titleSmall!
//                                       .copyWith(fontWeight: FontWeight.w600)),
//                             ]),
//                           ),
//                           const SizedBox(height: 5),
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: "INDENT NO.:",
//                                   style: Get.textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Theme.of(context).primaryColor)),
//                               TextSpan(
//                                   text: controller
//                                       .purchaseIndentList.first.iNVMPIPINo,
//                                   style: Get.textTheme.titleSmall!
//                                       .copyWith(fontWeight: FontWeight.w400)),
//                             ]),
//                           ),
//                           const SizedBox(height: 5),
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: "REFERENCE NO.:",
//                                   style: Get.textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Theme.of(context).primaryColor)),
//                               TextSpan(
//                                   text: controller.purchaseIndentList.first
//                                       .iNVMPIReferenceNo,
//                                   style: Get.textTheme.titleSmall!
//                                       .copyWith(fontWeight: FontWeight.w400)),
//                             ]),
//                           ),
//                           const SizedBox(height: 5),
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: "AMOUNT :",
//                                   style: Get.textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Theme.of(context).primaryColor)),
//                               TextSpan(
//                                   text: controller.purchaseIndentList.first
//                                       .iNVMPIApproxTotAmount
//                                       .toString(),
//                                   style: Get.textTheme.titleSmall!
//                                       .copyWith(fontWeight: FontWeight.w400)),
//                             ]),
//                           ),
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: "INDENT DATE: ",
//                                   style: Get.textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Theme.of(context).primaryColor)),
//                               TextSpan(
//                                   text: controller
//                                       .purchaseIndentList.first.iNVMPIPIDate,
//                                   style: Get.textTheme.titleSmall!
//                                       .copyWith(fontWeight: FontWeight.w400)),
//                             ]),
//                           ),
//                           const SizedBox(height: 5),
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: "REQUESTED BY: ",
//                                   style: Get.textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Theme.of(context).primaryColor)),
//                               TextSpan(
//                                   text: controller
//                                       .purchaseIndentList.first.indentCreadBy,
//                                   style: Get.textTheme.titleSmall!
//                                       .copyWith(fontWeight: FontWeight.w400)),
//                             ]),
//                           ),
//                           const SizedBox(height: 5),
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: "REMARKS:  ",
//                                   style: Get.textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Theme.of(context).primaryColor)),
//                               TextSpan(
//                                   text: controller
//                                       .purchaseIndentList.first.iNVMPIRemarks,
//                                   style: Get.textTheme.titleSmall!
//                                       .copyWith(fontWeight: FontWeight.w400)),
//                             ]),
//                           ),
//                         ],
//                       ),
//                     )),
//                     const SizedBox(height: 16),
//                     SingleChildScrollView(
//                         child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10.0, vertical: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // const SizedBox(height: 20),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width,
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: DataTable(
//                                   dataTextStyle: const TextStyle(
//                                       fontSize: 12,
//                                       color: Color.fromRGBO(0, 0, 0, 0.95),
//                                       fontWeight: FontWeight.w400),
//                                   dataRowHeight: 45,
//                                   headingRowHeight: 40,
//                                   horizontalMargin: 10,
//                                   columnSpacing: 40,
//                                   dividerThickness: 1,
//                                   headingTextStyle: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700),
//                                   border: TableBorder.all(
//                                       borderRadius: BorderRadius.circular(10),
//                                       width: 0.5),
//                                   headingRowColor: MaterialStateProperty.all(
//                                       Theme.of(context).primaryColor),
//                                   columns: const [
//                                     DataColumn(
//                                       numeric: true,
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'SL.No.',
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Approve',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Reject',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Item',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'UOM',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'PR Quantity',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'PI Quantity',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Aproval Qty.',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'PI Unit Rate',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Approximate Amount',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Remarks',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'view Comment',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                   rows: List.generate(
//                                       controller.getOnclickList.length,
//                                       (index) {
//                                     var i = index + 1;
//                                     // remarkController.text = controller.getOnclickList.elementAt(index).iNVTPIRemarks.toString();
//                                     // unitController.text = controller.getOnclickList.elementAt(index).iNVTPIPIUnitRate.toString();

//                                     return DataRow(
//                                       cells: [
//                                         DataCell(Align(
//                                             alignment: Alignment.center,
//                                             child: Text('$i'))),
//                                         DataCell(Radio(
//                                           fillColor:
//                                               MaterialStateColor.resolveWith(
//                                                   (states) => Theme.of(context)
//                                                       .primaryColor),
//                                           groupValue:
//                                               controller.selectedValue[index],
//                                           value: 'Approved',
//                                           onChanged: (dynamic value) {
//                                             setState(() {
//                                               controller.selectedValue[index] =
//                                                   value;
//                                               controller
//                                                   .totalApproxAmountControllerList
//                                                   .add(TextEditingController(
//                                                       text: controller
//                                                           .getOnclickList[index]
//                                                           .iNVTPIApproxAmount
//                                                           .toString()));
//                                               amount += num.parse(controller
//                                                   .totalApproxAmountControllerList
//                                                   .elementAt(index)
//                                                   .text);
//                                             });
//                                           },
//                                         )),
//                                         DataCell(Radio(
//                                           fillColor:
//                                               MaterialStateColor.resolveWith(
//                                                   (states) => Theme.of(context)
//                                                       .primaryColor),
//                                           groupValue:
//                                               controller.selectedValue[index],
//                                           value: 'Reject',
//                                           onChanged: (dynamic value) {
//                                             setState(() {
//                                               controller.selectedValue[index] =
//                                                   value;
//                                               controller
//                                                   .totalApproxAmountControllerList
//                                                   .add(TextEditingController(
//                                                       text: controller
//                                                           .getOnclickList[index]
//                                                           .iNVTPIApproxAmount
//                                                           .toString()));
//                                               amount -= num.parse(controller
//                                                   .totalApproxAmountControllerList
//                                                   .elementAt(index)
//                                                   .text);
//                                             });
//                                           },
//                                         )),
//                                         DataCell(Align(
//                                           alignment: Alignment.center,
//                                           child: Text(controller.getOnclickList
//                                               .elementAt(index)
//                                               .iNVMIItemName
//                                               .toString()),
//                                         )),
//                                         DataCell(Align(
//                                           alignment: Alignment.center,
//                                           child: Text(controller.getOnclickList
//                                               .elementAt(index)
//                                               .iNVMUOMUOMName
//                                               .toString()),
//                                         )),
//                                         DataCell(Align(
//                                           alignment: Alignment.center,
//                                           child: Text(controller.getOnclickList
//                                               .elementAt(index)
//                                               .iNVTPIPIQty
//                                               .toString()),
//                                         )),
//                                         DataCell(Align(
//                                           alignment: Alignment.center,
//                                           child: Text(controller.getOnclickList
//                                               .elementAt(index)
//                                               .iNVTPIPIQty
//                                               .toString()),
//                                         )),
//                                         DataCell(Align(
//                                           alignment: Alignment.center,
//                                           child: Text(controller.getOnclickList
//                                               .elementAt(index)
//                                               .iNVTPIAPPApprovedQty
//                                               .toString()),
//                                         )),
//                                         DataCell(TextField(
//                                           controller: controller
//                                               .unitControllerList
//                                               .elementAt(index),
//                                           keyboardType: TextInputType.number,
//                                         )),
//                                         DataCell(Align(
//                                           alignment: Alignment.center,
//                                           child: Text(controller.getOnclickList
//                                               .elementAt(index)
//                                               .iNVTPIApproxAmount
//                                               .toString()),
//                                         )),
//                                         DataCell(Align(
//                                           alignment: Alignment.center,
//                                           child: TextField(
//                                               controller: controller
//                                                   .remarkControllerList
//                                                   .elementAt(index)),
//                                         )),
//                                         DataCell(IconButton(
//                                           onPressed: () {
//                                             Get.to(() => ViewComment(
//                                                   purchaseController:
//                                                       controller,
//                                                   invmpiId: controller
//                                                       .purchaseIndentList
//                                                       .elementAt(index)
//                                                       .iNVMPIId!,
//                                                 ));
//                                           },
//                                           icon: const Icon(Icons.visibility),
//                                         )),
//                                       ],
//                                     );
//                                   }),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20.0,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Total Approximate Amount:",
//                                 style: Get.textTheme.titleSmall,
//                               ),
//                               Text(
//                                 amount.toString(),
//                                 style: Get.textTheme.titleSmall,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 25),
//                           CustomContainer(
//                               child: TextFormField(
//                             style: Get.textTheme.titleSmall,
//                             maxLines: 4,
//                             textInputAction: TextInputAction.next,
//                             keyboardType: TextInputType.multiline,
//                             controller: remarkController,
//                             decoration: InputDecoration(
//                               floatingLabelBehavior:
//                                   FloatingLabelBehavior.always,
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 20, horizontal: 12),
//                               border: const OutlineInputBorder(),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                 ),
//                               ),
//                               enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                 ),
//                               ),
//                               hintText: "Enter Remark",
//                               label: Container(
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFDFFBFE),
//                                   borderRadius: BorderRadius.circular(24.0),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8.0, vertical: 8.0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     SvgPicture.asset(
//                                       'assets/svg/noteicon.svg',
//                                       color:
//                                           const Color.fromRGBO(40, 182, 200, 1),
//                                       height: 24,
//                                     ),
//                                     const SizedBox(
//                                       width: 6.0,
//                                     ),
//                                     Text(
//                                       "Remark",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .labelMedium!
//                                           .merge(
//                                             const TextStyle(
//                                               fontSize: 20.0,
//                                               color: Color.fromRGBO(
//                                                   40, 182, 200, 1),
//                                             ),
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )),
//                           const SizedBox(
//                             height: 16.0,
//                           ),
//                         ],
//                       ),
//                     )),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 80.0),
//                       child: MSkollBtn(
//                         size: const Size.fromWidth(100),
//                         title: "Save",
//                         onPress: () {
//                           saveData();
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//         ));
//   }
// }
