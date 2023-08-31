import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/model/subject_wise_model.dart';

class GetExamDetails {
  GetExamDetails.init();
  static final GetExamDetails instance = GetExamDetails.init();

  Future<List<SubjectWiseDataModelValues>> getDetails({
    required int miId,
    required int emeId,
    required int amstId,
    required int asmayId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.examDetails;

    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "ASMAY_Id": asmayId,
            "EME_Id": emeId,
            "Amst_Id": amstId
          });
      final SubjectWiseDataModel subjectWiseDataModel =
          SubjectWiseDataModel.fromJson(response.data['subwiseexmlist']);
      return Future.value(subjectWiseDataModel.values);
    } on DioError catch (e) {
      logger.e(e.toString());
      logger.e(e.stackTrace);
      logger.e(e.message);
      return Future.error({
        "errorTitle": "Connection Error Occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg":
            "An internal error occured while trying to create a view for you",
      });
    }
  }
}
