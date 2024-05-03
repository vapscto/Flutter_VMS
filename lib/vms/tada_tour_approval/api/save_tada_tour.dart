import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
  import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
 
 
Future<bool> saveTadaTour(
  {
    required String base,
    required bool adminFlag,
    required int hrmeId,
    required String ierId,
    required int miID,
    required int userID,
    required String planerEndDate,
    required String planerName,
    required String plannerStarDate,
    required String tourRemark,
    required String tadaRemark,
    required int vTADAAADId,
    required int totalSanctionAmount,
    required int approvecount,
    required int leavel,
    required String tp,
    BuildContext? context,
    List<Map<String,dynamic>>? empList,
    List<Map<String,dynamic>>? headArray
  }

 )async{
    final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.savaTadaTourApi;
    
  logger.e({
 "AdminFlag": adminFlag,
  "HRME_Id": hrmeId,
  "IER_ID": ierId ,
  "MI_Id": miID,
   "userId":userID,
  "PlanEndDate": planerEndDate ,
  "PlanName": planerName,
  "PlanStartDate": plannerStarDate,
  "TourRemark": "",
  "VTADAAA_Id": vTADAAADId,
  "VTADAAA_Remarks": tadaRemark,
  "VTADAAA_TotalSactionedAmount":totalSanctionAmount,
  "approvecnt": approvecount,   
  "headarray": headArray,
  "level": leavel, 
   "listEmployeeSales":empList,
    "tp":tp

  });
   try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "AdminFlag": adminFlag,
  "HRME_Id": hrmeId,
  "IER_ID": ierId ,
  "MI_Id": miID,
  "userId":userID,
  "PlanEndDate": planerEndDate ,
  "PlanName": planerName,
  "PlanStartDate": plannerStarDate,
  "TourRemark": "",
  "VTADAAA_Id": vTADAAADId,
  "VTADAAA_Remarks": tadaRemark,
  "VTADAAA_TotalSactionedAmount":totalSanctionAmount,
  "approvecnt": approvecount,   
  "headarray": headArray,
  "level": leavel, 
   "listEmployeeSales":empList,
    "tp":tp

    });
    
    if (response.statusCode == 200) {
      logger.w(response.data);
      if(response.data['returnvalue']==true){
         Navigator.pop(context!);
          return true;
       }
      }
    return false;
  } on DioError catch (e) {
    logger.e(e.message);
    return false;
  } on Exception catch (e) {
    logger.e(e);
    return false;
  }
  
   
 }