import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/coe/controller/manager_coe_handler.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_event_data_model.dart';

class GetCoeEventsForManagerApi {
  GetCoeEventsForManagerApi.init();
  static final GetCoeEventsForManagerApi instance =
      GetCoeEventsForManagerApi.init();

  getEvents({
    required String base,
    required int miId,
    required String month,
    required int asmayId,
    required int type,
    required String asmsclId,
    required ManagerCoeHandler handler,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getEventForManager;
    logger.d(api);
    if (handler.isErrorOccuredWhileLoadingCoe.value) {
      handler.updateIsErrorOccuredWhileLoadingCoe(false);
    }

    handler.updateIsLoadingCoe(true);
    logger.d({
      "type": type,
      "ASMAY_Id": asmayId,
      "month": month,
      "ASMCL_Id": asmsclId,
      "COEE_EStartDate": "",
      "COEE_EEndDate": "",
      "MI_Id": miId,
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "type": type.toString(),
        "ASMAY_Id": asmayId,
        "month": month,
        "ASMCL_Id": asmsclId,
        "COEE_EStartDate": "",
        "COEE_EEndDate": "",
        "MI_Id": miId,
      });
      if (response.data['coereport'] == null) {
        handler.updateIsErrorOccuredWhileLoadingCoe(true);
        handler.updateStatus(
            "There is no coe available in the database... or it may be deleted");
        handler.updateIsLoadingCoe(false);
        return;
      }
      final CoeDataModel dataModel =
          CoeDataModel.fromJson(response.data['coereport']);
      handler.updateCoeEvent(dataModel.values!);
      handler.updateIsLoadingCoe(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);

      handler.updateIsErrorOccuredWhileLoadingCoe(true);
      handler.updateStatus(e.message);
      handler.updateIsLoadingCoe(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      // logger.e(e.message);

      handler.updateIsErrorOccuredWhileLoadingCoe(true);
      handler.updateStatus(
          "An internal error occured while creating view for you..");
      handler.updateIsLoadingCoe(false);
    }
  }
}
