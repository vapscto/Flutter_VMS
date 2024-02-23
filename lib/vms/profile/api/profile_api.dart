import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/coe/model/holiday_list_model.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/vms/profile/model/birthday_list_model.dart';
import 'package:m_skool_flutter/vms/profile/model/issues_list_model.dart';
import 'package:m_skool_flutter/vms/profile/model/late_in_model.dart';
import 'package:m_skool_flutter/vms/profile/model/periodicity_model.dart';
import 'package:m_skool_flutter/vms/profile/model/profile_model.dart';
import 'package:m_skool_flutter/vms/profile/model/rating_data_model.dart';

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
      logger.v({"MI_Id": miId, "UserId": userId, "IVRMRT_Id": roleId});
      logger.w(api);
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
        if (response.data['prioritylist'] != null) {
          PeriodicityListModel periodicityListModel =
              PeriodicityListModel.fromJson(response.data['prioritylist']);
          profileController.periodicityList.clear();
          profileController.periodicityList
              .addAll(periodicityListModel.values!);
        }
        logger.v(response.data['lateindata']);
        if (response.data['lateindata'] != null) {
          LateInModel lateInModel =
              LateInModel.fromJson(response.data['lateindata']);
          profileController.newData(lateInModel.values!);
        }
        profileController.present.value = response.data['totdayspresent'];
        profileController.holiday.value = response.data['totholiday'];
        RatingDataModel ratingDataModel =
            RatingDataModel.fromJson(response.data['ratingDetails']);
        profileController.ratingDataModelValues.clear();
        profileController.ratingDataModelValues.addAll(ratingDataModel.values!);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  issuesList(
      {required String base,
      required ProfileController profileController,
      required Map<String, dynamic> body}) async {
    var dio = Dio();
    var api = base + URLS.taskList;
    try {
      profileController.taskDataLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      logger.v(body);
      logger.w(api);
      if (response.statusCode == 200) {
        TaskIssuesListModel taskIssuesListModel =
            TaskIssuesListModel.fromJson(response.data['issueslist']);
        profileController.issuesList.clear();
        profileController.issuesList(taskIssuesListModel.values!);

        profileController.taskDataLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
