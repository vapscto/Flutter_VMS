import 'package:dio/dio.dart';
import 'package:m_skool_flutter/model/upload_files_model.dart';

import '../constants/api_url_constants.dart';
import '../controller/global_utilities.dart';

Future<String> uploadFiles({
  required String docFilePath,
  required String bucketName,
}) async {
  var dio = Dio();
  var url = URLS.base + URLS.userPath + URLS.fileUpload;
  Map<String, dynamic> body = {
    "bucketName": bucketName,
    "attachment": await MultipartFile.fromFile(docFilePath,
        filename: docFilePath.split("/").last)
  };
  FormData formData = FormData.fromMap(body);
  try {
    final response = await dio.put(url,
        options: Options(headers: getSession()), data: formData);
    if (response.statusCode == 200) {
      UploadFilesModel uploadFilesModel =
          UploadFilesModel.fromJson(response.data);
      if (uploadFilesModel.data!.responseCode == 109) {
        return uploadFilesModel.data!.attachmentUrl!.first;
      } else {
        return '';
      }
    }
  } catch (e) {
    return '';
  }
  return '';
}
