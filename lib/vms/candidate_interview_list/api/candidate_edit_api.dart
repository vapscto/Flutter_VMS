import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/controller/candidate_controller.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/model/edit_candidate_model.dart';

class CandidateListDataApi { CandidateListDataApi.init();
  static final CandidateListDataApi instance = CandidateListDataApi.init();
  
  getCandidateListDataApi({
    required String base,
    required int miId,
    required int userId,
    required int id,
    required CandidateController controller,
  }) async {
    final Dio ins = getGlobalDio();
   var api = "$base${URLS.editcandidate}$id";
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: 
  {
     "MI_Id": miId,
    "UserId": userId,
  });
       logger.w(api);
  logger.w( {
     "MI_Id": miId,
    "UserId": userId,
  });
 logger.w(response.data);

 if(response.statusCode == 200) {
     DataChangeCandidateModel dataChangeCandidateModel =
          DataChangeCandidateModel.fromJson(response.data['vmsEditValue']);
          controller.getcandiateeditList.clear();
      controller.getcandiateeditList.addAll(dataChangeCandidateModel.values!);
 }
     
      
 
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
