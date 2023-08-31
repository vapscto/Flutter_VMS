import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/cw_attachment_model.dart';

class GetClassworkAttachmentApi {
  GetClassworkAttachmentApi.init();
  static final GetClassworkAttachmentApi instance =
      GetClassworkAttachmentApi.init();

  Future<List<CwAttachmentModelValues>> getAttachedFiles({
    required int miId,
    required int iCwId,
    required int asmayId,
    required int userId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.getCwAttachedFile;
    logger.d(apiUrl);
    logger.d({
      "ICW_Id": iCwId,
      "ASMAY_Id": asmayId,
      "MI_Id": miId,
      "User_Id": userId,
    });

    try {
      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "ICW_Id": iCwId,
        "ASMAY_Id": asmayId,
        "MI_Id": miId,
        "User_Id": userId,
      });

      final CwAttachmentModel cwAttachmentModel =
          CwAttachmentModel.fromJson(response.data['viewhomework']);

      return Future.value(cwAttachmentModel.values);
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
