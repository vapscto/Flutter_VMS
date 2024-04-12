import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/controller/job_posting_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/client_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/depart_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/job_gender_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/job_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/job_post_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/position_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/priority_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/ql_list_model.dart';

class JobPostingAPI {
  JobPostingAPI.init();
  static final JobPostingAPI i = JobPostingAPI.init();
  var dio = Dio();
  onLoad(
      {required String base,
      required int miId,
      required JobPostingController controller}) async {
    var api = base + URLS.jobPostingOnLoad;
    controller.loading(true);
    var response = await dio.post(api,
        data: {"MI_Id": miId}, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      PositionListModel positionListModel =
          PositionListModel.fromJson(response.data['masterPositionList']);
      controller.positionList.clear();
      controller.positionList.addAll(positionListModel.values!);
      PriorityListModel priorityListModel =
          PriorityListModel.fromJson(response.data['masterPriorityList']);
      controller.priorityList.clear();
      controller.priorityList.addAll(priorityListModel.values!);
      QualificationListModel qualificationListModel =
          QualificationListModel.fromJson(response.data['masterQualification']);
      controller.qualificationList.clear();
      controller.qualificationList.addAll(qualificationListModel.values!);
      ClientListModel clientListModel =
          ClientListModel.fromJson(response.data['clientlist']);
      controller.clientList.clear();
      controller.clientList.addAll(clientListModel.values!);
      JobDepartmentListModel jobDepartmentListModel =
          JobDepartmentListModel.fromJson(
              response.data['masterDepartmentList']);
      controller.jobDepartmentList.clear();
      controller.jobDepartmentList.addAll(jobDepartmentListModel.values!);
      JobGenderListModel jobGenderListModel =
          JobGenderListModel.fromJson(response.data['masterGender']);
      controller.jobGenderList.clear();
      controller.jobGenderList.addAll(jobGenderListModel.values!);
      JobPostListModel jobPostListModel =
          JobPostListModel.fromJson(response.data['masterPosTypeList']);
      controller.jobPostList.clear();
      controller.jobPostList.addAll(jobPostListModel.values!);
      controller.loading(false);
    }
  }

//
  onLoadGrid(
      {required String base,
      required int miId,
      required JobPostingController controller}) async {
    var api = base + URLS.jobPostingOnLoad;
    controller.gridloading(true);
    var response = await dio.post(api,
        data: {"MI_Id": miId}, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      JobListModel jobListModel =
          JobListModel.fromJson(response.data['gridrecordMRF']);
      controller.data(jobListModel.values!);
      controller.gridloading(false);
    }
  }

//
  saveData({required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.postJob;
    var response = await dio.post(api,
        data: body, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      if (response.data['retrunMsg'] != "") {
        switch (response.data['retrunMsg']) {
          case "Duplicate":
            Fluttertoast.showToast(msg: "Record already exists..!!");
            break;
          case "false":
            Fluttertoast.showToast(
                msg: "Record Not saved / Updated..",
                toastLength: Toast.LENGTH_LONG);
            break;
          case "Add":
            Fluttertoast.showToast(msg: "Record Saved Successfully..");
            Get.back();
            break;
          case "Update":
            Fluttertoast.showToast(msg: "Record Updated Successfully..");
            Get.back();
            break;
          default:
            Fluttertoast.showToast(
                msg: "Something went wrong..! Kindly contact Administrator",
                toastLength: Toast.LENGTH_LONG);
            break;
        }
      }
    }
  }
}
