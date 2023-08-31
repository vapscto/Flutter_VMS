import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/notice_employee_data.dart';

class NoticeGetEmployee {
  NoticeGetEmployee.init();
  static NoticeGetEmployee instance = NoticeGetEmployee.init();

  getEmployee({
    required int asmayId,
    required int userId,
    required int ivrmrtId,
    required int miId,
    required List<Map<String, dynamic>> department,
    required List<Map<String, dynamic>> designation,
    required String base,
    required NoticeBoardController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.getEmployee;
    if (controller.isErrorOccuredWhileLoadingEmployee.value) {
      controller.updateIsErrorOccuredWhileLoadingEmployee(false);
    }
    controller.updateIsEmpLoading(true);
    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "MI_Id": miId,
        "departmentlist": department,
        "designationlist": designation,
      });
      logger.d(apiUrl);
      logger.d({
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "MI_Id": miId,
        "departmentlist": department,
        "designationlist": designation,
      });

      if (response.data['get_userEmplist'] == null) {
        controller.updateIsErrorOccuredWhileLoadingEmployee(true);
        controller.updateIsEmpLoading(false);
        return;
      }

      final NoticeEmployeeDataModel employeeDataModel =
          NoticeEmployeeDataModel.fromJson(response.data['get_userEmplist']);
      if (employeeDataModel.values!.isNotEmpty) {
        controller.addToSelectedEmployee(employeeDataModel.values!.first);
      }
      controller.updateNoticeEmployeeDataModel(employeeDataModel.values!);
      logger.d(controller.employee.length);
      controller.updateIsEmpLoading(false);
    } on DioError catch (e) {
      logger.e(e.message, e.stackTrace);
      controller.updateIsErrorOccuredWhileLoadingEmployee(true);
      controller.updateIsEmpLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingEmployee(true);
      controller.updateIsEmpLoading(false);
    }
  }
}
