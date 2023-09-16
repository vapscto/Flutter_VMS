import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/controller/petty_cash_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/model/particular_indent_details_model.dart';

Future<void> getParticularIndentDetails(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required int tempIndentId,
    required PettyCashApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final api =
      base + URLS.particularIndentDetails;
  logger.d(api);
  logger.d({
          "roleid": roleId,
          "Userid": userId,
          "MI_Id": miId,
          "ASMAY_Id": asmaYId,
          "temp_indentid":[
        {"PCINDENT_Id":tempIndentId},
        ]
        });

  try {
    controller.updateisLoadingParticularIndentDetails(true);

    final Response response = await ins.post(api,
        options: Options(headers: getSession()),
        data: {
          "roleid": roleId,
          "Userid": userId,
          "MI_Id": miId,
          "ASMAY_Id": asmaYId,
          "temp_indentid":[
        {"PCINDENT_Id":tempIndentId},
        ]
        });


    logger.d(response.data['indentparticulardetails']);


    if (response.data['indentparticulardetails'] == null) {
      controller.updateErrorLoadingParticularIndentDetails(true);

    } else if (response.data['indentparticulardetails'] != null) {
      controller.updateErrorLoadingParticularIndentDetails(false);
      controller.updateisLoadingParticularIndentDetails(false);
    }


    ParticularIndentDetailsModel dataList =
        ParticularIndentDetailsModel.fromJson(response.data['indentparticulardetails']);
    controller.particularIndentDetails.addAll(dataList.values!);

    for(int i= 0; i<dataList.values!.length;i++){
          controller.checkList.add( dataList.values!.elementAt(i).pcexptRActiveFlg!);
          controller.eTapprovalAmount.add(TextEditingController(text:dataList.values!.elementAt(i).pcexptRActiveFlg!? "":"" ));
       }

  } on DioError catch (e) {
    controller.updateErrorLoadingParticularIndentDetails(true);

    logger.e(e.message);

  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
