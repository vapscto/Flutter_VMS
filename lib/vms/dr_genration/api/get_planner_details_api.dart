import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/countTask_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_details.dart';

Future<bool> getPlanerdetails({
  required String base,
  required PlannerDetails controller,
  required int userId,
  required int ivrmrtId,
  required int miId,
}) async {
  final Dio ins = getGlobalDio();
  String baseApi = "https://vms.vapstech.com:44011/";
  final String apiUrl = baseApi + URLS.drDetailsGenration;
  //  print(base);
  controller.updatePlannerDeatails(true);
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": 61035,
      "IVRMRT_Id": ivrmrtId,
    });
    PlanerDeatails planerDeatailsList = PlanerDeatails.fromJson(response.data);
    GetTaskDrListModel taskDrListModel = GetTaskDrListModel.fromJson(response.data['gettasklist']);
    controller.getTaskDrList.addAll(taskDrListModel.values!);
    // here add countTask 
    CloseTaskCoutnModel closeTaskList = CloseTaskCoutnModel.fromJson(response.data['closeTaskCoutnDetails']);
    controller.closeTaskCoutnList.addAll(closeTaskList.values!);
    controller.plannernameEditingController.value.text =
        planerDeatailsList.plannername!;
    controller.otherDaysEditingController.value =
        planerDeatailsList.dailyreportothersdatecount!.toInt().toString();
    controller.updatePlannerDeatails(false);
    return true;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
    return false;
  }
}
