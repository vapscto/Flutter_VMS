import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/client_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/depart_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/job_gender_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/job_post_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/position_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/priority_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/ql_list_model.dart';

class JobPostingController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool l) {
    isLoading.value = l;
  }

  RxList<PositionListModelValues> positionList =
      <PositionListModelValues>[].obs;
  RxList<PriorityListModelValues> priorityList =
      <PriorityListModelValues>[].obs;
  RxList<QualificationListModelValues> qualificationList =
      <QualificationListModelValues>[].obs;
  RxList<ClientListModelValues> clientList = <ClientListModelValues>[].obs;
  RxList<JobDepartmentListModelValues> jobDepartmentList =
      <JobDepartmentListModelValues>[].obs;
  RxList<JobGenderListModelValues> jobGenderList =
      <JobGenderListModelValues>[].obs;
  RxList<JobPostListModelValues> jobPostList = <JobPostListModelValues>[].obs;
  RxBool isSaving = RxBool(false);
  void saving(bool b) {
    isSaving.value = b;
  }
}
