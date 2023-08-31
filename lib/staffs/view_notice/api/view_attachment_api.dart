import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/attachment_model.dart';

class ViewAttachmentApi {
  ViewAttachmentApi.init();
  static final ViewAttachmentApi instance = ViewAttachmentApi.init();

  Future<List<AttachmentModelValues>> getAttachment(
      {required int intBId, required String base}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.nB_Attachment;
    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()), data: {"INTB_Id": intBId});

      if (response.data['attachementlist'] == null) {
        return Future.error("No Attachment list found");
      }
      final AttachmentModel attachmentModel =
          AttachmentModel.fromJson(response.data['attachementlist']);

      return Future.value(attachmentModel.values);
    } on DioError catch (e) {
      logger.e(e.message);
      return Future.error(e.message);
    } catch (e) {
      logger.e(e.toString());
      return Future.error("error");
    }
  }
}
