import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/dr_details_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/employee_details.dart';

Future<int> getdrLists({
  required int roleId,
  required int userId,
  required int mi_id,
  required String base,
  required int hrmdc_Id,
  required int hrmdes_Id,
  required int hrme_Id,
  required String date,
  required DrDetailsCtrlr controller,
}) async {
  final Dio ins = getGlobalDio();
  String apiUrl = base + URLS.getDrs;

  logger.d(apiUrl);
  logger.d({
    "hrmdc_Id": hrmdc_Id,
    "hrmdes_Id": hrmdes_Id,
    "hrme_Id": hrme_Id,
    "date": date,
  });
  try {
    controller.drIsLoading(true);

    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": roleId,
      "UserId": userId,
      "MI_Id": mi_id,
      "DRApprovalTypeFlag": "DRApproval",
      "Fromdate": date,
      "Todate": date,
      "reporttype": "undefined",
      "deptlist": [
        {"HRMDC_ID": hrmdc_Id}
      ],
      "desglist": [
        {"HRMDES_Id": hrmdes_Id}
      ],
      "emplist": [
        {"HRME_Id": hrme_Id}
      ]
    });
    logger.d({
      "IVRMRT_Id": roleId,
      "UserId": userId,
      "MI_Id": mi_id,
      "DRApprovalTypeFlag": "DRApproval",
      "Fromdate": date,
      "Todate": date,
      "reporttype": "undefined",
      "deptlist": [
        {"HRMDC_ID": hrmdc_Id}
      ],
      "desglist": [
        {"HRMDES_Id": hrmdes_Id}
      ],
      "emplist": [
        {"HRME_Id": hrme_Id}
      ]
    });
    if (response.data['getsaveddetails'] == null) {
      controller.drErrorLaodig(true);
    }
    print(response.data['getsaveddetails']);
    print(response.statusCode);
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
      String str = drList.values![i].iSMDRPTTimeTakenInHrs!.toString();

      controller.etMinutesList.add(TextEditingController(
          text:
              "${drList.values![i].iSMDRPTTimeTakenInHrs!.toString().split('.')[1]} "));
      controller.etHoursList.add(TextEditingController(
          text:
              "${drList.values![i].iSMDRPTTimeTakenInHrs!.toInt().toString().padLeft(2, '0')} "));
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
