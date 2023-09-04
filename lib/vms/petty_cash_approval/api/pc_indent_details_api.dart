import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/indent_details_model.dart';

Future<void> getPcIndentApproval(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String fromDate,
    required String toDate,
    required PettyCashApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  const api =
      "https://vmsstaging.vapssmartecampus.com:40015//api/PC_Indent_ApprovalFacade/onchangedate";
  logger.d(api);
  logger.d({
    "MI_Id":17,
    "PCINDENT_Date_From":fromDate,
    "PCINDENT_Date_To":toDate,
    "roleid":2,
    "Userid":60145,
    "ASMAY_Id":124
    
  });

  try {
    controller.updateisLoadingIndentDetails(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: 

      {
    "MI_Id":17,
    "PCINDENT_Date_From":fromDate,
    "PCINDENT_Date_To":toDate,
    "roleid":2,
    "Userid":60145,
    "ASMAY_Id":124
}
    );

    logger.d(response);

     if (response.data['indentdetails'] == null) {
      controller.updateErrorLoadingIndentDetails(true);
      // return 0;
    } else if (response.data['indentdetails'] != null) {
      controller.updateErrorLoadingIndentDetails(false);
      controller.updateisLoadingIndentDetails(false);
    }
    PcApprovalFromtoDateModel val =
        PcApprovalFromtoDateModel.fromJson(response.data['indentdetails']);
    controller.pcIndentDetails.addAll(val.values!);
      controller.updateErrorLoadingIndentDetails(false);
    

  } on DioError catch (e) {
    controller.updateErrorLoadingIndentDetails(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
