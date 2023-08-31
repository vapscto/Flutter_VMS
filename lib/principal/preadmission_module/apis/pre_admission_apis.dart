import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/student_table_model.dart';

class PreAdmissionAPIS {
  static Future<GetStudentTableData> getStudentData({
    required String base,
    required String type,
    required int miId,
    required int asmyId,
    required String fromDate,
    required String toDate,
    required int report,
  }) async {
    var url = base + URLS.studentTable;
    GetStudentTableData studentTableModel = GetStudentTableData();
    try {
      var data = json.encode({
        "type": type, //"yearwise",
        "MI_Id": miId, //4,
        "ASMAY_Id": asmyId, //10137,
        "From_Date": fromDate, //"2023-08-12T05:05:47.477Z",
        "To_Date": toDate, //"2023-08-12T05:05:47.477Z",
        "ReportType": report,
      });
      var response = await Dio()
          .post(url, data: data, options: Options(headers: getSession()));
      logger.e(url);
      logger.i(data);
      logger.d(response.data);
      if (response.statusCode == 200) {
        studentTableModel =
            GetStudentTableData.fromJson(response.data['searchstudentDetails']);
        return studentTableModel;
      }
    } catch (e) {
      logger.e(e);
    }
    return studentTableModel;
  }
}
