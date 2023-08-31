import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/coe/controller/coe_data_handler.dart';
import 'package:m_skool_flutter/student/coe/models/coe_data_model.dart';

class GetEventsApi {
  GetEventsApi.init();
  static final GetEventsApi instance = GetEventsApi.init();

  Future<List<CoereportlistValues>> getEvents(
      {required int miId,
      required int amstId,
      required int asmayId,
      required int month,
      required String base,
      required String type,
      required int asmclID}) async {
    final Dio ins = getGlobalDio();
    final String coeApi = base + URLS.coeData;
    // logger.d(
    //   {
    //     "AMST_Id": amstId,
    //     "ASMAY_Id": asmayId,
    //     "MI_Id": miId,
    //     "month": month,
    //   },

    // );

    logger.d(coeApi);
    logger.d({
      "AMST_Id": amstId,
      "ASMAY_Id": asmayId,
      "MI_Id": miId,
      "month": month,
      "ASMCL_Id": asmclID,
      "type": type
    });

    try {
      Response response = await ins.post(
        coeApi,
        options: Options(headers: getSession()),
        data: {
          "AMST_Id": amstId,
          "ASMAY_Id": asmayId,
          "MI_Id": miId,
          "month": month,
          "ASMCL_Id": asmclID,
        },
      );
      final CoeDataModel coeDataModel = CoeDataModel.fromJson(response.data);
      //logger.d(coeDataModel.toJson());
      if (coeDataModel.coereportlist == null ||
          coeDataModel.coereportlist!.values == null) {
        return <CoereportlistValues>[];
      }
      return Future.value(coeDataModel.coereportlist!.values!);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error(
        {
          "errorTitle": "Unable to connect to server",
          "errorMsg":
              "Sorry!! We are unable to connect to server right now.. try again later",
        },
      );
    }
  }

  getCoeData({
    required int miId,
    required int amstId,
    required int asmayId,
    required int month,
    required String base,
    required int asmclID,
    required String roleForLogin,
    required CoeDataHandler coeDataHandler,
  }) async {
    if (coeDataHandler.coeReport.isNotEmpty) {
      coeDataHandler.coeReport.clear();
    }
    //  = await GetAcademicYearApi
    //     .instance
    //     .getAcademicYear(miId: miId, amstId: amstId, base: base);

    coeDataHandler.updateCoeReport(await getEvents(
        miId: miId,
        amstId: amstId,
        asmayId: asmayId,
        month: month,
        base: base,
        asmclID: asmclID,
        type: roleForLogin.toLowerCase() == "staff"
            ? "1"
            : roleForLogin.toLowerCase() == "student"
                ? "2"
                : "3"));

    coeDataHandler.updateShowEventLoading(false);
  }
}
