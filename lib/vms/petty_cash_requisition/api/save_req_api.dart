import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<int> saveRequisitionApi({
  required String base,
  required int userId,
  required int roleId,
  required int miId,
  required int asmayId,
  required String roleFlag,
  required int hrmDId,
  required int pcReqId,
  required int hrmEId,
  required String reqPurpose,
  required double reqTotalAmount,
  required String reqDate,

  

   required List<Map<String, dynamic>> reqDetailsDTOList,
}) async {
  final Dio ins = getGlobalDio();
    String apiUrl =
      base + URLS.reqDetailsSaveRecord;

  logger.d(apiUrl);
  logger.d({
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmayId,
    "Role_flag": roleFlag,
    "HRMD_Id": hrmDId,
    "PCREQTN_Id": pcReqId,
    "HRME_Id": hrmEId,
    "PCREQTN_Purpose": reqPurpose,
    "PCREQTN_TotAmount": reqTotalAmount,
    "PCREQTN_Date": reqDate,
    "PC_Requisition_DetailsDTO": reqDetailsDTOList


});

  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmayId,
    "Role_flag": roleFlag,
    "HRMD_Id": hrmDId,
    "PCREQTN_Id": pcReqId,
    "HRME_Id": hrmEId,
    "PCREQTN_Purpose": reqPurpose,
    "PCREQTN_TotAmount": reqTotalAmount,
    "PCREQTN_Date": reqDate,
    "PC_Requisition_DetailsDTO": reqDetailsDTOList


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

