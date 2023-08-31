import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/model/search_result_model.dart';

class SearchStudentApi {
  SearchStudentApi.init();
  static final SearchStudentApi instance = SearchStudentApi.init();

  Future<List<SearchResultModelValues>> getStudents({
    required String base,
    required int miId,
    required List<String> operators,
    required List<String> conditions,
    required List<String> field,
    required List<String> value,
    required String stuStatus,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.searchStudent;
    logger.d(api);
    try {
      logger.d({
        "field": field,
        "Operator": operators,
        "value": value,
        "condition": conditions,
        "MI_Id": miId,
        "stuStatus": stuStatus.toLowerCase()
      });
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "field": field,
          "Operator": operators,
          "value": value,
          "condition": conditions,
          "MI_Id": miId,
          "stuStatus": stuStatus.toLowerCase()
        },
      );
      if (response.data['searchResult'] == null) {
        return Future.error({
          "errorTitle": "Unexpected Error Occured",
          "errorMsg":
              "There is no search result present in db array is not available",
        });
      }

      final SearchResultModel searchResult =
          SearchResultModel.fromJson(response.data['searchResult']);
      return Future.value(searchResult.values);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
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
