import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/purchase_dropdownlist_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/purchase_getitem_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_Model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_getitem.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_items_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

import '../../../widget/mskoll_btn.dart';

class PurchaserequisitionHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PurchaserequisitionHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});
  @override
  // ignore: library_private_types_in_public_api
  _PurchaserequisitionHomeState createState() =>
      _PurchaserequisitionHomeState();
}

class _PurchaserequisitionHomeState extends State<PurchaserequisitionHome> {
  PurchaseRequisitionModelValues? selectedcompanyname;
  PurchaseGetItemModelValues? itemList;

  PurchaseRequisitionController purchaseRequisitionController =
      Get.put(PurchaseRequisitionController());
  RxList<int> newWidget = <int>[].obs;
  final uomController = TextEditingController();
  RxList<TextEditingController> quantityController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> rateController = <TextEditingController>[].obs;
  RxList<TextEditingController> amountController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> remarksController =
      <TextEditingController>[].obs;
  RxList<int> totalAmountList = <int>[].obs;
  final totalAmount = TextEditingController();
  int newAmount = 0;

  @override
  void initState() {
    load(widget.loginSuccessModel.mIID!);
    addControllerData(1);
    super.initState();
  }

  load(int id) async {
    // purchaseRequisitionController.getrequestGetItemList.clear();
    purchaseRequisitionController.updateIsLoadingRequestGetItem(true);
    await getPurchaseRequisitionApi(
      base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
      miIdnew: id,
      controller: purchaseRequisitionController,
    );
    if (purchaseRequisitionController.getrequestRequisitionList.isNotEmpty) {
      selectedcompanyname =
          purchaseRequisitionController.getrequestRequisitionList.first;
      // itemList = purchaseRequisitionController.getrequestGetItemList.first;
      logger.i(itemList);
    }
    purchaseRequisitionController.updateIsLoadingRequestGetItem(false);
  }

  addControllerData(int value) {
    newWidget.add(value);
    for (int i = 0; i < newWidget.length; i++) {
      quantityController.add(TextEditingController(text: ''));
      rateController.add(TextEditingController(text: ''));
      amountController.add(TextEditingController(text: ''));
      remarksController.add(TextEditingController(text: ''));
    }
  }

  removeControllerData(int value) {
    newWidget.removeAt(value);
    setState(() {});
  }

