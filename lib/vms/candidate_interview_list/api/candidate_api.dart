import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/controller/candidate_controller.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/model/candidate_model.dart';

class CandidateListApi { CandidateListApi.init();
  static final CandidateListApi instance = CandidateListApi.init();
  
  getCandidateListApi({
    required String base,
    required int miId,
    required int userId,
    required CandidateController controller,
  }) async {
    final Dio ins = getGlobalDio();
     String api2 =  base + URLS.candidate;
    try {
      final Response response =
          await ins.post(api2, options: Options(headers: getSession()), data: 
  {
     "MI_Id": miId,
    "UserId": userId,
  });
  logger.w(api2);
  logger.w( {
     "MI_Id": miId,
    "UserId": userId,
  });

      CandidateListModel candidateListModel =
          CandidateListModel.fromJson(response.data['vmsCandidateInterviewList']);
      controller.getcandiateList.addAll(candidateListModel.values!);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
