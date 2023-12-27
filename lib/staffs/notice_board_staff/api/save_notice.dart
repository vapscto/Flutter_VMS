// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http_parser/src/media_type.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:m_skool_flutter/constants/api_url_constants.dart';
// import 'package:m_skool_flutter/controller/global_utilities.dart';
// import 'package:m_skool_flutter/main.dart';
// import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
// import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
// import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
// import 'package:mime/mime.dart';

// class StaffSaveNoticeApi {
//   StaffSaveNoticeApi.init();
//   static final StaffSaveNoticeApi instance = StaffSaveNoticeApi.init();

//   Future<bool> saveForBoth({
//     required int asmayId,
//     required int userId,
//     required int ivrmrtId,
//     required int miId,
//     required String title,
//     required String description,
//     required String nTBTTSyllabusFlag,
//     required bool displayDisableFlag,
//     required bool toStaffFlag,
//     required bool toStudentFlag,
//     required String displayDate,
//     required String startDate,
//     required String endDate,
//     required HwCwController controller,
//     required NoticeBoardController nbController,
//     required String base,
//   }) async {
//     final Dio ins = getGlobalDio();
//     final String apiUrl = base + URLS.saveNotices;

//     List<UploadHwCwModel> attValues = [];
//     int no = 0;
//     for (XFile? ele in controller.attachment) {
//       no += 1;
//       try {
//         attValues.add(await uploadAtt(miId: miId, file: ele!));
//         controller.updateSaveStatus("Uploading Attachement's $no");
//       } catch (e) {
//         controller.updateIsErrorOccuredSavingHw(true);
//         controller.isSaving.value = false;
//         return Future.error({
//           "errorTitle": "An Error Occured",
//           "errorMsg":
//               "While trying to upload attchement, we encountered an error"
//         });
//       }
//     }

//     for (var element in controller.attFiles) {
//       try {
//         attValues.add(await uploadFiles(miId: miId, file: element));
//         controller.updateSaveStatus("Uploading Attachement's $no");
//       } catch (e) {
//         controller.updateIsErrorOccuredSavingHw(true);
//         controller.isSaving.value = false;
//         return Future.error({
//           "errorTitle": "An Error Occured",
//           "errorMsg":
//               "While trying to upload attchement, we encountered an error"
//         });
//       }
//     }

//     controller.updateSaveStatus(
//         "Please We are sending your notice to both student and employee.. ");

//     List<Map<String, dynamic>> att = [];

//     for (var element in attValues) {
//       att.add({
//         "INTBFL_FilePath": element.path,
//         "FileName": element.name,
//       });
//     }

//     int n = 0;
//     for (var element in controller.textEditors) {
//       n += 1;
//       att.add({
//         "INTBFL_FilePath": element.text,
//         "FileName": "Reference Item $n",
//       });
//     }

//     List<Map<String, dynamic>> sectionListArray = [];
//     List<Map<String, dynamic>> studentArray = [];
//     List<Map<String, dynamic>> classLstTwo = [];

//     for (var element in nbController.selectedSections) {
//       sectionListArray.add({
//         "ASMS_Id": element.asmSId,
//         "ASMCL_Id": element.asmcLId,
//       });
//     }

//     for (var element in nbController.selectedStuden) {
//       studentArray.add({
//         "AMST_Id": element.amsTId,
//       });
//     }

//     for (var element in nbController.selectedClasses) {
//       classLstTwo.add({
//         "ASMCL_Id": element.asmcLId,
//       });
//     }

//     List<Map<String, dynamic>> departmentList = [];
//     List<Map<String, dynamic>> designationList = [];
//     List<Map<String, dynamic>> employeeArrayList = [];

//     for (var element in nbController.selectedDepartment) {
//       departmentList.add({
//         "HRMDC_ID": element.hRMDCID,
//       });
//     }

//     for (var element in nbController.selectedDesignation) {
//       designationList.add({
//         "HRMDES_Id": element.hRMDESId,
//       });
//     }

