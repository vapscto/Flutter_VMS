import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/cash_requisition_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/department_pc_req_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/particulars_pc_req_model.dart';

Future<void> getPcRequisitionOnLoad(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,
    required CashRequisitionController controller}) async {
  final Dio ins = getGlobalDio();
  final String api = base +
      URLS.departmentonLoadPCRequest;
  logger.d(api);
  
  logger.d({
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag
  });

  try {
    controller.updateisLoadingOnloadDepartment(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "roleid": roleId,
      "Userid": userId,
      "MI_Id": miId,
      "ASMAY_Id": asmaYId,
      "Role_flag": roleFlag
    });

    ///***   PC REQUEST ONLOAD LIST API PARAMETER  ***///

    // print(response.data['getdept']);
    // logger.d(response.data['getdept']);
    if (response.data['getdept'] == null) {
      controller.updateErrorLoadingOnloadDepartment(true);
      // return 0;
    } else if (response.data['getdept'] != null) {
      controller.updateErrorLoadingOnloadDepartment(false);
      controller.updateisLoadingOnloadDepartment(false);
      DepartmentPcRequestModel departmentListResponse =
          DepartmentPcRequestModel.fromJson(response.data['getdept']);
      controller.departmentList.addAll(departmentListResponse.values!);
    }

    ///***   PARTICULAR LIST API PARAMETER  ***///

    // print(response.data['getparticulars']);
    // logger.d(response.data['getparticulars']);
    controller.updateErrorLoadingOnloadParticulars(false);
    controller.updateisLoadingOnloadParticulars(false);
    ParticularsPcRequestModel particularsListResponse =
        ParticularsPcRequestModel.fromJson(response.data['getparticulars']);

    controller.dropdownValue = particularsListResponse.values!.first;
    controller.itemsParticularList.addAll(particularsListResponse.values!);
    for (int i = 0; i < particularsListResponse.values!.length; i++) {
      controller.updateErrorLoadingOnloadParticulars(true);
      controller.textCtrl.add(TextEditingController(text: ""));
    }
    if (response.data['getparticulars'] == null) {
      controller.updateErrorLoadingOnloadParticulars(true);
      // return 0;
    } else if (response.data['getparticulars'] != null) {}
  } on DioError catch (e) {
    controller.updateErrorLoadingOnloadDepartment(true);

    controller.updateErrorLoadingOnloadParticulars(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
