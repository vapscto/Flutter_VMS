import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/health_check_up_approve_controller.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/get_loaded_data_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_comments.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_file_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_inst_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_data_model.dart';

class HealthCheckUpApproveAPI {
  HealthCheckUpApproveAPI.init();
  static final HealthCheckUpApproveAPI i = HealthCheckUpApproveAPI.init();
  var dio = Dio();
  onLoadAPI(
      {required String base,
      required int userId,
      required HealthCheckUpApproveController controller}) async {
    var api = base + URLS.healthCheckupApprovalOnload;
    try {
      var response = await dio.post(api,
          data: {"OnLoadOrOnChange": "OnLoad", "UserId": userId},
          options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['getuserinstitution'] != null) {
          HealthCheckupInstModel healthCheckupInstModel =
              HealthCheckupInstModel.fromJson(
                  response.data['getuserinstitution']);
          controller.institutionList.value = healthCheckupInstModel.values!;
          controller.selectedInstitution = controller.institutionList.first;
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
  }

  allData(
      {required String base,
      required int userId,
      required int miId,
      required HealthCheckUpApproveController controller}) async {
    var api = base + URLS.healthCheckupApprovalOnload;
    try {
      var response = await dio.post(api,
          data: {
            "OnLoadOrOnChange": "OnChange",
            "UserId": userId,
            "MI_Id": miId
          },
          options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['getapprovaldetails'] != null) {
          HealthCheckupDataModel healthCheckupDataModel =
              HealthCheckupDataModel.fromJson(
                  response.data['getapprovaldetails']);
          controller.detailsList.value = healthCheckupDataModel.values!;
        }
        if (response.data['getloaddata'] != null) {
          GetLoadedDataModel getLoadedDataModel =
              GetLoadedDataModel.fromJson(response.data['getloaddata']);
          controller.loadedDataList.value = getLoadedDataModel.values!;
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
  }

  Future<List<HealthCheckupCommentsValues>?> comments({
    required String base,
    required int hwhchupId,
    required int miId,
  }) async {
    var api = base + URLS.healthCheckupComments;
    try {
      var response = await dio.post(api,
          data: {"HWHCHUP_Id": hwhchupId, "MI_Id": miId},
          options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['viewcommens'] != null) {
          HealthCheckupComments healthCheckupComments =
              HealthCheckupComments.fromJson(response.data['viewcommens']);
          return healthCheckupComments.values!;
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
    return null;
  }

  Future<List<HealthCheckupFileModelValues>?> fileView({
    required String base,
    required int hwhchupId,
    required int miId,
  }) async {
    var api = base + URLS.healthCheckUpFiles;
    try {
      var response = await dio.post(api,
          data: {"HWHCHUP_Id": hwhchupId, "MI_Id": miId},
          options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['getviewfilesdetails'] != null) {
          HealthCheckupFileModel healthCheckupComments =
              HealthCheckupFileModel.fromJson(
                  response.data['getviewfilesdetails']);
          return healthCheckupComments.values!;
        }
      }
    } on DioError catch (e) {
      logger.e(e);
    }
    return null;
  }

  Future<bool?> approvehealthCheckup(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.healthCheckUpApprove;
    logger.w(api);
    logger.v(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        return response.data['returnval'];
      }
    } on Exception catch (e) {
      logger.e(e);
    }
    return false;
  }
}
