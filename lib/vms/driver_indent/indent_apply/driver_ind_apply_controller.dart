import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/model/vehicle_details.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/model/vehicle_list_model.dart';

class DriverIndentApplyController extends GetxController {
  RxBool isInitialLoading = RxBool(false);
  RxList<VehicleListModelValues> vehicleList = <VehicleListModelValues>[].obs;
  VehicleListModelValues? selectedVehicle;
  RxList<VehicleDetailsValues> vehicleDetailsList =
      <VehicleDetailsValues>[].obs;
  RxBool isAmountLoading = RxBool(false);
}