  DateTime? selectedDate;
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Purchase Requisition").getAppBar(),
        floatingActionButton: const HomeFab(),
        body: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: (purchaseRequisitionController
                    .isLoadingRequestPurchase.value)
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Getting Purchase Requistion",
                        desc: "We are loading Planner status... Please wait ",
                        animationPath: "assets/json/default.json"),
                  )
                : (purchaseRequisitionController
                        .getrequestRequisitionList.isEmpty)
                    ? const Center(
                        child: AnimatedProgressWidget(
                            title: "Purchase Requistion not Found",
                            desc: " ",
                            animationPath: "assets/json/nodata.json"))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            child: TextField(
                              controller: _dateController,
                              style: Theme.of(context).textTheme.titleSmall,
                              onTap: () async {
                                selectedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1000),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(3050));
                                if (selectedDate != null) {
                                  _dateController.text =
                                      '${numberList[selectedDate!.day]}-${months[selectedDate!.month - 1]}-${selectedDate!.year}';
                                }
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(229, 243, 255, 1),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/calendar_icon.svg",
                                        color: const Color.fromARGB(
                                            255, 31, 2, 54),
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
                                                color: Color.fromRGBO(
                                                    231, 42, 8, 1),
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
                                    color:
                                        const Color.fromARGB(255, 210, 246, 6),
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

                          Container(
                            margin: const EdgeInsets.only(
                                top: 30, left: 0, right: 0),
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
                            child: DropdownButtonFormField<
                                PurchaseRequisitionModelValues>(
                              value: selectedcompanyname,
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
                                hintText: purchaseRequisitionController
                                        .getrequestRequisitionList.isNotEmpty
                                    ? 'select company name'
                                    : "No data available",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/hat.png',
                                  containerColor:
                                      Color.fromRGBO(237, 167, 167, 1),
                                  text: 'Company Name',
                                  textColor: Color.fromRGBO(21, 3, 0, 1),
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
                                  purchaseRequisitionController
                                      .getrequestRequisitionList
                                      .length, (index) {
                                return DropdownMenuItem(
                                  value: purchaseRequisitionController
                                      .getrequestRequisitionList[index],
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13, left: 5, bottom: 4),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      child: Text(
                                        purchaseRequisitionController
                                            .getrequestRequisitionList
                                            .elementAt(index)
                                            .mIName!,
                                        maxLines: 2,
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
                              onChanged: (s) async {
                                purchaseRequisitionController
                                    .getrequestGetItemList
                                    .clear();
                                selectedcompanyname = s;
                                getPurchaseRequisitionGetitemApi(
                                    base: baseUrlFromInsCode("issuemanager",
                                        widget.mskoolController),
                                    miIdnew: s!.mIId!,
                                    controller: purchaseRequisitionController);
                              },
                            ),
                          ),
                          (purchaseRequisitionController
                                  .getrequestGetItemList.isEmpty)
                              ? const SizedBox()
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 0, right: 0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 8,
                                        color: Colors.black12,
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonFormField<
                                      PurchaseGetItemModelValues>(
                                    value: purchaseRequisitionController
                                        .getrequestGetItemList.first,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      isDense: true,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14.0,
                                              letterSpacing: 0.3)),
                                      hintText: purchaseRequisitionController
                                              .getrequestGetItemList.isNotEmpty
                                          ? 'Select Item'
                                          : "No data available",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      label: const CustomDropDownLabel(
                                        icon: 'assets/images/hat.png',
                                        containerColor:
                                            Color.fromRGBO(10, 4, 182, 1),
                                        text: 'Item',
                                        textColor:
                                            Color.fromRGBO(223, 234, 3, 1),
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
                                        purchaseRequisitionController
                                            .getrequestGetItemList
                                            .length, (index) {
                                      return DropdownMenuItem(
                                        value: purchaseRequisitionController
                                            .getrequestGetItemList[index],
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5, bottom: 5),
                                            child: SizedBox(
                                              child: Text(
                                                purchaseRequisitionController
                                                    .getrequestGetItemList
                                                    .elementAt(index)
                                                    .invmIItemName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    onChanged: (s) {
                                      setState(() {
                                        itemList = s!;
                                      });
                                    },
                                  ),
                                ),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(top: 16),
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
                                        'UOM',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Approximate Rate',
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
                                        'Action',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List.generate(newWidget.length, (index) {
                                  var i = index + 1;
                                  return DataRow(
                                    cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                            controller: uomController,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here.',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                            controller: quantityController
                                                .elementAt(index),
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here.',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                            controller:
                                                rateController.elementAt(index),
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              int rate = int.parse(
                                                  rateController
                                                      .elementAt(index)
                                                      .text);
                                              setState(() {
                                                // totalAmount.clear();
                                                int amount = rate *
                                                    int.parse(quantityController
                                                        .elementAt(index)
                                                        .text);

                                                amountController
                                                    .elementAt(index)
                                                    .text = amount.toString();
                                              });
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here.',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                            controller: amountController
                                                .elementAt(index),
                                            onChanged: (value) {
                                              newAmount += int.parse(
                                                  amountController
                                                      .elementAt(index)
                                                      .text);
                                              logger.i(newAmount);
                                              setState(() {
                                                totalAmount.text =
                                                    newAmount.toString();
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here.',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                            controller: remarksController
                                                .elementAt(index),
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here.',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(IconButton(
                                        onPressed: () {
                                          setState(() {
                                            (index == 0)
                                                ? addControllerData(index + 1)
                                                : removeControllerData(index);
                                            (index == 0)
                                                ? newAmount += int.parse(
                                                    amountController
                                                        .elementAt(index)
                                                        .text)
                                                : newAmount -= int.parse(
                                                    amountController
                                                        .elementAt(index)
                                                        .text);
                                          });
                                          totalAmount.text =
                                              newAmount.toString();
                                        },
                                        icon: (index == 0)
                                            ? Icon(
                                                Icons.add,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 25,
                                              )
                                            : Icon(
                                                Icons.remove,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 25,
                                              ),
                                      )),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                          //    }
                          //  ),
                          // const SizedBox(height: 16),
                          // CustomContainer(
                          //   child: Column(
                          //     children: List.generate(
                          //        newWidget. length, (index) {
                          //       return Column(
                          //         children: [
                          //          Padding(
                          //            padding: const EdgeInsets.only( right: 10.0,top: 10),
                          //            child: Align(
                          //               alignment: Alignment.topRight,
                          //               child: InkWell(onTap: (){setState(() {
                          //                (index ==0)?  newWidget.add(const PurchaseItemModel()): newWidget.removeAt(index);
                          //               });}, child:Container(
                          //                 decoration: BoxDecoration(shape: BoxShape.circle,color: Theme.of(context).primaryColor,
                          //                 boxShadow: const [
                          //                   BoxShadow(
                          //                     offset: Offset(1, 2),
                          //                     blurRadius: 4,
                          //                     spreadRadius: 0,
                          //                     color: Colors.black12
                          //                   )
                          //                 ],),
                          //                 padding: const EdgeInsets.all(4),
                          //                 child:  (index ==0)?  const Icon(Icons.add,color: Colors.white,size: 30,):const Icon(Icons.remove,color: Colors.white,size: 30,),
                          //               )),
                          //             ),
                          //          ),

                          //           Padding(padding: const EdgeInsets.only(bottom: 10),
                          //           child: newWidget[index],
                          //           ),
                          //         ],
                          //       );
                          //     })
                          //   ),

                          // ),
                          const SizedBox(height: 16),
                          TextFormField(
                            maxLines: 6,
                            style: const TextStyle(fontWeight: FontWeight.w100),
                            decoration: InputDecoration(
                              hintText: 'Enter Remarks',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w100),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomContainer(
                            child: TextField(
                              style: Theme.of(context).textTheme.titleSmall,
                              controller: totalAmount,
                              decoration: InputDecoration(
                                label: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(1, 2),
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                            color: Colors.black12)
                                      ],
                                      borderRadius: BorderRadius.circular(24.0),
                                      color:
                                          const Color.fromARGB(255, 11, 1, 0)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/subjectfielicon.png",
                                        height: 24.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Total Approximate Amount : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color.fromARGB(
                                                      255, 250, 251, 251)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: 'Total Amount.',
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
                            ),
                          ),
                          const SizedBox(height: 35),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: MSkollBtn(
                                  size: const Size.fromWidth(100),
                                  title: "Save",
                                  onPress: () {
                                    // saveData();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: MSkollBtn(
                                  size: const Size.fromWidth(100),
                                  title: "Exit",
                                  onPress: () {
                                    // saveData();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
          );
        }));
  }

  @override
  void dispose() {
    // TODO: imple
    purchaseRequisitionController.getrequestRequisitionList.clear();
    purchaseRequisitionController.getrequestGetItemList.clear();

    super.dispose();
  }
}
