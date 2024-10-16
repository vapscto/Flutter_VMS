import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/cheque_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/company_model.dart';

Future<int> getCompaniesList(
    {required String base, required ChequeController controller,
    required int userId}) async {
  final Dio ins = getGlobalDio();
//  final String apiUrl =
      //"https://vmsstaging.vapssmartecampus.com:40015/api/CheckBookEntryApprovalFacade/getalldata/";
    final String apiUrl = base + URLS.getcmpn;

  logger.d(apiUrl);

  try {
    controller.updateisLoading(true);

    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {"UserId": userId});

    logger.d(response.data['allcompany']);
    if (response.data['allcompany'] == null) {
      controller.updateErrorLoading(true);
      return 0;
    } else if (response.data['allcompany'] != null) {
      controller.updateErrorLoading(false);
      controller.updateisLoading(false);
    }
    CompanyList companyListResponse =
        CompanyList.fromJson(response.data['allcompany']);
    controller.companiesList.addAll(companyListResponse.values!);
    return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoading(true);

    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateErrorLoading(true);

    return 0;
  }
}
