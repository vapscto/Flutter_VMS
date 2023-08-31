import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/cw_student_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/hw_student_attachment_model.dart';

class GetStudentAttachmentApi {
  GetStudentAttachmentApi.init();
  static final GetStudentAttachmentApi instance =
      GetStudentAttachmentApi.init();

  Future<List<CwStuAttachmentModelValues>> getClassWorkUploads({
    required int miId,
    required int loginId,
    required int asmayId,
    required int userId,
    required int amstId,
    required int icwuplId,
    required int icwId,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getCwAttachmentFile;
    try {
      logger.d({
        "MI_Id": miId,
        "Login_Id": loginId,
        "ASMAY_Id": asmayId,
        "userId": userId,
        "AMST_Id": amstId,
        "ICWUPL_Id": icwuplId,
        "ICW_Id": icwId
      });
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "Login_Id": loginId,
        "ASMAY_Id": asmayId,
        "userId": userId,
        "AMST_Id": amstId,
        "ICWUPL_Id": icwuplId,
        "ICW_Id": icwId
      });

      final CwStuAttachmentModel stuAttachmentModel =
          CwStuAttachmentModel.fromJson(response.data['viewstudentupload']);
      return Future.value(stuAttachmentModel.values);
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

  Future<List<HwStuAttachmentModelValues>> getHomeWorkUploads({
    required int miId,
    required int loginId,
    required int asmayId,
    required int userId,
    required int amstId,
    required int iHwuplId,
    required int iHwId,
    required String base,
  }) async {
    String api = base + URLS.getStudentUploadedHw;
    final Dio ins = getGlobalDio();
    logger.d({
      "MI_Id": miId,
      "Login_Id": loginId,
      "ASMAY_Id": asmayId,
      "userId": userId,
      "AMST_Id": amstId,
      "IHWUPL_Id": iHwuplId,
      "IHW_Id": iHwId
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "Login_Id": loginId,
        "ASMAY_Id": asmayId,
        "userId": userId,
        "AMST_Id": amstId,
        "IHWUPL_Id": iHwuplId,
        "IHW_Id": iHwId
      });

      final HwStuAttachmentModel stuAttachmentModel =
          HwStuAttachmentModel.fromJson(response.data['viewstudentupload']);
      return Future.value(stuAttachmentModel.values);
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
