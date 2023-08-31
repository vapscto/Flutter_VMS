import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/institutional_code_model.dart';

class InstitutionalCodeApi {
  InstitutionalCodeApi.init();
  static final InstitutionalCodeApi instance = InstitutionalCodeApi.init();
  final String insApiUrl = URLS.institutionCodeBaseUrl + URLS.getApiUrl;
  Future<InstitutionalCodeModel> loginWithInsCode(
      String insCode, bool isInsCodePresent) async {
    final Dio ins = getGlobalDio();
    // institutionalCode!.delete("institutionalCode");
    try {
      Response response = await ins.post(
        insApiUrl,
        data: {
          "INSTITUTECODE": insCode.trim(),
        },
      );

      // debugPrint("${response.runtimeType}");
      // debugPrint("${response.data['apiarray']}");

      if (response.data['apiarray'] == null) {
        return Future.error({
          "errorTitle": "Incorrect Institutional Code",
          "errorMsg":
              "Sorry! but we are unable to find any institution with this code",
        });
      }

      final InstitutionalCodeModel institutionalCodeModel =
          InstitutionalCodeModel.fromMap(response.data);
      institutionalCookie!
          .put("insCookie", response.headers.map['set-cookie']![0]);

      //Common Ids putting in local;
      if (isInsCodePresent) {
        await importantIds!.put(URLS.miId, institutionalCodeModel.miId);
        await importantIds!.put(URLS.userId, institutionalCodeModel.userId);

        await importantIds!.put(URLS.asmayId, institutionalCodeModel.asmaYId);
        await importantIds!.put(URLS.ivrmrtId, 0);
        await importantIds!.put(URLS.amstId, institutionalCodeModel.amstId);
      }

      debugPrint(response.headers.map.toString());
      return institutionalCodeModel;
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      return Future.error({
        "errorTitle": "Kindly check your Internet Connection",
        "errorMsg":"",
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error({
        "errorTitle": "Unable to process request",
        "errorMsg":
            "Sorry! but we are unable to process right now due to internal error",
      });
    }

    // debugPrint(institutionalCodeModel.toString());
  }
}
