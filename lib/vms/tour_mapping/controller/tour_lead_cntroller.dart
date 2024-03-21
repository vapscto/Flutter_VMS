import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/model/demo_response_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/status_demo.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/tour_paln_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/tour_plan_List.dart';

class TourLeadController extends GetxController{
  RxList<TourPlanModelValues> listLeadName =  <TourPlanModelValues>[].obs;
  RxList<TourPlanListModelValues> listTourListName = <TourPlanListModelValues>[].obs;
  RxList<DemoResponseModelValues> listDemoRespose = <DemoResponseModelValues>[].obs;
  RxList<StatusDemoModelValues> listDemoStatus = <StatusDemoModelValues>[].obs;
  RxBool tourLeadNameLoading =RxBool(false);
  RxBool tourLeadListLoading =RxBool(false);
  RxList<String> demoDropDown=<String>[].obs;
  RxList<TextEditingController> demoRemarkEdt = <TextEditingController>[].obs;
  RxList<TextEditingController> demoNegotiate = <TextEditingController>[].obs;
  RxList<bool> demoMouList =<bool>[].obs;
  RxList<bool> demoNegotiateList = <bool>[].obs;
  RxList<bool> demoCancelList = <bool>[].obs;
  RxList<bool> checkBoxList=<bool>[].obs;
}