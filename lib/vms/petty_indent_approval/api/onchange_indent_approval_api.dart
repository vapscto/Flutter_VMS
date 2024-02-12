import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/on_change_ins_indent_approval_model.dart';

Future<void> getIndentApprovalOnChange(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,
    required PettyIndentApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final api = base + URLS.onChangeIndentapprovalIns;
  logger.d(api);
  logger.d({
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag
  });

  try {
    controller.updateisLoadingOnchangeIndent(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "roleid": roleId,
      "Userid": userId,
      "MI_Id": miId,
      "ASMAY_Id": asmaYId,
      "Role_flag": roleFlag
    });
    // logger.d(response.data['getapproveddata']);
    if (response.data['getapproveddata'] == null) {
      controller.updateErrorLoadingOnchangeIndent(true);
      // return 0;
    } else if (response.data['getapproveddata'] != null) {
      controller.updateErrorLoadingOnchangeIndent(false);
      controller.updateisLoadingOnchangeIndent(false);
    }
    OnChangeInsIndentApprovalModel organizationListResponse =
        OnChangeInsIndentApprovalModel.fromJson(
            response.data['getapproveddata']);
    controller.getapproveddata.addAll(organizationListResponse.values!);
    //  return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingOnchangeIndent(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
