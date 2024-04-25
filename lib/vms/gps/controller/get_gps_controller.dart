import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/gps/model/clients_model.dart';
import 'package:m_skool_flutter/vms/gps/model/sales_list_model.dart';

import '../../rating_report/screen/report_data_screen.dart';

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
    // var status = await Permission.location.request();
    // if (status.isGranted) {
    //   LocationData locationData = await Location().getLocation();
    //   latitude.value = locationData.latitude!;
    //   longitude.value = locationData.longitude!;
    //   return true;
    // }
    var status1 = await Geolocator.requestPermission();
    if (status1 == LocationPermission.denied) {
      Fluttertoast.showToast(msg: "Location Permission is denied");
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always) {
        _getLocation();
        return true;
      }
    }
    return false;
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    logger.d(longitude.value);
    logger.v(latitude.value);
  }
}
