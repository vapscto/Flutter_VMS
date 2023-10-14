import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_emp_details.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/priority_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/task_employee_list.dart';

Future<bool> getTskCompaniesList(
    {required String base,
    required TaskDepartController controller,
    required int userId,
    required int ivrmrtId,
    required int miId,
    }) async {
  final Dio ins = getGlobalDio();

  final String apiUrl = base + URLS.taskGetDetails;
   logger.d(base + URLS.taskGetDetails);
    
  try {
    controller.taskDeptLoading(true);
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
          "IVRMRT_Id": ivrmrtId,
          "UserId": userId,
          "MI_Id": miId,
        });
     GetEmployeeId getEmployeeId =  GetEmployeeId.fromJson(response.data );
     logInBox!.put("EmpId", getEmployeeId.hrmEId);
    GetDepts getDepts = GetDepts.fromJson(response.data['get_department']);
    GetPriorityModel priorityModelList = GetPriorityModel.fromJson(response.data['get_priority']); 
    TaskEmployeeListModel employeeListModel = TaskEmployeeListModel.fromJson(response.data['get_employeelist']);
    for(int i = 0; i < employeeListModel.values!.length; i++){
      controller.checkBox.add(false);
    }
    controller.getTaskEmployeeList.addAll(employeeListModel.values!);
    controller.getPriorityModelList.addAll(priorityModelList.values!);
    controller.getDeptsList.addAll(getDepts.values!);
    controller.taskDeptLoading(false);
    return  true;
  } on DioError catch (e) {
    controller.taskDeptErrorLoading(true);
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.taskDeptErrorLoading(true);

    return false;
  }
}
