import 'dart:io';

import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/health_chequeup/controlers/health_controler.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';

Future<bool> saveHealthCheckUp(
    {required int miId,
    required int userId,
    required int clientId,
    required int hrmEId,
    required String remark,
    required String date,
    required String base,
    required DrDetailsCtrlr loadingCntrl,
    required HealthCheckUpController controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.saveHC;
  logger.e(apiUrl);
  List<Map<String, dynamic>> att = [];
  List<UploadHwCwModel> uploadAttachment = [];

  for (var element in controller.addListBrowser) {
    if (element.FileName == "") {
      logger.d("File not exist");
    } else {
      try {
        uploadAttachment
            .add(await uploadAtt(miId: miId, file: File(element.file!.path)));
      } catch (e) {
        return Future.error({
          "errorTitle": "An Error Occured",
          "errorMsg":
              "While trying to upload attchement, we encountered an error"
        });
      }
    }
  }
  for (var element in uploadAttachment) {
    att.add({
      "filepath": element.path,
      "filename": element.name,
    });
  }
  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "UserId": userId,
      "ISMMCLT_Id": clientId,
      "HRME_Id": hrmEId,
      "Remarks": remark,
      "VisitedDate": date,
      "UploadedFiles": att
    });
    if (response.statusCode == 200) {
      logger.d(response.data);
      //loadingCntrl.updateTabLoading(false);
      return true;
    }
    return false;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e);
    return false;
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
