import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/cash_requisition_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/requested_details_pc_model.dart';

Future<void> requestedDetails(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,
    required CashRequisitionController controller}) async {
  final Dio ins = getGlobalDio();
  final String api = base + URLS.departmentonLoadPCRequest;

  logger.d(api);
  logger.d({
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag
  });

  try {
    controller.updateisLoadingRequestedDetails(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "roleid": roleId,
      "Userid": userId,
      "MI_Id": miId,
      "ASMAY_Id": asmaYId,
      "Role_flag": roleFlag
    });

    // print(response.data['getloaddata']);
    // logger.d(response.data['getloaddata']);
    if (response.data['getloaddata'] == null) {
      controller.updateErrorLoadingRequestedDetails(true);
      // return 0;
    } else if (response.data['getloaddata'] != null) {
      controller.updateErrorLoadingRequestedDetails(false);
      controller.updateisLoadingRequestedDetails(false);
      RequestedDetailsPCModel getLoadDataListResponse =
          RequestedDetailsPCModel.fromJson(response.data['getloaddata']);
      controller.getLoadDataList.addAll(getLoadDataListResponse.values!);
    }
  } on DioError catch (e) {
    controller.updateErrorLoadingRequestedDetails(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
