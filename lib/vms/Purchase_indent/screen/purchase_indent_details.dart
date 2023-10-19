import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/api/onclick_purchase_api.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/api/purchase_save_api.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/model/purchase_indent_model.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/screen/view_comment.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import '../../../widget/home_fab.dart';

class PurchaseDetails extends StatefulWidget {
  final int invmpiId;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PurchaseIndentModelValues values;
  const PurchaseDetails({
    super.key,
    required this.loginSuccessModel,
    required this.invmpiId,
    required this.mskoolController,
    required this.values,
  });
  @override
  _PurchaseDetailsState createState() => _PurchaseDetailsState();
}

class _PurchaseDetailsState extends State<PurchaseDetails> {
  PurchaseController controller = Get.find();

  RxString selectedValue = "".obs;

  String invmpiRemarks = '';
  var invmpiAmount;
  var invmpiId;
  num amount = 0;

  void saveData() {
    for (int i = 0; i < controller.getOnclickList.length; i++) {
      transRowEdit.add({
        "INVMPR_Id": controller.getOnclickList[i].iNVMPRId,
        "INVMI_Id": controller.getOnclickList[i].iNVMIId,
        "INVTPI_Id": controller.getOnclickList[i].iNVTPIId,
        "INVMUOM_Id": controller.getOnclickList[i].iNVMUOMId,
        "INVTPI_PRQty": controller.getOnclickList[i].iNVTPIPRQty,
        "INVTPI_PIQty": controller.getOnclickList[i].iNVTPIPIUnitRate,
        "INVTPI_PIUnitRate": controller.unitControllerList.elementAt(i).text,
        "INVTPI_ApproxAmount":
            controller.getOnclickList.elementAt(i).iNVTPIApproxAmount,
        "flag": controller.selectedValue.elementAt(i),
        "INVTPIAPP_ApprovedQty":
            controller.getOnclickList[i].iNVTPIAPPApprovedQty,
        "INVTPI_Remarks": controller.remarkControllerList.elementAt(i).text,
      });
    }
    controller.isSaveLoaeding(true);
    PurchaseSave.instance.purchaseSave(
        base: baseUrlFromInsCode('inventory', widget.mskoolController),
        invmpiRemarks: remarkController.text,
        invmpiAmount: widget.values.iNVMPIApproxTotAmount!.toInt(),
        arrayList: transRowEdit,
        invmpiId: widget.values.iNVMPIId!,
        miId: widget.loginSuccessModel.mIID!,
        approvecent: 1,
        controller: controller);
    controller.isSaveLoaeding(false);
  }

  var date;
  @override
  void initState() {
    OnclickPurchaseApi.instance.getOnclickPurchaseApiApi(
        base: baseUrlFromInsCode('inventory', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        controller: controller,
        invmpiId: widget.invmpiId);
    DateTime dt = DateTime.parse(widget.values.iNVMPIPIDate!);
    date = '${dt.day}-${dt.month}-${dt.year}';
    super.initState();
  }

  @override
  void dispose() {
    controller.getOnclickList.clear();
    super.dispose();
  }

  List<Map<String, dynamic>> transRowEdit = [];

  final remarkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            const CustomAppBar(title: "PURCHASE INDENT DETAILS").getAppBar(),
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
              : ListView(
                  padding: const EdgeInsets.all(12.0),
                  children: [
                    CustomContainer(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Company Name: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.mIName,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "INDENT NO.:",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.iNVMPIPINo,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "REFERENCE NO.:",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.iNVMPIReferenceNo,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "AMOUNT :",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.iNVMPIApproxTotAmount
                                      .toString(),
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "INDENT DATE: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: (widget.values.iNVMPIPIDate != null)
                                      ? date
                                      : '',
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "REQUESTED BY: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.indentCreadBy,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "REMARKS:  ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.iNVMPIRemarks,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 20),
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
                                      fontWeight: FontWeight.w400),
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
                                    // remarkController.text = controller.getOnclickList.elementAt(index).iNVTPIRemarks.toString();
                                    // unitController.text = controller.getOnclickList.elementAt(index).iNVTPIPIUnitRate.toString();

                                    return DataRow(
                                      cells: [
                                        DataCell(Align(
                                            alignment: Alignment.center,
                                            child: Text('$i'))),
                                        DataCell(Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Theme.of(context)
                                                      .primaryColor),
                                          groupValue:
                                              controller.selectedValue[index],
                                          value: 'Approved',
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              controller.selectedValue[index] =
                                                  value;
                                              controller
                                                  .totalApproxAmountControllerList
                                                  .add(TextEditingController(
                                                      text: controller
                                                          .getOnclickList[index]
                                                          .iNVTPIApproxAmount
                                                          .toString()));
                                              amount += num.parse(controller
                                                  .totalApproxAmountControllerList
                                                  .elementAt(index)
                                                  .text);
                                            });
                                          },
                                        )),
                                        DataCell(Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Theme.of(context)
                                                      .primaryColor),
                                          groupValue:
                                              controller.selectedValue[index],
                                          value: 'Reject',
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              controller.selectedValue[index] =
                                                  value;
                                              controller
                                                  .totalApproxAmountControllerList
                                                  .add(TextEditingController(
                                                      text: controller
                                                          .getOnclickList[index]
                                                          .iNVTPIApproxAmount
                                                          .toString()));
                                              amount -= num.parse(controller
                                                  .totalApproxAmountControllerList
                                                  .elementAt(index)
                                                  .text);
                                            });
                                          },
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getOnclickList
                                              .elementAt(index)
                                              .iNVMIItemName
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getOnclickList
                                              .elementAt(index)
                                              .iNVMUOMUOMName
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.getOnclickList
                                                  .elementAt(index)
                                                  .iNVTPIPIQty
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w100))),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getOnclickList
                                              .elementAt(index)
                                              .iNVTPIPIQty
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            controller.getOnclickList
                                                .elementAt(index)
                                                .iNVTPIAPPApprovedQty
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                        DataCell(TextField(
                                          controller: controller
                                              .unitControllerList
                                              .elementAt(index),
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            controller.getOnclickList
                                                .elementAt(index)
                                                .iNVTPIApproxAmount
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                    fontSize: 14)),
                                          ),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: TextField(
                                            controller: controller
                                                .remarkControllerList
                                                .elementAt(index),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w200),
                                          ),
                                        )),
                                        DataCell(IconButton(
                                          onPressed: () {
                                            Get.to(() => ViewComment(
                                                  purchaseController:
                                                      controller,
                                                  invmpiId: controller
                                                      .purchaseIndentList
                                                      .elementAt(index)
                                                      .iNVMPIId!,
                                                ));
                                          },
                                          icon: const Icon(Icons.visibility),
                                        )),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Approximate Amount:",
                                style: Get.textTheme.titleSmall,
                              ),
                              Text(
                                amount.toString(),
                                style: Get.textTheme.titleSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          CustomContainer(
                              child: TextFormField(
                            style: Get.textTheme.titleSmall,
                            maxLines: 4,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            controller: remarkController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 12),
                              border: const OutlineInputBorder(),
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
                              hintText: "Enter Remark",
                              label: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFFBFE),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/noteicon.svg',
                                      color:
                                          const Color.fromRGBO(40, 182, 200, 1),
                                      height: 24,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      "Remark",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                              fontSize: 20.0,
                                              color: Color.fromRGBO(
                                                  40, 182, 200, 1),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: MSkollBtn(
                        size: const Size.fromWidth(100),
                        title: "Save",
                        onPress: () {
                          saveData();
                        },
                      ),
                    )
                  ],
                ),
        ));
  }
}
