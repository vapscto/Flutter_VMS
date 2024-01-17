import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/add_extra_task_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/previous_task_details.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/search_previous_task_model.dart';

class AddExtraTaskAPI {
  AddExtraTaskAPI.init();
  static final AddExtraTaskAPI instance = AddExtraTaskAPI.init();
  addExtraTaskDR(
      {required String base,
      required int mIId,
      required int userId,
      required int roleId,
      required String ismDate,
      required PlannerDetails controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.addExtraTaskDR;
    try {
      logger.d(api);
      logger.d({
        "MI_Id": mIId,
        "Userid": userId,
        "roleId": roleId,
        "ISMDRPT_Date": ismDate,
      });
      final response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": mIId,
        "Userid": userId,
        "roleId": roleId,
        "ISMDRPT_Date": ismDate,
      });
      if (response.data['getextratasks'] == null) {
        controller.updateErrorLoadingaddExtraTaskDR(true);
      } else if (response.data['getextratasks'] != null) {
        controller.updateErrorLoadingaddExtraTaskDR(false);
        AddExtraTaskModel addExtraTaskDRListResponse =
            AddExtraTaskModel.fromJson(response.data['getextratasks']);
        controller.getExtratask(addExtraTaskDRListResponse.values!);
        for (int i = 0; i < addExtraTaskDRListResponse.values!.length; i++) {
          controller.extraTaskCheckBox.add(false);
        }
      }
    } on Exception catch (e) {
      logger.printError();
    }
  }
}

class PreviousDrReport {
  PreviousDrReport.init();
  static final PreviousDrReport instance = PreviousDrReport.init();
  previousDrData(
      {required String base,
      required int mIId,
      required int userId,
      required String ismDate,
      required PlannerDetails controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.previousTaskList;
    try {
      logger.d(api);
      logger.d({
        "MI_Id": mIId,
        "Userid": userId,
        "ISMDRPT_Date": ismDate,
      });
      controller.searchTaskLoading(true);
      final response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": mIId,
        "Userid": userId,
        "ISMDRPT_Date": ismDate,
      });
      if (response.data['getsearchdailyreport'] == null) {
        controller.searchTaskLoading(true);
      } else if (response.data['getsearchdailyreport'] != null) {
        controller.searchTaskLoading(false);
        SearchPreviousTaskModel searchPreviousTaskModel =
            SearchPreviousTaskModel.fromJson(
                response.data['getsearchdailyreport']);
        controller.searchTask(searchPreviousTaskModel.values!);
      }
      if (response.data['droveralldetailsdatewise'] != null) {
        SearchPreviousTaskDetailsModel searchPreviousTaskDetailsModel =
            SearchPreviousTaskDetailsModel.fromJson(
                response.data['droveralldetailsdatewise']);
        controller.previousTaskDetails(searchPreviousTaskDetailsModel.values!);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      logger.printError();
    }
  }
}
