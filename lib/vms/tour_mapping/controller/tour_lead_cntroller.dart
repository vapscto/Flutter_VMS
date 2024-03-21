import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/tour_paln_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/models/tour_plan_List.dart';

class TourLeadController extends GetxController{
  RxList<TourPlanModelValues> listLeadName =  <TourPlanModelValues>[].obs;
  RxList<TourPlanListModelValues> listTourListName = <TourPlanListModelValues>[].obs;
  RxBool tourLeadNameLoading =RxBool(false);
  RxBool tourLeadListLoading =RxBool(false);
}