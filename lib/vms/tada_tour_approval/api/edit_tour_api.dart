import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_accomadation.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_payment_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_source.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_time_arrry.dart';

Future<void> getEditTour(
    {required String base,
    required int userId,
    required int hrmeId,
    required String ierId,
    required int vtadaaaId,
    required int miID,
    required TadaTourController tadaTourController}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.editTadaTour;
  logger.w(apiUrl);

  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "HRME_Id": hrmeId,
      "IER_ID": ierId,
      "MI_Id": miID,
      "VTADAAA_Id": vtadaaaId,
      "userId": userId
    });

    logger.e({
      "HRME_Id": hrmeId,
      "IER_ID": ierId,
      "MI_Id": miID,
      "VTADAAA_Id": vtadaaaId,
      "userId": userId
    });
    // if (tadaTourController.timeArrayList.isNotEmpty ||
    //     tadaTourController.sourcesList.isNotEmpty ||
    //     tadaTourController.accomdationList.isNotEmpty ||
    //     tadaTourController.paymentDetails.isNotEmpty ||
    //     tadaTourController.chartData.isNotEmpty) {
    //   tadaTourController.timeArrayList.clear();
    //   tadaTourController.sourcesList.clear();
    //   tadaTourController.paymentDetails.clear();
    //   tadaTourController.accomdationList.clear();
    //   tadaTourController.chartData.clear();
    //   tadaTourController.sancationAmountEt.clear();
    // }
    TadaTimeArray timeArrayList =
        TadaTimeArray.fromJson(response.data['timeArray']);
    tadaTourController.timeArrayList.addAll(timeArrayList.values!);
     TadaClientSources sourcList =
        TadaClientSources.fromJson(response.data['client_Master']);
    tadaTourController.sourcesList.addAll(sourcList.values!);
    for (int i = 0; i < tadaTourController.sourcesList.length; i++) {
      if (tadaTourController.sourcesList[i].closure != null) {
        tadaTourController.chartData.add(ChartData(
            x: "Closer",
            y: tadaTourController.sourcesList[i].closure!.toDouble()));
      }
      if (tadaTourController.sourcesList[i].cold != null) {
        tadaTourController.chartData.add(ChartData(
            x: "Cold", y: tadaTourController.sourcesList[i].cold!.toDouble()));
        
      }
      if (tadaTourController.sourcesList[i].followUp != null) {
        tadaTourController.chartData.add(ChartData(
            x: "FollowUp",
            y: tadaTourController.sourcesList[i].followUp!.toDouble()));
         
      }
      if (tadaTourController.sourcesList[i].nEGOTATION != null) {
        tadaTourController.chartData.add(ChartData(
            x: "Negotn",
            y: tadaTourController.sourcesList[i].nEGOTATION!.toDouble()));
         
      }
      if (tadaTourController.sourcesList[i].hOT != null) {
        tadaTourController.chartData.add(ChartData(
            x: "Hot", y: tadaTourController.sourcesList[i].hOT!.toDouble()));
           
      }
    }
    if (tadaTourController.sourcesList.first.nEGOTATION != null) {
      tadaTourController.showTable.value = true;
      // logger.i("showTable${tadaTourController.showTable.value}");
    } else if (tadaTourController.sourcesList.first.cold != null) {
      tadaTourController.showTable.value = false;
      //logger.i("showTable${tadaTourController.showTable.value}");
    }
    if(response.data['editArray'] !=null){
      
    }
    TadaAccomodationModel tadaAccomodationModel =
        TadaAccomodationModel.fromJson(response.data['editArray']);
    logger.w(response.data['editArray']);    
    tadaTourController.accomdationList1.addAll(tadaAccomodationModel.values!);
    for (int i = 0; i < tadaAccomodationModel.values!.length; i++) {
    if(tadaAccomodationModel.values![i].sanctionLevelNo ==1){
      tadaTourController.percentageET.add(TextEditingController(text: "80"));
      var sancationAmount =
          tadaAccomodationModel.values![i].vTADAAADAmount!.toInt();
      var percaent = sancationAmount * (80 / 100);
       
      tadaTourController.sancationAmountEt
          .add(TextEditingController(text: "${percaent.toInt()}"));
      tadaTourController.approvalRemarkEt.add(TextEditingController(text: ""));
        tadaTourController.sancationAmountEt[i].addListener(() {
       tadaTourController.calculateSum();
      });
       if(
      tadaAccomodationModel.values![i].vTADAAAAHStatusFlg=="Pending"||tadaAccomodationModel.values![i].vTADAAAAHStatusFlg=="Approved"  
      ){
      tadaTourController.radioItems.add(Item(isApproved: true, isRejected: false));
      }else if(tadaAccomodationModel.values![i].vTADAAAAHStatusFlg=="Rejected"){
             tadaTourController.radioItems.add(Item(isApproved: false, isRejected: true));
      }
      } else if(
        tadaAccomodationModel.values![i].sanctionLevelNo! >1
      ){
        var setPercntage2 = tadaAccomodationModel.values![i].vTADAAAAHSactionedAmount! /  tadaAccomodationModel.values![i].vTADAAADAmount! * 100;
tadaTourController.sancationAmountEt
          .add(TextEditingController(text: "${tadaAccomodationModel.values![i].vTADAAAAHSactionedAmount!.toInt()}"));
      tadaTourController.percentageET.add(TextEditingController(text: "${setPercntage2.toInt()}"));
      tadaTourController.approvalRemarkEt.add(TextEditingController(text: ""));
        tadaTourController.sancationAmountEt[i].addListener(() {
       tadaTourController.calculateSum();
      });
       if(
      tadaAccomodationModel.values![i].vTADAAAAHStatusFlg=="Pending"||tadaAccomodationModel.values![i].vTADAAAAHStatusFlg=="Approved"  
      ){
      tadaTourController.radioItems.add(Item(isApproved: true, isRejected: false));
      }else if(tadaAccomodationModel.values![i].vTADAAAAHStatusFlg=="Rejected"){
             tadaTourController.radioItems.add(Item(isApproved: false, isRejected: true));
      }
      }
   }
  
     TadaPaymentDetailsModel paymentDetails =
        TadaPaymentDetailsModel.fromJson(response.data['editArrayTwo']);
    tadaTourController.paymentDetails.addAll(paymentDetails.values!);
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
