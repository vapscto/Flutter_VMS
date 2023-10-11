import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<int> approveApi({
  required String base,
  required int userId,
  required int roleId,
  required int miId,
  required int asmayId,
  required int pcIndentId,
  required String pcIndentNo,
  required String pcIndentDesc,
  required double pcIndentSanctionedAmt,
  required double pcIndentRequestedAmt,
  required String pcIndentDate,

   required List<Map<String, dynamic>> featchList,
}) async {
  final Dio ins = getGlobalDio();
    String apiUrl =
      base + URLS.saveRecordPC;

  logger.d(apiUrl);
  logger.d({
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmayId,
    "PCINDENT_Id": pcIndentId,
    "PCINDENTAPT_IndentNo": pcIndentNo,
    "PCINDENTAPT_Desc": pcIndentDesc,
    "PCINDENTAPT_SanctionedAmt": pcIndentSanctionedAmt,
    "PCINDENTAPT_RequestedAmount": pcIndentRequestedAmt,
    "PCINDENTAPT_Date": pcIndentDate,
    "PC_Indent_Approved_Details_DTO": featchList


});

  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmayId,
    "PCINDENT_Id": pcIndentId,
    "PCINDENTAPT_IndentNo": pcIndentNo,
    "PCINDENTAPT_Desc": pcIndentDesc,
    "PCINDENTAPT_SanctionedAmt": pcIndentSanctionedAmt,
    "PCINDENTAPT_RequestedAmount": pcIndentRequestedAmt,
    "PCINDENTAPT_Date": pcIndentDate,
    "PC_Indent_Approved_Details_DTO": featchList


}
          );
     return response.statusCode!;
  } on DioError catch (e) {
    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());

    return 0;
  }
}

