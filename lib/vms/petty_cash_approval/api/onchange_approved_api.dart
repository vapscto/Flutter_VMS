import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/onchange_approved_model.dart';

Future<void> getPcApprovalOnChange(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required PettyCashApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final api =
      "https://vmsstaging.vapssmartecampus.com:40015/api/PC_Indent_ApprovalFacade/OnChangeInstitution";
  logger.d(api);
  logger.d({
          "roleid": roleId,
          "Userid": userId,
          "MI_Id": miId,
          "ASMAY_Id": asmaYId
        });

  try {
    controller.updateisLoadingIndentApprovedDetails(true);

    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {
          "roleid": roleId,
          "Userid": userId,
          "MI_Id": miId,
          "ASMAY_Id": asmaYId
        });
    logger.d(response.data['getloaddata']);
    if (response.data['getloaddata'] == null) {
      controller.updateErrorLoadingIndentApprovedDetails(true);
      // return 0;
    } else if (response.data['getloaddata'] != null) {
      controller.updateErrorLoadingIndentApprovedDetails(false);
      controller.updateisLoadingIndentApprovedDetails(false);
    }
    PCApprovalOnChangeModel organizationListResponse =
        PCApprovalOnChangeModel.fromJson(response.data['getloaddata']);
    controller.pcApprovedList.addAll(organizationListResponse.values!);
    //  return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingIndentApprovedDetails(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
