import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/classes_model_data_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/department_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/view_notice_data_model.dart';

class StaffNoticeBoardApi {
  StaffNoticeBoardApi.init();
  static final StaffNoticeBoardApi instance = StaffNoticeBoardApi.init();

  getAllNotices({
    required int miId,
    required int hrme,
    required int userId,
    required int ivrmrtId,
    required int asmayId,
    required String base,
    required NoticeBoardController noticeBoardController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = base + URLS.noticeGetDetails;
      if (noticeBoardController.isErrorOccuredWhileLoadingWork.value) {
        noticeBoardController.updateIsErrorOccuredWhileLoadingNotice(false);
      }

      noticeBoardController.updateIsWorkLoading(true);
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "HRME_Id": hrme,
        "userId": userId,
        "IVRMRT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
      });
      if (response.data['notice_details'] == null) {
        noticeBoardController.updateIsErrorOccuredWhileLoadingNotice(true);
        noticeBoardController.updateIsWorkLoading(false);
        noticeBoardController.updateViewWorkLoadingStatus(
            "No Notice present or it may be deleted, ask to add array");
        return;
      }
      final ViewNoticeDetailsModelValues detailsModelValues =
          ViewNoticeDetailsModelValues.fromJson(
              response.data['notice_details']);

      noticeBoardController.updateViewNoticeList(detailsModelValues.values!);
      noticeBoardController.updateIsWorkLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      noticeBoardController.updateIsErrorOccuredWhileLoadingNotice(true);
      noticeBoardController.updateIsWorkLoading(false);
      noticeBoardController.updateViewWorkLoadingStatus(
          "Server did not responsed correctly and returing an error");
    } on Exception catch (e) {
      logger.e(e.toString());
      noticeBoardController.updateIsErrorOccuredWhileLoadingNotice(true);
      noticeBoardController.updateIsWorkLoading(false);
      noticeBoardController.updateViewWorkLoadingStatus(
          "An internal error Occured while trying to create a view for you");
    }
  }

  getClassList({
    required int miId,
    required int hrme,
    required int userId,
    required int ivrmrtId,
    required int asmayId,
    required String base,
    required NoticeBoardController noticeBoardController,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = base + URLS.noticeGetDetails;
      if (noticeBoardController.isErrorOccuredWhileLoadingClass.value) {
        noticeBoardController.updateIsErrorOccuredWhileLoadingClass(false);
      }

      noticeBoardController.updateIsClassLoading(true);
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "HRME_Id": hrme,
        "userId": userId,
        "IVRMRT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
      });
      if (response.data['classlist'] == null) {
        noticeBoardController.updateIsErrorOccuredWhileLoadingClass(true);
        noticeBoardController.updateIsClassLoading(false);
        noticeBoardController.updateViewWorkLoadingStatus(
            "No Classes present or it may be deleted, ask to add array");
        return;
      }
      final ClassNameDetailsModel detailsModelValues =
          ClassNameDetailsModel.fromJson(response.data['classlist']);
      if (detailsModelValues.values!.isNotEmpty) {
        if (noticeBoardController.selectedClasses.isNotEmpty) {
          noticeBoardController.selectedClasses.clear();
        }
        noticeBoardController
            .addToSelectedClasses(detailsModelValues.values!.first);
      }
      noticeBoardController.updateClassesList(detailsModelValues.values!);

      noticeBoardController.updateIsClassLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      noticeBoardController.updateIsErrorOccuredWhileLoadingClass(true);
      noticeBoardController.updateIsClassLoading(false);
      noticeBoardController.updateViewWorkLoadingStatus(
          "Server did not responsed correctly and returing an error");
    } on Exception catch (e) {
      logger.e(e.toString());
      noticeBoardController.updateIsErrorOccuredWhileLoadingClass(true);
      noticeBoardController.updateIsClassLoading(false);
      noticeBoardController.updateViewWorkLoadingStatus(
          "An internal error Occured while trying to create a view for you");
    }
  }

  getDepartmentList({
    required int miId,
    required int hrme,
    required int userId,
    required int ivrmrtId,
    required int asmayId,
    required String base,
    required NoticeBoardController noticeBoardController,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.noticeGetDetails;

    if (noticeBoardController.isErrorOccuredWhileLoadingDepartment.value) {
      noticeBoardController.updateIsErrorOccuredWhileLoadingDepartment(false);
    }

    noticeBoardController.updateIsDepartmentLoading(true);

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "HRME_Id": hrme,
        "userId": userId,
        "IVRMRT_Id": ivrmrtId,
        "ASMAY_Id": asmayId,
      });
      if (response.data['departmentList'] == null) {
        noticeBoardController.updateIsErrorOccuredWhileLoadingDepartment(true);
        noticeBoardController.updateIsDepartmentLoading(false);
        // noticeBoardController.updateViewWorkLoadingStatus(
        //     "No Department present or it may be deleted, ask to add array");
        return;
      }

      final DepartmentListModel department =
          DepartmentListModel.fromJson(response.data['departmentList']);
      if (department.values!.isNotEmpty) {
        if (noticeBoardController.selectedDepartment.isNotEmpty) {
          noticeBoardController.selectedDepartment.clear();
        }
        noticeBoardController.addToSelectedDepartment(department.values!.first);
      }
      noticeBoardController.updateDepartment(department.values!);
      noticeBoardController.updateIsDepartmentLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      noticeBoardController.updateIsErrorOccuredWhileLoadingDepartment(true);
      noticeBoardController.updateIsDepartmentLoading(false);
      noticeBoardController.updateViewWorkLoadingStatus(
          "Server did not responsed correctly and returing an error");
    } on Exception catch (e) {
      logger.e(e.toString());
      noticeBoardController.updateIsErrorOccuredWhileLoadingDepartment(true);
      noticeBoardController.updateIsDepartmentLoading(false);
      noticeBoardController.updateViewWorkLoadingStatus(
          "An internal error Occured while trying to create a view for you");
    }
  }
}