//     for (var element in nbController.selectedEmployee) {
//       employeeArrayList.add({
//         "HRME_Id": element.hRMEId,
//       });
//     }
//     Map<String, dynamic> both = {
//       "getClass": false,
//       "ASMAY_Id": asmayId,
//       "UserId": userId,
//       "IVRMRT_Id": ivrmrtId,
//       "MI_Id": miId,
//       "INTB_Id": 0,
//       "INTB_Title": title,
//       "INTB_Description": description,
//       "NTB_TTSylabusFlg": nTBTTSyllabusFlag,
//       "INTB_DispalyDisableFlg": displayDisableFlag,
//       "INTB_ToStaffFlg": toStaffFlag,
//       "INTB_ToStudentFlg": toStudentFlag,
//       "INTB_DisplayDate": displayDate,
//       "INTB_StartDate": startDate,
//       "INTB_EndDate": endDate,
//       "sectionlistarray": sectionListArray,
//       "studentarray": studentArray,
//       "classlsttwo": classLstTwo,
//       "departmentlist": departmentList,
//       "designationlist": designationList,
//       "employeearraylist": employeeArrayList,
//       "FilePath_Array": att,
//     };
//     logger.d(both);

//     try {
//       final Response response = await ins.post(
//         apiUrl,
//         options: Options(headers: getSession()),
//         data: both,
//       );

//       if (response.statusCode == 200) {
//         return Future.value(true);
//       }
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     } on DioError catch (e) {
//       logger.e(e.message, e.stackTrace);
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     }
//   }

//   Future<bool> saveForStudent({
//     required int asmayId,
//     required int userId,
//     required int ivrmrtId,
//     required int miId,
//     required String title,
//     required String description,
//     required String nTBTTSyllabusFlag,
//     required bool displayDisableFlag,
//     required bool toStaffFlag,
//     required bool toStudentFlag,
//     required String displayDate,
//     required String startDate,
//     required String endDate,
//     // required List<Map<String, dynamic>> sectionListArray,
//     // required List<Map<String, dynamic>> studentArray,
//     // required List<Map<String, dynamic>> classLstTwo,
//     required NoticeBoardController nbController,
//     required String base,
//     required HwCwController controller,
//   }) async {
//     final Dio ins = getGlobalDio();
//     final String apiUrl = base + URLS.saveNotices;

//     List<UploadHwCwModel> attValues = [];
//     int no = 0;
//     for (XFile? ele in controller.attachment) {
//       no += 1;
//       try {
//         attValues.add(await uploadAtt(miId: miId, file: ele!));
//         controller.updateSaveStatus("Uploading Attachement's $no");
//       } catch (e) {
//         controller.updateIsErrorOccuredSavingHw(true);
//         controller.isSaving.value = false;
//         return Future.error({
//           "errorTitle": "An Error Occured",
//           "errorMsg":
//               "While trying to upload attchement, we encountered an error"
//         });
//       }
//     }

//     for (var element in controller.attFiles) {
//       try {
//         attValues.add(await uploadFiles(miId: miId, file: element));
//         controller.updateSaveStatus("Uploading Attachement's $no");
//       } catch (e) {
//         controller.updateIsErrorOccuredSavingHw(true);
//         controller.isSaving.value = false;
//         return Future.error({
//           "errorTitle": "An Error Occured",
//           "errorMsg":
//               "While trying to upload attchement, we encountered an error"
//         });
//       }
//     }

//     controller
//         .updateSaveStatus("Please We are sending your notice to Students.. ");
//     List<Map<String, dynamic>> att = [];

//     for (var element in attValues) {
//       att.add({
//         "INTBFL_FilePath": element.path,
//         "FileName": element.name,
//       });
//     }

//     int n = 0;
//     for (var element in controller.textEditors) {
//       n += 1;
//       att.add({
//         "INTBFL_FilePath": element.text,
//         "FileName": "Reference Item $n",
//       });
//     }

