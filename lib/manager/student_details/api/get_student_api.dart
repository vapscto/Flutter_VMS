import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_student_model.dart';

class GetStudentApi {
  GetStudentApi.init();
  static final GetStudentApi instance = GetStudentApi.init();

  Future<void> getStudents({
    required int miId,
    required int asmayId,
    required int asmcld,
    required int asmsId,
    required String base,
    required StudentDetailsController controller,
  }) async {
    final String api = base + URLS.managerGetStuent;

    logger.d(api);
    final Dio ins = getGlobalDio();

    if (controller.isErrorOccuredWhileLoadingStudent.value) {
      controller.updateIsErrorOccuredWhileLoadingStudent(false);
    }

    controller.updateIsStudentLoading(true);
    controller.updateStatus("We are loading students for your..");

    logger.d({
      "MI_Id": miId,
      "ASMAY_Id": asmayId,
      "ASMCL_Id": asmcld,
      "ASMS_Id": asmsId
    });
    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "ASMAY_Id": asmayId,
            "ASMCL_Id": asmcld,
            "ASMS_Id": asmsId
          });

      if (response.data['getstudentdetails'] == null) {
        controller.updateIsErrorOccuredWhileLoadingStudent(true);
        controller.updateIsStudentLoading(false);
        controller.updateStatus(
            "There is no student right now or may be deleted.. ask your tech team to provide");
        return;
      }

      final ManagerStudentModel student =
          ManagerStudentModel.fromJson(response.data['getstudentdetails']);

      if (student.values!.isNotEmpty) {
        controller.updateSelectedStudent(student.values!.first);
      }
      controller.updateStudents(student.values!);
      controller.updateIsStudentLoading(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      controller.updateIsErrorOccuredWhileLoadingStudent(true);
      controller.updateIsStudentLoading(false);
      controller.updateStatus(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingStudent(true);
      controller.updateIsStudentLoading(false);
      controller.updateStatus(
          "An internal error occured while trying to create a view for you");
    }
  }
}
