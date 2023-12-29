import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/controller/gallery_controller.dart';
import 'package:m_skool_flutter/vms/utils/upload_image.dart';
// import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:mime/mime.dart';

class UploadGallery {
  UploadGallery.init();
  static final UploadGallery instance = UploadGallery.init();

  Future<String> upload({
    required int miId,
    required int userId,
    required int asmayId,
    required int ivrmrtId,
    required String roleFlag,
    required int amstId,
    required int asmcelId,
    required String igaGalleryName,
    required String date,
    required String time,
    required String mediatype,
    required StaffGalleryController controller,
    required String base,
  }) async {
    try {
      final String api = base + URLS.uploadGallery;
      if (controller.isErrorOccuredSavingHw.value) {
        controller.updateIsErrorOccuredSavingHw(false);
      }
      controller.isSaving.value = true;
      final Dio ins = getGlobalDio();
      List<UploadHwCwModel> attValues = [];
      int no = 0;
      for (File? ele in mediatype == "I"
          ? controller.selectedMedia
          : controller.selectedVideos) {
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

      List<String> att = [];

      for (var element in attValues) {
        att.add(
          element.path,
        );
      }
      int n = 0;
      for (var element in controller.textEditors) {
        n += 1;
        att.add(
          element.text,
        );
      }

      List<Map<String, dynamic>> sections = [];
      for (var element in controller.selectedSection) {
        sections.add({
          "ASMS_Id": element.asmSId,
        });
      }

      Map<String, dynamic> data = {
        "MI_Id": miId,
        "UserId": userId,
        "ASMAY_Id": asmayId,
        "IVRMRT_Id": ivrmrtId,
        "Role_flag": roleFlag,
        "AMST_Id ": amstId,
        "ASMCL_Id": asmcelId,
        "IGACL_ActiveFlag": false,
        "IGAP_ActiveFlag": false,
        "IGAP_CoverPhotoFlag": true,
        "IGA_ActiveFlag": false,
        "IGA_CommonGalleryFlg": false,
        "IGA_Date ": date,
        "IGA_GalleryName": igaGalleryName,
        "IGA_Id": null,
        "IGA_Time ": time,
        "arraySection": sections,
        "images_list": att,
        "mediatype": mediatype,
        "month": 0,
      };

      logger.d(api);
      logger.d(data);
      final Response response = await ins.post(api,
          options: Options(headers: getSession()), data: data);
      return response.statusCode!.toString();
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
      {required int miId, required File file}) async {
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
