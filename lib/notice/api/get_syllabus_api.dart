import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/notice/model/notice_data_model.dart';

class GetSyllabusApi {
  GetSyllabusApi.init();
  static final GetSyllabusApi instance = GetSyllabusApi.init();

  Future<List<NoticeDataModelValues>> loadSyllabusNotice({
    required int amstId,
    required int miId,
    required int asmayId,
    required int userId,
    required int roleId,
    required String flag,
    required String base,
  }) async {
    final String api = base + URLS.getSyllabusNotice;
    final Dio ins = getGlobalDio();

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "AMST_Id": amstId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "User_Id": userId,
        "roleid": roleId,
        "flag": "S",
        "OnClickOrOnChange": "OnClick",
        "Feecheck": 1,
        "stdupdate": 1,
      });

      if (response.data['noticelist'] == null) {
        return Future.error({
          "errorTitle": "Unexpected Error Occured",
          "errorMsg":
              "There is no syllabus array present ... contact your tech team to add the same",
        });
      }

      final NoticeDataModel noticeDataModel =
          NoticeDataModel.fromJson(response.data['noticelist']);

      return Future.value(noticeDataModel.values);
    } on DioError catch (e) {
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": e.message,
      });
    } catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg":
            "Sorry! but we are unable to connect to server right now, or server returned an error.",
      });
    }
  }
}
