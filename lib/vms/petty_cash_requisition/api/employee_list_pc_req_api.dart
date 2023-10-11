import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/cash_requisition_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/employee_list_pc_req_model.dart';

Future<void> getEmployeeListPcReq(

  {
    required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,
    required int hrmdId,
    required CashRequisitionController controller
  }

) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.employeeListPCRequest;
  logger.d(api);


   logger.d({
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag,
    "HRMD_Id": hrmdId
});

  try {
    controller.updateisLoadingOnloadEmployee(true);

    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag,
    "HRMD_Id": hrmdId
});
    // print(response.data['getemp']);
    // logger.d(response.data['getemp']);
    if (response.data['getemp'] == null) {
      controller.updateErrorLoadingOnloadEmployee(true);
      // return 0;
    } else if (response.data['getemp'] != null) {
      controller.updateErrorLoadingOnloadEmployee(false);
      controller.updateisLoadingOnloadEmployee(false);
       EmployeeListPcReqModel employeeListResponse =
        EmployeeListPcReqModel.fromJson(response.data['getemp']);
    controller.employeeList.addAll(employeeListResponse.values!);
    }
   
    //  return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingOnloadEmployee(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}