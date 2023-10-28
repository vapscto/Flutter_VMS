import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/indent_view_data_model.dart';

 getIndentViewData(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,
    required int pcIndentId,
    required PettyIndentApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final api = base + URLS.indentViewData;
  logger.d(api);
  logger.d({
    "MI_Id": miId,
    "roleid": roleId,
    "Userid": userId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag,
    "PCINDENT_Id": pcIndentId
  });

  try {
    controller.updateisLoadingIndentViewData(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "roleid": roleId,
      "Userid": userId,
      "ASMAY_Id": asmaYId,
      "Role_flag": roleFlag,
      "PCINDENT_Id": pcIndentId
    });
    // logger.d(response.data['getviewdata']);
    if (response.data['getviewdata'] == null) {
      controller.updateErrorLoadingIndentViewData(true);
      // return 0;
    } else if (response.data['getviewdata'] != null) {
      controller.updateErrorLoadingIndentViewData(false);
      controller.updateisLoadingIndentViewData(false);
    }
    IndentViewDataModel organizationListResponse =
        IndentViewDataModel.fromJson(response.data['getviewdata']);
    controller.viewDataList.addAll(organizationListResponse.values!);
    //  return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingIndentViewData(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
