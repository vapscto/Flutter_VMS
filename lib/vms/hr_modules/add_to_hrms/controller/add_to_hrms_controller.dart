import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrmd_deg.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_candidate_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_dep_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_emp_type.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/candidates_details_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/cast_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/company_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/grade_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/group_type_list.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/marital_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/religion_model.dart';

class AddToHRMSConttroller extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool l) {
    isLoading.value = l;
  }

  RxBool isSaving = RxBool(false);
  void save(bool l) {
    isSaving.value = l;
  }

  RxList<AddToHrmsCandidateListModelValues> candidateList =
      <AddToHrmsCandidateListModelValues>[].obs;
  RxList<AddToHrmsEmpTypeModelValues> empTypeList =
      <AddToHrmsEmpTypeModelValues>[].obs;
  RxList<ReligionListModelValues> religionlist =
      <ReligionListModelValues>[].obs;
  RxList<CastListModelValues> castList = <CastListModelValues>[].obs;
  RxList<MaritalListModelValues> maritalList = <MaritalListModelValues>[].obs;
  RxList<AddToHrmsDepListModelValues> depList =
      <AddToHrmsDepListModelValues>[].obs;
  RxList<AddToHrmsDegModelValues> degList = <AddToHrmsDegModelValues>[].obs;
  RxList<GradeListModelValues> gradeList = <GradeListModelValues>[].obs;
  RxList<GroupTypeListModelValues> groupTypeList =
      <GroupTypeListModelValues>[].obs;
  RxList<CompanyListModelValues> companyList = <CompanyListModelValues>[].obs;
  RxList<CandidateDetailsModelValues> candidateDetailsList =
      <CandidateDetailsModelValues>[].obs;
}
