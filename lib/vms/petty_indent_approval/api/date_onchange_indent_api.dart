import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/requisition_details_indent_approval_model.dart';

Future<void> getPcIndentApproval(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String fromDate,
    required String toDate,
    required PettyIndentApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final api =
      base + URLS.onChangeIndentDatePC;
  logger.d(api);
  logger.d({
    "MI_Id":miId,
    "PCINDENT_Date_From":fromDate,
    "PCINDENT_Date_To":toDate,
    "roleid":roleId,
    "Userid":userId,
    "ASMAY_Id":asmaYId
    
  });

  try {
    controller.updateisLoadingrequisitiondetais(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: 

      {
     "MI_Id":miId,
    "PCINDENT_Date_From":fromDate,
    "PCINDENT_Date_To":toDate,
    "roleid":roleId,
    "Userid":userId,
    "ASMAY_Id":asmaYId
}
    );

    logger.d(response);

     if (response.data['requisitiondetais'] == null) {
      controller.updateErrorLoadingrequisitiondetais(true);
      // return 0;
    } else if (response.data['requisitiondetais'] != null) {
      controller.updateErrorLoadingrequisitiondetais(false);
      controller.updateisLoadingrequisitiondetais(false);
    }
    RequestIndentDetailsModel val =
        RequestIndentDetailsModel.fromJson(response.data['requisitiondetais']);
    controller.requisitiondetais.addAll(val.values!);
      controller.updateErrorLoadingrequisitiondetais(false);
    

  } on DioError catch (e) {
    controller.updateErrorLoadingrequisitiondetais(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
