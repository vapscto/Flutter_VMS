import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:mime/mime.dart';

Future<bool> saveTask({
  required typeAssign,
  required String base,
  required TaskDepartController controller,
  required DrDetailsCtrlr controllerLoading,
  required Map<String, dynamic> trnsNumConfig,
  required int miId,
  required int userID,
  required int ivrmrtId,
  required int academicYear,
  required int hrme,
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
  required var TaskDay,
  required String? TimeRequiredFlg,
  required String? Yearlydate,
  required String? assignto,
  required List<AtachmentFile> uploadDocs,
  required double? effortinhrs,
  required String? enddate,
  required String? periodicity,
  required String? remarks,
  required String? roletype,
  required String? startdate,
  required List<Map<String, dynamic>> taskEmpArray,
}) async {
  final Dio ins = getGlobalDio();
  var dataMap;
  final String apiUrl = base + URLS.saveTaskCreation;
  List<Map<String, dynamic>> att = [];
  List<UploadHwCwModel> uploadAttachment = [];
  logger.d(apiUrl);

  for (var element in controller.addListBrowser) {
    if (element.FileName == "") {
      print("File not exist");
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
    att.add(
        {"ISMTCRAT_Attatchment": element.path, "ISMTCRAT_File": element.name});
  }
  if (typeAssign == "Y") {
    if (periodicity == "Daily") {
      print("001");
      dataMap = {
        "transnumbconfigurationsettingsss": trnsNumConfig,
        "UserId": userID,
        "Role_flag": "S",
        "roletype": roletype,
        "IVRMRT_Id": ivrmrtId,
        "plannerextapproval": false,
        "plannerMaxdate": "0001-01-01T00:00:00",
        "MI_Id": miId,
        "HRME_Id": hrme,
        "ASMAY_Id": academicYear,
        "HRMD_Id": HRMD_Id,
        "HRMDC_ID": null,
        "ISMMPR_Id": ISMMPR_Id,
        "IVRMM_Id": IVRMM_Id,
        "ISMTCR_BugOREnhancementFlg": ISMTCR_BugOREnhancementFlg,
        "assignto": assignto,
        "ISMTCR_CreationDate": ISMTCR_CreationDate,
        "ISMTCR_Title": ISMTCR_Title,
        "HRMPR_Id": HRMPR_Id,
        "ISMMTCAT_Id": ISMMTCAT_Id,
        "ISMTCR_Desc": ISMTCR_Desc,
        "ISMTCR_Status": "Open",
        "ISMTCRCL_Id": 0,
        "ISMMCLT_Id": ISMMCLT_Id,
        "TimeRequiredFlg": "HOURS",
        "attachmentArray": att,
        "effortinhrs": effortinhrs,
        "enddate": enddate,
        "periodicity": periodicity,
        "remarks": remarks,
        "startdate": startdate,
        "taskEmpArray": taskEmpArray
      };
    } else {
      print("002");
      dataMap = {
        "transnumbconfigurationsettingsss": trnsNumConfig,
        "UserId": userID,
        "Role_flag": "S",
        "roletype": roletype,
        "IVRMRT_Id": ivrmrtId,
        "plannerextapproval": false,
        "plannerMaxdate": "0001-01-01T00:00:00",
        "MI_Id": miId,
        "HRME_Id": hrme,
        "ASMAY_Id": academicYear,
        "HRMD_Id": HRMD_Id,
        "HRMDC_ID": null,
        "ISMMPR_Id": ISMMPR_Id,
        "IVRMM_Id": IVRMM_Id,
        "ISMTCR_BugOREnhancementFlg": ISMTCR_BugOREnhancementFlg,
        "assignto": assignto,
        "ISMTCR_CreationDate": ISMTCR_CreationDate,
        "ISMTCR_Title": ISMTCR_Title,
        "HRMPR_Id": HRMPR_Id,
        "ISMMTCAT_Id": ISMMTCAT_Id,
        "ISMTCR_Desc": ISMTCR_Desc,
        "ISMTCR_Status": "Open",
        "ISMTCRCL_Id": 0,
        "ISMMCLT_Id": ISMMCLT_Id,
        "TaskDay": TaskDay,
        "TimeRequiredFlg": "HOURS",
        "attachmentArray": att,
        "effortinhrs": effortinhrs,
        "enddate": enddate,
        "periodicity": periodicity,
        "remarks": remarks,
        "startdate": startdate,
        "taskEmpArray": taskEmpArray
      };
    }
    logger.d(dataMap);
  } else if (typeAssign == "N") {
    dataMap = {
      "transnumbconfigurationsettingsss": trnsNumConfig,
      "UserId": userID,
      "Role_flag": "S",
      "roletype": roletype,
      "IVRMRT_Id": ivrmrtId,
      "plannerextapproval": false,
      "plannerMaxdate": "0001-01-01T00:00:00",
      "MI_Id": miId,
      "HRME_Id": hrme,
      "ASMAY_Id": academicYear,
      "HRMD_Id": HRMD_Id,
      "HRMDC_ID": null,
      "ISMMPR_Id": ISMMPR_Id,
      "IVRMM_Id": IVRMM_Id,
      "ISMTCR_BugOREnhancementFlg": ISMTCR_BugOREnhancementFlg,
      "assignto": assignto,
      "ISMTCR_CreationDate": ISMTCR_CreationDate,
      "ISMTCR_Title": ISMTCR_Title,
      "HRMPR_Id": HRMPR_Id,
      "ISMMTCAT_Id": ISMMTCAT_Id,
      "ISMTCR_Desc": ISMTCR_Desc,
      "ISMTCR_Status": "Open",
      "ISMTCRCL_Id": 0,
      "ISMMCLT_Id": ISMMCLT_Id,
      "attachmentArray": att
    };
  }

  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: dataMap);
    // logger.d(dataMap);
    logger.d(response.data);
    controllerLoading.updateTabLoading(false);
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
