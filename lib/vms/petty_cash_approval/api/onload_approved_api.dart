import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/onload_approved_model.dart';

Future<void> getPcApprovalOnload(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required PettyCashApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  // final String api = base + URLS.pcApprovalOnload;
  final api = base + URLS.onLoadPcApproval;
  logger.d(base);
  
  logger.d(
      {"roleid": roleId, "Userid": userId, "MI_Id": miId, "ASMAY_Id": asmaYId});

  try {
    controller.updateisLoadingOnloadorganization(true);

    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {
          "roleid": roleId,
          "Userid": userId,
          "MI_Id": miId,
          "ASMAY_Id": asmaYId
        });
    print(response.data['getuserinstitution']);
    logger.d(response.data['getuserinstitution']);
    if (response.data['getuserinstitution'] == null) {
      controller.updateErrorLoadingOnloadorganization(true);
      // return 0;
    } else if (response.data['getuserinstitution'] != null) {
      controller.updateErrorLoadingOnloadorganization(false);
      controller.updateisLoadingOnloadorganization(false);
      PCApprovalOnloadModel organizationListResponse =
          PCApprovalOnloadModel.fromJson(response.data['getuserinstitution']);
      controller.organizationList.addAll(organizationListResponse.values!);
    }

    //  return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingOnloadorganization(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
