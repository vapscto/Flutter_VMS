import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// ignore: implementation_imports
import 'package:http_parser/src/media_type.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

import 'package:mime/mime.dart';

Future<String?> securUpload(
    {required String image, required int miId, required String base}) async {
  var url = "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";
  String? mime = lookupMimeType(
    image,
  );
  try {
    FormData formData = FormData.fromMap(
      {
        "MI_Id": miId,
        "File": await MultipartFile.fromFile(
          image,
          contentType: MediaType(mime!.split("/").first, mime.split("/").last),
        ),
      },
    );

    var response = await dio!.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: formData,
    );
    if (response.statusCode == 200) {
      logger.d(response.data);
      var imageUrl = response.data[0]['path'];
      return imageUrl;
    } else {
      return null;
    }
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
