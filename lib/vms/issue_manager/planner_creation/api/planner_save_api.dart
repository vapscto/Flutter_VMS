import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class PlannerSaveAPI {
  PlannerSaveAPI.init();
  static final PlannerSaveAPI instance = PlannerSaveAPI.init();

  saveDataAPI({
    required String base,
    required int userId,
    required int miId,
    required String plannerName,
    required String startDate,
    required String endDate,
    required String totalHour,
    required String remarks,
    required List<Map<String, dynamic>> catListId,
    required List<Map<String, dynamic>> taskplannerArray,
  }) async {
    var dio = Dio();
    var url = base + URLS.savePlanner;
    try {
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "UserId": userId,
        "ISMTPL_PlannerName": plannerName,
        "ISMTPL_StartDate": startDate,
        "ISMTPL_EndDate": endDate,
        "ISMTPL_TotalHrs": totalHour,
        "ISMTPL_Remarks": remarks,
        "taskplannerArray": taskplannerArray,
        "catlistid": catListId
      });
      logger.i('===$url');
      logger.i({
        "MI_Id": miId,
        "UserId": userId,
        "ISMTPL_PlannerName": plannerName,
        "ISMTPL_StartDate": startDate,
        "ISMTPL_EndDate": endDate,
        "ISMTPL_TotalHrs": totalHour,
        "ISMTPL_Remarks": remarks,
        "taskplannerArray": taskplannerArray,
        "catlistid": catListId
      });
      if (response.statusCode == 200) {
        if (response.data['returnval'] == true) {
          if (response.data['ismtpL_Id'] == 0 ||
              response.data['ismtpL_Id'] < 0) {
            Fluttertoast.showToast(
                msg:
                    "Planner Saved successfully ... !!', 'Approval has to be given by your department head");
          } else if (response.data['ismtpL_Id'] > 0) {
            Fluttertoast.showToast(msg: "Record updated successfully");
          }
        }
      } else {
        Fluttertoast.showToast(msg: "Something Went Wrong");
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
