import 'package:dio/dio.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/controller/pick_image_controller.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/images_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/upload_model.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:mime/mime.dart';

class UploadHwAttachment {
  UploadHwAttachment.init();
  static final UploadHwAttachment instance = UploadHwAttachment.init();

  uploadNow({
    required int miId,
    required PickImageController controller,
    required String base,
    required bool forHw,
  }) async {
    final Dio ins = getGlobalDio();

    if (controller.isErrorOccured.value) {
      controller.updateIsErrorOccured(false);
    }

    controller.updateIsUploading(true);
    try {
      final String api = forHw
          ? "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}"
          : "https://bdcampus.azurewebsites.net/${URLS.uploadCwEnd}";

      int index = 1;
      for (ImageModel element in controller.images) {
        String? mime = lookupMimeType(element.xfile.first.path);
        final Response response = await ins.post(
          api,
          options: Options(headers: getSession()),
          data: FormData.fromMap(
            {
              "MI_Id": miId,
              "File": await MultipartFile.fromFile(
                element.xfile.first.path,
                contentType:
                    MediaType(mime!.split("/").first, mime.split("/").last),
              )
            },
          ),
        );
        controller.updateUploadStatus("Uploading File $index");
        controller.addToUpload(UploadAttModel(
            amstId: element.amstId,
            model: UploadHwCwModel.fromMap(response.data.first)));

        logger.d(element.amstId);
        logger.d(response.data);
        index += 1;
      }

      // for (PlatformFile element in controller.platformFile) {
      //   final Response response = await ins.post(
      //     api,
      //     options: Options(headers: getSession()),
      //     data: FormData.fromMap(
      //       {
      //         "MI_Id": miId,
      //         "File": await MultipartFile.fromFile(element.path!)
      //       },
      //     ),
      //   );
      //   controller.updateUploadStatus("Uploading File $index");
      //   controller.addToUpload(UploadHwCwModel.fromJson(response.data));
      //   index += 1;
      // }

      controller.updateIsUploading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      controller.updateIsUploading(false);
      controller.updateUploadStatus(e.message);
      controller.updateIsErrorOccured(true);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsUploading(false);
      controller.updateUploadStatus("Internal Error Occured");
      controller.updateIsErrorOccured(true);
    }
  }
}
