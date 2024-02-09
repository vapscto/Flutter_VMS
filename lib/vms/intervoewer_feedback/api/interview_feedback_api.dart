import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/intervoewer_feedback/controller/interview_feedback_controller.dart';

class InterviewFeedbackAPI {
  InterviewFeedbackAPI.init();
  static final InterviewFeedbackAPI i = InterviewFeedbackAPI.init();
  onload({
    required String base,
    required InterviewFeedbackController controller,
    required Map<String, dynamic> body,
  }) async {
    logger.i(body);
    var dio = Dio();
    var api = base + URLS.driverIndent;
    try {
      controller.listLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      if (response.statusCode == 200) {
        controller.listLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
