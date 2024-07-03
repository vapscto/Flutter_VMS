import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/api/purchase_api.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/controller/purchase_controller.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/screen/purchase_indent_details.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class PurchaseIndentHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PurchaseIndentHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});
  @override
  // ignore: library_private_types_in_public_api
  _PurchaseIndentHomeState createState() => _PurchaseIndentHomeState();
}

class _PurchaseIndentHomeState extends State<PurchaseIndentHome> {
  PurchaseController controller = Get.put(PurchaseController());

  @override
  void initState() {
    _onLoad();
    super.initState();
  }

  RxBool isLoading = RxBool(false);
  _onLoad() async {
    setState(() {
      isLoading.value = true;
    });
    await PurchaseIndentApi.instance.getPurchaseIndentApiApi(
        base: baseUrlFromInsCode('inventory', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        controller: controller);
    setState(() {
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: "PURCHASE INDENT FOR APPROVAL").getAppBar(),
      floatingActionButton: const HomeFab(),
      body: Obx(
        () => (isLoading.value)
            ? const Center(
                child: AnimatedProgressWidget(
                  animationPath: "assets/json/default.json",
                  title: "Loading",
                  desc:
                      "Please wait while we load detail table and create a view for you.",
                ),
              )
            : controller.purchaseIndentList.isEmpty
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: "assets/json/nodata.json",
                      animatorHeight: 250,
                      title: "Data is not Available",
                      desc: "purchase indent approval Data is not Available",
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
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
                                        'Company Name',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'PI Number',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Date',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Reference No',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Requested by',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Department Name',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Approx Amount',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Click to View',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                    controller.purchaseIndentList.length,
                                    (index) {
                                  var i = index + 1;
                                  return DataRow(
                                    cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(controller
                                                .purchaseIndentList
                                                .elementAt(index)
                                                .mIName ??
                                            ''),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(controller
                                                .purchaseIndentList
                                                .elementAt(index)
                                                .iNVMPIPINo ??
                                            ''),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(controller
                                                .purchaseIndentList
                                                .elementAt(index)
                                                .iNVMPIPIDate ??
                                            ''),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(controller
                                                .purchaseIndentList
                                                .elementAt(index)
                                                .iNVMPIReferenceNo ??
                                            ''),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(controller
                                                .purchaseIndentList
                                                .elementAt(index)
                                                .indentCreadBy ??
                                            ''),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(controller
                                                .purchaseIndentList
                                                .elementAt(index)
                                                .createdDeptName ??
                                            ''),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(controller
                                            .purchaseIndentList
                                            .elementAt(index)
                                            .iNVMPIApproxTotAmount
                                            .toString()),
                                      )),
                                      DataCell(IconButton(
                                        onPressed: () {
                                          Get.to(() => PurchaseDetails(
                                                invmpiId: controller
                                                    .purchaseIndentList
                                                    .elementAt(index)
                                                    .iNVMPIId!,
                                                loginSuccessModel:
                                                    widget.loginSuccessModel,
                                                mskoolController:
                                                    widget.mskoolController,
                                                values: controller
                                                    .purchaseIndentList
                                                    .elementAt(index),
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
                          height: 128.0,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
