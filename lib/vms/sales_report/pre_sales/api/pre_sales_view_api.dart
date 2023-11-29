import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/controller/pre_sales_controller.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/demo_response_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/product_details_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/view_lead_model.dart';

class PreSalesViewAPI {
  PreSalesViewAPI.init();
  static final PreSalesViewAPI instance = PreSalesViewAPI.init();
  preSalesView(
      {required String base,
      required int userId,
      required int miId,
      required int ismsledmId,
      required int hrmrId,
      required int ismsleId,
      required int hrmeId,
      required PreSalesController preSalesController}) async {
    var dio = Dio();
    var api =
        "https://vmsstaging.vapssmartecampus.com:40019/${URLS.priSalesView}";
    try {
      preSalesController.productLoading(true);
      var response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "ISMSLEDM_Id": ismsledmId,
        "HRMR_Id": hrmrId,
        "MI_Id": 17,
        "ISMSLE_Id": ismsleId,
        "HRME_Id": hrmeId,
        "user_id": 60948,
      });
      logger.i({
        "ISMSLEDM_Id": ismsledmId,
        "HRMR_Id": hrmrId,
        "MI_Id": 17,
        "ISMSLE_Id": ismsleId,
        "HRME_Id": hrmeId,
        "user_id": 60948,
      });

      if (response.statusCode == 200) {
        PreSalesProductModel preSalesListModel =
            PreSalesProductModel.fromJson(response.data['product_dd_s']);
        preSalesController.getProduct(preSalesListModel.values!);
        ViewLeadModel viewLeadModel =
            ViewLeadModel.fromJson(response.data['view_lead_demo']);
        preSalesController.getLeadView(viewLeadModel.values!);
        preSalesController.productLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  preSalesViewResponse(
      {required String base,
      required int userId,
      required int miId,
      required int ismsledmId,
      required int hrmrId,
      required int ismsleId,
      required int hrmeId,
      required int viewAll,
      required PreSalesController preSalesController}) async {
    var dio = Dio();
    var api =
        "https://vmsstaging.vapssmartecampus.com:40019/${URLS.priSalesView}";
    try {
      preSalesController.productLoading(true);
      var response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "ISMSLEDM_Id": ismsledmId,
        "HRMR_Id": hrmrId,
        "MI_Id": 17,
        "ISMSLE_Id": ismsleId,
        "HRME_Id": hrmeId,
        "user_id": 60948,
        "viewall": viewAll
      });
      logger.i({
        "ISMSLEDM_Id": ismsledmId,
        "HRMR_Id": hrmrId,
        "MI_Id": 17,
        "ISMSLE_Id": ismsleId,
        "HRME_Id": hrmeId,
        "user_id": 60948,
        "viewall": viewAll
      });

      if (response.statusCode == 200) {
        DemoResponseModel preSalesListModel =
            DemoResponseModel.fromJson(response.data['demo_response_details']);
        preSalesController.getDemoResponse(preSalesListModel.values!);

        preSalesController.productLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
