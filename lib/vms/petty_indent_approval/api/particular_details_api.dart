import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/controller/petty_indent_approval_controller.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/model/particular_details_model.dart';

Future<void> particularReqDetails(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,


    required List<Map<String, dynamic>> tempRequisitionId ,



    required PettyIndentApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final api = base + URLS.particularReqDetails;

  //     // Simply map the list of integers to a list of objects
  // final List<Map<String, int>> requisitionIds = tempRequisitionId
  //     .map((id) => {"PCREQTN_Id": id})
  //     .toList();


  logger.d(api);
  logger.d({
    "MI_Id": miId,
    "roleid": roleId,
    "Userid": userId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag,
    "temp_requisitionid": tempRequisitionId,
  });

  try {
    controller.updateisLoadingParticularrequisitiondetais(true);

    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_Id": miId,
      "roleid": roleId,
      "Userid": userId,
      "ASMAY_Id": asmaYId,
      "Role_flag": roleFlag,
      "temp_requisitionid": tempRequisitionId,
    });

    logger.d(response);

    if (response.data['requisitionparticulardetais'] == null) {
      controller.updateErrorLoadingParticularrequisitiondetais(true);
      // return 0;
    } else if (response.data['requisitionparticulardetais'] != null) {
      controller.updateErrorLoadingParticularrequisitiondetais(false);
      controller.updateisLoadingParticularrequisitiondetais(false);
    }
    RequisitionParticularDetailsModel val =
        RequisitionParticularDetailsModel.fromJson(
            response.data['requisitionparticulardetais']);
    controller.particularRequisitionDetais.addAll(val.values!);

    for(int i= 0; i<val.values!.length;i++){
          controller.checkBoxList.add( val.values!.elementAt(i).pcindentdeTActiveFlg!);
          controller.eTapprovalAmount.add(TextEditingController(text:val.values!.elementAt(i).pcindentdeTActiveFlg!? "":"" ));
       }


    // for(int i = 0;i<controller.particularRequisitionDetais.length;i++){
    //   controller.checkBoxList.add(false);
    // }


    controller.updateErrorLoadingParticularrequisitiondetais(false);
  } on DioError catch (e) {
    controller.updateErrorLoadingParticularrequisitiondetais(true);

    logger.e(e.message);
    // return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
