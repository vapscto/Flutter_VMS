// import 'package:dio/dio.dart';
// import 'package:m_skool_flutter/constants/api_url_constants.dart';
// import 'package:m_skool_flutter/controller/global_utilities.dart';
// import 'package:m_skool_flutter/main.dart';
// import 'package:m_skool_flutter/staffs/coe/controller/coe_data_handler.dart';
// import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_session_model.dart';

// class CoeAcademicSession {
//   CoeAcademicSession.init();
//   static final CoeAcademicSession instance = CoeAcademicSession.init();
//   getViewNoticeSession({
//     required int miId,
//     required int asmayId,
//     required int amstId,
//     required String flag,
//     required String base,
//     required CoeDataHandler handler,
//   }) async {
//     if (handler.isErrorOccured.value) {
//       handler.updateIsErrorOccured(false);
//     }
//     handler.updateIsWholePageLoading(true);
//     handler.updateCoeLoadingStatus(handler.loadingAcademicYearString);
//     final String api = base + URLS.viewNoticeGetSession;
//     final Dio ins = getGlobalDio();

//     logger.d(api);

//     logger.d({
//         "MI_Id": miId,
//         "ASMAY_Id": asmayId,
//         "AMST_Id": amstId,
//         "flag": flag,
//       });

//     try {
//       final Response response =
//           await ins.post(api, options: Options(headers: getSession()), data: {
//         "MI_Id": miId,
//         "ASMAY_Id": asmayId,
//         "AMST_Id": amstId,
//         "flag": flag,
//       });

//       final ViewNoticeSessionModel sessionModel =
//           ViewNoticeSessionModel.fromJson(response.data['yearlist']);
//       handler.updateSelectedAcademicYear(sessionModel.values!.first);
//       handler.updateSessions(sessionModel.values!);
//       handler.updateIsAcademicYearLoaded(true);

//       handler.updateIsWholePageLoading(false);
//       handler.updateIsErrorOccured(false);
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       handler.updateIsErrorOccured(true);
//     }
//   }
// }
