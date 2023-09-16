import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/purchase_dropdownlist_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_Model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_getitem.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class PurchaserequisitionHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PurchaserequisitionHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});
  @override
  // ignore: library_private_types_in_public_api
  _PurchaserequisitionHomeState createState() => _PurchaserequisitionHomeState();
}

class _PurchaserequisitionHomeState extends State<PurchaserequisitionHome> {


PurchaseRequisitionModelValues? selectedcompanyname;

PurchaseRequisitionController purchaseRequisitionController = Get.put(PurchaseRequisitionController());

  @override
  void initState() {
     load();
    super.initState();
  }
load()async{
 await getPurchaseRequisitionApi(base: "", miIdnew: 20,controller: purchaseRequisitionController,);
 if(purchaseRequisitionController.getrequestRequisitionList.isNotEmpty){
  selectedcompanyname = purchaseRequisitionController.getrequestRequisitionList.first;
 }
}
DateTime? selectedDate;
final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: "Purchase Requisition").getAppBar(),
          
      floatingActionButton: const HomeFab(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 16),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
             CustomContainer(
               child: TextField(
                controller: _dateController,
                 style:
                     Theme.of(context).textTheme.titleSmall,
                 onTap: () async {
             selectedDate = await showDatePicker(
              context: context,
              firstDate:DateTime(1000),
              initialDate: DateTime.now(),
                lastDate:DateTime(3050));
             if(selectedDate != null){
                  _dateController.text = '${numberList[selectedDate!.day]}-${months[selectedDate!.month-1]}-${selectedDate!.year}';
             }
                 },
                 decoration: InputDecoration(
                   border: const OutlineInputBorder(),
                   label: Container(
                     decoration: BoxDecoration(
                       color: const Color.fromRGBO(
                           229, 243, 255, 1),
                       borderRadius:
                           BorderRadius.circular(24.0),
                     ),
                     margin:
                         const EdgeInsets.only(bottom: 10),
                     padding: const EdgeInsets.symmetric(
                         horizontal: 12.0, vertical: 6.0),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         SvgPicture.asset(
                           "assets/svg/calendar_icon.svg",
                           color: const Color.fromARGB(255, 31, 2, 54),
                           height: 18.0,
                         ),
                         const SizedBox(
                           width: 6.0,
                         ),
                         Text(
                           "Requisition Date",
                           style: Theme.of(context)
                               .textTheme
                               .labelMedium!
                               .merge(
                                 const TextStyle(
                                   fontSize: 20.0,
                                   color: Color.fromRGBO(231, 42, 8, 1),
                                 ),
                               ),
                         ),
                       ],
                     ),
                   ),
                   hintText: 'Select date.'.tr,
                   suffixIcon: Padding(
                     padding: const EdgeInsets.all(12),
                     child: SvgPicture.asset(
                       "assets/svg/calendar_icon.svg",
                       color: const Color.fromARGB(255, 210, 246, 6),
                     ),
                   ),
                   floatingLabelBehavior:
                       FloatingLabelBehavior.always,
                   enabledBorder: const OutlineInputBorder(
                     borderSide: BorderSide(
                       color: Colors.transparent,
                     ),
                   ),
                   focusedBorder: const OutlineInputBorder(
                     borderSide: BorderSide(
                       color: Colors.transparent,
                     ),
                   ),
                 ),
                 readOnly: true,
               ),
             ),
             const SizedBox(height: 20),
               Obx(
                () =>
                 Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 0, right: 0, bottom: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<PurchaseRequisitionModelValues>(
                              value:selectedcompanyname ,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(0, 0, 0, 0),
                                  ),
                                ),
                                isDense: true,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                                hintText: purchaseRequisitionController.getrequestRequisitionList.isNotEmpty
                                    ? 'select company name'
                                    : "No data available",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/hat.png',
                                  color: Color.fromARGB(255, 31, 2, 54),
                                  containerColor:
                                      Color.fromRGBO(237, 167, 167, 1),
                                  text: 'Company Name',
                                  textColor:  Color.fromRGBO(231, 42, 8, 1),
                                ),
                              ),
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30,
                                ),
                              ),
                              iconSize: 35,
                              
                              items: List.generate(
                                 purchaseRequisitionController.getrequestRequisitionList.length,
                                  (index) {
                                return DropdownMenuItem(
                                  value: purchaseRequisitionController.getrequestRequisitionList[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5,bottom: 4),
                                    child: SizedBox(
                                       width:
                                          MediaQuery.of(context).size.width / 1.4,
                                      child: Text(
                                        purchaseRequisitionController.getrequestRequisitionList
                                            .elementAt(index).mIName!
                                            ,maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              onChanged: (s) {
                                
                              },
                            ),
                          ),

               ),

                 
              // Obx(
              //   () =>
              //    Container(
              //               margin: const EdgeInsets.only(
              //                   top: 20, left: 10, right: 10, bottom: 10),
              //               decoration: BoxDecoration(
              //                 color: Theme.of(context).scaffoldBackgroundColor,
              //                 borderRadius: BorderRadius.circular(16.0),
              //                 boxShadow: const [
              //                   BoxShadow(
              //                     offset: Offset(0, 1),
              //                     blurRadius: 8,
              //                     color: Colors.black12,
              //                   ),
              //                 ],
              //               ),
              //               child: DropdownButtonFormField<PurchaseGetItemModelValues>(
              //                 value: purchaseRequisitionController.getrequestGetItemList.first,
              //                 decoration: InputDecoration(
              //                   focusedBorder: const OutlineInputBorder(
              //                     borderSide: BorderSide(
              //                       color: Colors.transparent,
              //                     ),
              //                   ),
              //                   enabledBorder: const OutlineInputBorder(
              //                     borderSide: BorderSide(
              //                       color: Colors.transparent,
              //                     ),
              //                   ),
              //                   isDense: true,
              //                   hintStyle: Theme.of(context)
              //                       .textTheme
              //                       .labelSmall!
              //                       .merge(const TextStyle(
              //                           fontWeight: FontWeight.w400,
              //                           fontSize: 14.0,
              //                           letterSpacing: 0.3)),
              //                   hintText: purchaseRequisitionController.getrequestGetItemList.isNotEmpty
              //                       ? 'select company name'
              //                       : "No data available",
              //                   floatingLabelBehavior:
              //                       FloatingLabelBehavior.always,
              //                   label: const CustomDropDownLabel(
              //                     icon: 'assets/images/hat.png',
              //                     containerColor:
              //                         Color.fromRGBO(223, 251, 254, 1),
              //                     text: 'Company Name',
              //                     textColor: Color.fromRGBO(40, 182, 200, 1),
              //                   ),
              //                 ),
              //                 icon: const Padding(
              //                   padding: EdgeInsets.only(top: 3),
              //                   child: Icon(
              //                     Icons.keyboard_arrow_down_rounded,
              //                     size: 30,
              //                   ),
              //                 ),
              //                 iconSize: 35,
              //                 items: List.generate(
              //                    purchaseRequisitionController.getrequestGetItemList.length,
              //                     (index) {
              //                   return DropdownMenuItem(
              //                     value: purchaseRequisitionController.getrequestGetItemList[index],
              //                     child: Padding(
              //                       padding:
              //                           const EdgeInsets.only(top: 13, left: 5),
              //                       child: SizedBox(
                                       
                                
              //                         child: Text(
              //                           purchaseRequisitionController.getrequestGetItemList
              //                               .elementAt(index).invmIItemName!
              //                               ,
              //                           style: Theme.of(context)
              //                               .textTheme
              //                               .labelSmall!
              //                               .merge(const TextStyle(
              //                                   fontWeight: FontWeight.w400,
              //                                   fontSize: 14.0,
              //                                   letterSpacing: 0.3)),
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 }),
              //                 onChanged: (s) {
                                
              //                 },
              //               ),
              //             ),

              //  ),
          ],
          
        ),
      )

    );
  }   
  
  
}
