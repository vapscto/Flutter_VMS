import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class PlannerApprovalSaveAPI {
  PlannerApprovalSaveAPI.init();
  static final PlannerApprovalSaveAPI instance = PlannerApprovalSaveAPI.init();
  plannerapproval({
    required String base,
    required List<Map<String, dynamic>> plannerList,
    required int userId,
    required int miId,
    required String roleFlag,
    required int ivrmrtId,
    required int asmayId,
    required int view,
    required int ismtplId,
    required String remarks,
    required double totalEffort,
  }) async {
    var dio = Dio();
    var url = base + URLS.plannerSave;
    try {
      var response =
          await dio.post(url, options: Options(headers: getSession()), data: {
        "UserId": userId,
        "MI_Id": miId,
        "Role_flag": "S",
        "IVRMRT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
        "view": view,
        "ISMTPL_Id": ismtplId,
        "ISMTPLAP_Remarks": remarks,
        "totaleffort": totalEffort,
        "approveplannerArray": plannerList,
      });
      logger.i({
        "UserId": userId,
        "MI_Id": miId,
        "Role_flag": "S",
        "IVRMRT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
        "view": view,
        "ISMTPL_Id": ismtplId,
        "ISMTPLAP_Remarks": remarks,
        "totaleffort": totalEffort,
        "approveplannerArray": plannerList,
      });
      logger.i(url);
      if (response.statusCode == 200) {
        if (response.data['returnval'] != null) {
          if (response.data['returnval'] == true) {
            Fluttertoast.showToast(msg: "Planner Status update successfully");
          } else if (response.data['returnval'] == false) {
            Fluttertoast.showToast(msg: "Planner Status is not update");
          }
        } else {
          Fluttertoast.showToast(msg: "Something went Wrong");
        }
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
