import 'package:dio/dio.dart';
// ignore: implementation_imports
import 'package:http_parser/src/media_type.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/interaction/model/message_model.dart';
import 'package:mime/mime.dart';

var dio = Dio();

Future<MessageModel?> getMessages(
    {required int ismintId,
    required int miId,
    required int asmayId,
    required int userId,
    required String base,
    required int ivrmrtId}) async {
  var url = base + URLS.vmsMessageList;
  logger.d(url);
  logger.d({
    "ISMINT_Id": ismintId,
    "IVRMRT_Id": ivrmrtId,
    "MI_Id": miId,
    "ASMAY_Id": asmayId,
    "UserId": userId
  });
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ISMINTR_Id": ismintId,
        "IVRMRT_Id": ivrmrtId,
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "Role_flag": "S",
      },
    );
    if (response.statusCode == 200) {
      MessageModel messageModel = MessageModel.fromJson(response.data);
      logger.d(messageModel.toJson());
      return messageModel;
    } else {
      return null;
    }
  } catch (e) {
    logger.i(e.toString());
    return null;
  }
}

Future<bool> sendMessage({
  required int miId,
  required int amstId,
  required int asmayId,
  required String message,
  required int istintComposedByFlg,
  required int ismintId,
  required int userId,
  required List<String> image,
  required int roleId,
  required String base,
}) async {
  var url = base + URLS.sendMessage;
  logger.d(url);
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "mI_ID": miId,
        "AMST_Id": amstId,
        "ASMAY_Id": asmayId,
        "ISTINT_Interaction": message,
        "IINTSS_Date": DateTime.now().toIso8601String(),
        "ISTINT_ComposedByFlg": istintComposedByFlg,
        "ISMINT_Id": ismintId,
        "UserId": userId,
        "ISMINT_MACAddress": await getMac(),
        "ISMINT_ISPIPAddress":
            (await getIpAddress() as Map<String, dynamic>)['ip'],
        "IVRMRT_Id": roleId,
        "images_paths": image,
      },
    );
    if (response.statusCode == 200) {
      logger.d('true');
      return true;
    }
    logger.d('false');
    return false;
  } catch (e) {
    logger.e(e.toString());
    return false;
  }
}

Future<String?> jpgToNetworkImageUrl(
    {required String image, required int miId, required String base}) async {
  var url = base + URLS.interactionImageUpload;
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

    var response = await dio.post(
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
