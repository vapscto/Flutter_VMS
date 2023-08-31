import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_academic_year.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_class_model.dart';

class ManagerGetAcademic {
  ManagerGetAcademic.init();
  static final ManagerGetAcademic instance = ManagerGetAcademic.init();

  Future<void> getAcademics(
      {required int miId,
      required int asmayId,
      required String base,
      required StudentDetailsController controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.managerAcademic;
    if (controller.isErrorOccuredWhileLoadingAcademicYear.value) {
      controller.updateIsErrorOccuredWhileLoadingAcademicYear(false);
    }
    controller.updateIsAcademicYearLoading(true);
    controller.updateStatus("Please wait we are loading academic year");
    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "ASMAY_Id": asmayId,
        },
      );

      if (response.data['yearlist'] == null) {
        controller.updateStatus(
            "There are no academic year available or may be deleted ask them to add");
        controller.updateIsErrorOccuredWhileLoadingAcademicYear(true);
        controller.updateIsAcademicYearLoading(false);
        return;
      }
      final ManagerAcademiCYearModel managerAcademiCYearModel =
          ManagerAcademiCYearModel.fromJson(response.data['yearlist']);
      // final ManagerClassModel classModel =
      //     ManagerClassModel.fromJson(response.data['classlist']);
      if (managerAcademiCYearModel.values!.isNotEmpty) {
        controller
            .updateSelectedAcademicYear(managerAcademiCYearModel.values!.first);
      }

      controller.updateAcademicYear(managerAcademiCYearModel.values!);
      // controller.updateClassName(classModel.values!);
      controller.updateIsAcademicYearLoading(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      controller.updateIsErrorOccuredWhileLoadingAcademicYear(true);
      controller.updateIsAcademicYearLoading(false);
      controller.updateStatus(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingAcademicYear(true);
      controller.updateIsAcademicYearLoading(false);
      controller.updateStatus(
          "An internal error occured while trying to create a view for you");
    }
  }

  getClassName({
    required int miId,
    required int asmayId,
    required String base,
    required StudentDetailsController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.managerAcademic;
    if (controller.isErrorOccuredWhileLoadingClass.value) {
      controller.updateIsErrorOccuredWhileLoadingClass(false);
    }
    controller.updateIsLoadingClass(true);
    controller.updateStatus("Please wait we are loading academic year");
    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "ASMAY_Id": asmayId,
        },
      );

      if (response.data['classlist'] == null) {
        controller.updateStatus(
            "There are no class available or may be deleted ask them to add");
        controller.updateIsErrorOccuredWhileLoadingClass(true);
        controller.updateIsLoadingClass(false);
        return;
      }

      final ManagerClassModel classModel =
          ManagerClassModel.fromJson(response.data['classlist']);

      if (classModel.values!.isNotEmpty) {
        controller.updateSelectedClass(classModel.values!.first);
      }

      controller.updateClassName(classModel.values!);
      controller.updateIsLoadingClass(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      controller.updateIsErrorOccuredWhileLoadingClass(true);
      controller.updateIsLoadingClass(false);
      controller.updateStatus(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingClass(true);
      controller.updateIsLoadingClass(false);
      controller.updateStatus(
          "An internal error occured while trying to create a view for you");
    }
  }
}
