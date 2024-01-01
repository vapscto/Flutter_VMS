import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/DeptWise_Devitaion_Model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/advance_tada_applied.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/countTask_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_status_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/drnotapprovedmessage_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/drnotsent_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/get_planner_details.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/hrplannerdetails_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_details.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/tada_not_approve_model.dart';

Future<bool> getPlanerdetails({
  required String base,
  required PlannerDetails controller,
  required int userId,
  required int ivrmrtId,
  required int miId,
}) async {
  final Dio ins = getGlobalDio();
  // String base = "https://vms.vapstech.com:44011/";
  final String apiUrl = base + URLS.drDetailsGenration;
  //  print(base);
  controller.updatePlannerDeatails(true);
  logger.e(apiUrl);
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": userId,
      "IVRMRT_Id": ivrmrtId,
    });
    logger.e({
      "MI_Id": miId,
      "UserId": userId,
      "IVRMRT_Id": ivrmrtId,
    });
    PlanerDeatails planerDeatailsList = PlanerDeatails.fromJson(response.data);
    if (response.data['gettasklist'] != null) {
      GetTaskDrListModel taskDrListModel =
          GetTaskDrListModel.fromJson(response.data['gettasklist']);
      controller.getTaskDrList.addAll(taskDrListModel.values!);
      for (int i = 0; i < taskDrListModel.values!.length; i++) {
        controller.hoursEt.add(TextEditingController(text: ''));
        controller.minutesEt.add(TextEditingController(text: ''));
        controller.statusEtField.add(TextEditingController(text: ''));
        controller.deveationEtField.add(TextEditingController(text: ''));
        controller.etResponse.add(TextEditingController(text: ''));
        controller.checkBoxList.add(false);
      }
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
    if (response.data['closeTaskCoutnDetails'] != null) {
      CloseTaskCoutnModel closeTaskList =
          CloseTaskCoutnModel.fromJson(response.data['closeTaskCoutnDetails']);
      controller.closeTaskCoutnList.addAll(closeTaskList.values!);
    }

    if (response.data['gettasklist'] != null) {
      controller.plannernameEditingController.value.text =
          planerDeatailsList.plannername ?? '';
      controller.otherDaysEditingController.value =
          planerDeatailsList.dailyreportothersdatecount!.toInt().toString();
    }

    if (response.data['drnotapprovedmessage'] != null) {
      Drnotapprovedmessage drnotapprovedmessage =
          Drnotapprovedmessage.fromJson(response.data['drnotapprovedmessage']);
      controller.drnotapprovedList.addAll(drnotapprovedmessage.values!);
    }

    if (response.data['getdrnotsentdetails'] != null) {
      Getdrnotsentdetails getdrnotsentdetails =
          Getdrnotsentdetails.fromJson(response.data['getdrnotsentdetails']);
      controller.drNotSend(getdrnotsentdetails.values!);
      for (var a = 0; a < getdrnotsentdetails.values!.length; a++) {
        controller.etRemark.add(TextEditingController(text: ""));
      }
    }
    if (response.data['hrplannerdetails'] != null) {
      Hrplannerdetails hrplannerdetails =
          Hrplannerdetails.fromJson(response.data['hrplannerdetails']);
      controller.hrplannerDetailsList.addAll(hrplannerdetails.values!);
    }
    controller.daviationId.value = response.data['deviation_id'];
    if (response.data['getplannerdetails'] != null) {
      GetPlannerDetailsModel getPlannerDetailsModel =
          GetPlannerDetailsModel.fromJson(response.data['getplannerdetails']);
      controller.getPlannerData(getPlannerDetailsModel.values!);
    }

    if (response.data['adavanceList'] != null) {
      AdvanceApplyModel advanceApplyModel =
          AdvanceApplyModel.fromJson(response.data['adavanceList']);
      controller.getAdvanceApply(advanceApplyModel.values!);
    }
    if (response.data['applyList'] != null) {
      TADAApplyListModel tadaApplyListModel =
          TADAApplyListModel.fromJson(response.data['applyList']);
      controller.getList(tadaApplyListModel.values!);
    }
    if (response.data['extensiondays'] != null) {
      controller.deviationCount.value = response.data['extensiondays'];
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

Future<bool?> saveDr({
  required String base,
  required PlannerDetails controller,
  required String ismdrptDate,
  required bool halfDayFlag,
  required int ismtplId,
  required List<Map<String, dynamic>> drList,
  required int deviationId,
  required String endWeek,
  required String reasion,
  required String startWeek,
  required String todayOrOthersDay,
  required double totalWorkingHrFlag,
  required int userId,
  required int miID,
  required int roleId,
}) async {
  var dio = Dio();
  var api = base + URLS.drSaveAPI;
  logger.e({
    "UserId": userId,
    "MI_Id": miID,
    "roleId": roleId,
    "ISMDRPT_Date": ismdrptDate,
    "ISMDRPT_HalfDayFlag": halfDayFlag,
    "ISMTPL_Id": ismtplId,
    "Temp_ISM_DailyReportGenerationDTO": drList,
    "deviation_id": deviationId,
    "endweek": endWeek,
    "reason": reasion,
    "startweek": startWeek,
    "todayorothers": todayOrOthersDay,
    "totalworkinghrsflag": totalWorkingHrFlag
  });
  try {
    controller.saveLoading(true);
    var response =
        await dio.post(api, options: Options(headers: getSession()), data: {
      "UserId": userId,
      "MI_Id": miID,
      "ISMDRPT_Date": ismdrptDate,
      "ISMDRPT_HalfDayFlag": halfDayFlag,
      "ISMTPL_Id": ismtplId,
      "Temp_ISM_DailyReportGenerationDTO": drList,
      "deviation_id": deviationId,
      "endweek": endWeek,
      "reason": reasion,
      "startweek": startWeek,
      "todayorothers": todayOrOthersDay,
      "totalworkinghrsflag": totalWorkingHrFlag
    });

    if (response.statusCode == 200) {
      if (response.data['returnval'] == true) {
        Fluttertoast.showToast(msg: "Saved Successfully");
      }
      controller.saveLoading(false);
      return true;
    }
    return false;
  } on DioError catch (e) {
    logger.e(e.message);
    controller.saveLoading(true);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
  return null;
}

Future<bool?> drNotSaveDAPI({
  required String base,
  required PlannerDetails controller,
  required List<Map<String, dynamic>> drList,
  required int userId,
  required int miId,
  required String todayDate,
}) async {
  var dio = Dio();
  var api = base + URLS.drNotSave;
  logger.e({
    "UserId": userId,
    "MI_Id": miId,
    "SaveDRNotSentRemarksDetails": drList,
    "ISMDRNSDR_RemarksDate": "",
  });
  try {
    controller.saveLoading(true);
    var response =
        await dio.post(api, options: Options(headers: getSession()), data: {
      "UserId": userId,
      "MI_Id": miId,
      "SaveDRNotSentRemarksDetails": drList,
      "ISMDRNSDR_RemarksDate": todayDate,
    });

    if (response.statusCode == 200) {
      controller.saveLoading(false);
      return true;
    }
    return false;
  } on DioError catch (e) {
    logger.e(e.message);
    controller.saveLoading(true);
    return false;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
  return null;
}
