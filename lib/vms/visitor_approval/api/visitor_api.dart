import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/visitor_approval/controller/visitor_approval_controller.dart';
import 'package:m_skool_flutter/vms/visitor_approval/model/visitor_approval_model.dart';

class VisitorApprovalApi {
  VisitorApprovalApi.init();

  static final VisitorApprovalApi instance = VisitorApprovalApi.init();

  getVisitorApprovalApi({
    required String base,
    required int userId,
    required int miId,
    required VisitorApprovalController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.visitorapprovalapi;

    if (controller.isErrorOccuredvisitor.value) {
      controller.updateIsErrorOccured(false);
    }

    controller.updateIsLoadingVisitor(true);

    logger.d(api);

    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {"UserId": userId, "MI_Id": miId});

      logger.i({"UserId": userId, "MI_Id": miId});
      logger.d(response.data);

      if (response.data['visitorlist'] != null) {
        controller.updateIsErrorOccured(true);
        controller.updateIsLoadingVisitor(false);
        VisitorApprovalModel visitorApprovalModelValues =
            VisitorApprovalModel.fromJson(response.data['visitorlist']);
        controller.getvisitorList.addAll(visitorApprovalModelValues.values!);
        return;
      }

      controller.updateIsLoadingVisitor(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccured(true);
      controller.updateIsLoadingVisitor(false);
    }
  }
}
