import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/classwork_attachment_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/model/homework_attachment_model.dart';

class GetAttachmentApi {
  GetAttachmentApi.init();
  static final GetAttachmentApi instance = GetAttachmentApi.init();

  Future<List<HomeWorkAttachmentModelValues>> getHomeWorkAttachment({
    required int ihwId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getHwAttachment;
    logger.d(api);
    logger.d({
      "IHW_Id": ihwId,
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "IHW_Id": ihwId,
      });

      final HomeWorkAttachmentModel att =
          HomeWorkAttachmentModel.fromJson(response.data['attachementlist']);

      return Future.value(att.values);
    } on DioError catch (e) {
      logger.e(e.message);
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "An internal error occured while creating your view",
      });
    }
  }

  Future<List<ClassWorkAttachmentModelValues>> getClassWorkAttachment({
    required int icwId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getCwAttachment;

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "ICW_Id": icwId,
      });

      final ClassWorkAttachmentModel att =
          ClassWorkAttachmentModel.fromJson(response.data['attachementlist']);

      return Future.value(att.values);
    } on DioError catch (e) {
      logger.e(e.message);
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "An internal error occured while creating your view",
      });
    }
  }
}
