import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/profile_model.dart';
import 'package:m_skool_flutter/model/student_profile_details_model.dart';

class GetProfileDetails {
  GetProfileDetails.init();
  static final GetProfileDetails instance = GetProfileDetails.init();

  Future<List<ProfileDataModelValues>> getProfileData({
    required int miId,
    required int asmayId,
    required int amstId,
    required int userId,
    required int roleId,
    required String type,
    required String base,
  }) async {
    final Dio dio = getGlobalDio();
    final String api = base + URLS.profile;
    try {
      Response response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "User_Id": userId,
        "roleid": roleId,
        "type": "Mobile"
      });

      if (response.data['studetailslist'] == null) {
        return Future.error({
          "errorTitle": "Unexpected error occured",
          "errorMsg":
              "We are unable to load the data because studetailslist is not available in db"
        });
      }

      final ProfileDataModel profileDataModel =
          ProfileDataModel.fromJson(response.data['studetailslist']);

      logger.d(profileDataModel.toJson());
      return Future.value(profileDataModel.values!);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "Sorry! but we are unable to connect to server, try again later."
      });
    }
  }

  Future<StudentProfileDetailsModel> getStudentProfileDetails({
    required int miId,
    required int asmayId,
    required int amstId,
    required int userId,
    required int roleId,
    required String base,
  }) async {
    final Dio dio = getGlobalDio();
    final String api = base + URLS.studentProfileDetails;
    logger.d(api);
    logger.d({
      "AMST_Id": amstId,
      "MI_Id": miId,
      "ASMAY_Id": asmayId,
      "User_Id": userId,
      "roleid": roleId,
      "student_staffflag": "Student"
    });
    try {
      Response response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "AMST_Id": amstId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "User_Id": userId,
        "roleid": roleId,
        "student_staffflag": "Student"
      });

      final StudentProfileDetailsModel studentProfileDetailsModel =
          StudentProfileDetailsModel.fromJson(response.data);

      logger.d(studentProfileDetailsModel.toJson());
      return Future.value(studentProfileDetailsModel);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "Sorry! but we are unable to connect to server, try again later."
      });
    }
  }
}
