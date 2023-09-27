 import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/employee_details/model/designationModel.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/detailed_todo_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/getTaDaModel.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/mc_home_screen.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/department_list.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/designation.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/employee_model_list.dart';

Future<int> feacthUserApi({
  required String base,
  required int ivrmrtId,
  required int userId,
  required int mi_id,
  required MakerCheckerController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl =
      base+"api/ISM_DailyReport_ApprovalFacade/GetDetails/";
    logger.d("damn ${apiUrl}");

  

  try {
    controller.updateLoading(true);

    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
          "IVRMRT_Id":ivrmrtId,
          "UserId": userId, 
           "MI_Id": mi_id,
           "DRApprovalTypeFlag":"DRApproval"  });

     
     if (response.data['get_leaveDetails'] == null || response.data['compoffdetails'] == null  ) {
      controller.checkLeaveandCompoff(true);
      return 300;
    } else if (response.data['get_userEmplist'] != null && response.data['departmentList'] != null && response.data['designation'] != null) {
      controller.upateErrorLoading(false);
      controller.updateLoading(false);
       DepartmentModelList deptList = DepartmentModelList.fromJson( response.data['departmentList']);
        controller.departmentList.addAll( deptList.values!);
    //       DesignationsModel dsgnList = DesignationsModel.fromJson(response.data['designation']);

    //  controller.designationList.addAll(dsgnList.values!);
      return response.statusCode!;
    }

    return response.statusCode!;
  } on DioError catch (e) {
    controller.upateErrorLoading(true);

    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.upateErrorLoading(true);

    return 0;
  }
}
