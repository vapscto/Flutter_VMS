import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class SaveLeaveApplication {
  SaveLeaveApplication.init();
  static final SaveLeaveApplication instance = SaveLeaveApplication.init();

  Future<bool> saveNow({
    required int miId,
    required int userId,
    required int asmayId,
    required String applicationDate,
    required int contactNoOnLeave,
    required String leaveReason,
    required String reportingDate,
    required String supportingDocument,
    required List<Map<String, dynamic>> frmToDate,
    required List<Map<String, dynamic>> temp,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.saveLeave;
    try {
      logger.d({
        "HRELAP_ApplicationDate": applicationDate,
        "HRELAP_ContactNoOnLeave": contactNoOnLeave,
        "HRELAP_LeaveReason": leaveReason,
        "HRELAP_ReportingDate": reportingDate,
        "HRELT_SupportingDocument": "undefined",
        "MI_Id": miId,
        "UserId": "$userId",
        "asmay_id": asmayId,
        "frmToDates": frmToDate,
        "temp_table_data": temp
      });
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "HRELAP_ApplicationDate": applicationDate,
        "HRELAP_ContactNoOnLeave": contactNoOnLeave,
        "HRELAP_LeaveReason": leaveReason,
        "HRELAP_ReportingDate": reportingDate,
        "HRELT_SupportingDocument": "undefined",
        "MI_Id": miId,
        "UserId": "$userId",
        "asmay_id": asmayId,
        "frmToDates": frmToDate,
        "temp_table_data": temp
      });

      // logger.d()
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        if (response.data['returnMsg'] != null &&
            response.data['returnMsg'] == 'Saved') {
          return Future.value(true);
        }

        if (response.data['returnMsg'] != null &&
            response.data['returnMsg'] == "Duplicate") {
          return Future.error({
            "errorTitle": "You have already applied",
            "errorMsg":
                "We already have this leave application with us.. you can check the status in homepage"
          });
        }

        if (response.data['returnMsg'] != null &&
            response.data['returnMsg'] == "NoMapping") {
          return Future.error({
            "errorTitle": "Exception Occured in server side",
            "errorMsg":
                "Please Create Leave Numbering Using Transaction Numbering Page ... Ask your tech team to fix this issue"
          });
        }

        if (response.data['returnMsg'] != null &&
            response.data['returnMsg'] == 'Limits Crossed') {
          return Future.error({
            "errorTitle": "Limit Exceeded",
            "errorMsg": "You have exceeded the limit for this leave"
          });
        }

        if (response.data['returnval'] == true) {
          return Future.value(true);
        }

        return Future.error({
          "errorTitle": "Already applied",
          "errorMsg": "For this date or leave you already applied "
        });
      }

      return Future.error({
        "errorTitle": "Something went wrong",
        "errorMsg": "Server didn't responded correctly for this request"
      });
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      return Future.error({
        "errorTitle": "Something went wrong",
        "errorMsg": e.message,
      });
    }
  }
}
