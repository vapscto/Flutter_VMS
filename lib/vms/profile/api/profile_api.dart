import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/coe/model/holiday_list_model.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/vms/profile/model/birthday_list_model.dart';
import 'package:m_skool_flutter/vms/profile/model/profile_model.dart';

class ProfileAPI {
  ProfileAPI.init();
  static final ProfileAPI instance = ProfileAPI.init();
  profileData(
      {required String base,
      required ProfileController profileController,
      required int miId,
      required int userId,
      required int roleId}) async {
    var dio = Dio();
    var api = base + URLS.profileData;
    try {
      profileController.profileLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "UserId": userId, "IVRMRT_Id": roleId});
      logger.i({"MI_Id": miId, "UserId": userId, "IVRMRT_Id": roleId});
      logger.i(api);
      if (response.statusCode == 200) {
        ProfileDataModel profileDataModel =
            ProfileDataModel.fromJson(response.data['emp_deatils']);
        profileController.getProfile(profileDataModel.values!);
        if (response.data['birthdaylist'] != null) {
          BirthDayListModel birthDayListModel =
              BirthDayListModel.fromJson(response.data['birthdaylist']);
          profileController.birthday(birthDayListModel.values!);
        }
        if (response.data['upcomingholiday'] != null) {
          HolidayListModel holidayListModel =
              HolidayListModel.fromJson(response.data['upcomingholiday']);
          profileController.getHoliday(holidayListModel.values!);
        }
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
