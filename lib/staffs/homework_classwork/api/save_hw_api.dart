import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/src/media_type.dart';
// import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:mime/mime.dart';

class SaveHwApi {
  SaveHwApi.init();
  static SaveHwApi instance = SaveHwApi.init();

  Future<bool> saveHw({
    required int miId,
    required int asmayId,
    required int asmclId,
    required int ismsId,
    required String topic,
    required String assignment,
    required String date,
    required HwCwController controller,
    required String base,
    required int userId,
    required int ivrmrtId,
    required int hrmeId,
    required int loginId,
  }) async {
    final String apiUrl = base + URLS.saveHw;
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
        "IHW_FilePath": element.path,
        "FileName": element.name,
      });
    }
    int n = 0;
    for (var element in controller.textEditors) {
      n += 1;
      att.add({
        "IHW_FilePath": element.text,
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

    Map<String, dynamic> hwMap = {
      "MI_Id": miId,
      "HRME_Id": hrmeId,
      "Login_Id": loginId,
      "UserId": userId,
      "ivrmrT_Id": ivrmrtId,
      "ASMAY_Id": asmayId,
      "ASMCL_Id": asmclId,
      "ISMS_Id": ismsId,
      "IHW_Topic": topic,
      "IHW_Assignment": assignment,
      "IHW_AssignmentNo": "0",
      "IHW_Date": date,
      "hm_section_list": sections,
      "IHW_FilePath_Array": att,
    };

    logger.d(hwMap);

    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: hwMap);

    logger.d(response.data);

    return Future.value(true);
  }

  Future<UploadHwCwModel> uploadAtt(
      {required int miId, required XFile file}) async {
    final Dio ins = getGlobalDio();
    final String uploadFile =
        "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";

    try {
      logger.d(file.name);
      String? mime = lookupMimeType(file.path);
      if (mime == null) {
        logger.d("mime null");
      }
      final Response response = await ins.post(uploadFile,
          options: Options(headers: getSession()),
          data: FormData.fromMap(
            {
              "MI_Id": miId,
              "File": await MultipartFile.fromFile(
                file.path,
                filename: file.name,
                contentType:
                    MediaType(mime!.split("/").first, mime.split("/").last),
              )
            },
          ));

      return Future.value(UploadHwCwModel.fromMap(response.data.first));
    } catch (e) {
      logger.e(e.toString());
      return Future.error({"error Occured"});
    }
  }

  Future<UploadHwCwModel> uploadFiles(
      {required int miId, required PlatformFile file}) async {
    final Dio ins = getGlobalDio();
    final String uploadFile =
        "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";
    String? mime = lookupMimeType(file.path!);
    try {
      final Response response = await ins.post(uploadFile,
          options: Options(headers: getSession()),
          data: FormData.fromMap(
            {
              "MI_Id": miId,
              "File": await MultipartFile.fromFile(
                file.path!,
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
