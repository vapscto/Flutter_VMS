import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/model/staff_profile_data_model.dart';

class GetStaffProfileDetail {
  GetStaffProfileDetail.init();
  static final GetStaffProfileDetail instance = GetStaffProfileDetail.init();

  Future<List<StaffProfileDataModelValues>> getDetails({
    required int miId,
    required int hrmeId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getStaffProfileDet;
    logger.d(api);
    logger.d({
      "MI_Id": "$miId",
      "HRME_Id": "$hrmeId",
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": "$miId",
        "HRME_Id": "$hrmeId",
      });

      if (response.data['staffdetails'] == null) {
        return Future.error({
          "errorTitle": "Unexpected error Occured",
          "errorMsg":
              "There is no staffdetails array present in the api, tell you tech team to add it inside the api",
        });
      }

      final StaffProfileDataModel staffProfile =
          StaffProfileDataModel.fromJson(response.data['staffdetails']);

      return Future.value(staffProfile.values);
    } on DioError catch (e) {
      logger.e(e.message);
      return Future.error({
        "errorTitle": "An error Occured while trying to connect to server",
        "errorMsg": e.message,
      });
    } catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected error Occured",
        "errorMsg":
            "An internal error occured while trying to create a view for you",
      });
    }
  }
}
