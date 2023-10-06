import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:mime/mime.dart';

Future<bool> saveTask({
  required typeAssign,
  required String base,
  required TaskDepartController controller,
  required int miId,
  required int? HRMD_Id,
  required String? HRMPR_Id,
  required String? ISMCIM_IEList,
  required int? ISMMCLT_Id,
  required int? ISMMPR_Id,
  required int? ISMMTCAT_Id,
  required String? ISMTCR_BugOREnhancementFlg,
  required String? ISMTCR_CreationDate,
  required String? ISMTCR_Desc,
  required String? ISMTCR_Id,
  required String? ISMTCR_Status,
  required String? ISMTCR_Title,
  required int? IVRMM_Id,
  required String? TaskDay,
  required String? TimeRequiredFlg,
  required String? Yearlydate,
  required String? assignto,
  required List<AtachmentFile> uploadDocs,
  required int? effortinhrs,
  required String? enddate,
  required String? periodicity,
  required String? remarks,
  required String? roletype,
  required String? startdate,
  required List<Map<String, dynamic>> taskEmpArray,
}) async {
  final Dio ins = getGlobalDio();
  var dataMap;
  final String apiUrl = base+URLS.saveTaskCreation;
  List<Map<String, dynamic>> att = [];
  List<UploadHwCwModel> uploadAttachment = [];
   logger.d(apiUrl);
  for (var element in controller.addListBrowser) {
    try {
      uploadAttachment
          .add(await uploadAtt(miId: miId, file: File(element.file!.path)));
    } catch (e) {
      return Future.error({
        "errorTitle": "An Error Occured",
        "errorMsg": "While trying to upload attchement, we encountered an error"
      });
    }
  }
  for (var element in uploadAttachment) {
    att.add(
        {"ISMTCRAT_Attatchment": element.path, "ISMTCRAT_File": element.name});
  }
  if (typeAssign == "Y") {
    dataMap = {
      "MI_Id":miId,
      "UserId":60934,
      "IVRMRT_Id":18,
      "HRMD_Id": HRMD_Id,
      "HRMPR_Id": HRMPR_Id,
      "ISMCIM_IEList": "undefined",
      "ISMMCLT_Id": ISMMCLT_Id,
      "ISMMPR_Id": ISMMPR_Id,
      "ISMMTCAT_Id": ISMMTCAT_Id,
      "ISMTCR_BugOREnhancementFlg": ISMTCR_BugOREnhancementFlg,
      "ISMTCR_CreationDate": ISMTCR_CreationDate,
      "ISMTCR_Desc": ISMTCR_Desc,
      "ISMTCR_Id": "undefined",
      "ISMTCR_Status": "Open",
      "ISMTCR_Title": ISMTCR_Title,
      "IVRMM_Id": IVRMM_Id,
      "TaskDay": TaskDay,
      "TimeRequiredFlg": "HOURS",
      "Yearlydate": "Thu Jan 01 1970",
      "assignto": assignto,
      "attachmentArray": att,
      "effortinhrs": effortinhrs,
      "enddate": enddate,
      "periodicity": periodicity,
      "remarks": remarks,
      "roletype": roletype,
      "startdate": startdate,
      "taskEmpArray": taskEmpArray
    };
     
  } else if (typeAssign == "N") {
    dataMap = {
      "MI_Id":miId,
      "UserId":60934,
      "IVRMRT_Id":18,
      "HRMD_Id": HRMD_Id,
      "HRMPR_Id": HRMPR_Id,
      "ISMCIM_IEList": "undefined",
      "ISMMCLT_Id": ISMMCLT_Id,
      "ISMMPR_Id": ISMMPR_Id,
      "ISMMTCAT_Id": ISMMTCAT_Id,
      "ISMTCR_BugOREnhancementFlg": ISMTCR_BugOREnhancementFlg,
      "ISMTCR_CreationDate": ISMTCR_CreationDate,
      "ISMTCR_Desc": ISMTCR_Desc,
      "ISMTCR_Id": "undefined",
      "ISMTCR_Status": "Open",
      "ISMTCR_Title": ISMTCR_Title,
      "IVRMM_Id": IVRMM_Id,
      "assignto": assignto,
      "attachmentArray": att,
      "roletype": roletype,
    };
    
  }

  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data:  dataMap);
    logger.d(dataMap);
    logger.d(response);
    return true;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
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
