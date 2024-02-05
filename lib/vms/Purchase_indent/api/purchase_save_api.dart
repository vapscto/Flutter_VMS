import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/controller/purchase_controller.dart';

class PurchaseSave {
  PurchaseSave.init();
  static final PurchaseSave instance = PurchaseSave.init();

  purchaseSave({
    required String base,
    required String invmpiRemarks,
    required int totalAppxAmount,
    required List<Map<String, dynamic>> arrayList,
    required int invmpiId,
    required int miId,
    required int userId,
    required int approvecent,
    required PurchaseController controller,
  }) async {
    try {
      var dio = Dio();
      var url = base + URLS.purchaseSaveApi;
      // controller.saveLoading(true);
      var response = await dio.post(
        url,
        options: Options(headers: getSession()),
        data: {
          "INVMPI_Remarks": invmpiRemarks,
          "INVMPI_ApproxTotAmount": totalAppxAmount,
          "arrayPI": arrayList,
          "INVMPI_Id": invmpiId,
          "MI_Id": miId,
          "UserId": userId,
          "approvecnt": approvecent,
        },
      );
      logger.i({
        "INVMPI_Remarks": invmpiRemarks,
        "INVMPI_ApproxTotAmount": totalAppxAmount,
        "arrayPI": arrayList,
        "INVMPI_Id": invmpiId,
        "MI_Id": miId,
        "UserId": userId,
        "approvecnt": approvecent,
      });

      if (response.statusCode == 200) {
        logger.i("=====$response");
        // controller.saveLoading(false);
        // Fluttertoast.showToast(msg: "Update Successfully");
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
