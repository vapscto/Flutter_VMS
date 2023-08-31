import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

class ActiveDeactiveApi {
  ActiveDeactiveApi.init();
  static ActiveDeactiveApi instance = ActiveDeactiveApi.init();

  activeDeactiveHwNow({
    required int miId,
    required int ihcId,
    required int flag,
    required String base,
  }) async {
    Dio ins = getGlobalDio();
    final String api = base + URLS.activateDeactiveHw;
    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "IHW_Id": ihcId,
          "IHW_ActiveFlag": flag,
        },
      );
      if (response.data['returnval'] == true) {
        Fluttertoast.showToast(
            msg: flag == 0
                ? "Assignment Deactivated Successfully"
                : "Assignment Activated Successfully");
      } else {
        Fluttertoast.showToast(msg: "Operation Failed to perform");
      }
    } on DioError catch (e) {
      logger.e(e.message);
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "An internal error Occured while trying to make request",
      });
    }
  }

  activeDeactiveCw({
    required int miId,
    required int ihcId,
    required int flag,
    required String base,
  }) async {
    Dio ins = getGlobalDio();
    final String api = base + URLS.activateDeactiveCw;

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ICW_Id": ihcId,
        "ICW_ActiveFlag": flag,
      });

      if (response.data['returnval'] == true) {
        Fluttertoast.showToast(
            msg: flag == 0
                ? "Assignment Deactivated Successfully"
                : "Assignment Activated Successfully");
      }
    } on DioError catch (e) {
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": e.message,
      });
    } on Exception {
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "An internal error occured"
      });
    }
  }
}
