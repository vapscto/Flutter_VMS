import 'package:dio/dio.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';

class ScheduleInterviewAPI {
  ScheduleInterviewAPI.init();
  static final ScheduleInterviewAPI instance = ScheduleInterviewAPI.init();
  var dio = Dio();
  var header = getSession();
}
