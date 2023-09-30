import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_projects_cntroller.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';
 

Future<int> getTskPrjtCatgryList(
    {required String base,
    required TaskProjectsController controller,
    required int userId,
    required int ivrmrtId,
    required int miId,
    required int HRME_Id,
    required int HRMD_Id}) async {
  final Dio ins = getGlobalDio();

  final String apiUrl = base + URLS.taskGetProjects;
   logger.d(base + URLS.taskGetDetails);

  try {
    controller.updateTaskProjectsLoading(true);
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
    "IVRMRT_Id": ivrmrtId,
    "UserId": userId,
    "MI_Id": miId,
    "HRME_Id":HRME_Id,
    "HRMD_Id":HRMD_Id
});
logger.d(
   {
    "IVRMRT_Id": ivrmrtId,
    "UserId": userId,
    "MI_Id": miId,
    "HRME_Id":HRME_Id,
    "HRMD_Id":HRMD_Id
}
);
 GeTskProjects project = GeTskProjects.fromJson(response.data['get_project']);
 controller.getTaskProjectsList.addAll(project.values!);

 TaskCategoryModel category = TaskCategoryModel.fromJson(response.data['get_category']);
 controller.getTaskCategoryList.addAll(category.values!);


  controller.updateTaskProjectsLoading(false);
    return response.statusCode!;
  } on DioError catch (e) {
    controller.updateTaskProjectsErrorLoading(true);
    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateTaskProjectsErrorLoading(true);

    return 0;
  }
}
