import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/exam_model.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_attendance_model.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_get_fee_details.dart';
import 'package:m_skool_flutter/manager/student_details/model/personal_details.dart';

class GetStudentDetailsApi {
  GetStudentDetailsApi.init();
  static GetStudentDetailsApi instance = GetStudentDetailsApi.init();

  getDetails({
    required int miId,
    required int amstId,
    required int asmayId,
    required String base,
    required ViewStudentDetailsController controller,
  }) async {
    final String api = base + URLS.getStudentDetails;

    final Dio ins = getGlobalDio();
    logger.d(api);

    if (controller.isErrorOccured.value) {
      controller.updateIsErrorOccured(false);
    }
    controller.updateIsLoading(true);

    try {
      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "Amst_Id": amstId,
      });
      final Response response = await ins.post(api, options: Options(), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "Amst_Id": amstId,
      });

      final PersonalDetails personalDetails =
          PersonalDetails.fromJson(response.data['fillstudentalldetails']);

      final ManagerAttendanceModel managerAttendanceModel =
          ManagerAttendanceModel.fromJson(response.data['attendencelist']);

      final GetFeeDetails feeDetails =
          GetFeeDetails.fromJson(response.data['getfeedetails']);

      final GetTermFeeDetails termFeeDetails =
          GetTermFeeDetails.fromJson(response.data['termwisefeelist']);

      final ManagerExamModel examModel =
          ManagerExamModel.fromJson(response.data['examlist']);

      controller.updatePersonalData(personalDetails.values!);
      controller.updateAttendance(managerAttendanceModel.values!);
      controller.updateFeeDetails(feeDetails.values!);
      controller.updateGetTermFee(termFeeDetails.values!);
      controller.updateManagerExam(examModel.values!);
      controller.updateIsLoading(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      controller.updateIsErrorOccured(true);
      controller.updateIsLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccured(true);
      controller.updateIsLoading(false);
    }
  }
}