//     List<Map<String, dynamic>> sectionListArray = [];
//     List<Map<String, dynamic>> studentArray = [];
//     List<Map<String, dynamic>> classLstTwo = [];

//     for (var element in nbController.selectedSections) {
//       sectionListArray.add({
//         "ASMS_Id": element.asmSId,
//         "ASMCL_Id": element.asmcLId,
//       });
//     }

//     for (var element in nbController.selectedStuden) {
//       studentArray.add({
//         "AMST_Id": element.amsTId,
//       });
//     }

//     for (var element in nbController.selectedClasses) {
//       classLstTwo.add({
//         "ASMCL_Id": element.asmcLId,
//       });
//     }

//     Map<String, dynamic> empMap = {
//       "getclass": false,
//       "ASMAY_Id": asmayId,
//       "UserId": userId,
//       "IVRMRT_Id": ivrmrtId,
//       "MI_Id": miId,
//       "INTB_Id": 0,
//       "INTB_Title": title,
//       "INTB_Description": description,
//       "NTB_TTSylabusFlg": nTBTTSyllabusFlag,
//       "INTB_DispalyDisableFlg": displayDisableFlag,
//       "INTB_ToStaffFlg": toStaffFlag,
//       "INTB_ToStudentFlg": toStudentFlag,
//       "INTB_DisplayDate": displayDate,
//       "INTB_StartDate": startDate,
//       "INTB_EndDate": endDate,
//       "sectionlistarray": sectionListArray,
//       "studentarray": studentArray,
//       "classlsttwo": classLstTwo,
//       "FilePath_Array": att,
//       "defarray": null
//     };

//     logger.d(empMap);

//     try {
//       final Response response = await ins.post(
//         apiUrl,
//         options: Options(headers: getSession()),
//         data: empMap,
//       );

//       if (response.statusCode == 200) {
//         return Future.value(true);
//       }
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     } on DioError catch (e) {
//       logger.e(e.message, e.stackTrace);
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     }
//   }

//   Future<bool> saveForEmployee({
//     required int asmayId,
//     required int userId,
//     required int ivrmrtId,
//     required int miId,
//     required String title,
//     required String description,
//     required bool displayDisableFlag,
//     required bool toStaffFlag,
//     required bool toStudentFlag,
//     required String displayDate,
//     required String startDate,
//     required String endDate,
//     required NoticeBoardController nbController,
//     // required List<Map<String, dynamic>> departmentList,
//     // required List<Map<String, dynamic>> designationList,
//     // required List<Map<String, dynamic>> employeeArrayList,
//     required HwCwController controller,
//     required String base,
//   }) async {
//     final Dio ins = getGlobalDio();
//     final String apiUrl = base + URLS.saveNotices;

//     List<UploadHwCwModel> attValues = [];
//     int no = 0;
//     for (XFile? ele in controller.attachment) {
//       no += 1;
//       try {
//         attValues.add(await uploadAtt(miId: miId, file: ele!));
//         controller.updateSaveStatus("Uploading Attachement's $no");
//       } catch (e) {
//         controller.updateIsErrorOccuredSavingHw(true);
//         controller.isSaving.value = false;
//         return Future.error({
//           "errorTitle": "An Error Occured",
//           "errorMsg":
//               "While trying to upload attchement, we encountered an error"
//         });
//       }
//     }

//     for (var element in controller.attFiles) {
//       try {
//         attValues.add(await uploadFiles(miId: miId, file: element));
//         controller.updateSaveStatus("Uploading Attachement's $no");
//       } catch (e) {
//         controller.updateIsErrorOccuredSavingHw(true);
//         controller.isSaving.value = false;
//         return Future.error({
//           "errorTitle": "An Error Occured",
//           "errorMsg":
//               "While trying to upload attchement, we encountered an error"
//         });
//       }
//     }

//     List<Map<String, dynamic>> att = [];

