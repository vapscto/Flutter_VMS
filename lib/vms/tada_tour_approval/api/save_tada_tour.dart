 
 import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';

Future<bool> saveTadaTour(
  {
    required bool adminFlag,
    required int hrmeId,
    required String ierId,
    required int miID,
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
    List<Map<String,dynamic>>? empList,
    List<Map<String,dynamic>>? headArray
  }

 )async{
  logger.e({
 "AdminFlag": adminFlag,
  "HRME_Id": hrmeId,
  "IER_ID": ierId ,
  "MI_Id": miID,
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
  return false;
 }