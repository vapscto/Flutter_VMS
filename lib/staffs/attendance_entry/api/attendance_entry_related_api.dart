import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/attendanceEntryRecordModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/initialdataModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/periodwiseStudentlistModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/sectionModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/monthwiseStudentListModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/dailyonceAndDailytwiceStudentListModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/subjectModel.dart';

var dio = Dio();
Future<InitialDataModel?> getAttendanceEntryIntialData({
  required int asmayId,
  required int userId,
  required int miId,
  required String username,
  required int roleId,
  required String base,
}) async {
  var url = base + URLS.getAttendanceInitialData;

  logger.d(url);
  logger.d({
    "ASMAY_Id": asmayId,
    "userId": userId,
    "MI_Id": miId,
    "username": username,
    "flag": "staff",
    "roleId": roleId
  });
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "userId": userId,
        "MI_Id": miId,
        "username": username,
        "flag": "staff",
        "roleId": roleId
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

Future<SectionModel?> getSectionData({
  required int asmayId,
  required String asmclId,
  required int miId,
  required String username,
  required int roleId,
  required int userId,
  required String base,
}) async {
  var url = base + URLS.onChangeClass;
  logger.d(asmayId);
  logger.d(asmclId);
  logger.d(miId);
  logger.d(username);
  logger.d(roleId);
  logger.d(userId);

  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "MI_Id": miId,
        "classsecflag": 1,
        "username": username,
        "roleId": roleId,
        "flag": "S",
        "userId": userId
      },
    );
    if (response.statusCode == 200) {
      SectionModel sectionModel = SectionModel.fromJson(response.data);
      return sectionModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<MonthWiseStudentListModel?> getAttendanceDataOnChangeofMonth({
  required int miId,
  required int asmayId,
  required int asmclId,
  required int asmsId,
  required int monthId,
  required String base,
}) async {
  var url = base + URLS.onChangeMonth;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "monthflag": "M",
        "monthflag1": "monthly",
        "monthid": monthId
      },
    );
    if (response.statusCode == 200) {
      MonthWiseStudentListModel studentListModel =
          MonthWiseStudentListModel.fromJson(response.data);
      return studentListModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

// onchange of section to get dailyonce and dailytwice studentlist.

Future<DailyOnceAndDailyTwiceStudentListModel?> onChangeOfSection({
  required int asmayId,
  required int userId,
  required int miId,
  required String username,
  required int roleId,
  required String fromDate,
  required String asmclId,
  required String asmsId,
  required String monthFlag,
  required String monthFlag1,
  required String base,
}) async {
  var url = base + URLS.onChangeClass;
  logger.d(url);
  logger.d(
    {
      "ASMAY_Id": asmayId,
      "userId": userId,
      "MI_Id": miId,
      "username": username,
      "flag": "staff",
      "roleId": roleId,
      "ASA_FromDate": fromDate,
      "ASMCL_Id": asmclId,
      "ASMS_Id": asmsId,
      "checksubject": "1",
      "monthflag": monthFlag,
      "monthflag1": monthFlag1,
    },
  );
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "userId": userId,
        "MI_Id": miId,
        "username": username,
        "flag": "staff",
        "roleId": roleId,
        "ASA_FromDate": fromDate,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "checksubject": "1",
        "monthflag": monthFlag,
        "monthflag1": monthFlag1,
      },
    );
    if (response.statusCode == 200) {
      DailyOnceAndDailyTwiceStudentListModel studentListModel1 =
          DailyOnceAndDailyTwiceStudentListModel.fromJson(response.data);
      return studentListModel1;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

// to get subject list... and studentlist for periodwise attendance entry..

Future<SubjectModel?> onChangeSection({
  required int asmayId,
  required String asmclId,
  required int asmsId,
  required int userId,
  required int miId,
  required String username,
  required int roleId,
  required String base,
}) async {
  var url = base + URLS.onChangeClass;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "classsecflag": "1",
        "userId": userId,
        "MI_Id": miId,
        "username": username,
        "flag": "S",
        "roleId": roleId,
        "checksubject": 1
      },
    );
    if (response.statusCode == 200) {
      SubjectModel subjectModel = SubjectModel.fromJson(response.data);
      return subjectModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<PeriodWiseStudentListModel?> onChangeOfPeriod({
  required int asmayId,
  required int asmclId,
  required int asmsId,
  required int ttmpId,
  required int ismsId,
  required int miId,
  required String fromDate,
  required String base,
}) async {
  var url = base + URLS.onChangePeriod;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASA_FromDate": fromDate,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId.toString(),
        "ASMS_Id": asmsId.toString(),
        "TTMP_Id": ttmpId.toString(),
        "ismS_Id": ismsId.toString(),
        "monthflag": "P",
        "monthflag1": "period",
        "MI_Id": miId
      },
    );
    if (response.statusCode == 200) {
      PeriodWiseStudentListModel periodWiseStudentListModel =
          PeriodWiseStudentListModel.fromJson(response.data);
      return periodWiseStudentListModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<bool> saveAttendanceEntry({
  required Map<String, dynamic> data,
  required String base,
}) async {
  var url = base + URLS.saveAttendanceEntry;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    logger.d(e.toString());
    return false;
  }
}

Future<AttendanceEntryRecordModel?> getAttendanceEntryRecords({
  required String base,
  required int miId,
  required int asmayId,
  required int asmclId,
  required int asmsId,
  required String username,
  required int userId,
  required String attentrytype,
}) async {
  var url = base + URLS.getAttendanceRecord;
  try {
    logger.d(
      {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "username": username,
        "userId": userId,
        "att_entry_type": attentrytype
      },
    );
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "username": username,
        "userId": userId,
        "att_entry_type": attentrytype
      },
    );
    if (response.statusCode == 200) {
      AttendanceEntryRecordModel attendanceEntryRecordModel =
          AttendanceEntryRecordModel.fromJson(response.data);
      return attendanceEntryRecordModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<bool> deleteAttendanceEntryRecord(
    {required String base, required int asaId, required int userId}) async {
  var url = base + URLS.attendanceRecordDelete;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {"ASA_Id": asaId, "userId": userId},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    logger.d(e.toString());
    return false;
  }
}
