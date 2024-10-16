import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/cash_requisition_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/modal_view_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/view_data_model.dart';

Future<int> getviewdataPcReq(
    {required int miId,
    required String base,
    required int roleId,
    required int userId,
    required int asmaYId,
    required String roleFlag,
    required int pcReqTNid,
    required CashRequisitionController controller}) async {
  final Dio ins = getGlobalDio();
  final api =
      base + URLS.viewDataPcReq;

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


    controller.updateisLoadingViewDataParticular(true);
    
    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
    "roleid": roleId,
    "Userid": userId,
    "MI_Id": miId,
    "ASMAY_Id": asmaYId,
    "Role_flag": roleFlag,
    "PCREQTN_Id": pcReqTNid
    });
    
    
    if (response.data['getviewdata'] == null) {
      controller.updateErrorLoadingViewDataParticular(true);
      return 0;
    }   
    
     ViewDataPcReqModel list =
        ViewDataPcReqModel.fromJson(response.data['getviewdata']);
     controller.getViewDataParticular.addAll(list.values!);



    //   //// MODAL VIEW /////

    //  if (response.data['modalview'] == null) {
    //   controller.updateErrorLoadingModalView(true);
    //   return 0;
    // }   
    
    //  ModalViewPcReqModel modalList =
    //     ModalViewPcReqModel.fromJson(response.data['modalview']);
    //  controller.getData(modalList.values!);


   
     return response.statusCode!;
  } on DioError catch (e) {
    controller.updateErrorLoadingViewDataParticular(true);
    // controller.updateErrorLoadingModalView(true);
      return 0;
  } on Exception catch (e) {
    return 0;
    
  }
}
