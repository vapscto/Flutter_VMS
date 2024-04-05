import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/controller/interview_sc_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/model/candidate_list_model.dart';

class InterViewSchduleAPI {
  InterViewSchduleAPI.init();
  static final InterViewSchduleAPI i = InterViewSchduleAPI.init();
  var dio = Dio();
  onLoad(
      {required String base,
      required int miId,
      required InterviewScController controller}) async {
    var api = base + URLS.interviewSchduleOnLoad;
    controller.loading(true);
    var response = await dio.post(api,
        data: {"MI_Id": miId}, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      CandidateListModel candidateListModel =
          CandidateListModel.fromJson(response.data['candidateDetailsList']);
      controller.loading(false);
    }
  }
}
