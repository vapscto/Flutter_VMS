import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/punch_report/controller/punch_filter_controller.dart';
import 'package:m_skool_flutter/vms/punch_report/model/current_punch_details.dart';

class PunchApi {
  PunchApi.init();
  static final PunchApi instance = PunchApi.init();

  pcReports({
    required Map<String, dynamic> body,
    required String base,
    required PunchFilterController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.punchList;
    if (controller.isErrorOccured.value) {
      controller.isErrorOccured.value = false;
    }
    logger.d(apiUrl);

    controller.punchLoading(true);
    try {
      final Response response = await ins.post(apiUrl,
          options: Options(headers: getSession()), data: body);

      if (response.data['punchdetails'] == null) {
        controller.punchLoading(true);
        controller.message.value =
            "Sorry! but we are unable to find any data, it may happens that data list is deleted";
      }

      final CurrentPunchDetailsModel prModel =
          CurrentPunchDetailsModel.fromJson(response.data['punchdetails']);
      logger.d(prModel.toJson());
      controller.punchLoading(false);
      controller.getPunch(prModel.values!);
    } on DioError catch (e) {
      logger.e(e.message);
      controller.message.value = e.message;
      return Future.error(
        {
          "errorTitle": "Unexpected Error Occured",
          "errorMsg": e.message,
        },
      );
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.message.value =
          "While Creating your view, we encountered an error.. Try again later";
    }
  }
}

Future<void> attendance({
  required String base,
  required Map<String, dynamic> body,
  required PunchFilterController ctn,
}) async {
  var api = base + URLS.attendance;
  var dio = Dio();
  try {
    var response = await dio.post(api,
        data: body, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      List<dynamic> selectedActivityDetails1Stf =
          response.data['selectedActivityDetails1_stf'];
      if (selectedActivityDetails1Stf.isNotEmpty) {
        if (selectedActivityDetails1Stf.first['hrmE_Relaxtime'] != null) {
          ctn.relaxsationTime.value =
              selectedActivityDetails1Stf.first['hrmE_Relaxtime'];
        }
      }

      // ctn.staffDetails.add(SelectedActivityDetails1Stf(
      //   fomSId: selectedActivityDetails1Stf.first['fomS_Id'],
      //   hrmEId: selectedActivityDetails1Stf.first['hrmE_Id'],
      //   mIId: selectedActivityDetails1Stf.first['mI_Id'],
      //   ivrmrTId: selectedActivityDetails1Stf.first['ivrmrT_Id'],
      //   vmscrTId: selectedActivityDetails1Stf.first['vmscrT_Id'],
      //   hrmEEmployeeFirstName:
      //       selectedActivityDetails1Stf.first['hrmE_EmployeeFirstName'],
      //   hrmEEmployeeCode:
      //       selectedActivityDetails1Stf.first['hrmE_EmployeeCode'],
      //   hrmEPerStreet: selectedActivityDetails1Stf.first['hrmE_PerStreet'],
      //   hrmEDOJ: selectedActivityDetails1Stf.first['hrmE_DOJ'],
      //   hrmERelaxtime: selectedActivityDetails1Stf.first['hrmE_Relaxtime'],
      //   hrmELeftFlag: selectedActivityDetails1Stf.first['hrmE_LeftFlag'],
      //   hrmEExcDR: selectedActivityDetails1Stf.first['hrmE_ExcDR'],
      //   hrmEExcPunch: selectedActivityDetails1Stf.first['hrmE_ExcPunch'],
      //   ivrmuLId: selectedActivityDetails1Stf.first['ivrmuL_Id'],
      //   logInUserId: selectedActivityDetails1Stf.first['logInUserId'],
      //   fomsTId: selectedActivityDetails1Stf.first['fomsT_Id'],
      //   fohwdTId: selectedActivityDetails1Stf.first['fohwdT_Id'],
      // ));

      // AttStaffDetailsModel attStaffDetailsModel =
      //     AttStaffDetailsModel.fromJson(response.data['staffDetails']);
      // ctn.staffDetailsModel.clear();
      // ctn.staffDetailsModel.addAll(attStaffDetailsModel.values!);
      // AttWorkingHrModel attWorkingHrModel =
      //     AttWorkingHrModel.fromJson(response.data['workinghourDetails']);
      // for (int i = 0; i < attWorkingHrModel.values!.length; i++) {
      //   if (attWorkingHrModel.values![i].hRMEId ==
      //       selectedActivityDetails1Stf.first['hrmE_Id']) {
      //     if (selectedActivityDetails1Stf.first['hrmE_ExcPunch'] == false) {
      //       ctn.workingDays.value = attWorkingHrModel.values!.length;
      //     }
      //   }
      // }
      // AttLeaveDetailsModel attLeaveDetailsModel =
      //     AttLeaveDetailsModel.fromJson(response.data['staffleaveDetails']);
      // ctn.unAuthorizedLeave.value = 0;
      // for (int i = 0; i < attLeaveDetailsModel.values!.length; i++) {
      //   if (attLeaveDetailsModel.values![i].hRMEId ==
      //       selectedActivityDetails1Stf.first['hrmE_Id']) {
      //     if (attLeaveDetailsModel.values![i].absentday! > 0) {
      //       ctn.unAuthorizedLeave.value +=
      //           attLeaveDetailsModel.values![i].absentday!;
      //     }
      //   }
      // }
      // if (response.data['leaveDetails'] != null) {
      //   AttLeaveNameModel attLeaveNameModel =
      //       AttLeaveNameModel.fromJson(response.data['leaveDetails']);
      //   for (int i = 0; i < attLeaveNameModel.values!.length; i++) {
      //     if (attLeaveDetailsModel.values![i].hRMEId ==
      //         selectedActivityDetails1Stf.first['hrmE_Id']) {
      //       if (ctn.unauthleavedates == "") {
      //         ctn.unauthleavedates = DateTime.parse(
      //                 attLeaveDetailsModel.values![i].drNotSentDates!)
      //             .day
      //             .toString();
      //         if (attLeaveDetailsModel.values![i].approvedday == 0) {
      //           ctn.unauthleavedatesdisplay =
      //               "${DateTime.parse(attLeaveDetailsModel.values![i].drNotSentDates!).day}(F)";
      //           ctn.unauthleavedatestemp = DateTime.parse(
      //                   attLeaveDetailsModel.values![i].drNotSentDates!)
      //               .day
      //               .toString();
      //         }
      //       } else {
      //         ctn.unauthleavedates +=
      //             ", ${DateTime.parse(attLeaveDetailsModel.values![i].drNotSentDates!).day}";
      //         if (attLeaveDetailsModel.values![i].approvedday == 0 &&
      //             ctn.unauthleavedatesdisplay != "") {
      //           ctn.unauthleavedatesdisplay +=
      //               ", ${DateTime.parse(attLeaveDetailsModel.values![i].drNotSentDates!).day}(F)";
      //           ctn.unauthleavedatestemp +=
      //               ", ${DateTime.parse(attLeaveDetailsModel.values![i].drNotSentDates!).day}";
      //         } else if (attLeaveDetailsModel.values![i].approvedday == 0 &&
      //             ctn.unauthleavedatesdisplay == "") {
      //           ctn.unauthleavedatesdisplay =
      //               "${DateTime.parse(attLeaveDetailsModel.values![i].drNotSentDates!).day}(F)";
      //           ctn.unauthleavedatestemp = DateTime.parse(
      //                   attLeaveDetailsModel.values![i].drNotSentDates!)
      //               .day
      //               .toString();
      //         }
      //       }
      //       logger.v(ctn.unauthleavedatesdisplay);
      //     }
      //     ctn.leaveListName.clear();
      //     ctn.leaveListName.addAll(attLeaveNameModel.values!);
      //   }
      // }
    }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.v(e);
  }
}
