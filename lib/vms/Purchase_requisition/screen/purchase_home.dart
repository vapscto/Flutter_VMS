import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/onchange_item_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/purchase_dropdownlist_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/purchase_getitem_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/api/purchase_save_api.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_Model.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/model/purchase_getitem.dart';
import 'package:m_skool_flutter/vms/api/vms_transation_api.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
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
  _PurchaserequisitionHomeState createState() =>
      _PurchaserequisitionHomeState();
}

class _PurchaserequisitionHomeState extends State<PurchaserequisitionHome> {
  PurchaseRequisitionModelValues? selectedcompanyname;
  PurchaseGetItemModelValues? itemList;
  DrDetailsCtrlr drDetailsCtrlr = Get.put(DrDetailsCtrlr());
  PurchaseRequisitionController purchaseRequisitionController =
      Get.put(PurchaseRequisitionController());
  RxList<int> newWidget = <int>[].obs;
  RxList<TextEditingController> uomController = <TextEditingController>[].obs;
  RxList<TextEditingController> quantityController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> rateController = <TextEditingController>[].obs;
  RxList<TextEditingController> amountController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> remarksController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> selectEt = <TextEditingController>[].obs;
  final totalAmount = TextEditingController();
  int newAmount = 0;
  List<PurchaseItemAdd> newPurchaseItems = <PurchaseItemAdd>[].obs;
  final commonRemarksController = TextEditingController();
  List<Map<String, dynamic>> list = [];
  VmsTransationController vmsTransationController =
      Get.put(VmsTransationController());
  List<Map<String, dynamic>> arrayPR = [];
  Map<String, dynamic> transnumbconfigurationsettingsss = {};

  // String? selectedItemName;

  String? selectedItemInvmIId;
  _getTransation() async {
    String password = logInBox!.get("password");
    await VmsTransationAPI.instance.getTransation(
        base: baseUrlFromInsCode("login", widget.mskoolController),
        vmsTransationController: vmsTransationController,
        userName: widget.loginSuccessModel.userName!,
        password: password,
        miId: widget.loginSuccessModel.mIID!,
        roleId: widget.loginSuccessModel.roleId!);
    for (int index = 0;
        index < vmsTransationController.transationConfigmodel.length;
        index++) {
      transnumbconfigurationsettingsss.addAll({
        // "IMN_Id": 138,
        // "MI_Id": 17,
        // "IMN_AutoManualFlag": "Auto",
        // "IMN_StartingNo": "1",
        // "IMN_WidthNumeric": "4",
        // "IMN_ZeroPrefixFlag": "No",
        // "IMN_PrefixParticular": "PR",
        // "IMN_SuffixAcadYearCode": true,
        // "IMN_SuffixParticular": "",
        // "IMN_RestartNumFlag": "Never",
        // "IMN_Flag": "INVPR",
        // "ASMAY_Id": 0,
        // "CreatedDate": "2017-05-24T09:35:34.587",
        // "UpdatedDate": "2017-05-24T09:35:34.587"
        "IMN_Id": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNId,
        "MI_Id":
            vmsTransationController.transationConfigmodel.elementAt(index).mIId,
        "IMN_AutoManualFlag": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNAutoManualFlag,
        "IMN_StartingNo": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNStartingNo,
        "IMN_WidthNumeric": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNWidthNumeric,
        "IMN_ZeroPrefixFlag": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNZeroPrefixFlag,
        "IMN_PrefixParticular": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNPrefixParticular,
        "IMN_SuffixAcadYearCode": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNSuffixAcadYearCode,
        "IMN_SuffixParticular": "",
        "IMN_RestartNumFlag": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNRestartNumFlag,
        "IMN_Flag": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .imNFlag,
        "ASMAY_Id": 0,
        "CreatedDate": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .createdDate,
        "UpdatedDate": vmsTransationController.transationConfigmodel
            .elementAt(index)
            .updatedDate
      });
    }
  }

  @override
  void initState() {
    _getTransation();
    load(widget.loginSuccessModel.mIID!);
    addControllerData(1);
    super.initState();
  }

  load(int id) async {
    // purchaseRequisitionController.getrequestGetItemList.clear();
    purchaseRequisitionController.updateIsLoadingRequestGetItem(true);
    await getPurchaseRequisitionApi(
      base: baseUrlFromInsCode("inventory", widget.mskoolController),
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
      selectEt.add(TextEditingController(text: "Select item"));
      uomController.add(TextEditingController(text: ''));
      quantityController.add(TextEditingController(text: ''));
      rateController.add(TextEditingController(text: ''));
      amountController.add(TextEditingController(text: ''));
      remarksController.add(TextEditingController(text: ''));
      amountController[i].addListener(() {
        addAmount();
      });
    }
  }

