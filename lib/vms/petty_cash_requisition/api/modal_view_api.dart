import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/modal_view_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/modal_view_model.dart';

Future<int> modalViewDetails(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,
    required int pcReqTNid,
    required ModalViewController controller}) async {
  final Dio ins = getGlobalDio();
  final api = base + URLS.viewDataPcReq;

  try {
    logger.d(api);
    logger.d({
      "roleid": roleId,
      "Userid": userId,
      "MI_Id": miId,
      "ASMAY_Id": asmaYId,
      "Role_flag": roleFlag,
      "PCREQTN_Id": pcReqTNid
    });

    controller.updateisLoadingModalView(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "roleid": roleId,
      "Userid": userId,
      "MI_Id": miId,
      "ASMAY_Id": asmaYId,
      "Role_flag": roleFlag,
      "PCREQTN_Id": pcReqTNid
    });

    logger.d(response.data['modalview']);

    // if (response.data['modalview'] == null) {
    //   controller.updateErrorLoadingModalView(true);
    //   return 0;
    // }

    ModalViewPcReqModel modalList =
        ModalViewPcReqModel.fromJson(response.data['modalview']);
    controller.getData(modalList.values!);

    return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingModalView(true);
    logger.i(e.message);
    return 0;
  } on Exception catch (e) {
    logger.i(e.toString());
    return 0;
  }
}
