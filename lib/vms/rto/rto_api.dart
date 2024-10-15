import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_emp_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_fine_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_v_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_violation_model.dart';
import 'package:m_skool_flutter/vms/rto/rto_controller.dart';

class RTOAPI {
  RTOAPI.init();
  static final RTOAPI i = RTOAPI.init();
  var dio = Dio();
  getOnLoadData(
      {required String base,
      required int miId,
      required RTOController controller}) async {
    var api = base + URLS.rtoOnLoad;
    try {
      var response = await dio.post(api,
          data: {"MI_Id": miId}, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['vehicalArray'] != null) {
          RtoVehicleModel rtoVehicleModel =
              RtoVehicleModel.fromJson(response.data['vehicalArray']);
          controller.vehicleList.value = rtoVehicleModel.values!;
        }
        if (response.data['emplist'] != null) {
          RtoEmpModel rtoEmpModel =
              RtoEmpModel.fromJson(response.data['emplist']);
          controller.empList.value = rtoEmpModel.values!;
        }
        if (response.data['fineArray'] != null) {
          RtoFineModel rtoFineModel =
              RtoFineModel.fromJson(response.data['fineArray']);
          controller.fineList.value = rtoFineModel.values!;
        }
        if (response.data['rtO_VialationList'] != null) {
          RtoViolationModel rtoViolationModel =
              RtoViolationModel.fromJson(response.data['rtO_VialationList']);
          controller.violationList.value = rtoViolationModel.values!;
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
  }

  saveRtoData(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.rtoSaveData;
    logger.w(body);
    var response = await dio.post(api,
        data: body, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      switch (response.data['returnval']) {
        case "save":
          Fluttertoast.showToast(msg: "Record Saved Successfully");
          Get.back();
          break;
        case "Notsave":
          Fluttertoast.showToast(msg: "Record is not Saved");
          break;
        case "duplicate":
          Fluttertoast.showToast(msg: "Duplicate Record");
          Get.back();
          break;
        case "update":
          Fluttertoast.showToast(msg: "Record Updated Successfully");
          Get.back();
          break;
        case "Notupdate":
          Fluttertoast.showToast(msg: "Record is not Update");
          break;
        case "admin":
          Fluttertoast.showToast(msg: "Please Contact Administrator !");
          break;
        default:
          Fluttertoast.showToast(msg: "Something went Wrong !");
      }
    }
  }
}
