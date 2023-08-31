import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/controller/class_teacher_controller.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/model/class_teacher_model.dart';

Future<void> getClassTeacherList(
    {required int mIID,
    required int asmayId,
    required String base,
    required ClassTeacherController controller}) async {
  final String api = base + URLS.classTeacherList;
  final Dio ins = getGlobalDio();
  logger.d(api);
  logger.d({"MI_Id": mIID, "ASMAY_Id": asmayId, "Flag": controller.grpOrInd});
  var flag = controller.grpOrInd;
  var data = json
      .encode({"MI_Id": mIID, "ASMAY_Id": asmayId, "Flag": flag.toString()});

  try {
    final Response response = await ins.post(api,
        options: Options(headers: getSession()), data: data);
    logger.d(response.data["searchstudentDetails"]);

    final ClassTeacherListModel classTeacherList =
        ClassTeacherListModel.fromJson(response.data['searchstudentDetails']);

    controller.classTeacherList.addAll(classTeacherList.values!);
  } on Exception catch (e) {}
}
