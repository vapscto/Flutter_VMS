import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/dr_check_list_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/dr_details_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/employee_details.dart';

Future<int> getdrLists({
  required int roleId,
  required int userId,
  required int miId,
  required String base,
  required int hrmdcId,
  required int hrmdesId,
  required int hrmeId,
  required String date,
  required DrDetailsCtrlr controller,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getDrs;

  logger.d(apiUrl);
  logger.d({
    "hrmdc_Id": hrmdcId,
    "hrmdes_Id": hrmdesId,
    "hrme_Id": hrmeId,
    "date": date,
  });
  try {
    controller.drIsLoading(true);

    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": roleId,
      "UserId": userId,
      "MI_Id": miId,
      "DRApprovalTypeFlag": "DRApproval",
      "Fromdate": date,
      "Todate": date,
      "reporttype": "undefined",
      "deptlist": [
        {"HRMDC_ID": hrmdcId}
      ],
      "desglist": [
        {"HRMDES_Id": hrmdesId}
      ],
      "emplist": [
        {"HRME_Id": hrmeId}
      ]
    });
    logger.d({
      "IVRMRT_Id": roleId,
      "UserId": userId,
      "MI_Id": miId,
      "DRApprovalTypeFlag": "DRApproval",
      "Fromdate": date,
      "Todate": date,
      "reporttype": "undefined",
      "deptlist": [
        {"HRMDC_ID": hrmdcId}
      ],
      "desglist": [
        {"HRMDES_Id": hrmdesId}
      ],
      "emplist": [
        {"HRME_Id": hrmeId}
      ]
    });
    if (response.data['getsaveddetails'] == null) {
      controller.drErrorLaodig(true);
    }
    logger.i(response.data['getsaveddetails']);
    logger.v(response.statusCode);
    controller.drIsLoading(false);
    DrDetailModel drList =
        DrDetailModel.fromJson(response.data['getsaveddetails']);
    controller.getList(drList.values!);
    controller.sList.add('Approved');
    controller.sList.add('Rejected');
    GetEmployeeDetail getEmployeeDetail =
        GetEmployeeDetail.fromJson(response.data['filldata']);
    controller.empDetails.addAll(getEmployeeDetail.values!);
    for (int i = 0; i < drList.values!.length; i++) {
      controller.statusET.add(TextEditingController(text: "Select"));

      controller.etMinutesList.add(TextEditingController(
          text: returnHour(drList.values![i].iSMDRPTTimeTakenInHrs!)
              .split(':')[1]));
      controller.etHoursList.add(TextEditingController(
          text: returnHour(drList.values![i].iSMDRPTTimeTakenInHrs!)
              .split(':')[0]));
      controller.etRemakeList.add(TextEditingController(text: "Approved"));
    }

    return response.statusCode!;
  } on DioError catch (e) {
    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());

    return 0;
  }
}

Future<int?> makerCheckerAttachment({
  required Map<String, dynamic> body,
  required String base,
  required DrDetailsCtrlr controller,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getDrCheckList;

  logger.d(apiUrl);
  logger.d({body});
  try {
    controller.imageLoading(true);

    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: body);

    if (response.data['getchecklistarray'] == null) {
      controller.imageLoading(true);
    }
    DrCheckListModel drCheckListModel =
        DrCheckListModel.fromJson(response.data['getchecklistarray']);
    controller.checkList.clear();
    controller.checkList.addAll(drCheckListModel.values!);
    controller.imageLoading(false);

    return response.statusCode!;
  } on DioError catch (e) {
    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());

    return 0;
  }
}
