import 'package:get/get.dart';
import 'package:location/location.dart';
// import 'package:m_skool_flutter/vms/gps/api/gps_api.dart';
import 'package:m_skool_flutter/vms/gps/model/clients_model.dart';
// import 'package:m_skool_flutter/vms/gps/model/gps_emp.dart';
import 'package:m_skool_flutter/vms/gps/model/sales_list_model.dart';
import 'package:permission_handler/permission_handler.dart';

class GetEmpDetailsController extends GetxController {
  RxList<GetGpsClientDetailsValues> gpsClientList =
      <GetGpsClientDetailsValues>[].obs;
  // RxList<GetGpsEmployeeDetailsValues>gpsEmpList = <GetGpsEmployeeDetailsValues>[].obs;
  RxList<GetGpsSalesDetailsValues> gpsSalesList =
      <GetGpsSalesDetailsValues>[].obs;
  RxString getGpsLocation = "".obs;

  RxBool gpsLoading = RxBool(false);
  RxBool gpsErrorLoading = RxBool(false);
  RxBool mapLoading = RxBool(false);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  updateMapLoading(bool val) {
    mapLoading.value = val;
  }

  updategpsLoading(bool val) {
    gpsLoading.value = val;
  }

  updategpsErrorLoading(bool val) {
    gpsErrorLoading.value = val;
  }

  Future<bool> getLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      LocationData locationData = await Location().getLocation();
      latitude.value = locationData.latitude!;
      longitude.value = locationData.longitude!;

      return true;
    }
    return false;
  }
}
