import 'package:dio/dio.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/student/information/controller/upload_assignment_controller.dart';
import 'package:mime/mime.dart';

class UploadAssignmentApi {
  UploadAssignmentApi.init();
  static final UploadAssignmentApi instance = UploadAssignmentApi.init();

  uploadNow(
      {required int miId,
      required int asmayId,
      required int amstId,
      required int roleId,
      required int userId,
      required int ihwId,
      required List<String> uploadArray,
      required String base,
      required UploadAssignmentController uploadAssignmentController,
      required String type}) async {
    final Dio dio = getGlobalDio();
    String uploadApiUrl = base;
    if (type == "homework") {
      uploadApiUrl += URLS.uploadHomeWork;
    } else {
      uploadApiUrl += URLS.uploadClasswork;
    }

    uploadAssignmentController.updateUploadStatus("pending");

    uploadAssignmentController.updateDesc("Connecting to server....");
    // Uint8List lst = File(uploadArray.first).readAsBytesSync();

    // Map<String, dynamic> uploadAssignmentsMap = {};

    // FormData formData = FormData.fromMap({
    //   "MI_Id":miId,
    //   "File": await MultipartFile.fromFile(uploadArray.first),
    // });

    List<UploadHwCwModel> uploadedData = [];
    String? mime = lookupMimeType(uploadArray.first);
    try {
      for (int i = 0; i < uploadArray.length; i++) {
        uploadAssignmentController
            .updateDesc("Uploading Assignment File ${i + 1}");
        FormData formData = FormData.fromMap({
          "MI_Id": miId,
          "File": await MultipartFile.fromFile(
            uploadArray.first,
            contentType:
                MediaType(mime!.split("/").first, mime.split("/").last),
          ),
        });

        Response response = await dio.post(
          URLS.uploadHomeWorkBase + URLS.uploadHomeWorkEnd,
          options: Options(
            headers: getSession(),
          ),
          data: formData,
        );

        if (response.statusCode != 200) {
          uploadAssignmentController.updateDesc(
              "Sorry but we are unable to upload your assignment,because of server error, try again after some time.");
          uploadAssignmentController.updateDesc("failed");
          return;
        }
        // uploadedData.add();

        uploadedData.add(
          UploadHwCwModel.fromMap(response.data.first),
        );
        uploadAssignmentController
            .updateDesc("Assignment File ${i + 1} uploaded successfully");
      }

      uploadAssignmentController.updateDesc(
          "All Files were Uploaded Successfully.. Sending it to teacher's");
      List<Map<String, dynamic>> uploadArr = [];
      for (int i = 0; i < uploadedData.length; i++) {
        uploadArr.add({
          "Doc_FileName": uploadedData.elementAt(i).name,
          "DCO_Attachment": uploadedData.elementAt(i).path,
        });
      }
      logger.d(uploadedData);

      // logger.d(data);
      Map<String, dynamic> data = {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "UserId": userId,
        "RoleId": roleId,
        "uploaddoc_array": uploadArr
      };
      if (type == "homework") {
        data["IHW_Id"] = ihwId;
      } else {
        data["ICW_Id"] = ihwId;
      }

      logger.d(uploadApiUrl);
      logger.d(data);
      Response response = await dio.post(uploadApiUrl,
          options: Options(headers: getSession()), data: data);

      logger.d(response.statusCode);
      if (response.statusCode != 200) {
        //logger.d(response.data);

        uploadAssignmentController.updateDesc(
            "Sorry but we are unable to send your assignment to teacher, because of server error, try again after some time.");
        uploadAssignmentController.updateUploadStatus("failed");
        return;
      }
      if (response.data['returnval'] == true) {
        uploadAssignmentController
            .updateDesc("We Successfully sent your assignment to teacher.");
        uploadAssignmentController.updateUploadStatus("completed");
        return;
      }
      uploadAssignmentController.updateDesc(
          "Sorry but we are unable to send your assignment to teacher, try again after some time.");
      uploadAssignmentController.updateUploadStatus("failed");
    } on Exception catch (e) {
      logger.e(e.toString());
      uploadAssignmentController.updateDesc(
          "Sorry but we are unable to send your assignment to teacher, because of server error, try again after some time.");
      uploadAssignmentController.updateUploadStatus("failed");
    }
  }
}
