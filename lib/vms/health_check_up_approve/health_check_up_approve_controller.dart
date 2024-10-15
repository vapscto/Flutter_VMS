import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/get_loaded_data_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_inst_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_data_model.dart';

class HealthCheckUpApproveController extends GetxController {
  RxBool isInitialLoading = RxBool(false);
  RxList<HealthCheckupInstModelValues> institutionList =
      <HealthCheckupInstModelValues>[].obs;
  HealthCheckupInstModelValues? selectedInstitution;

  RxList<HealthCheckupDataModelValues> detailsList =
      <HealthCheckupDataModelValues>[].obs;
  RxBool isDataLoading = RxBool(false);
  RxList<GetLoadedDataModelValues> loadedDataList =
      <GetLoadedDataModelValues>[].obs;
}
