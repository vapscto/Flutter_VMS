import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/homework/model/homework_data_model_values.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';

class GetHomeWorkApi {
  GetHomeWorkApi.init();
  static final GetHomeWorkApi instance = GetHomeWorkApi.init();

  getHomeAssignment({
    required int miId,
    required int asmayId,
    required int amstId,
    required String startDate,
    required String endDate,
    required String baseUrl,
    required HwCwNbController hwCwNbController,
  }) async {
    final Dio dio = getGlobalDio();
    final String apiUrl = baseUrl + URLS.homeWork;
    try {
      hwCwNbController.updateIsErrorHappendInHomeWorkLoading(false);
      hwCwNbController.updateIsHomeWorkLoading(true);
      Response response = await dio
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "INTB_StartDate": startDate,
        "INTB_EndDate": endDate
      });
      logger.d(apiUrl);
      logger.d({
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "INTB_StartDate": startDate,
        "INTB_EndDate": endDate
      });

      final HomeWorkDataModel homeWorkDataModel =
          HomeWorkDataModel.fromJson(response.data['homeworklist']);
      //logger.d(homeWorkDataModel.toJson());
      hwCwNbController.updateHomeWorkDataModel(homeWorkDataModel.values!);
      Future.delayed(const Duration(seconds: 3), () {
        hwCwNbController.updateIsHomeWorkLoading(false);
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      hwCwNbController.updateIsErrorHappendInHomeWorkLoading(true);
    }
  }
}
