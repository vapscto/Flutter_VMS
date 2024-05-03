import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/clientLead_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_planerdata.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_palner_details.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_view_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_accomadation.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_getcategory.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_payment_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_source.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_time_arrry.dart';

class TadaTourController extends GetxController {
  RxList<GetTourViewValues> getTourViewList = <GetTourViewValues>[].obs;
  RxBool viewLoading = RxBool(false);
  RxList<GetTourPlanDetailsValues> getTourPlanDetails =
      <GetTourPlanDetailsValues>[].obs;
  RxList<TourMap> planerName = <TourMap>[].obs;
  RxList<TadaTimeArrayValues> timeArrayList = <TadaTimeArrayValues>[].obs;
  RxList<TadaClientSourcesValues> sourcesList = <TadaClientSourcesValues>[].obs;
  RxList<TadaPaymentDetailsModelValues> paymentDetails =
      <TadaPaymentDetailsModelValues>[].obs;
  RxList<TadaAccomodationModelValues> accomdationList1 =
      <TadaAccomodationModelValues>[].obs;
  RxList<TadaGetCategoryModelValues> getTadaCategory =
      <TadaGetCategoryModelValues>[].obs;
  RxList<TadaPlanerDataValues> getPlanerListData = <TadaPlanerDataValues>[].obs;
  RxList<TextEditingController> percentageET = <TextEditingController>[].obs;
  RxList<TextEditingController> sancationAmountEt =
      <TextEditingController>[].obs;
  RxList<TextEditingController> approvalRemarkEt =
      <TextEditingController>[].obs;
  RxString totalSamount = "".obs;
  RxBool showTable = RxBool(false);
  RxList<bool> checkBoxList  =  <bool>[].obs;
  RxList<LeadsModelValues> leadsList = <LeadsModelValues>[].obs;
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxList<LeadsModelValues> leadList = <LeadsModelValues>[].obs;
  Rx<TextEditingController> sancationAmountTotal =
      TextEditingController(text: "").obs;
  RxList<Item> radioItems = <Item>[].obs;
       
  RxInt approvedCount = 0.obs;
  RxInt rejectedCount = 0.obs;
  RxInt adminTotal =0.obs;
   RxList<DataColumn> columns =<DataColumn>[].obs;
  RxList<DataCell> rows = <DataCell>[].obs;
  RxList<DataColumn> sourceColumns = <DataColumn>[].obs;
  RxList<String> sourceRows = <String>[].obs;
  RxBool adminFlag = RxBool(false);
  void calculateSum() {
    int sum = 0;
    for (TextEditingController controller in sancationAmountEt) {
      int value = int.tryParse(controller.text) ?? 0;
      sum += value;
    }
  totalSamount.value = '$sum';
  }
}

class ChartData {
  String? x;
  double? y;
  ChartData({required this.x, required this.y});
}

class TourMap {
  String? ieRID;
  String? locationName;
  TourMap(this.ieRID, this.locationName);
}

class Item {
  bool isApproved;
  bool isRejected;

  Item({required this.isApproved, required this.isRejected});
}
