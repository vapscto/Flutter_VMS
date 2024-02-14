import 'dart:io';

import 'package:dio/dio.dart';
// ignore: implementation_imports
import 'package:http_parser/src/media_type.dart';
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
  required int? hRMDId,
  required String? hRMPRId,
  required String? iSMCIMIEList,
  required int? iSMMCLTId,
  required int? iSMMPRId,
  required int? iSMMTCATId,
  required String? iSMTCRBugOREnhancementFlg,
  required String? iSMTCRCreationDate,
  required String? iSMTCRDesc,
  required String? iSMTCRId,
  required String? iSMTCRStatus,
  required String? iSMTCRTitle,
  required int? iVRMMId,
  required var taskDay,
  required String? timeRequiredFlg,
  required String? yearlyDate,
  required String? assignto,
  required List<AtachmentFile> uploadDocs,
  required double? effortinhrs,
  required String? enddate,
  required String? periodicity,
  required String? remarks,
  required String? roletype,
  required String? startdate,
  required List<Map<String, dynamic>> taskEmpArray,
  required double ismtcrHour,
  required double ismtcrDay,
  required bool ismtcrMainGroupTask,
  required List<Map<String, dynamic>> multiTask,
}) async {
  final Dio ins = getGlobalDio();
  // ignore: prefer_typing_uninitialized_variables
  var dataMap;
  final String apiUrl = base + URLS.saveTaskCreation;
  List<Map<String, dynamic>> att = [];

  List<UploadHwCwModel> uploadAttachment = [];
  logger.d(apiUrl);
  logger.v({
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
    "HRMD_Id": hRMDId,
    "HRMDC_ID": null,
    "ISMMPR_Id": iSMMPRId,
    "IVRMM_Id": iVRMMId,
    "ISMTCR_BugOREnhancementFlg": iSMTCRBugOREnhancementFlg,
    "assignto": assignto,
    "ISMTCR_CreationDate": iSMTCRCreationDate,
    "ISMTCR_Title": iSMTCRTitle,
    "HRMPR_Id": hRMPRId,
    "ISMMTCAT_Id": iSMMTCATId,
    "ISMTCR_Desc": iSMTCRDesc,
    "ISMTCR_Status": "Open",
    "ISMTCRCL_Id": 0,
    "ISMMCLT_Id": iSMMCLTId,
    "attachmentArray": att,
    "ISMTCR_Hours": ismtcrHour,
    "ISMTCR_Days": ismtcrDay,
    "ISMTCR_MainGroupTaskFlg": ismtcrMainGroupTask,
    "MulttaskDepartments": multiTask
  });
  for (var element in controller.addListBrowser) {
    if (element.FileName == "") {
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
      logger.i("001");
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
        "HRMD_Id": hRMDId,
        "HRMDC_ID": null,
        "ISMMPR_Id": iSMMPRId,
        "IVRMM_Id": iVRMMId,
        "ISMTCR_BugOREnhancementFlg": iSMTCRBugOREnhancementFlg,
        "assignto": assignto,
        "ISMTCR_CreationDate": iSMTCRCreationDate,
        "ISMTCR_Title": iSMTCRTitle,
        "HRMPR_Id": hRMPRId,
        "ISMMTCAT_Id": iSMMTCATId,
        "ISMTCR_Desc": iSMTCRDesc,
        "ISMTCR_Status": "Open",
        "ISMTCRCL_Id": 0,
        "ISMMCLT_Id": iSMMCLTId,
        "TimeRequiredFlg": "HOURS",
        "attachmentArray": att,
        "effortinhrs": effortinhrs,
        "enddate": enddate,
        "periodicity": periodicity,
        "remarks": remarks,
        "startdate": startdate,
        "taskEmpArray": taskEmpArray,
        "ISMTCR_Hours": ismtcrHour,
        "ISMTCR_Days": ismtcrDay,
        "ISMTCR_MainGroupTaskFlg": ismtcrMainGroupTask
      };
    } else {
      logger.i("002");
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
        "HRMD_Id": hRMDId,
        "HRMDC_ID": null,
        "ISMMPR_Id": iSMMPRId,
        "IVRMM_Id": iVRMMId,
        "ISMTCR_BugOREnhancementFlg": iSMTCRBugOREnhancementFlg,
        "assignto": assignto,
        "ISMTCR_CreationDate": iSMTCRCreationDate,
        "ISMTCR_Title": iSMTCRTitle,
        "HRMPR_Id": hRMPRId,
        "ISMMTCAT_Id": iSMMTCATId,
        "ISMTCR_Desc": iSMTCRDesc,
        "ISMTCR_Status": "Open",
        "ISMTCRCL_Id": 0,
        "ISMMCLT_Id": iSMMCLTId,
        "TaskDay": taskDay,
        "TimeRequiredFlg": "HOURS",
        "attachmentArray": att,
        "effortinhrs": effortinhrs,
        "enddate": enddate,
        "periodicity": periodicity,
        "remarks": remarks,
        "startdate": startdate,
        "taskEmpArray": taskEmpArray,
        "ISMTCR_Hours": ismtcrHour,
        "ISMTCR_Days": ismtcrDay,
        "ISMTCR_MainGroupTaskFlg": ismtcrMainGroupTask
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
      "HRMD_Id": hRMDId,
      "HRMDC_ID": null,
      "ISMMPR_Id": iSMMPRId,
      "IVRMM_Id": iVRMMId,
      "ISMTCR_BugOREnhancementFlg": iSMTCRBugOREnhancementFlg,
      "assignto": assignto,
      "ISMTCR_CreationDate": iSMTCRCreationDate,
      "ISMTCR_Title": iSMTCRTitle,
      "HRMPR_Id": hRMPRId,
      "ISMMTCAT_Id": iSMMTCATId,
      "ISMTCR_Desc": iSMTCRDesc,
      "ISMTCR_Status": "Open",
      "ISMTCRCL_Id": 0,
      "ISMMCLT_Id": iSMMCLTId,
      "attachmentArray": att,
      "ISMTCR_Hours": ismtcrHour,
      "ISMTCR_Days": ismtcrDay,
      "ISMTCR_MainGroupTaskFlg": ismtcrMainGroupTask,
      "MulttaskDepartments": multiTask
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
