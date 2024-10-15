import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/driver_ind_apply_controller.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/model/vehicle_details.dart';
import 'package:m_skool_flutter/vms/driver_indent/indent_apply/model/vehicle_list_model.dart';

class DriverIndentApplyAPI {
  DriverIndentApplyAPI.init();
  static final DriverIndentApplyAPI i = DriverIndentApplyAPI.init();
  var dio = Dio();
  driverIndentOnLoad(
      {required String base,
      required int miId,
      required DriverIndentApplyController controller}) async {
    var api = base + URLS.driverIndentApplyOnLoad;
    try {
      var response = await dio.post(
        api,
        data: {"MI_Id": miId},
      );
      if (response.statusCode == 200) {
        if (response.data['vehicle_list'] != null) {
          VehicleListModel vehicleListModel =
              VehicleListModel.fromJson(response.data["vehicle_list"]);
          controller.vehicleList.value = vehicleListModel.values!;
          return vehicleListModel.values!;
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
    return null;
  }

  driverIndentVDetails(
      {required String base,
      required int miId,
      required int irmvId,
      required DriverIndentApplyController controller}) async {
    var api = base + URLS.vehicleDetails;
    try {
      var response = await dio.post(api,
          data: {"MI_Id": miId, "TRMV_Id": irmvId},
          options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['vehicledetails'] != null) {
          VehicleDetails vehicleDetails =
              VehicleDetails.fromJson(response.data["vehicledetails"]);
          controller.vehicleDetailsList.value = vehicleDetails.values!;
          return vehicleDetails.values!;
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
    return null;
  }

  saveDriverIndent(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.saveDriverIndent;
    logger.i(api);
    logger.i(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        logger.i(response.data);
        if (response.data['msg'] == "Saved") {
          Fluttertoast.showToast(msg: "Request Saved Successfully");
          Get.back();
        } else if (response.data['msg'] == "updated") {
          Fluttertoast.showToast(msg: "Request updated Successfully");
          Get.back();
        } else if (response.data['msg'] == "Failed") {
          Fluttertoast.showToast(msg: "Request not Saved");
        } else {
          Fluttertoast.showToast(msg: "Something went Wrong");
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
  }
}
