import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/controller/add_to_hrms_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_candidate_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_emp_type.dart';

class AddToHRMSAPI {
  AddToHRMSAPI.init();
  static final AddToHRMSAPI i = AddToHRMSAPI.init();
  var dio = Dio();
  onLoad(
      {required String base,
      required int miId,
      required AddToHRMSConttroller controller}) async {
    controller.loading(true);
    var api = base + URLS.addToHrmsOnLoad;
    try {
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: {"MI_Id": miId});
      if (response.statusCode == 200) {
        AddToHrmsCandidateListModel addToHrmsCandidateListModel =
            AddToHrmsCandidateListModel.fromJson(
                response.data['candidatelist']);
        controller.candidateList.clear();
        controller.candidateList.addAll(addToHrmsCandidateListModel.values!);

        AddToHrmsEmpTypeModel addToHrmsEmpTypeModel =
            AddToHrmsEmpTypeModel.fromJson(response.data['masterEmployeetype']);
        controller.empTypeList.clear();
        controller.empTypeList.addAll(addToHrmsEmpTypeModel.values!);
        controller.loading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
