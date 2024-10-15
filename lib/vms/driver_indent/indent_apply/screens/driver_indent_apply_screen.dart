import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/api/driver_ind_apply_api.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/driver_ind_apply_controller.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/model/vehicle_list_model.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/screens/fuel_request_details.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class DriverIndentApplyHomeScreen extends StatefulWidget {
  final String title;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const DriverIndentApplyHomeScreen(
      {super.key,
      required this.title,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<DriverIndentApplyHomeScreen> createState() =>
      _DriverIndentApplyHomeScreenState();
}

class _DriverIndentApplyHomeScreenState
    extends State<DriverIndentApplyHomeScreen> {
  DriverIndentApplyController controller =
      Get.put(DriverIndentApplyController());
  _getOnLoadData() async {
    controller.isInitialLoading.value = true;
    await DriverIndentApplyAPI.i.driverIndentOnLoad(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        controller: controller);
    controller.selectedVehicle = controller.vehicleList.first;
    controller.isInitialLoading.value = false;
    _getData(controller.selectedVehicle!.trmVId!);
  }

  _getData(int id) async {
    controller.isAmountLoading.value = true;
    await DriverIndentApplyAPI.i.driverIndentVDetails(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        irmvId: id,
        controller: controller);
    if (controller.vehicleDetailsList.isNotEmpty) {
      openIngKm.text = controller.vehicleDetailsList.first.ismdiTClosingKM!
          .toStringAsFixed(2);
    } else {
      openIngKm.text = "";
    }
    controller.isAmountLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    _getOnLoadData();
  }

  final billNoController = TextEditingController();
  final fuelLtrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Obx(() {
        return (controller.isInitialLoading.value)
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading",
                desc: "We are under process to get your details from server.")
            : (controller.vehicleList.isEmpty)
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "",
                    animatorHeight: 250,
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          DropdownButtonFormField<VehicleListModelValues>(
                            value: controller.selectedVehicle,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.all(16.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              hintText: 'Select Vehicle',
                              hintStyle: Get.textTheme.titleSmall!
                                  .copyWith(color: Colors.grey),
                              labelStyle: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                              labelText: "Vehicle No",
                            ),
                            icon: const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              ),
                            ),
                            iconSize: 30,
                            items: List.generate(
                              controller.vehicleList.length,
                              (index) =>
                                  DropdownMenuItem<VehicleListModelValues>(
                                value: controller.vehicleList.elementAt(index),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, left: 8, right: 8),
                                  child: Text(
                                    controller.vehicleList
                                            .elementAt(index)
                                            .trmVVehicleNo ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            letterSpacing: 0.3)),
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (s) async {
                              setState(() {
                                controller.selectedVehicle = s!;
                                _getData(s.trmVId!);
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall,
                                  controller: billNoController,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: 'Bill No',
                                    hintStyle: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.grey),
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                    labelText: "Bill No",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall,
                                  controller: fuelLtrController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: 'Fuel Quantity (Ltr)',
                                    hintStyle: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.grey),
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                    labelText: "Fuel Quantity (Ltr)",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall,
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: 'Amount',
                                    hintStyle: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.grey),
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                    labelText: "Amount",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall,
                                  controller: openIngKm,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: 'Opening km',
                                    hintStyle: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.grey),
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                    labelText: "Opening km",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall,
                                  controller: closingKm,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: 'Closing km',
                                    hintStyle: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.grey),
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                    labelText: "Closing km",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall,
                                  controller: balanceDiesel,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.all(16.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: 'Balance diesel',
                                    hintStyle: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.grey),
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                    labelText: "Balance diesel",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            style: Get.textTheme.titleSmall,
                            controller: remarkController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.all(16.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Remark',
                              hintStyle: Get.textTheme.titleSmall!
                                  .copyWith(color: Colors.grey),
                              labelStyle: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                              labelText: "Remark",
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: (isLoading.value)
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MSkollBtn(
                                    title: "Request",
                                    onPress: () async {
                                      if (billNoController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Enter Bill Number");
                                        return;
                                      } else if (fuelLtrController
                                          .text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Enter Fuel Quantity");
                                        return;
                                      } else if (amountController
                                          .text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Enter Amount");
                                        return;
                                      } else if (closingKm.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Enter Closeing KM");
                                        return;
                                      } else if (balanceDiesel.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Enter Balance Diesel");
                                        return;
                                      } else {
                                        isLoading.value = true;
                                        await DriverIndentApplyAPI.i
                                            .saveDriverIndent(
                                                base: baseUrlFromInsCode(
                                                    "issuemanager",
                                                    widget.mskoolController),
                                                body: {
                                              "UserId": widget
                                                  .loginSuccessModel.userId,
                                              "IVRMRT_Id": widget
                                                  .loginSuccessModel.roleId,
                                              "MI_Id":
                                                  widget.loginSuccessModel.mIID,
                                              "ISMDIT_Id": controller
                                                  .vehicleDetailsList
                                                  .first
                                                  .ismdiTId,
                                              "ISMDIT_Date": DateTime.now()
                                                  .toIso8601String(),
                                              "TRMV_Id": controller
                                                  .selectedVehicle!.trmVId,
                                              "ISMDIT_BillNo":
                                                  billNoController.text,
                                              "ISMDIT_Qty": double.parse(
                                                  fuelLtrController.text),
                                              "ISMDIT_Amount": double.parse(
                                                  amountController.text),
                                              "ISMDIT_Remarks":
                                                  remarkController.text,
                                              "ISMDIT_OpeningKM":
                                                  double.parse(openIngKm.text),
                                              "ISMDIT_ClosingKM":
                                                  double.parse(closingKm.text),
                                              "ISMDIT_BalanceDiesel":
                                                  double.parse(
                                                      balanceDiesel.text),
                                            });
                                        isLoading.value = false;
                                      }
                                    }),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: controller.isAmountLoading.value,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const CircularProgressIndicator(
                              backgroundColor: Colors.green,
                              color: Colors.red,
                              strokeWidth: 6,
                            ),
                          )),
                    ],
                  );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (context) {
          bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
          return Visibility(
            visible: !isKeyboardVisible,
            child: MSkollBtn(
              onPress: () {
                FocusScope.of(context).unfocus();
                Get.to(() => const FuelRequestDetails());
              },
              title: "Fuel Request Details",
            ),
          );
        },
      ),
    );
  }

  RxBool isLoading = RxBool(false);
  @override
  void dispose() {
    controller.selectedVehicle = null;
    remarkController.clear();
    balanceDiesel.clear();
    closingKm.clear();
    openIngKm.clear();
    amountController.clear();
    billNoController.clear();
    fuelLtrController.clear();
    super.dispose();
  }

  final remarkController = TextEditingController();
  final balanceDiesel = TextEditingController();
  final closingKm = TextEditingController();
  final openIngKm = TextEditingController();
  final amountController = TextEditingController();
}
