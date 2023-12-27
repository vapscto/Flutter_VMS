// import 'package:dio/dio.dart';
// import 'package:m_skool_flutter/constants/api_url_constants.dart';
// import 'package:m_skool_flutter/controller/global_utilities.dart';
// import 'package:m_skool_flutter/main.dart';
// import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
// import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_classwork_topic_model.dart';
// import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_homework_topic_model.dart';

// class GetVerifyTopicApi {
//   GetVerifyTopicApi.init();
//   static GetVerifyTopicApi instance = GetVerifyTopicApi.init();

//   getTopicForHw({
//     required int miId,
//     required int asmclId,
//     required int asmsId,
//     // required int ismsId,
//     required int asmayId,
//     required int loginId,
//     required HwCwController controller,
//     required String base,
//   }) async {
//     final Dio ins = getGlobalDio();
//     final String api = base + URLS.getHwTopic;

//     if (controller.isErrorOccuredWhileLoadingTopic.value) {
//       controller.updateIsErrorOccuredWhileLoadingTopic(false);
//     }
//     controller.updateIsTopicLoading(true);
//     logger.d({
//       "ASMAY_Id": asmayId,
//       "ASMCL_Id": asmclId,
//       "ASMS_Id": asmsId,
//       "ISMS_Id": ismsId,
//       "MI_Id": miId.toString(),
//       "Login_Id": loginId.toString()
//     });
//     try {
//       final Response response = await ins.post(
//         api,
//         options: Options(headers: getSession()),
//         data: {
//           "ASMAY_Id": asmayId,
//           "ASMCL_Id": asmclId,
//           "ASMS_Id": asmsId,
//           "ISMS_Id": ismsId,
//           "MI_Id": miId.toString(),
//           "Login_Id": loginId.toString()
//         },
//       );
//       if (response.data['topicList'] == null) {
//         controller.updateHomeworkTopic([]);
//         controller.updateIsTopicLoading(false);
//         return;
//       }
//       final HomeworkTopicModel hwTopic =
//           HomeworkTopicModel.fromJson(response.data['topicList']);

//       List<HomeworkTopicModelValues> hwTopicValues = [];

//       if (hwTopic.values!.isNotEmpty) {
//         hwTopicValues.add(HomeworkTopicModelValues(
//           iHWId: 0,
//           iHWTopic: "Select All",
//         ));
//         controller.updateSelectedHwTopic(hwTopicValues.first);
//       }

//       hwTopicValues.addAll(hwTopic.values!);

//       controller.updateHomeworkTopic(hwTopicValues);
//       controller.updateIsTopicLoading(false);
//     } on DioError catch (e) {
//       logger.e(e.message);
//       logger.e(e.stackTrace);
//       controller.updateIsErrorOccuredWhileLoadingTopic(true);
//       controller.updateIsTopicLoading(false);
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       // logger.e(e.stackTrace);
//       controller.updateIsErrorOccuredWhileLoadingTopic(true);
//       controller.updateIsTopicLoading(false);
//     }
//   }

//   getTopicForCw({
//     required int miId,
//     required int asmclId,
//     required int asmsId,
//     required int ismsId,
//     required int asmayId,
//     required int loginId,
//     required HwCwController controller,
//     required String base,
//   }) async {
//     final Dio ins = getGlobalDio();
//     final String api = base + URLS.getVerifyClassWorkTopic;

//     if (controller.isErrorOccuredWhileLoadingTopic.value) {
//       controller.updateIsErrorOccuredWhileLoadingTopic(false);
//     }
//     controller.updateIsTopicLoading(true);

//     try {
//       logger.d({
//         "ASMAY_Id": asmayId,
//         "ASMCL_Id": asmclId,
//         "ASMS_Id": asmsId,
//         "ISMS_Id": ismsId,
//         "MI_Id": miId.toString(),
//         "Login_Id": loginId.toString()
//       });
//       final Response response = await ins.post(
//         api,
//         options: Options(headers: getSession()),
//         data: {
//           "ASMAY_Id": asmayId,
//           "ASMCL_Id": asmclId,
//           "ASMS_Id": asmsId,
//           "ISMS_Id": ismsId,
//           "MI_Id": miId.toString(),
//           "Login_Id": loginId.toString()
//         },
//       );

//       if (response.data['topicList'] == null) {
//         controller.updateClassworkTopic([]);
//         controller.updateIsTopicLoading(false);
//         return;
//       }
//       final ClassworkTopicModel cwTopic =
//           ClassworkTopicModel.fromJson(response.data['topicList']);

//       List<ClassworkTopicModelValues> cwTopicValues = [];

//       if (cwTopic.values!.isNotEmpty) {
//         cwTopicValues.add(ClassworkTopicModelValues(
//           iCWId: 0,
//           iCWTopic: "Select All",
//         ));

//         controller.updateSelectedCwTopic(cwTopicValues.first);
//       }

//       cwTopicValues.addAll(cwTopic.values!);

//       controller.updateClassworkTopic(cwTopicValues);
//       controller.updateIsTopicLoading(false);
//     } on DioError catch (e) {
//       logger.e(e.message);
//       logger.e(e.stackTrace);
//       controller.updateIsErrorOccuredWhileLoadingTopic(true);
//       controller.updateIsTopicLoading(false);
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       // logger.e(e.stackTrace);
//       controller.updateIsErrorOccuredWhileLoadingTopic(true);
//       controller.updateIsTopicLoading(false);
//     }
//   }
// }
