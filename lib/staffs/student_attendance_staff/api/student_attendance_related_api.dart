import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/initialData.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/studentAttendanceDetailModel.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/studentModel.dart';

var dio = Dio();

Future<InitialDataModel?> getStudentAttendanceInitialData({
  required String base,
  required int miId,
  required int asmayId,
  required String username,
  required int roleId,
  required int userId,
}) async {
  var url = base + URLS.getInitialData;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "miid": miId,
        "username": username,
        "userId": userId,
        "roleId": roleId,
        "flag": "S"
      },
    );
    if (response.statusCode == 200) {
      InitialDataModel initialDataModel =
          InitialDataModel.fromJson(response.data);
      return initialDataModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<StudentModel?> getStudentData({
  required int asmayId,
  required int asmclId,
  required int asmsId,
  required int radiotype,
  required String type1,
  required int miId,
  required String base,
}) async {
  var url = base + URLS.getStudentList;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMC_Id": asmsId,
        "radiotype": radiotype,
        "type1": type1,
        "miid": miId,
        "AMC_Id": 0
      },
    );
    if (response.statusCode == 200) {
      StudentModel studentModel = StudentModel.fromJson(response.data);
      return studentModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<StudentAttendanceDetailModel?> getStudentAttendanceDetail({
  required int asmayId,
  required int asmclId,
  required int asmsId,
  required int monthId,
  required int radioType,
  required int datewise,
  required String fromdate,
  required String todate,
  required int type,
  required int amstId,
  required int miId,
  required String base,
}) async {
  var url = base + URLS.getStudentAttendanceDetails;
  logger.d({
    "ASMAY_Id": asmayId,
    "ASMCL_Id": asmclId,
    "ASMC_Id": asmsId,
    "AMM_ID": monthId,
    "radiotype": radioType,
    "datewise": datewise,
    "fromdate": fromdate,
    "todate": todate,
    "type": type,
    "AMST_Id": amstId,
    "miid": miId,
    "AMC_Id": 0
  });
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMC_Id": asmsId,
        "AMM_ID": monthId,
        "radiotype": radioType,
        "datewise": datewise,
        "fromdate": fromdate,
        "todate": todate,
        "type": type,
        "AMST_Id": amstId,
        "miid": miId,
        "AMC_Id": 0
      },
    );
    if (response.statusCode == 200) {
      StudentAttendanceDetailModel studentAttendanceDetailModel =
          StudentAttendanceDetailModel.fromJson(response.data);
      return studentAttendanceDetailModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
