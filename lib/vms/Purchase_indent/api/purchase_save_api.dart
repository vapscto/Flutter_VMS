import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/controller/purchase_controller.dart';

class PurchaseSave {
  PurchaseSave.init();
  static final PurchaseSave instance = PurchaseSave.init();

  purchaseSave({
    required String base,
    required String invmpiRemarks,
    required int invmpiAmount,
    required List<Map<String, dynamic>> arrayList,
    required int invmpiId,
    required int miId,
    required int approvecent,
    required PurchaseController controller,
  }) async {
    try {
      var dio = Dio();
      var url =
          'https://vmsstaging.vapssmartecampus.com:40016/api/IndentApprovalFacade/savedetails/';
      controller.saveLoading(true);
      var response = await dio.post(
        url,
        options: Options(headers: getSession()),
        data: {
          "INVMPI_Remarks": invmpiRemarks,
          "INVMPI_ApproxTotAmount": invmpiAmount,
          "arrayPI": arrayList,
          "INVMPI_Id": invmpiId,
          "MI_Id": miId,
          "approvecnt": approvecent,
        },
      );
      logger.i({
        "INVMPI_Remarks": invmpiRemarks,
        "INVMPI_ApproxTotAmount": invmpiAmount,
        "arrayPI": arrayList,
        "INVMPI_Id": invmpiId,
        "MI_Id": miId,
        "approvecnt": approvecent,
      });
      logger.i("=====${response.statusCode}");
      if (response.statusCode == 200) {
        controller.saveLoading(false);
        Fluttertoast.showToast(msg: "Update Successfully");
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
