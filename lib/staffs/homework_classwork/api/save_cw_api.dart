import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:mime/mime.dart';

class SaveCwApi {
  SaveCwApi.init();
  static final SaveCwApi instance = SaveCwApi.init();

  Future<bool> save({
    required int miId,
    required int asmayId,
    required int asmclId,
    required int ismsId,
    required String topic,
    required String subTopic,
    required String content,
    required String fromDate,
    required String toDate,
    required HwCwController controller,
    required String base,
    required int userId,
    required int ivrmrtId,
    required int hrmeId,
    required int loginId,
  }) async {
    try {
      final String api = base + URLS.saveCw;
      if (controller.isErrorOccuredSavingHw.value) {
        controller.updateIsErrorOccuredSavingHw(false);
      }
      controller.isSaving.value = true;
      final Dio ins = getGlobalDio();
      List<UploadHwCwModel> attValues = [];
      int no = 0;
      for (XFile? ele in controller.attachment) {
        no += 1;
        try {
          attValues.add(await uploadAtt(miId: miId, file: ele!));
          controller.updateSaveStatus("Uploading Attachement's $no");
        } catch (e) {
          controller.updateIsErrorOccuredSavingHw(true);
          controller.isSaving.value = false;
          return Future.error({
            "errorTitle": "An Error Occured",
            "errorMsg":
                "While trying to upload attchement, we encountered an error"
          });
        }
      }

      for (var element in controller.attFiles) {
        try {
          attValues.add(await uploadFiles(miId: miId, file: element));
          controller.updateSaveStatus("Uploading Attachement's $no");
        } catch (e) {
          controller.updateIsErrorOccuredSavingHw(true);
          controller.isSaving.value = false;
          return Future.error({
            "errorTitle": "An Error Occured",
            "errorMsg":
                "While trying to upload attchement, we encountered an error"
          });
        }
      }

      List<Map<String, dynamic>> att = [];

      for (var element in attValues) {
        att.add({
          "ICW_FilePath": element.path,
          "FileName": element.name,
        });
      }
      int n = 0;
      for (var element in controller.textEditors) {
        n += 1;
        att.add({
          "ICW_FilePath": element.text,
          "FileName": "Reference Item $n",
        });
      }

      List<Map<String, dynamic>> sections = [];
      for (var element in controller.selectedSection) {
        sections.add({
          "ASMS_Id": element.asmSId,
          "ASMC_SectionName": element.asmCSectionName
        });
      }

      Map<String, dynamic> data = {
        "MI_Id": miId,
        "ICW_Topic": topic,
        "ICW_SubTopic": subTopic,
        "ICW_Content": content,
        "ICW_TeachingAid": 0,
        "ICW_ActiveFlag": false,
        "ICW_FromDate": fromDate,
        "ICW_ToDate": toDate,
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "Role_flag": "Staff",
        "IVRMRT_Id": ivrmrtId,
        "ISMS_Id": ismsId,
        "HRME_Id": hrmeId,
        "Login_Id": loginId,
        "ASMCL_Id": asmclId,
        "hm_section_list": sections,
        "ICW_FilePath_Array": att,
      };

      logger.d(data);
      logger.d(api);
      final Response response = await ins.post(api,
          options: Options(headers: getSession()), data: data);

      logger.d(response.data);

      return Future.value(true);
    } on DioError catch (e) {
      logger.e(e.response!.realUri.toString());
      logger.d(e.error);
      logger.e(e.stackTrace);
      return Future.error({
        "errorTitle": "Error Occured Connecting to server",
        "errorMsg": e.message,
      });
    } catch (e) {
      return Future.error({
        "errorTitle": "An Error Occured",
        "errorMsg": "An internal error Occured while saving Assignment",
      });
    }
  }

  Future<UploadHwCwModel> uploadAtt(
      {required int miId, required XFile file}) async {
    final Dio ins = getGlobalDio();
    final String uploadFile =
        "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";

    String? mime = lookupMimeType(file.path);
    if (mime == null) {
      logger.d("mime null");
    }
    try {
      final Response response = await ins.post(uploadFile,
          options: Options(headers: getSession()),
          data: FormData.fromMap(
            {
              "MI_Id": miId,
              "File": await MultipartFile.fromFile(
                file.path,
                contentType:
                    MediaType(mime!.split("/").first, mime.split("/").last),
              )
            },
          ));

      return Future.value(UploadHwCwModel.fromMap(response.data.first));
    } catch (e) {
      return Future.error({"error Occured"});
    }
  }

  Future<UploadHwCwModel> uploadFiles(
      {required int miId, required PlatformFile file}) async {
    final Dio ins = getGlobalDio();
    final String uploadFile =
        "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";

    try {
      String? mime = lookupMimeType(file.path!);
      if (mime == null) {
        logger.d("mime null");
      }
      final Response response = await ins.post(uploadFile,
          options: Options(headers: getSession()),
          data: FormData.fromMap(
            {
              "MI_Id": miId,
              "File": await MultipartFile.fromFile(
                file.path!,
                filename: file.name,
                contentType:
                    MediaType(mime!.split("/").first, mime.split("/").last),
              )
            },
          ));

      return Future.value(UploadHwCwModel.fromMap(response.data.first));
    } catch (e) {
      return Future.error({"error Occured"});
    }
  }
}
