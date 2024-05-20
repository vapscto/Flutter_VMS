import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/controller/final_tada_tour_approval.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/approval_final_submission.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/file_plan_dmo.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/final_tour_plan_details.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/lead_final_submision.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/models/lead_status_list.dart';
 
Future<void> getFinalAdavncedPlanerDetails(
    {required String base,
    required int userId,
    required int ierId,
    required TadaTourApprovalController controller}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getTadaTourPlanerDetails;
  logger.w(apiUrl);
   try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {
              "UserId":userId,
              "IER_ID":ierId});
  FinalTourPlanDetails finalTourPlanDetails = FinalTourPlanDetails.fromJson(response.data['tourPlanDetails']);
  controller.finalPalnerDetails.addAll(finalTourPlanDetails.values!);
  TourPlanFileDmo fileDmoList = TourPlanFileDmo.fromJson(response.data['getloadarray']);
  LeadStatusNameModel leadList = LeadStatusNameModel.fromJson(response.data['leadLists']);
  LeadFinalSubmission leadFinalSubmission =  LeadFinalSubmission.fromJson(response.data['finalSumbmission']);
  ApprovalSubmision finalApprovalSubmission = ApprovalSubmision.fromJson(response.data['approvalSubmission']);
  controller.etPlanedAmount.value.text = finalApprovalSubmission.values!.first.totalAmt.toString();
  controller.etEligibleAmount.value.text = finalApprovalSubmission.values!.first.eligibleAmt.toString();
 controller. etDebitAmount.value.text = finalApprovalSubmission.values!.first.creditWalletAmount!.toString();
     controller. etDeductectedAmount.value.text = finalApprovalSubmission.values!.first.salaryCreditAmt.toString();

   controller.approvalSubmission.addAll(finalApprovalSubmission.values!);
  controller.leadFinalSubmission.addAll(leadFinalSubmission.values!);
  controller.leadStatusList.addAll(leadList.values!);
  controller.fileList.addAll(fileDmoList.values!);
  for(int i = 0;i<leadFinalSubmission.values!.length;i++){
    controller.totalFinalappliedAmount.value += leadFinalSubmission.values![i].vTADAAATotalAppliedAmount!.toDouble();
    controller.totalFinalSanctionAmount.value += leadFinalSubmission.values![i].vTADAAATotalSactionedAmount!.toDouble();
    controller.totalFinalElgibleAmount.value += leadFinalSubmission.values![i].vTADAAATotalEligbleAmount!.toDouble();
  }
  } on DioError catch (e) {
    logger.e(e.message);
   } on Exception catch (e) {
    logger.e(e.toString());
   }
}
