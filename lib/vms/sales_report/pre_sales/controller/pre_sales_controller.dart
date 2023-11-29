import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/demo_response_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/product_details_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/sales_list_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/view_lead_model.dart';

class PreSalesController extends GetxController {
  RxBool isPreSalesLoading = RxBool(false);
  void salesLoading(bool loading) {
    isPreSalesLoading.value = loading;
  }

  RxList<PreSalesListModelValues> preSaleList = <PreSalesListModelValues>[].obs;
  RxList<PreSalesListModelValues> filterPreSaleList =
      <PreSalesListModelValues>[].obs;
  void getData(List<PreSalesListModelValues> data) {
    if (preSaleList.isNotEmpty) {
      preSaleList.clear();
    }
    for (int i = 0; i < data.length; i++) {
      preSaleList.add(data.elementAt(i));
    }
  }

  RxList<PreSalesProductModelValues> productListData =
      <PreSalesProductModelValues>[].obs;
  RxBool isProdustDataLoading = RxBool(false);
  void productLoading(bool loading) {
    isProdustDataLoading.value = loading;
  }

  void getProduct(List<PreSalesProductModelValues> product) {
    if (productListData.isNotEmpty) {
      productListData.clear();
    }
    for (int i = 0; i < product.length; i++) {
      productListData.add(product.elementAt(i));
    }
  }

  RxList<ViewLeadModelValues> viewLeadModel = <ViewLeadModelValues>[].obs;
  void getLeadView(List<ViewLeadModelValues> view) {
    if (viewLeadModel.isNotEmpty) {
      viewLeadModel.clear();
    }
    for (int i = 0; i < view.length; i++) {
      viewLeadModel.add(view.elementAt(i));
    }
  }

  RxList<DemoResponseModelValues> demoResponseList =
      <DemoResponseModelValues>[].obs;
  void getDemoResponse(List<DemoResponseModelValues> demoResponse) {
    if (demoResponseList.isNotEmpty) {
      demoResponseList.clear();
    }
    for (int i = 0; i < demoResponse.length; i++) {
      demoResponseList.add(demoResponse.elementAt(i));
    }
  }
}