  void addAmount() {
    int sum = 0;
    for (TextEditingController controller in amountController) {
      int value = int.tryParse(controller.text) ?? 0;
      sum += value;
    }
    setState(() {
      totalAmount.text = '$sum';
    });
  }

  removeControllerData(int value) {
    // Check if the index is valid
    if (value >= 0 && value < newWidget.length) {
      // Remove data from the lists
      selectEt.removeAt(value);
      uomController.removeAt(value);
      quantityController.removeAt(value);
      rateController.removeAt(value);
      amountController.removeAt(value);
      remarksController.removeAt(value);

      // Remove the item from newWidget
      newWidget.removeAt(value);

      // Update total amount
      updateTotalAmount();

      // Call setState to trigger a rebuild
      setState(() {});
    }
  }

  updateTotalAmount() {
    int total = 0;
    for (int i = 0; i < amountController.length; i++) {
      total += int.tryParse(amountController[i].text) ?? 0;
    }
    totalAmount.text = total.toString();
  }

  // removeControllerData(int value) {
  //   newWidget.removeAt(value);
  //   setState(() {});
  // }

  int sum = 0;
  removeAmount(int amount) {
    sum -= amount;
    totalAmount.text = sum.toString();
    setState(() {});
  }

  _saveData() async {
    purchaseRequisitionController.saveLoading(true);
    drDetailsCtrlr.updateTabLoading(true);
    int miIdNew = 0;
    int hrmdId = 0;
    int invmId = 0;
    int invmmouId = 0;
    int invmprId = 0;
    int invtprId = 0;
    double quantity = 0.0;
    double approxAmount = 0.0;
    double approvedQuantity = 0.0;
    double unitRate = 0.0;
    for (int i = 0; i < newWidget.length; i++) {
      arrayPR.add({
        "INVTPR_Id": 0,
        "INVMPR_Id": 0,
        "INVMI_Id": newPurchaseItems[i].invmIId,
        "INVMUOM_Id": newPurchaseItems[i].invmuomId,
        "INVTPR_PRQty": double.tryParse(quantityController[i].text),
        "INVTPR_ApproxAmount": double.tryParse(amountController[i].text),
        "INVTPR_ApprovedQty": 0.0,
        "INVTPR_PRUnitRate": double.tryParse(rateController[i].text),
        "INVTPR_Remarks": remarksController[i].text,
        "INVTPR_ActiveFlg": newPurchaseItems[i].activeFlag
      });
    }

    await PurchaseSaveAPI.instance.purchaseSave(
        base: baseUrlFromInsCode("inventory", widget.mskoolController),
        purchaseRequisitionController: purchaseRequisitionController,
        controller: drDetailsCtrlr,
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "MI_IdNew": widget.loginSuccessModel.mIID,
          "HRMD_Id": hrmdId,
          "ASMAY_Id": widget.loginSuccessModel.asmaYId,
          "UserId": widget.loginSuccessModel.userId,
          "INVMI_Id": invmId,
          "INVMUOM_Id": invmmouId,
          "INVMPR_Id": invmprId,
          "INVMPR_PRDate": DateTime.now().toString(),
          "INVMPR_Remarks": commonRemarksController.text,
          "INVMPR_ApproxTotAmount": double.tryParse(totalAmount.text),
          "INVTPR_Id": invtprId,
          "INVTPR_PRQty": quantity,
          "INVTPR_ApproxAmount": approxAmount,
          "INVTPR_ApprovedQty": approvedQuantity,
          "INVTPR_PRUnitRate": unitRate,
          "INVTPR_Remarks": null,
          "transnumbconfigurationsettingsss": transnumbconfigurationsettingsss,
          "arrayPR": arrayPR,
        }).then(
      (value) {
        if (value) {
          purchaseRequisitionController.saveLoading(false);
        }
      },
    );
  }

  DateTime? selectedDate;
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Purchase Requisition"),
          leading: const CustomGoBackButton(),
          titleSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: BtnSave(
                onPress: () async {
                  await _saveData();
                },
                title: "Save",
              ),
            ),
          ],
        ),
        floatingActionButton: const HomeFab(),
        body: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: (purchaseRequisitionController
                    .isLoadingRequestPurchase.value)
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Getting Purchase Requistion",
                        desc: "We are loading Requistion... Please wait ",
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
                              //  value: selectedcompanyname,
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
                                    base: baseUrlFromInsCode(
                                        "inventory", widget.mskoolController),
                                    miIdnew: s!.mIId!,
                                    controller: purchaseRequisitionController);
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
                                dataRowHeight: 75,
                                headingRowHeight: 40,
                                horizontalMargin: 10,
                                columnSpacing: 20,
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
                                    child: Text('select item'),
                                  )),
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
                                      DataCell(Obx(
                                        () => SizedBox(
                                            width: 200,
                                            child: TextFormField(
                                              readOnly: true,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              controller: selectEt[index],
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: SizedBox(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child:
                                                              ListView.builder(
                                                            itemBuilder:
                                                                (context, i) {
                                                              return ListTile(
                                                                title: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      purchaseRequisitionController
                                                                              .selecInt
                                                                              .value =
                                                                          purchaseRequisitionController
                                                                              .getrequestGetItemList[i]
                                                                              .invmIId!;
                                                                      logger.w(
                                                                          "Prathap ${purchaseRequisitionController.selecString.value}"); 
                                                                      String
                                                                          selectedItemName =
                                                                          purchaseRequisitionController
                                                                              .getrequestGetItemList[i]
                                                                              .invmIItemName!;
                                                                      int selectedItemIndex =
                                                                          index;
                                                                      int selectedItemInvmIId = purchaseRequisitionController
                                                                          .getrequestGetItemList[
                                                                              i]
                                                                          .invmIId!;
                                                                      int selectedItemInvmuomId = purchaseRequisitionController
                                                                          .getrequestGetItemList[
                                                                              i]
                                                                          .invmuoMId!;
                                                                      bool selectedItemActiveFlag = purchaseRequisitionController
                                                                          .getrequestGetItemList[
                                                                              i]
                                                                          .invmpRActiveFlg!;

                                                                      selectEt[selectedItemIndex]
                                                                              .text =
                                                                          selectedItemName;

                                                                      int existingIndex = newPurchaseItems.indexWhere((item) =>
                                                                          item.id ==
                                                                          selectedItemIndex);

                                                                      if (existingIndex !=
                                                                          -1) {
                                                                        newPurchaseItems[existingIndex].invmIId =
                                                                            selectedItemInvmIId;
                                                                        newPurchaseItems[existingIndex].invmuomId =
                                                                            selectedItemInvmuomId;
                                                                        newPurchaseItems[existingIndex].activeFlag =
                                                                            selectedItemActiveFlag;
                                                                      } else {
                                                                        newPurchaseItems
                                                                            .add(PurchaseItemAdd(
                                                                          id: selectedItemIndex,
                                                                          invmIId:
                                                                              selectedItemInvmIId,
                                                                          invmuomId:
                                                                              selectedItemInvmuomId,
                                                                          activeFlag:
                                                                              selectedItemActiveFlag,
                                                                        ));
                                                                      }

                                                                      setState(
                                                                          () {});
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();

                                                                      // Pass the selected value to the API call
                                                                      getIndentItemDetails(
                                                                        miId: widget
                                                                            .loginSuccessModel
                                                                            .mIID!,
                                                                        base: baseUrlFromInsCode(
                                                                            "inventory",
                                                                            widget.mskoolController),
                                                                        userId: widget
                                                                            .loginSuccessModel
                                                                            .userId!,
                                                                        itemId: purchaseRequisitionController
                                                                            .selecInt
                                                                            .value, // Pass the selected value as itemId
                                                                        controller:
                                                                            purchaseRequisitionController,
                                                                      ).then(
                                                                        (value) {
                                                                          setState(
                                                                              () {
                                                                            uomController.elementAt(index).text =
                                                                                value;
                                                                          });
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      purchaseRequisitionController
                                                                          .getrequestGetItemList[
                                                                              i]
                                                                          .invmIItemName!,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .merge(
                                                                            const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            itemCount:
                                                                purchaseRequisitionController
                                                                    .getrequestGetItemList
                                                                    .length,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    ;
                                                  },
                                                );
                                              },
                                            )),
                                      )),
                                      DataCell(
                                        Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Obx(() => Text(uomController
                                                .elementAt(index)
                                                .text))),
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
                                            readOnly: true,
                                            controller: amountController
                                                .elementAt(index),
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
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
                                          if (index == 0) {
                                            addControllerData(index + 1);
                                            addAmount();
                                          } else {
                                            removeControllerData(index);
                                          }
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
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: commonRemarksController,
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
                              // readOnly: true,
                              style: Theme.of(context).textTheme.titleSmall,
                              keyboardType: TextInputType.number,
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
                        ],
                      ),
          );
        }));
  }

  @override
  void dispose() {
    purchaseRequisitionController.getrequestRequisitionList.clear();
    purchaseRequisitionController.getrequestGetItemList.clear();
    super.dispose();
  }
}
