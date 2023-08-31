import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/hw_attachment_model.dart';

class GetHomeworkAttachmentApi {
  GetHomeworkAttachmentApi.init();
  static final GetHomeworkAttachmentApi instance =
      GetHomeworkAttachmentApi.init();

  Future<List<HwAttachmentModelValues>> getHwAttachedFile({
    required int iHwId,
    required int miId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getHwAttachedFile;

    logger.d(api);
    logger.d({
      "IHW_Id": iHwId,
      "MI_Id": miId,
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "IHW_Id": iHwId,
        "MI_Id": miId,
      });

      final HwAttachmentModel hwAttachmentModel =
          HwAttachmentModel.fromJson(response.data['viewhomework']);

      return Future.value(hwAttachmentModel.values);
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      return Future.error({
        "errorTitle": "An Error Incountered",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "An Error Incountered",
        "errorMsg":
            "An Internal error Occurred, while trying to create a view for you",
      });
    }
  }
}
