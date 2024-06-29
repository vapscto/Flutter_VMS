import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_controller/gate_pass_controller.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_dep_list.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_list_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_staff_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/pass_deg_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/pass_inst_model.dart';

class GatePassAPI {
  GatePassAPI.init();
  static final GatePassAPI instance = GatePassAPI.init();
  var dio = Dio();
  onLoad(
      {required String base,
      required int miId,
      required int userId,
      required GatePassController controller}) async {
    var api = base + URLS.gatePassOnload;
    try {
      var res = await dio.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "UserId": userId});
      if (res.statusCode == 200) {
        GatePassInstModel gatePassInstModel =
            GatePassInstModel.fromJson(res.data['institutionlist']);
        controller.institutionList.clear();
        controller.institutionList.addAll(gatePassInstModel.values!);
        if (res.data['alldata'] != null) {
          GatePassListModel gatePassListModel =
              GatePassListModel.fromJson(res.data['alldata']);
          controller.gatePassedList.clear();
          controller.gatePassedList.addAll(gatePassListModel.values!);
        }
        if (res.data['filldepartment'] != null) {
          GatePassDepartmentModel gatePassDepartmentModel =
              GatePassDepartmentModel.fromJson(res.data['filldepartment']);
          controller.departmentList.clear();
          controller.departmentList.addAll(gatePassDepartmentModel.values!);
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  designation(
      {required String base,
      required int miId,
      required int depId,
      required GatePassController controller}) async {
    var api = base + URLS.gatePassDeg;
    try {
      var res = await dio.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "HRMD_Id": depId});
      if (res.statusCode == 200) {
        if (res.data['filldesignation'] != null) {
          GatePassDesignationModel gatePassDesignationModel =
              GatePassDesignationModel.fromJson(res.data['filldesignation']);
          controller.degList.clear();
          controller.degList.addAll(gatePassDesignationModel.values!);
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  staffData(
      {required String base,
      required int miId,
      required int depId,
      required int degId,
      required GatePassController controller}) async {
    var api = base + URLS.gatePassEmpList;
    logger.i(api);
    logger.w({"MI_Id": miId, "HRMD_Id": depId, "HRMDES_Id": degId});
    try {
      var res = await dio.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "HRMD_Id": depId, "HRMDES_Id": degId});
      if (res.statusCode == 200) {
        if (res.data['emplist'] != null) {
          GatePassStaffModel gatePassDesignationModel =
              GatePassStaffModel.fromJson(res.data['emplist']);
          controller.staffList.clear();
          controller.staffList.addAll(gatePassDesignationModel.values!);
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<int?> saveData({
    required String base,
    required Map<String, dynamic> body,
  }) async {
    var api = base + URLS.gatePassSave;
    logger.i(api);
    logger.w(body);
    try {
      var res = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      if (res.statusCode == 200) {
        if (res.data['returnval'] == true) {
          if (res.data['gphsT_Id'] > 0) {
            Fluttertoast.showToast(msg: "Record Updated Successfully!!!");
          } else {
            Fluttertoast.showToast(msg: 'Record Saved Successfully!!!');
          }
        }
      }
      return res.statusCode;
    } on DioError catch (e) {
      logger.e(e);
    } on Exception catch (e) {
      logger.e(e);
    }
    return 0;
  }

  Future<int?> activate({
    required String base,
    required Map<String, dynamic> body,
  }) async {
    var api = base + URLS.gatePassActive;
    logger.i(api);
    logger.w(body);
    try {
      var res = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      // if (res.statusCode == 200) {
      //   if (res.data['returnval'] == true) {
      //     if (res.data['gphsT_Id'] > 0) {
      //       Fluttertoast.showToast(msg: "Record Updated Successfully!!!");
      //     } else {
      //       Fluttertoast.showToast(msg: 'Record Saved Successfully!!!');
      //     }
      //   }
      // }
      return res.statusCode;
    } on DioError catch (e) {
      logger.e(e);
    } on Exception catch (e) {
      logger.e(e);
    }
    return 0;
  }
}
