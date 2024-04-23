import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_palner_details.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_view_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_accomadation.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_getcategory.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_payment_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_source.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_time_arrry.dart';

class TadaTourController extends  GetxController{
RxList<GetTourViewValues> getTourViewList =  <GetTourViewValues>[].obs;
RxBool viewLoading = RxBool(false);
RxList<GetTourPlanDetailsValues> getTourPlanDetails = <GetTourPlanDetailsValues>[].obs;
RxList<TourMap> planerName = <TourMap>[].obs;
RxList<TadaTimeArrayValues> timeArrayList =<TadaTimeArrayValues>[].obs;
RxList<TadaClientSourcesValues> sourcesList = <TadaClientSourcesValues>[].obs;
RxList<TadaPaymentDetailsModelValues> paymentDetails = <TadaPaymentDetailsModelValues>[].obs;
RxList<TadaAccomodationModelValues> accomdationList = <TadaAccomodationModelValues>[].obs;
RxList<TadaGetCategoryModelValues> getTadaCategory =<TadaGetCategoryModelValues>[].obs;
}

class TourMap{
  String?ieRID;
  String? locationName;
  TourMap(this.ieRID, this.locationName);
}