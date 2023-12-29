import 'dart:io';

import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/category_check_list_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/others_day_planned.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/upload_dr_image.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';

Future<CategoryCheckListModel?> getCategoryChecklistDetails(
    {required String base,
    required int ismctrId,
    required int ismmcatId,
    required PlannerDetails controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getTaskCheckList;
  logger.e(apiUrl);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"ISMMTCAT_Id": ismmcatId, "ISMTCR_Id": ismctrId});
    logger.e(apiUrl);
    CategoryCheckListModel checkListModel = CategoryCheckListModel.fromJson(
        response.data['gettaskcategorychecklist']);

    return checkListModel;
  } on DioError catch (e) {
    logger.e(e.message);
    return null;
  } on Exception catch (e) {
    logger.e(e.toString());
    return null;
  }
}

Future<UploadDrImage> uploadDrImage(
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
    logger.e(response.data);
    return Future.value(UploadDrImage.fromMap(response.data.first));
  } catch (e) {
    return Future.error({e});
  }
}

//
Future<OthersDayPlannedModel?> othersDayTask(
    {required String base,
    required PlannerDetails controller,
    required Map<String, dynamic> body}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getTaskCheckList;
  logger.e(apiUrl);
  logger.e(body);
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: body);
    if (response.data['getplannerdetails'] != null) {
      OthersDayPlannedModel checkListModel =
          OthersDayPlannedModel.fromJson(response.data['getplannerdetails']);
      controller.getPlanner(checkListModel.values!);
      return checkListModel;
    }

    return null;
  } on DioError catch (e) {
    logger.e(e.message);
    return null;
  } on Exception catch (e) {
    logger.e(e.toString());
    return null;
  }
}
