import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_palner_details.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_view_model.dart';

class TadaTourController extends  GetxController{
RxList<GetTourViewValues> getTourViewList =  <GetTourViewValues>[].obs;
RxBool viewLoading = RxBool(false);
RxList<GetTourPlanDetailsValues> getTourPlanDetails = <GetTourPlanDetailsValues>[].obs;
RxList<TourMap> planerName = <TourMap>[].obs;
}

class TourMap{
  String?ieRID;
  String? locationName;
  TourMap(this.ieRID, this.locationName);
}