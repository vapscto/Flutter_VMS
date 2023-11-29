import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/DeptWise_Devitaion_Model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/countTask_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_status_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/drnotapprovedmessage_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/drnotsent_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/hrplannerdetails_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_details.dart';

Future<bool> getPlanerdetails({
  required String base,
  required PlannerDetails controller,
  required int userId,
  required int ivrmrtId,
  required int miId,
}) async {
  final Dio ins = getGlobalDio();
  String base = "https://vms.vapstech.com:44011/";
  final String apiUrl = base + URLS.drDetailsGenration;
  //  print(base);
  controller.updatePlannerDeatails(true);
  logger.e(apiUrl);
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": 60241,
      "IVRMRT_Id": 11,
    });
    logger.e({
      "MI_Id": miId,
      "UserId": userId,
      "IVRMRT_Id": ivrmrtId,
    });
    PlanerDeatails planerDeatailsList = PlanerDeatails.fromJson(response.data);
    GetTaskDrListModel taskDrListModel =
        GetTaskDrListModel.fromJson(response.data['gettasklist']);
    controller.getTaskDrList.addAll(taskDrListModel.values!);
    for (int i = 0; i < taskDrListModel.values!.length; i++) {
      controller.hoursEt.add(TextEditingController(text: ''));
      controller.minutesEt.add(TextEditingController(text: ''));
      controller.statusEtField.add(TextEditingController(text: ''));
      controller.deveationEtField.add(TextEditingController(text: ''));
      controller.checkBoxList.add(false);
    }
    // adding status in the list
    DrstatusListModel drStatusListModel =
        DrstatusListModel.fromJson(response.data['get_Status']);
    controller.statusDrList.addAll(drStatusListModel.values!);
    // here add countTask
    // get Deviation task list
    DepartwisedeviationModel departwisedeviationModel =
        DepartwisedeviationModel.fromJson(
            response.data['getdepartwisedeviationremrks']);
    controller.depWiseDevitnList.addAll(departwisedeviationModel.values!);
    CloseTaskCoutnModel closeTaskList =
        CloseTaskCoutnModel.fromJson(response.data['closeTaskCoutnDetails']);
    controller.closeTaskCoutnList.addAll(closeTaskList.values!);
    controller.plannernameEditingController.value.text =
        planerDeatailsList.plannername!;
    controller.otherDaysEditingController.value =
        planerDeatailsList.dailyreportothersdatecount!.toInt().toString();
    Drnotapprovedmessage drnotapprovedmessage =
        Drnotapprovedmessage.fromJson(response.data['drnotapprovedmessage']);
    controller.drnotapprovedList.addAll(drnotapprovedmessage.values!);
    Getdrnotsentdetails getdrnotsentdetails = Getdrnotsentdetails.fromJson(response.data['getdrnotsentdetails']);
  controller.drnotSentdetailsList.addAll(getdrnotsentdetails.values!);
  Hrplannerdetails hrplannerdetails = Hrplannerdetails.fromJson(response.data['hrplannerdetails']);
  controller.hrplannerDetailsList.addAll(hrplannerdetails.values!);
   for(var a =0;a<getdrnotsentdetails.values!.length;a++){
    controller.etRemark.add(TextEditingController(text: ""));
  }
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
