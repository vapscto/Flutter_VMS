import 'package:dio/dio.dart';
// import 'package:m_skool_flutter/apis/authentication_api.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/security/controller/security_controller.dart';
import 'package:m_skool_flutter/vms/security/model/model.dart';

Future<int> feacthSecurityApi({
  required String base,
  required int ivrmrtId,
  required int userId,
  required int miId,
  required LoginSuccessModel loginSuccessModel,
  required SecurtyWorkController controller,
}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.security;
  logger.d("damn $apiUrl");
  logger.d({
    "UserId": loginSuccessModel.userId,
    "MI_Id": loginSuccessModel.mIID,
    "IVRMRT_Id": loginSuccessModel.roleId,
    "ASMAY_Id": loginSuccessModel.asmaYId,
  });
  try {
    controller.updateLoading(true);

    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "UserId": loginSuccessModel.userId,
      "MI_Id": loginSuccessModel.mIID,
      "IVRMRT_Id": loginSuccessModel.roleId,
      "ASMAY_Id": loginSuccessModel.asmaYId,
    });

    QRcodeActivityDetails qrDetails =
        QRcodeActivityDetails.fromJson(response.data['qRcodeActivityDetails']);
    logger.w(response.data['qRcodeActivityDetails']);
    controller.securtyWorkList.addAll(qrDetails.values!);
    controller.updateLoading(false);
    for (int i = 0; i < qrDetails.values!.length; i++) {
      controller.checkBox.add(true);
    }

    return response.statusCode!;
  } on DioError catch (e) {
    controller.updateError(true);

    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateError(true);

    return 0;
  }
}
