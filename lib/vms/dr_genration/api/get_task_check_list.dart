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
// ignore: implementation_imports
import 'package:http_parser/src/media_type.dart';

Future<CategoryCheckListModel?> getCategoryChecklistDetails(
    {required String base,
    required int ismctrId,
    required int ismmcatId,
    required PlannerDetails controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getTaskCheckList;
  logger.e('=== $apiUrl');
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"ISMMTCAT_Id": ismmcatId, "ISMTCR_Id": ismctrId});
    logger.e({"ISMMTCAT_Id": ismmcatId, "ISMTCR_Id": ismctrId});
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
othersDayTask(
    {required String base,
    required PlannerDetails controller,
    required Map<String, dynamic> body}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.othersDayCount;
  logger.e(apiUrl);
  logger.e(body);
  try {
    var response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: body);
    if (response.statusCode == 200) {
      logger.v(response.data);
      if (response.data['getplannerdetails'] != null) {
        OthersDayPlannedModel checkListModel =
            OthersDayPlannedModel.fromJson(response.data['getplannerdetails']);
        controller.getPlanner(checkListModel.values!);
      }
      // if (response.data['getgenerateddailyreportdetails'] != null) {
      //   GeneratedDrDetailsModel generatedDrDetailsModel =
      //       GeneratedDrDetailsModel.fromJson(
      //           response.data['getgenerateddailyreportdetails']);
      //   controller.generatedDrDetailsModelValues
      //       .addAll(generatedDrDetailsModel.values!);
      // }
      // logger.w(response.data['gettasklist']);
      // if (response.data['gettasklist'] != null) {
      //   GetTaskDrListModel taskDrListModel =
      //       GetTaskDrListModel.fromJson(response.data['gettasklist']);
      //   controller.getTaskDrList.addAll(taskDrListModel.values!);

      //   for (int index = 0; index < taskDrListModel.values!.length; index++) {
      //     var value = taskDrListModel.values!.elementAt(index);
      //     controller.generatedDrDetailsModelValues.value = controller
      //         .generatedDrDetailsModelValues
      //         .where((data) => data.ismdRId == value.iSMDRId)
      //         .toList();
      //     controller.deveationEtField.add(TextEditingController(
      //         text: controller.generatedDrDetailsModelValues.first.ismdRId
      //             .toString()));
      //     List<String> parts =
      //         value.iSMDRPTTimeTakenInHrs.toString().split('.');

      //     String integerPart = parts[0];
      //     String fractionalPart = parts.length > 1 ? parts[1] : "00";
      //     controller.hoursEt.add(TextEditingController(text: integerPart));
      //     controller.minutesEt.add(TextEditingController(text: fractionalPart));
      //     controller.statusEtField
      //         .add(TextEditingController(text: value.iSMDRPTStatus));

      //     controller.etResponse
      //         .add(TextEditingController(text: value.iSMDRPTRemarks));
      //     controller.checkBoxList.add(controller.checkBoxList[index] = true);
      //   }
      // }
    }

    // if (response.data['getplannerdetails'] == null) {
    //   controller.isPopup = true;
    // }
  } on DioError catch (e) {
    logger.e(e.message);
    return null;
  } on Exception catch (e) {
    logger.e(e.toString());
    return null;
  }
}