//     for (var element in attValues) {
//       att.add({
//         "INTBFL_FilePath": element.path,
//         "FileName": element.name,
//       });
//     }
//     controller
//         .updateSaveStatus("Please We are sending your notice to employee.. ");
//     int n = 0;
//     for (var element in controller.textEditors) {
//       n += 1;
//       att.add({
//         "INTBFL_FilePath": element.text,
//         "FileName": "Reference Item $n",
//       });
//     }

//     List<Map<String, dynamic>> departmentList = [];
//     List<Map<String, dynamic>> designationList = [];
//     List<Map<String, dynamic>> employeeArrayList = [];

//     for (var element in nbController.selectedDepartment) {
//       departmentList.add({
//         "HRMDC_ID": element.hRMDCID,
//       });
//     }

//     for (var element in nbController.selectedDesignation) {
//       designationList.add({
//         "HRMDES_Id": element.hRMDESId,
//       });
//     }

//     for (var element in nbController.selectedEmployee) {
//       employeeArrayList.add({
//         "HRME_Id": element.hRMEId,
//       });
//     }

//     Map<String, dynamic> empMap = {
//       "getClass": false,
//       "ASMAY_Id": asmayId,
//       "UserId": userId,
//       "IVRMRT_Id": ivrmrtId,
//       "MI_Id": miId,
//       "INTB_Title": title,
//       "INTB_Description": description,
//       "INTB_DispalyDisableFlg": displayDisableFlag,
//       "INTB_ToStaffFlg": toStaffFlag,
//       "INTB_ToStudentFlg": toStudentFlag,
//       "INTBC_ActiveFlag": false,
//       "ASMCL_ActiveFlag": false,
//       "INTB_DisplayDate": displayDate,
//       "INTB_StartDate": startDate,
//       "INTB_EndDate": endDate,
//       "departmentlist": departmentList,
//       "designationlist": designationList,
//       "employeearraylist": employeeArrayList,
//       "FilePath_Array": att,
//     };

//     logger.d(empMap);

//     try {
//       final Response response = await ins.post(
//         apiUrl,
//         options: Options(headers: getSession()),
//         data: empMap,
//       );

//       if (response.statusCode == 200) {
//         return Future.value(true);
//       }
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     } on DioError catch (e) {
//       logger.e(e.message, e.stackTrace);
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       return Future.error({
//         "errorTitle": "An Error Occured",
//         "errorMsg": "While sending notices we encountered an error",
//       });
//     }
//   }

//   Future<UploadHwCwModel> uploadAtt(
//       {required int miId, required XFile file}) async {
//     final Dio ins = getGlobalDio();
//     final String uploadFile =
//         "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";
//     String? mime = lookupMimeType(file.path);
//     try {
//       final Response response = await ins.post(uploadFile,
//           options: Options(headers: getSession()),
//           data: FormData.fromMap(
//             {
//               "MI_Id": miId,
//               "File": await MultipartFile.fromFile(
//                 file.path,
//                 contentType:
//                     MediaType(mime!.split("/").first, mime.split("/").last),
//               )
//             },
//           ));

//       return Future.value(UploadHwCwModel.fromMap(response.data.first));
//     } catch (e) {
//       return Future.error({"error Occured"});
//     }
//   }

//   Future<UploadHwCwModel> uploadFiles(
//       {required int miId, required PlatformFile file}) async {
//     final Dio ins = getGlobalDio();
//     final String uploadFile =
//         "https://bdcampus.azurewebsites.net/${URLS.uploadHomeWorkEnd}";
//     String? mime = lookupMimeType(file.path!);
//     try {
//       final Response response = await ins.post(uploadFile,
//           options: Options(headers: getSession()),
//           data: FormData.fromMap(
//             {
//               "MI_Id": miId,
//               "File": await MultipartFile.fromFile(
//                 file.path!,
//                 contentType:
//                     MediaType(mime!.split("/").first, mime.split("/").last),
//               )
//             },
//           ));

//       return Future.value(UploadHwCwModel.fromMap(response.data.first));
//     } catch (e) {
//       return Future.error({"error Occured"});
//     }
//   }
// }
