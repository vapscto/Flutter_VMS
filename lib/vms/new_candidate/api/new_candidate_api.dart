import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/new_candidate/controller/new_candidate_controller.dart';
import 'package:m_skool_flutter/vms/new_candidate/model/new_candidate_model.dart';

class NewCandidateListApi {
  NewCandidateListApi.init();
  static final NewCandidateListApi instance = NewCandidateListApi.init();

  getNewCandidateListApi({
    required String base,
    required int miId,
    required NewCandidateController controller,
  }) async {
    final Dio ins = getGlobalDio();
    String api2 = base + URLS.newcandidate;
    try {
      final Response response =
          await ins.post(api2, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
      });
      logger.w(api2);
      logger.w({
        "MI_Id": miId,
      });
      NewCandidateListModel newCandidateListModel =
          NewCandidateListModel.fromJson(response.data['vmsmrfList']);

      controller.getnewcandiateList.clear();
      controller.getnewcandiateList.addAll(newCandidateListModel.values!);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
