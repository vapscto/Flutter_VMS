import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';

Future<bool> submitDrs({
  required String base,
  required String date,
  required int userId,
  required int mi_id,
  required int academicYear,
  required String roleflag,
  required int roleId,
  required List<Map<String, dynamic>> selectedemployeedetails,
  required DrDetailsCtrlr controller,
}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.submit;
  logger.d("submit ${apiUrl}");
  // logger.d({
  //     "DRApprovalTypeFlag": "DRApproval",
  //     "Fromdate": date,
  //     "Todate": date,
  //      "UserId": userId,
  //      "MI_Id": mi_id,
  //    "selectedemployeedetails": selectedemployeedetails
  //   });

  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": mi_id,
      "UserId": userId,
      "ASMAY_Id": academicYear,
      "Role_flag": roleflag,
      "IVRMRT_Id": roleId,
      "selectedemployeedetails": selectedemployeedetails,
      "Fromdate": date,
      "Todate": date,
      "DRApprovalTypeFlag": "DRApproval"
    });

    logger.d({
      "MI_Id": mi_id,
      "UserId": userId,
      "ASMAY_Id": academicYear,
      "Role_flag": roleflag,
      "IVRMRT_Id": roleId,
      "selectedemployeedetails": selectedemployeedetails,
      "Fromdate": date,
      "Todate": date,
      "DRApprovalTypeFlag": "DRApproval"
    });
    logger.d(response);
    return true;
  } on DioError catch (e) {
    controller.updateTabLoading(true);

    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    controller.updateTabLoading(true);

    logger.e(e.toString());

    return false;
  }
}
