import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/approved_particular_indent_model.dart';


Future<int> getPcapprovedIndentParticular(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required int pcIndentApproved,
    required int pcIndentId,
    required PettyCashApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final api =
      base + URLS.particularapprovedIndentPC;
  logger.d(base);
  logger.d({
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "PCINDENTAP_Id": pcIndentApproved,
    "PCINDENT_Id": pcIndentId
  });

  try {
    controller.updateisLoadingApprovedParticularIndent(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
     "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "PCINDENTAP_Id":pcIndentApproved,
    "PCINDENT_Id":pcIndentId
    });
     print("${response.data['getviewdata']}");
    if (response.data['getviewdata'] == null) {
      controller.updateErrorLoadingApprovedParticularIndent(true);
      return 0;
    }   
    
     ParticularApprovedIndentModel list =
        ParticularApprovedIndentModel.fromJson(response.data['getviewdata']);
     controller.approvedparticular.addAll(list.values!);
   
     return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingApprovedParticularIndent(true);
      return 0;
  } on Exception catch (e) {
    return 0;
    
  }
}
